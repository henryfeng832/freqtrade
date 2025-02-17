# vendored Wheels compiled via https://github.com/xmatthias/ta-lib-python/tree/ta_bundled_040

python3 -m pip install --upgrade pip
python3 -c "import sys; print(f'{sys.version_info.major}.{sys.version_info.minor}')"

pip install -U wheel "numpy<2"
pip install --only-binary ta-lib --find-links=build_helpers\ ta-lib

# 添加 py_find_1st 安装
# pip install --no-deps build_helpers\py_find_1st-1.1.7-py3.10-win-amd64.egg

pip install -r requirements-dev.txt
pip install -e .
