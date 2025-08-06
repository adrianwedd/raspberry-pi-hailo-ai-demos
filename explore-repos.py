#!/usr/bin/env python3
"""
Interactive Hailo AI Repository Explorer
Navigate and discover demos across all categories
"""

import os
import json
import subprocess
from pathlib import Path
from typing import Dict, List, Optional
import argparse

class HailoRepoExplorer:
    def __init__(self, base_path: str = "."):
        self.base_path = Path(base_path)
        self.categories = {
            "official-repositories": "Official Hailo repositories",
            "yolo-implementations": "YOLO model implementations",
            "computer-vision": "Computer vision applications",
            "robotics-integration": "Robotics and ROS integration",
            "community-projects": "Community contributions",
            "tools-utilities": "Development tools and utilities",
            "hackathon-projects": "Hackathon winning projects"
        }
        
    def scan_repositories(self) -> Dict[str, List[Dict]]:
        """Scan all categories and list repositories"""
        repos = {}
        
        for category, description in self.categories.items():
            category_path = self.base_path / category
            if category_path.exists():
                repos[category] = []
                for repo_dir in category_path.iterdir():
                    if repo_dir.is_dir() and not repo_dir.name.startswith('.'):
                        repo_info = self.get_repo_info(repo_dir)
                        repos[category].append(repo_info)
        
        return repos
    
    def get_repo_info(self, repo_path: Path) -> Dict:
        """Extract information about a repository"""
        info = {
            "name": repo_path.name,
            "path": str(repo_path),
            "has_readme": (repo_path / "README.md").exists(),
            "has_requirements": (repo_path / "requirements.txt").exists(),
            "has_setup": (repo_path / "setup.py").exists() or (repo_path / "setup.sh").exists(),
            "languages": self.detect_languages(repo_path),
            "size": self.get_dir_size(repo_path)
        }
        
        # Try to get description from README
        readme_path = repo_path / "README.md"
        if readme_path.exists():
            try:
                with open(readme_path, 'r', encoding='utf-8') as f:
                    lines = f.readlines()[:10]  # First 10 lines
                    for line in lines:
                        if line.strip() and not line.startswith('#'):
                            info["description"] = line.strip()[:100]
                            break
            except:
                pass
        
        return info
    
    def detect_languages(self, repo_path: Path) -> List[str]:
        """Detect programming languages in repository"""
        languages = set()
        
        extensions = {
            '.py': 'Python',
            '.cpp': 'C++',
            '.c': 'C',
            '.h': 'C/C++',
            '.hpp': 'C++',
            '.sh': 'Bash',
            '.js': 'JavaScript',
            '.ts': 'TypeScript',
            '.rs': 'Rust',
            '.go': 'Go'
        }
        
        for file_path in repo_path.rglob('*'):
            if file_path.is_file():
                ext = file_path.suffix
                if ext in extensions:
                    languages.add(extensions[ext])
        
        return list(languages)
    
    def get_dir_size(self, path: Path) -> str:
        """Get human-readable directory size"""
        try:
            result = subprocess.run(['du', '-sh', str(path)], 
                                  capture_output=True, text=True)
            if result.returncode == 0:
                return result.stdout.split()[0]
        except:
            pass
        return "N/A"
    
    def print_summary(self, repos: Dict[str, List[Dict]]):
        """Print a summary of all repositories"""
        total_repos = sum(len(r) for r in repos.values())
        
        print("\n🚀 HAILO AI REPOSITORY EXPLORER")
        print("=" * 60)
        print(f"📊 Total Repositories: {total_repos}")
        print()
        
        for category, repo_list in repos.items():
            if repo_list:
                print(f"\n📁 {self.categories.get(category, category)}")
                print(f"   ({len(repo_list)} repositories)")
                print("-" * 60)
                
                for repo in repo_list:
                    status_icons = []
                    if repo['has_readme']:
                        status_icons.append("📖")
                    if repo['has_requirements']:
                        status_icons.append("📦")
                    if repo['has_setup']:
                        status_icons.append("⚙️")
                    
                    print(f"  • {repo['name']:<30} {' '.join(status_icons)}")
                    if 'description' in repo:
                        print(f"    {repo['description'][:70]}...")
                    if repo['languages']:
                        print(f"    Languages: {', '.join(repo['languages'][:3])}")
                    print(f"    Size: {repo['size']}")
                    print()
    
    def search_repos(self, query: str, repos: Dict[str, List[Dict]]):
        """Search repositories by name or description"""
        results = []
        query_lower = query.lower()
        
        for category, repo_list in repos.items():
            for repo in repo_list:
                if (query_lower in repo['name'].lower() or 
                    ('description' in repo and query_lower in repo['description'].lower())):
                    results.append((category, repo))
        
        if results:
            print(f"\n🔍 Search results for '{query}':")
            print("-" * 60)
            for category, repo in results:
                print(f"  {category}/{repo['name']}")
                if 'description' in repo:
                    print(f"    {repo['description']}")
                print()
        else:
            print(f"No repositories found matching '{query}'")
    
    def show_details(self, repo_path: str):
        """Show detailed information about a specific repository"""
        path = Path(repo_path)
        if not path.exists():
            print(f"Repository not found: {repo_path}")
            return
        
        info = self.get_repo_info(path)
        
        print(f"\n📦 Repository: {info['name']}")
        print("=" * 60)
        print(f"Path: {info['path']}")
        print(f"Size: {info['size']}")
        
        if info['languages']:
            print(f"Languages: {', '.join(info['languages'])}")
        
        print("\nFiles:")
        if info['has_readme']:
            print("  ✅ README.md")
        if info['has_requirements']:
            print("  ✅ requirements.txt")
        if info['has_setup']:
            print("  ✅ Setup script")
        
        # Show key files
        print("\nKey files:")
        for item in path.iterdir():
            if item.is_file() and not item.name.startswith('.'):
                print(f"  - {item.name}")
                if len(list(path.iterdir())) > 10:
                    print("  ... and more")
                    break
    
    def generate_json_report(self, output_file: str = "repo_report.json"):
        """Generate a JSON report of all repositories"""
        repos = self.scan_repositories()
        
        report = {
            "total_repositories": sum(len(r) for r in repos.values()),
            "categories": {}
        }
        
        for category, repo_list in repos.items():
            report["categories"][category] = {
                "description": self.categories.get(category, ""),
                "count": len(repo_list),
                "repositories": repo_list
            }
        
        with open(output_file, 'w') as f:
            json.dump(report, f, indent=2)
        
        print(f"✅ Report saved to {output_file}")

def main():
    parser = argparse.ArgumentParser(description="Explore Hailo AI repository collection")
    parser.add_argument('--search', '-s', help='Search repositories by name or description')
    parser.add_argument('--details', '-d', help='Show details for a specific repository path')
    parser.add_argument('--json', '-j', action='store_true', help='Generate JSON report')
    parser.add_argument('--category', '-c', help='Filter by category')
    
    args = parser.parse_args()
    
    explorer = HailoRepoExplorer()
    
    if args.json:
        explorer.generate_json_report()
    elif args.details:
        explorer.show_details(args.details)
    elif args.search:
        repos = explorer.scan_repositories()
        explorer.search_repos(args.search, repos)
    else:
        repos = explorer.scan_repositories()
        
        if args.category:
            filtered = {args.category: repos.get(args.category, [])}
            explorer.print_summary(filtered)
        else:
            explorer.print_summary(repos)
            
            print("\n💡 Tips:")
            print("  • Use --search 'query' to find specific repos")
            print("  • Use --details 'path' for detailed information")
            print("  • Use --category 'name' to filter by category")
            print("  • Use --json to generate a JSON report")

if __name__ == "__main__":
    main()