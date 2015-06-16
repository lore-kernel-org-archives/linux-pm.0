From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v2] x86: Load __USER_DS into DS/ES after resume
Date: Tue, 16 Jun 2015 11:13:33 +0200
Message-ID: <20150616091333.GA6448@amd>
References: <20150612075013.GA8759@gmail.com>
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
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:49359 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933075AbbFPJNg (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 16 Jun 2015 05:13:36 -0400
Content-Disposition: inline
In-Reply-To: <20150614074922.GA30290@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Denys Vlasenko <dvlasenk@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, the arch/x86 maintainers <x86@kernel.org>, linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Andy Lutomirski <luto@amacapital.net>, Brian Gerst <brgerst@gmail.com>, Peter Anvin <hpa@zytor.com>

> > That second KERNEL should be USER.
> 
> Yeah, doh :-/ Updated patch below.
> 
> Thanks,
> 
> 	Ingo

Acked-by: Pavel Machek <pavel@ucw.cz>
Tested-by: Pavel Machek <pavel@ucw.cz>

[of course, it worked for me before, so I only tested it also works
with the patch.]

Rafael, can you apply it?
									Pavel


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

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
