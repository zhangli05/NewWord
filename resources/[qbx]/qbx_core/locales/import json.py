import json
import shutil
import os

# 定义文件路径
current_dir = os.getcwd()
en_json_path = os.path.join(current_dir, 'en.json')
cn_json_path = os.path.join(current_dir, 'zh.json')
en_json_backup_path = os.path.join(current_dir, 'en.json.backup')

# 检查 en.json 和 cn.json 文件是否存在
if not os.path.exists(en_json_path):
    print(f"未找到 {en_json_path} 文件，请检查。")
elif not os.path.exists(cn_json_path):
    print(f"未找到 {zh_json_path} 文件，请检查。")
else:
    try:
        # 备份 en.json 文件
        shutil.copy2(en_json_path, en_json_backup_path)
        backup_success = True
        print(f"已成功备份 {en_json_path} 到 {en_json_backup_path}")

        # 读取 cn.json 文件内容
        with open(cn_json_path, 'r', encoding='utf-8') as cn_file:
            cn_data = json.load(cn_file)

        # 将 cn.json 的内容写入 en.json
        with open(en_json_path, 'w', encoding='utf-8') as en_file:
            json.dump(cn_data, en_file, ensure_ascii=False, indent=4)
        replace_success = True
        print(f"已将 {cn_json_path} 的内容替换到 {en_json_path}")

        if backup_success and replace_success:
            print("备份和替换操作均成功完成。")

    except Exception as e:
        print(f"执行过程中出现错误: {e}")

input("按回车键退出...")