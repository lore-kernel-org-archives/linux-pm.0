From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [rft] s2ram wakeup moves to .c, could fix few machines
Date: Fri, 8 Feb 2008 22:56:49 +0100
Message-ID: <20080208215644.GM12923@elf.ucw.cz>
References: <20080205190600.GB11613@elf.ucw.cz> <200802060227.14385.rjw@sisk.pl> <200802070049.00461.rjw@sisk.pl> <200802072312.31430.rjw@sisk.pl> <47AB887E.7010000@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755887AbYBHV4w@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <47AB887E.7010000@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, kernel list <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

Hi!

>> +	.section ".header", "a"
>> +
>> +/* This should match the structure in wakeup.h */
>> +		.globl	wakeup_header
>> +wakeup_header:
>> +video_mode:	.short	0	/* Video mode number */
>> +pmode_return:	.byte	0x66, 0xea	/* ljmpl */
>> +		.long	0	/* offset goes here */
>> +		.short	__KERNEL_CS
>
> Missing a .short pad here... Pavel fixed that at some point, I thought.

No pad needed, AFAICT.

>>  	}
>> -	memcpy((void *)acpi_wakeup_address, &wakeup_start,
>> -	       &wakeup_end - &wakeup_start);
>> -	acpi_copy_wakeup_routine(acpi_wakeup_address);
>> +	memcpy((void *)acpi_realmode, &wakeup_code_start, 4*PAGE_SIZE);
>
> Using a PAGE_SIZE multiplier here isn't a good thing...

Fixed.

>> +	header = (struct wakeup_header *)(acpi_realmode + 0x3f00);
>
> ... especially not with magic constants like this.

Fixed.

> If you're putting the "header" at the end, then you should also replace the 
> end_signature stuff since that's, then, redundant.  Furthermore, by doing 
> so, you're also padding the binary out to its maximum length, so you might 
> as well just remove the .bss-clearing stuff.

Good, lets remove bss clearing.

>> +	header->pmode_efer_low = nx_enabled;
>> +	if (header->pmode_efer_low & 1) {
>> +		/* This is strange, why not save efer, always? */
>> +		rdmsr(MSR_EFER, header->pmode_efer_low,
>> +			header->pmode_efer_high);
>> +	}
>
> Yes, why not save EFER every time?

Dunno, I copied it from other code, and as it depends on nx setting,
I'd prefer not to touch it for now. Do old CPUs have EFER?

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
