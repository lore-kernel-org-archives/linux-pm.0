From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] x86: General protection fault after STR (32 bit systems only)
Date: Fri, 12 Jun 2015 01:15:58 -0700
Message-ID: <A58C5D0E-A557-4406-9317-442D78E4700B@zytor.com>
References: <1434066338-6619-1-git-send-email-srinivas.pandruvada@linux.intel.com> <20150612060747.GA25024@gmail.com> <CALCETrUfrbLeJoOeNQU2vK+jAmNBazB5rmfD5M11tv6NVeppmg@mail.gmail.com> <20150612075013.GA8759@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:33706 "EHLO mail.zytor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753200AbbFLIRc (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 12 Jun 2015 04:17:32 -0400
In-Reply-To: <20150612075013.GA8759@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Andy Lutomirski <luto@amacapital.net>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Pavel Machek <pavel@ucw.cz>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, X86 ML <x86@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Denys Vlasenko <dvlasenk@redhat.com>, Borislav Petkov <bp@alien8.de>, Brian Gerst <brgerst@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>

%es is used implicitly by string instructions.

On June 12, 2015 12:50:13 AM PDT, Ingo Molnar <mingo@kernel.org> wrote:
>
>* Andy Lutomirski <luto@amacapital.net> wrote:
>
>> > --- a/arch/x86/kernel/acpi/wakeup_32.S
>> > +++ b/arch/x86/kernel/acpi/wakeup_32.S
>> > @@ -81,6 +81,10 @@ ENTRY(do_suspend_lowlevel)
>> >         jmp     ret_point
>> >         .p2align 4,,7
>> >  ret_point:
>> > +       /* In case the BIOS corrupted DS, make the kernel context
>minimally functional: */
>> > +       movl    $__KERNEL_DS, %eax
>> > +       movl    %eax, %ds
>> > +
>> 
>> On further thought, I think you want movl $__USER_DS, %eax.  The
>> 32-bit kernel is a strange beast.  Also, you should probably fix up
>> %es as well.
>
>So restore_processor_state() already restores ES. The idea here was to
>reload DS 
>early on, because the kernel implicitly uses it for data access so we
>need it to 
>be good to be able to continue executing any generic kernel code.
>
>We don't use %es: prefixed assembly AFAICS, what are the implicit users
>of ES?
>
>Also, to further confuse things, we also have:
>
>ENTRY(wakeup_pmode_return)
>wakeup_pmode_return:
>        movw    $__KERNEL_DS, %ax
>        movw    %ax, %ss
>        movw    %ax, %ds
>        movw    %ax, %es
>        movw    %ax, %fs
>        movw    %ax, %gs
>
>        # reload the gdt, as we need the full 32 bit address
>        lidt    saved_idt
>        lldt    saved_ldt
>        ljmp    $(__KERNEL_CS), $1f
>1:
>        movl    %cr3, %eax
>        movl    %eax, %cr3
>        wbinvd
>
>which seems to be another layer of restoration - but it possibly does
>not trigger 
>in the S2RAM case here.
>
>Oh, funny the 'reload the gdt' comment: do you see an LGDT there? It
>reloads all 
>segment selectors, the IDT, LDT and CR3, but does not seem to reload
>the GDT - the 
>only thing the comment describes.
>
>Thanks,
>
>	Ingo

-- 
Sent from my mobile phone.  Please pardon brevity and lack of formatting.
