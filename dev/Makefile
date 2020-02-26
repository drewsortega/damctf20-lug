LOOP=loop8

default: build	

important.tar.gz: docs/flag
	tar -cvzf important.tar.gz docs

usb/Documents:
	mkdir usb/Documents
	mkdir usb/Documents/other
	mkdir usb/Documents/jfobb

important: important.tar.gz usb/Documents
	gpg --output important --recipient jfobb@email.com --armor --encrypt important.tar.gz
	cp important usb/Documents/jfobb/important

usb.img: important
	mksquashfs ./usb ./usb.img

build: usb.img

deploy: usb.img
	losetup /dev/${LOOP} ./usb.img
	chmod 555 /dev/${LOOP}

clean:
	rm -r usb/Documents important important.tar.gz usb.img

unstage:
	losetup -d /dev/${LOOP}
