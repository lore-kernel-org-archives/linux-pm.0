From: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
Subject: Re: [PATCH] swsusp: simpler calculation of number of pages
	in PBE list
Date: Fri, 29 Jul 2005 23:14:32 +0200
Message-ID: <42EA9C38.90905@stud.feec.vutbr.cz>
References: <42EA87A0.908@stud.feec.vutbr.cz> <200507292243.28276.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------060408070000030101030503"
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200507292243.28276.rjw@sisk.pl>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-pm@lists.osdl.org, linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

This is a multi-part message in MIME format.
--------------060408070000030101030503
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Rafael J. Wysocki wrote:
> On Friday, 29 of July 2005 21:46, Michal Schmidt wrote:
> 
>>The function calc_nr uses an iterative algorithm to calculate the number 
>>of pages needed for the image and the pagedir. Exactly the same result 
>>can be obtained with a one-line expression.
> 
> 
> Could you please post the proof?
> 
> Rafael

OK, attached is a proof-by-brute-force program. It compares the results 
of the original function and the simplified one.

This is its output:

$ ./calc_nr2
checked 0 ...
checked 100000000 ...
checked 200000000 ...
checked 300000000 ...
checked 400000000 ...
checked 500000000 ...
checked 600000000 ...
checked 700000000 ...
checked 800000000 ...
checked 900000000 ...
checked 1000000000 ...
checked 1100000000 ...
checked 1200000000 ...
checked 1300000000 ...
checked 1400000000 ...
checked 1500000000 ...
checked 1600000000 ...
checked 1700000000 ...
checked 1800000000 ...
checked 1900000000 ...
checked 2000000000 ...
checked 2100000000 ...
First difference at 2130706433:  -2147483646 x -2147483647

It means that the two functions give the same results for sensible 
values of the input argument.
They results only differ when they overflow into negative values. At 
this point both of the results are useless.

Michal

--------------060408070000030101030503
Content-Type: text/x-csrc;
 name="calc_nr2.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="calc_nr2.c"

#include <stdio.h>
#include <limits.h>

typedef struct {
	unsigned long val;
} swp_entry_t;

typedef struct pbe {
	unsigned long address;
	unsigned long orig_address;
	swp_entry_t swap_address;
	struct pbe *next;
} suspend_pagedir_t;

#define PAGE_SIZE 4096
#define PBES_PER_PAGE (PAGE_SIZE/sizeof(struct pbe))

static int calc_nr_orig(int nr_copy)
{
        int extra = 0;
	int mod = !!(nr_copy % PBES_PER_PAGE);
	int diff = (nr_copy / PBES_PER_PAGE) + mod;

	do {
		extra += diff;
		nr_copy += diff;
		mod = !!(nr_copy % PBES_PER_PAGE);
		diff = (nr_copy / PBES_PER_PAGE) + mod - extra;
	} while (diff > 0);
	
	return nr_copy;
}

static int calc_nr(int nr_copy)
{
	return nr_copy + (nr_copy+PBES_PER_PAGE-2)/(PBES_PER_PAGE-1);
}

int main()
{
	int i;
	for (i=0; i>=0; i++) {
		if (i%100000000 == 0)
			printf("checked %d ...\n", i);
		if (calc_nr(i) != calc_nr_orig(i)) {
			printf("First difference at %d:  %d x %d\n", i, calc_nr(i), calc_nr_orig(i));
			break;
		}
	}
	return 0;
}


--------------060408070000030101030503
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--------------060408070000030101030503--
