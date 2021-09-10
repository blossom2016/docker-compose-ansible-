up:
	docker build -t conti-test .
	docker-compose up -d
ansible:
	ansible-playbook -i hosts playbook.yml
	
	
