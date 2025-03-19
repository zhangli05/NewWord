import json
import shutil
import os

# 获取当前目录
current_dir = os.getcwd()
missing_files_log = []

# 遍历当前目录下的所有子目录
for root, dirs, files in os.walk(current_dir):
    # 检查是否存在 locales 文件夹
    if 'locales' in dirs:
        locales_path = os.path.join(root, 'locales')
        en_json_path = os.path.join(locales_path, 'en.json')
        zh_json_path = os.path.join(locales_path, 'zh.json')
        en_json_backup_path = os.path.join(locales_path, 'en.json.backup')

        # 检查 en.json 和 zh.json 文件是否存在
        if not os.path.exists(en_json_path):
            print(f"在 {locales_path} 中未找到 {en_json_path} 文件，将记录该位置并继续。")
            missing_files_log.append(f"未找到 {en_json_path}")
            continue
        elif not os.path.exists(zh_json_path):
            print(f"在 {locales_path} 中未找到 {zh_json_path} 文件，将记录该位置并继续。")
            missing_files_log.append(f"未找到 {zh_json_path}")
            continue

        try:
            # 备份 en.json 文件
            shutil.copy2(en_json_path, en_json_backup_path)
            backup_success = True
            print(f"已成功备份 {en_json_path} 到 {en_json_backup_path}")

            # 读取 zh.json 文件内容
            with open(zh_json_path, 'r', encoding='utf-8') as zh_file:
                zh_data = json.load(zh_file)

            # 将 zh.json 的内容写入 en.json
            with open(en_json_path, 'w', encoding='utf-8') as en_file:
                json.dump(zh_data, en_file, ensure_ascii=False, indent=4)
            replace_success = True
            print(f"已将 {zh_json_path} 的内容替换到 {en_json_path}")

            if backup_success and replace_success:
                print("备份和替换操作均成功完成。")

        except Exception as e:
            print(f"在 {locales_path} 执行过程中出现错误: {e}")

# 输出未找到文件的记录
if missing_files_log:
    print("\n以下是未找到文件的记录：")
    for log in missing_files_log:
        print(log)
else:
    print("\n未发现文件缺失情况。")

input("按回车键退出...")
