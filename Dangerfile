view_extensions = [".xib", ".storyboard", "View.swift", "ViewController.swift"]
has_view_changes = git.modified_files.any? { |file| view_extensions.any? { |ext| file.end_with? ext }}
pr_has_screenshot = github.pr_body =~ /https?:\/\/\S*\.(png|jpg|jpeg|gif|PNG|MP4){1}/
warn("見た目に変更がある場合は、スクリーンショットを添付してね🐶。") if has_view_changes and !pr_has_screenshot

swiftlint.lint_files inline_mode: true
