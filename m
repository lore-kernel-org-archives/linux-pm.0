From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] x86: Load __USER_DS into DS/ES after resume
Date: Sun, 14 Jun 2015 09:03:20 +0200
Message-ID: <20150614070319.GA15988@amd>
References: <20150612060747.GA25024@gmail.com>
 <CALCETrUfrbLeJoOeNQU2vK+jAmNBazB5rmfD5M11tv6NVeppmg@mail.gmail.com>
 <20150612075013.GA8759@gmail.com>
 <A58C5D0E-A557-4406-9317-442D78E4700B@zytor.com>
 <20150612083625.GA22760@gmail.com>
 <CAMzpN2gHpsW9ZMBdOR8+VuMNkYyi_THVeX5W4JLukmFK95GjZQ@mail.gmail.com>
 <20150613070359.GB26502@gmail.com>
 <CALCETrX_goAyqMVdkZTnJwDCJgfz2osVVsNAt8Gv3ZqZMX85ZQ@mail.gmail.com>
 <CAMzpN2jyQWTEWd4sZosfkocDabu=CxiEVncp94+P+vHYjpicTw@mail.gmail.com>
 <20150614065635.GA5294@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:48322 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751754AbbFNHDX (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 14 Jun 2015 03:03:23 -0400
Content-Disposition: inline
In-Reply-To: <20150614065635.GA5294@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Brian Gerst <brgerst@gmail.com>, Andy Lutomirski <luto@amacapital.net>, "H. Peter Anvin" <hpa@zytor.com>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, X86 ML <x86@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Denys Vlasenko <dvlasenk@redhat.com>, Borislav Petkov <bp@alien8.de>, Linus Torvalds <torvalds@linux-foundation.org>

On Sun 2015-06-14 08:56:35, Ingo Molnar wrote:
> 
> * Brian Gerst <brgerst@gmail.com> wrote:
> 
> > >> So if wakeup_pmode_return is really the first thing called then the whole 
> > >> premise of shadow descriptor corruption goes out the window: we reload all 
> > >> relevant segment registers.
> > >
> > > True, but it still leaves the fact that we're loading __KERNEL_DS instead of 
> > > __USER_DS, right?  So we end up in the kernel in some context (I have no clue 
> > > what context) with __KERNEL_DS loaded.  It's very easy for us to inadvertently 
> > > fix it: we could return to userspace by any means whatsoever except SYSEXIT, 
> > > or we could even return back to some preempted kernel context.
> > >
> > > I still think we should replace __KERNEL_DS with __USER_DS in 
> > > wakeup_pmode_return and see if the problem goes away.
> > 
> > I'm pretty sure that's what the problem is.  If you look at the sysexit path, it 
> > never reloads ds/es.  It assumes they are still __USER_DS set at sysenter.  The 
> > iret path does restore all the user segments.
> 
> Ok, so something like the patch below, right?
> 
> Thanks,
> 
> 	Ingo
> 
> =====================>
>  arch/x86/kernel/acpi/wakeup_32.S | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kernel/acpi/wakeup_32.S b/arch/x86/kernel/acpi/wakeup_32.S
> index 665c6b7d2ea9..7302bbaea184 100644
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
> +	movw	$__KERNEL_DS, %ax
> +	movw	%ax, %ds
> +	movw	%ax, %es

Umm. Are you sure? :-).
									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
