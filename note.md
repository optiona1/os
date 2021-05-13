```shell
bximage

1

fd

default

boot.img

```

compiler

`nasm boot.asm -o boot.bin`

`dd if=boot.bin of=boot.img bs=512 count=1 conv=notrunc`
