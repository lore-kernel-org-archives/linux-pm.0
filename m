From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 1/2] PM / arch: x86: Rework the MSR_IA32_ENERGY_PERF_BIAS handling
Date: Mon, 25 Mar 2019 11:06:36 +0100
Message-ID: <CAJZ5v0hBRXhQqqXp4wSe+EJNcsJRN5knx0DONnc5UTa+601mug@mail.gmail.com>
References: <1637073.gl2OfxWTjI@aspire.rjw.lan> <1605148.8jT99SsvVP@aspire.rjw.lan>
 <20190322142828.GA12472@zn.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190322142828.GA12472@zn.tnic>
Sender: linux-kernel-owner@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>, Linux PM <linux-pm@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Laura Abbott <labbott@fedoraproject.org>, Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Simon Schricker <sschricker@suse.de>, Hannes Reinecke <hare@suse.de>
List-Id: linux-pm@vger.kernel.org

On Fri, Mar 22, 2019 at 3:28 PM Borislav Petkov <bp@alien8.de> wrote:
>
> On Thu, Mar 21, 2019 at 11:18:01PM +0100, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > The current handling of MSR_IA32_ENERGY_PERF_BIAS in the kernel is
> > problematic, because it may cause changes made by user space to that
> > MSR (with the help of the x86_energy_perf_policy tool, for example)
>
> One more reason to control MSR accesses from userspace. I'm working on
> a series to even completely forbid accesses to some MSRs over /dev/msr
> so I think accessing MSR_IA32_ENERGY_PERF_BIAS solely over the new
> interface in patch 2 would be much better.
>
> So, you're carrying those and you'd like to have an ACK from me?
>
> Btw, a couple of nitpicks below.
>
> > Index: linux-pm/arch/x86/kernel/cpu/intel_epb.c
> > ===================================================================
> > --- /dev/null
> > +++ linux-pm/arch/x86/kernel/cpu/intel_epb.c
> > @@ -0,0 +1,131 @@
> > +// SPDX-License-Identifier: GPL-2.0
>
> ...
>
> > +static DEFINE_PER_CPU(u8, saved_epb);
> > +
> > +#define EPB_MASK     0x0fULL
> > +#define EPB_SAVED    0x10ULL
> > +
> > +static int intel_epb_save(void)
>
> I'd drop that "intel_epb_" prefix from those static functions, but your
> call...

They help indexing tools (elixir.bootlin.com and similar) a bit, so
I'd rather retain them.

> > +{
> > +     u64 epb;
> > +
> > +     rdmsrl(MSR_IA32_ENERGY_PERF_BIAS, epb);
> > +     /*
> > +      * Ensure that saved_epb will always be nonzero after this write even if
> > +      * the EPB value read from the MSR is 0.
> > +      */
> > +     this_cpu_write(saved_epb, (epb & EPB_MASK) | EPB_SAVED);
> > +
> > +     return 0;
> > +}
>
> ...
>
> > Index: linux-pm/Documentation/admin-guide/pm/intel_epb.rst
> > ===================================================================
> > --- /dev/null
> > +++ linux-pm/Documentation/admin-guide/pm/intel_epb.rst
>
> WARNING: Missing or malformed SPDX-License-Identifier tag in line 1
> #345: FILE: Documentation/admin-guide/pm/intel_epb.rst:1:

Well, this is documentation, so ...
