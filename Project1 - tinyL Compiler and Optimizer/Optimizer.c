/*
 *********************************************
 *  314 Principles of Programming Languages  *
 *  Spring 2013                              *
 *  Authors: Ulrich Kremer                   *
 *           Hans Christian Woithe           *
 *********************************************
 */

#include <assert.h>
#include <stdio.h>
#include <stdlib.h>
#include "InstrUtils.h"
#include "Utils.h"

 int main()
 {
 	Instruction *head;
 	head = ReadInstructionList(stdin);
 	if (!head) {
 		ERROR("No instructions\n");
 		exit(EXIT_FAILURE);
 	}

	/* YOUR CODE GOES HERE */

 	Instruction *first;
 	Instruction *second;
 	Instruction *third;

	Instruction *instr = head;

	do {
		first = instr;
		second = instr->next;
		third = second->next;
		if (first->opcode == LOADI && second->opcode == LOADI) {
			switch (third->opcode) {
				case ADD:
					if ((first->field1 == third->field2 && second->field1 == third->field3) || (first->field1 == third->field3 && second->field1 == third->field2)) {
						instr->field1 = third->field1;
						instr->field2 = first->field2 + second->field2;
						instr->next = third->next;
						third->next->prev = instr;
						free(second);
						free(third);
						// printf("Found ADD optimization.\n");
					}		
					break;
				case MUL:
					if ((first->field1 == third->field2 && second->field1 == third->field3) || (first->field1 == third->field3 && second->field1 == third->field2)) {
						instr->field1 = third->field1;
						instr->field2 = first->field2 * second->field2;
						instr->next = third->next;
						third->next->prev = instr;
						free(second);
						free(third);
						// printf("Found MUL optimization.\n");
					}		
					break;		
				case SUB:
					if (first->field1 == third->field2 && second->field1 == third->field3) {
						instr->field1 = third->field1;
						instr->field2 = first->field2 - second->field2;
						instr->next = third->next;
						third->next->prev = instr;
						free(second);
						free(third);
						// printf("Found SUB optimization.\n");
					}
					break;
				default:
					// printf("\nNot optimizable.\n");
					break;
			}
		}
		instr = instr->next;
	} while (instr != NULL && instr->next != NULL && instr->next->next != NULL);

 	PrintInstructionList(stdout, head);
 	DestroyInstructionList(head);
 	return EXIT_SUCCESS;
}
