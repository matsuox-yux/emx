from openpyxl import load_workbook
from openpyxl.utils.exceptions import InvalidFileException
import zipfile

try:
    wb = load_workbook("sample.xlsx")

except FileNotFoundError:
    print("ファイルが存在しません")

except InvalidFileException:
    print("Excelファイルではありません")

except zipfile.BadZipFile:
    print("ファイルが壊れています")

except PermissionError:
    print("ファイルにアクセスできません")

except Exception as e:
    print(f"予期しないエラー: {e}")
