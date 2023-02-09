DOMAIN ?= $(shell hostname|awk -F- '{print $$1}') 
KEY = $(shell secret-tool lookup user ${USER} domain $(DOMAIN))

all:
	@if [ -z "$(KEY)" ]; then \
  		secret-tool store --label=time-based-one-time-password user ${USER} domain $(DOMAIN); \
	else \
		oathtool --totp -b $(KEY) | xclip  -selection clipboard; \
		echo The time-based one-time password is now in your clipboard; \
	fi
