From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH] x86: General protection fault after STR (32 bit systems
 only)
Date: Sat, 13 Jun 2015 09:03:59 +0200
Message-ID: <20150613070359.GB26502@gmail.com>
References: <1434066338-6619-1-git-send-email-srinivas.pandruvada@linux.intel.com>
 <20150612060747.GA25024@gmail.com>
 <CALCETrUfrbLeJoOeNQU2vK+jAmNBazB5rmfD5M11tv6NVeppmg@mail.gmail.com>
 <20150612075013.GA8759@gmail.com>
 <A58C5D0E-A557-4406-9317-442D78E4700B@zytor.com>
 <20150612083625.GA22760@gmail.com>
 <CAMzpN2gHpsW9ZMBdOR8+VuMNkYyi_THVeX5W4JLukmFK95GjZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181]:38849 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750939AbbFMHEF (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 13 Jun 2015 03:04:05 -0400
Content-Disposition: inline
In-Reply-To: <CAMzpN2gHpsW9ZMBdOR8+VuMNkYyi_THVeX5W4JLukmFK95GjZQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Brian Gerst <brgerst@gmail.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@amacapital.net>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Pavel Machek <pavel@ucw.cz>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, X86 ML <x86@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Denys Vlasenko <dvlasenk@redhat.com>, Borislav Petkov <bp@alien8.de>, Linus Torvalds <torvalds@linux-foundation.org>


* Brian Gerst <brgerst@gmail.com> wrote:

> On Fri, Jun 12, 2015 at 4:36 AM, Ingo Molnar <mingo@kernel.org> wrote:
> >
> > * H. Peter Anvin <hpa@zytor.com> wrote:
> >
> >> %es is used implicitly by string instructions.
> >
> > Ok, so we are probably better off reloading ES as well early, right
> > when we return from the firmware, just in case something does
> > a copy before we hit the ES restore in restore_processor_state(),
> > which is a generic C function?
> >
> > Something like the patch below?
> >
> > I also added FS/GS/SS reloading to make it complete. If this (or a variant
> > thereof, it's still totally untested) works then we can remove the segment
> > save/restore layer in __save/restore_processor_state().
> >
> > Thanks,
> >
> >         Ingo
> >
> > ===========>
> >  arch/x86/kernel/acpi/wakeup_32.S | 13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> >
> > diff --git a/arch/x86/kernel/acpi/wakeup_32.S b/arch/x86/kernel/acpi/wakeup_32.S
> > index 665c6b7d2ea9..1376a7fc21b7 100644
> > --- a/arch/x86/kernel/acpi/wakeup_32.S
> > +++ b/arch/x86/kernel/acpi/wakeup_32.S
> > @@ -61,6 +61,19 @@ ENTRY(wakeup_pmode_return)
> >
> >
> >  restore_registers:
> > +       /*
> > +        * In case the BIOS corrupted our segment descriptors,
> > +        * reload them to clear out any shadow descriptor
> > +        * state:
> > +        */
> > +       movl    $__USER_DS, %eax
> > +       movl    %eax, %ds
> > +       movl    %eax, %es
> > +       movl    %eax, %fs
> > +       movl    %eax, %gs
> > +       movl    $__KERNEL_DS, %eax
> > +       movl    %eax, %ss
> > +
> >         movl    saved_context_ebp, %ebp
> >         movl    saved_context_ebx, %ebx
> >         movl    saved_context_esi, %esi
> 
> If you follow the convoluted flow of the calls in this file, wakeup_pmode_return 
> is the first thing called from the trampoline on resume, and that loads the data 
> segments with __KERNEL_DS. [...]

So if wakeup_pmode_return is really the first thing called then the whole premise 
of shadow descriptor corruption goes out the window: we reload all relevant 
segment registers.

Which leaves us with only two small channels through which the patch might make a 
bug go away:

  - timing, as it introduces a small delay

  - code/cache layout, as it slightly rearranges the code

... but both of these are in the 'grasping at straws' category of hypotheses 
really.

Thanks,

	Ingo
