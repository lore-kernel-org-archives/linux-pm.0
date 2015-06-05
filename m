From: Ingo Molnar <mingo@kernel.org>
Subject: Re: Getting rid of i7300_idle's idle notifier?
Date: Fri, 5 Jun 2015 08:52:19 +0200
Message-ID: <20150605065219.GA19628@gmail.com>
References: <CALCETrVGefbgXzvjC3bTm9DgSr2UkpsPn6P_QwKm1cogZ0AVkQ@mail.gmail.com>
 <CALCETrUb6yhLAZ5P3J86h7DVR-vq0aVD9EHTc3YRPU2E735ETg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CALCETrUb6yhLAZ5P3J86h7DVR-vq0aVD9EHTc3YRPU2E735ETg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Lutomirski <luto@amacapital.net>
Cc: Andy Lutomirski <luto@kernel.org>, Andy Henroid <andrew.d.henroid@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, X86 ML <x86@kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>
List-Id: linux-pm@vger.kernel.org


* Andy Lutomirski <luto@amacapital.net> wrote:

> On Thu, Jun 4, 2015 at 4:32 PM, Andy Lutomirski <luto@kernel.org> wrote:
>
> > AFAICT the sole purpose for the hideous x86_64 idle_notifier mess is to 
> > support i7300_idle.  IMO this junk does not belong in IRQ handling, etc.  Can 
> > we redo this to work in some kind of generic way?
> >
> > I have no idea why it makes sense to twiddle I/O AT registers in the beginning 
> > of whatever IRQ wakes up the CPU.
> >
> > Note that, if absolutely necessary, the ECX bit 0 MWAIT extension can be used 
> > to reliably execute code before handling interrupts that wake us from idle.  
> > That is, there could be a real cpuidle driver for that chip that does:
> >
> > cli;
> > poke ioat;
> > mwait(ecx = 1);
> > poke ioat;
> > sti;
> >
> > Or we could delete the driver entirely.
> 
> It's even easier than that.  Just shove the hooks into acpi_idle_do_entry or 
> similar and remove them from every other exit_idle call site in the kernel.

Yes!

Interested in doing a patch?

Thanks,

	Ingo
