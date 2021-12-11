run:
		poetry run python ./script/update_setting.py
		poetry run python ./script/convert.py

lint:
		poetry run pflake8 ./script
		poetry run isort --check --diff ./script
		poetry run black --check ./script

format:
		poetry run isort ./script
		poetry run black ./script