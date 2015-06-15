From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH v2] x86: Load __USER_DS into DS/ES after resume
Date: Mon, 15 Jun 2015 09:12:02 -0700
Message-ID: <1434384722.2353.49.camel@spandruv-DESK3.jf.intel.com>
References: <CALCETrUfrbLeJoOeNQU2vK+jAmNBazB5rmfD5M11tv6NVeppmg@mail.gmail.com>
	 <20150612075013.GA8759@gmail.com>
	 <A58C5D0E-A557-4406-9317-442D78E4700B@zytor.com>
	 <20150612083625.GA22760@gmail.com>
	 <CAMzpN2gHpsW9ZMBdOR8+VuMNkYyi_THVeX5W4JLukmFK95GjZQ@mail.gmail.com>
	 <20150613070359.GB26502@gmail.com>
	 <CALCETrX_goAyqMVdkZTnJwDCJgfz2osVVsNAt8Gv3ZqZMX85ZQ@mail.gmail.com>
	 <CAMzpN2jyQWTEWd4sZosfkocDabu=CxiEVncp94+P+vHYjpicTw@mail.gmail.com>
	 <20150614065635.GA5294@gmail.com>
	 <CA+55aFzB9dYidEf_7Hs47FOF7WPPJnJQwj_RiwL--c5Gb1uqyw@mail.gmail.com>
	 <20150614074922.GA30290@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:5202 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932150AbbFOQOG (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 15 Jun 2015 12:14:06 -0400
In-Reply-To: <20150614074922.GA30290@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Denys Vlasenko <dvlasenk@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, the arch/x86 maintainers <x86@kernel.org>, linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Andy Lutomirski <luto@amacapital.net>, Brian Gerst <brgerst@gmail.com>, Peter Anvin <hpa@zytor.com>

On Sun, 2015-06-14 at 09:49 +0200, Ingo Molnar wrote:
> * Linus Torvalds <torvalds@linux-foundation.org> wrote:
> 
> > On Jun 13, 2015 8:56 PM, "Ingo Molnar" <mingo@kernel.org> wrote:
> > >
> > > Ok, so something like the patch below, right?
> > >
> > >         movw    $__KERNEL_DS, %ax
> > >         movw    %ax, %ss
> > > -       movw    %ax, %ds
> > > -       movw    %ax, %es
> > >         movw    %ax, %fs
> > >         movw    %ax, %gs
> > >
> > > +       movw    $__KERNEL_DS, %ax
> > > +       movw    %ax, %ds
> > > +       movw    %ax, %es
> > 
> > .. except with less cut-and-paste bugs.
> > 
> > That second KERNEL should be USER.
> 
> Yeah, doh :-/ Updated patch below.
> 
> Thanks,
> 
> 	Ingo
> 
> =====
>  arch/x86/kernel/acpi/wakeup_32.S | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kernel/acpi/wakeup_32.S b/arch/x86/kernel/acpi/wakeup_32.S
> index 665c6b7d2ea9..0c26b1b44e51 100644
> --- a/arch/x86/kernel/acpi/wakeup_32.S
> +++ b/arch/x86/kernel/acpi/wakeup_32.S
> @@ -12,11 +12,13 @@ ENTRY(wakeup_pmode_return)
>  wakeup_pmode_return:
>  	movw	$__KERNEL_DS, %ax
>  	movw	%ax, %ss
> -	movw	%ax, %ds
> -	movw	%ax, %es
>  	movw	%ax, %fs
>  	movw	%ax, %gs
>  
> +	movw	$__USER_DS, %ax
> +	movw	%ax, %ds
> +	movw	%ax, %es
> +
>  	# reload the gdt, as we need the full 32 bit address
>  	lidt	saved_idt
>  	lldt	saved_ldt

We did suggest this patch to our customer and initial test results
showed no crash. But they didn't merge this because they did months of
testing with my earlier patch with load/save segment of ds, which will
store restore _USER_DS.

I tried this patch again today on another 32 bit system and STR didn't
break, so if you apply this change, during next kernel upgrade this will
be picked up.

Thanks to you, Andy, Brian for helping on this issue.

- Srinivas


