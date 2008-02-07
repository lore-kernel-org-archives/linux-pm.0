From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [rft] s2ram wakeup moves to .c, could fix few machines
Date: Thu, 07 Feb 2008 15:13:58 -0800
Message-ID: <47AB90B6.8090607@zytor.com>
References: <20080205190600.GB11613@elf.ucw.cz> <200802072312.31430.rjw@sisk.pl> <47AB887E.7010000@zytor.com> <200802080006.54151.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1763736AbYBGXOg@vger.kernel.org>
In-Reply-To: <200802080006.54151.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

Rafael J. Wysocki wrote:
> On Thursday, 7 of February 2008, H. Peter Anvin wrote:
>> Rafael J. Wysocki wrote:
>>> Index: linux-2.6/arch/x86/kernel/acpi/realmode/wakeup.S
>>> ===================================================================
>>> --- /dev/null
>>> +++ linux-2.6/arch/x86/kernel/acpi/realmode/wakeup.S
>>> @@ -0,0 +1,122 @@
>>> +/*
>>> + * ACPI wakeup real mode startup stub
>>> + */
>>> +#include <asm/segment.h>
>>> +#include <asm/msr-index.h>
>>> +#include <asm/page_64.h>
>>> +#include <asm/pgtable_64.h>
>>> +
>>> +	.code16
>>> +	.section ".header", "a"
>>> +
>>> +/* This should match the structure in wakeup.h */
>>> +		.globl	wakeup_header
>>> +wakeup_header:
>>> +video_mode:	.short	0	/* Video mode number */
>>> +pmode_return:	.byte	0x66, 0xea	/* ljmpl */
>>> +		.long	0	/* offset goes here */
>>> +		.short	__KERNEL_CS
>> Missing a .short pad here... Pavel fixed that at some point, I thought.
> 
> Hm, the struct in wakeup.h doesn't contain it too.  Why exactly is it
> necessary?

Err, I guess it's only necessary if _jmp2 is declared u32.  I generally 
prefer to keep fields naturally aligned even though x86 doesn't require 
it, it's a bit of paranoia on my part.

> 
> Yeah.  Pavel, what's at 0x3f00, btw?
> 

To be fair, this might have come from my early hack, I don't know for sure.

> In fact, I'd prefer to remove .signature from the header and use the
> end_signature only, so that I can use struct wakeup_header for addressing
> the header fields in the assembly too.

I *thought* that's what I had originally.  I'm a bit confused, or it 
might have been something Pavel changed.

>> Furthermore, by doing so, you're also padding the binary out to its maximum
>> length, so you might as well just remove the .bss-clearing stuff.
> 
> Do you mean placing the header at the end will fill the area between it and the
> code with zeros, so the .bss clearing is not necessary?

Yes.  It could, of course, also be cleared by a simple memset() in the 
setup code in the kernel, as opposed by the initial assembly code. 
That's probably the preferred option.

	-hpa
