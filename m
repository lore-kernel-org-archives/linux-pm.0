From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [linux-pm] Re: wakeup code translated to .c
Date: Mon, 4 Feb 2008 00:30:27 +0100
Message-ID: <200802040030.28700.rjw@sisk.pl>
References: <20080130120111.GB22820@elf.ucw.cz> <200802032333.02821.rjw@sisk.pl> <200802040020.14836.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754676AbYBCXc2@vger.kernel.org>
In-Reply-To: <200802040020.14836.rjw@sisk.pl>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-pm@lists.linux-foundation.org, Linux-pm mailing list <linux-pm@lists.osdl.org>, kernel list <linux-kernel@vger.kernel.org>, "H. Peter Anvin" <hpa@zytor.com>
List-Id: linux-pm@vger.kernel.org

On Monday, 4 of February 2008, Rafael J. Wysocki wrote:
> On Sunday, 3 of February 2008, Rafael J. Wysocki wrote:
> > On Sunday, 3 of February 2008, Pavel Machek wrote:
> > > Hi!
> > >=20
> > > > > This version works on 32-bit, and builds on 64-bit (but I'm p=
retty
> > > > > sure it does not work. 32-bit code probably needs to go into =
rm/....)
> > > > >=20
> > > >=20
> > > > Do you have an updated version or is this the latest one?
> > >=20
> > > I'm glad you ask ;-). Here's reasonably-recent version (I have
> > > slightly cleaner one, but it got obscured by 2.6.24-git merge), I
> > > eventually got it to work on 64-bit, by reusing trampoline.S code=
=2E
> >=20
> > I needed to rebase it against the current mainline (Makefile confli=
ct).
> >=20
> > Some remarks:
> >=20
> > - It looks like arch/x86/kernel/acpi/wakeup.S is not necessary any =
more.
> >=20
> > - These warnings:
> >=20
> > /home/rafael/src/linux-2.6/arch/x86/kernel/acpi/sleep.c: In functio=
n =E2=80=98acpi_save_state_mem=E2=80=99:
> > /home/rafael/src/linux-2.6/arch/x86/kernel/acpi/sleep.c:41: warning=
: initialization makes pointer from integer without a cast
> > /home/rafael/src/linux-2.6/arch/x86/kernel/acpi/sleep.c:50: warning=
: format =E2=80=98%d=E2=80=99 expects type =E2=80=98int=E2=80=99, but a=
rgument 2 has type =E2=80=98long unsigned int=E2=80=99
> > /home/rafael/src/linux-2.6/arch/x86/kernel/acpi/sleep.c:50: warning=
: format =E2=80=98%d=E2=80=99 expects type =E2=80=98int=E2=80=99, but a=
rgument 3 has type =E2=80=98long unsigned int=E2=80=99
> > /home/rafael/src/linux-2.6/arch/x86/kernel/acpi/sleep.c:70: warning=
: ISO C90 forbids mixed declarations and code
> > /home/rafael/src/linux-2.6/arch/x86/kernel/acpi/sleep.c:82: warning=
: assignment makes integer from pointer without a cast
> > /home/rafael/src/linux-2.6/arch/x86/kernel/acpi/sleep.c:83: warning=
: assignment makes integer from pointer without a cast
> > /home/rafael/src/linux-2.6/arch/x86/kernel/acpi/sleep.c:84: warning=
: ISO C90 forbids mixed declarations and code
> > /home/rafael/src/linux-2.6/arch/x86/kernel/acpi/sleep.c:87: warning=
: ISO C90 forbids mixed declarations and code
> > /home/rafael/src/linux-2.6/arch/x86/kernel/acpi/sleep.c:90: warning=
: assignment makes integer from pointer without a cast
> > /home/rafael/src/linux-2.6/arch/x86/kernel/acpi/sleep.c:91: warning=
: ISO C90 forbids mixed declarations and code
> >=20
> > look pretty scary.
>=20
> Below is the arch/x86/kernel/acpi/sleep.c part without the warnings (=
untested).

Now also tested on x86-64 (works just fine :-)).


> It still contains some hardcoded magic numbers and extern declaration=
s, so
> I guess the #include list is not complete or another header is necess=
ary.
>=20
> BTW:
> 1) why exactly is acpi_wakeup_address not (void *)?
> 2) header->level3_ident_pgt and header->level3_ident_pgt could be (ch=
ar *) IMO
>=20
>=20
> --- linux-2.6.orig/arch/x86/kernel/acpi/sleep.c
> +++ linux-2.6/arch/x86/kernel/acpi/sleep.c
> @@ -11,29 +11,92 @@
>  #include <linux/cpumask.h>
> =20
>  #include <asm/smp.h>
> +#include "rm/wakeup.h"
> =20
>  /* address in low memory of the wakeup routine. */
> -unsigned long acpi_wakeup_address =3D 0;
> +static unsigned long acpi_realmode;
> +unsigned long acpi_wakeup_address;
>  unsigned long acpi_realmode_flags;
> -extern char wakeup_start, wakeup_end;
> =20
> +extern char wakeup_code_start, wakeup_code_end;
>  extern unsigned long acpi_copy_wakeup_routine(unsigned long);
> +extern unsigned long setup_trampoline(void);
> +extern void wakeup_long64(void);
> +
> +extern unsigned long saved_video_mode;
> +extern long saved_magic;
> +extern char level3_ident_pgt[PAGE_SIZE];
> +extern char level3_kernel_pgt[PAGE_SIZE];
> +extern volatile unsigned long init_rsp;
> +extern void (*initial_code)(void);
> +#ifndef CONFIG_64BIT
> +extern int wakeup_pmode_return;
> +extern char swsusp_pg_dir[PAGE_SIZE];
> +#endif
> +
> +static char temp_stack[10240];
> =20
>  /**
>   * acpi_save_state_mem - save kernel state
>   *
>   * Create an identity mapped page table and copy the wakeup routine =
to
>   * low memory.
> + *
> + * Note that this is too late to change acpi_wakeup_address.
>   */
>  int acpi_save_state_mem(void)
>  {
> -	if (!acpi_wakeup_address) {
> -		printk(KERN_ERR "Could not allocate memory during boot, S3 disable=
d\n");
> +	struct wakeup_header *header;
> +
> +	printk("acpi_save_state_mem\n");
> +
> +	if (!acpi_realmode) {
> +		printk(KERN_ERR "Could not allocate memory during boot, "
> +				"S3 disabled\n");
>  		return -ENOMEM;
>  	}
> -	memcpy((void *)acpi_wakeup_address, &wakeup_start,
> -	       &wakeup_end - &wakeup_start);
> -	acpi_copy_wakeup_routine(acpi_wakeup_address);
> +
> +	memcpy((void *)acpi_realmode, &wakeup_code_start, 4*PAGE_SIZE);
> +
> +	header =3D (struct wakeup_header *)(acpi_realmode + 0x3f00);
> +	if (header->signature !=3D 0x51ee1111) {
> +		printk(KERN_ERR "wakeup header does not match\n");
> +		return -EINVAL;
> +	}
> +
> +	header->video_mode =3D saved_video_mode;
> +	printk("Video mode =3D %lu, realmode flags =3D %lu\n",
> +		saved_video_mode, acpi_realmode_flags);
> +	mdelay(1000);
> +
> +#ifndef CONFIG_64BIT
> +	store_gdt(&header->pmode_gdt);
> +
> +	header->pmode_efer_low =3D nx_enabled;
> +	if (header->pmode_efer_low & 1) {
> +		/* This is strange, why not save efer, always? */
> +		rdmsr(MSR_EFER, header->pmode_efer_low,
> +			header->pmode_efer_high);
> +	}
> +#endif /* !CONFIG_64BIT */
> +
> +	header->pmode_cr0 =3D read_cr0();
> +	header->pmode_cr4 =3D read_cr4();
> +	header->realmode_flags =3D acpi_realmode_flags;
> +	header->real_magic =3D 0x12345678;
> +
> +#ifndef CONFIG_64BIT
> +	header->pmode_entry =3D &wakeup_pmode_return;
> +	header->pmode_cr3 =3D swsusp_pg_dir - __PAGE_OFFSET;
> +	saved_magic =3D 0x12345678;
> +#else /* CONFIG_64BIT */
> +	header->level3_ident_pgt =3D (u64)level3_ident_pgt;
> +	header->level3_kernel_pgt =3D (u64)level3_kernel_pgt;
> +	header->trampoline_segment =3D setup_trampoline() >> 4;
> +	init_rsp =3D (unsigned long)temp_stack + 4096;
> +	initial_code =3D wakeup_long64;
> +	saved_magic =3D 0x123456789abcdef0;
> +#endif /* CONFIG_64BIT */
> =20
>  	return 0;
>  }
> @@ -56,15 +119,20 @@ void acpi_restore_state_mem(void)
>   */
>  void __init acpi_reserve_bootmem(void)
>  {
> -	if ((&wakeup_end - &wakeup_start) > PAGE_SIZE*2) {
> +	if ((&wakeup_code_end - &wakeup_code_start) > PAGE_SIZE*4) {
>  		printk(KERN_ERR
>  		       "ACPI: Wakeup code way too big, S3 disabled.\n");
>  		return;
>  	}
> =20
> -	acpi_wakeup_address =3D (unsigned long)alloc_bootmem_low(PAGE_SIZE*=
2);
> -	if (!acpi_wakeup_address)
> +	acpi_realmode =3D (unsigned long)alloc_bootmem_low(PAGE_SIZE*4);
> +
> +	if (!acpi_realmode) {
>  		printk(KERN_ERR "ACPI: Cannot allocate lowmem, S3 disabled.\n");
> +		return;
> +	}
> +
> +	acpi_wakeup_address =3D acpi_realmode;
>  }
> =20
> =20

Greetings,
Rafael
