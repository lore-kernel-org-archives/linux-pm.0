From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH] x86: General protection fault after STR (32 bit systems
 only)
Date: Fri, 12 Jun 2015 09:15:07 +0200
Message-ID: <20150612071507.GA6411@gmail.com>
References: <1434066338-6619-1-git-send-email-srinivas.pandruvada@linux.intel.com>
 <20150612060747.GA25024@gmail.com>
 <CALCETrWjckJqfBdvhjGk81-tOOKu8QVeT6WC=hjtXYURvJ7dmA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CALCETrWjckJqfBdvhjGk81-tOOKu8QVeT6WC=hjtXYURvJ7dmA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Lutomirski <luto@amacapital.net>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Pavel Machek <pavel@ucw.cz>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, X86 ML <x86@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Denys Vlasenko <dvlasenk@redhat.com>, Borislav Petkov <bp@alien8.de>, Brian Gerst <brgerst@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org


* Andy Lutomirski <luto@amacapital.net> wrote:

> > 1)
> >
> > So the first critical question is: if the ACPI/BIOS suspend code corrupts the 
> > kernel's DS, how can we get so far as to resume fully, return to user-space, 
> > and segfault there so that it can all be reported?
> >
> > So neither the explanation nor the code makes any sense in the context of the 
> > reported bugs. Can anyone else offer any plausible theory about why this patch 
> > would fix 32-bit user-space segfaults?
> 
> I'm too tired to look at this intelligently right now, but this reminds me of 
> the sysret_ss_attrs thing.  What if we have a situation where, after 
> suspend/resume, we end up with a perfectly valid ss *selector* (or, on 64-bit 
> kernels, a ds selector that does not matter one whit) but a somehow-screwed-up 
> ds *cached hidden descriptor*.  (On 32-bit kernels, this could be something 
> exotic like grows-down limit 2^31.)

Yes, that theory is what my patch tests, by reloading DS with __KERNEL_DS.

This should be safe as the first thing to execute after re-entry, as we don't 
save/restore the GDT. (If the BIOS mucks with the GDT without restoring it to our 
value we are probably screwed in any case.)

> Now we do the very first return.  If we're on AMD hardware and that return is 
> SYSRET, then we end up with some complete random garbage loaded in the hidden DS 
> descriptor if SYSRET on 32-bit mode is indeed screwed up on AMD.

But why would this change from v3.10 to v3.11? I cannot see any low level x86 
change that should make a difference there.

> Don't even bother saving it.  Just load the known value on resume.

Yeah, so that's what my simple patch does.

> Here's my full-fledged half-asleep theory:
> 
> We suspend to RAM.  We resume.  DS and/or ES contains something unusual but not 
> unusual enough to crash us.  Our first entry to userspace is via SYSEXIT.  
> Because we're daft, we don't reload DS or ES at any point along the way.  Now 
> we're in userspace with an even more screwed up DS or ES than usual.  We get 
> SIGSEGV (presumably #GP) and try to deliver the signal.  We end up with 
> impossible pt_regs (bogus RPL) but who cares?  We get to __setup_frame, which 
> fixes the garbage in pt_regs and we re-enter user mode through an IRET patch, so 
> we finally reload DS and ES.  As a result, we successfully deliver the signal.  
> The saved regs would reveal the damage, but systemd throws them away, and we 
> remain confused for a full ten kernel versions.

That's indeed plausible.

If so then the DS reloading patch I sent should help.

So we should also do a full review of all the DS/ES save/restore paths, 
everywhere, as they don't seem to be very consistently done.

Thanks,

	Ingo
