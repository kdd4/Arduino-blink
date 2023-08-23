target = main
target_dir = bin
source_dir = src
mmcu = atmega328
flags = -DNDEBUG -Os -Wall

sources = $(wildcard ${source_dir}/*.cpp)
obj_dir = obj
objects = $(patsubst ${source_dir}/%.cpp, ${obj_dir}/%.o, ${sources})

.PHONY: clean all

all: ${target_dir}/${target}.hex
	avr-size -C ${target_dir}/${target}.elf

${target_dir}/${target}.elf: ${objects} ${target_dir}
	avr-g++ -o ${target_dir}/${target}.elf ${objects} -mmcu=${mmcu} ${flags} 
	
${target_dir}/${target}.hex: ${target_dir}/${target}.elf ${target_dir}
	avr-objcopy -j .text -j .data -O ihex ${target_dir}/${target}.elf ${target_dir}/${target}.hex
	
${obj_dir}/%.o: src/%.cpp ${obj_dir}
	avr-g++ -c -o $@ $< -mmcu=${mmcu} ${flags}
	
${obj_dir} ${target_dir}:
	mkdir ${obj_dir}
	mkdir ${target_dir}

clean:
	rm -f ${target_dir}/* ${obj_dir}/*
	rmdir ${obj_dir} ${target_dir}