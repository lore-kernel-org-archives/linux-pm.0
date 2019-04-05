From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] PM / arch: x86: Rework the MSR_IA32_ENERGY_PERF_BIAS
 handling
Date: Fri, 5 Apr 2019 17:32:09 +0200 (CEST)
Message-ID: <alpine.DEB.2.21.1904051731510.1802@nanos.tec.linutronix.de>
References: <2816566.rddYshD6lm@aspire.rjw.lan> <20190321075807.GK6058@hirez.programming.kicks-ass.net> <CAJZ5v0hz3KFtmsP+8Qbee7KrV4BBOUzReUmK8BWH52+hwekt=Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0hz3KFtmsP+8Qbee7KrV4BBOUzReUmK8BWH52+hwekt=Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>, Linux PM <linux-pm@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Laura Abbott <labbott@fedoraproject.org>, Ingo Molnar <mingo@kernel.org>, Simon Schricker <sschricker@suse.de>, Borislav Petkov <bp@suse.de>, Hannes Reinecke <hare@suse.de>
List-Id: linux-pm@vger.kernel.org

On Thu, 21 Mar 2019, Rafael J. Wysocki wrote:

> On Thu, Mar 21, 2019 at 8:58 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Thu, Mar 21, 2019 at 01:00:52AM +0100, Rafael J. Wysocki wrote:
> > > + * The Performance and Energy Bias Hint (EPB) allows software to specify its
> > > + * preference with respect to the power-performance tradeoffs present in the
> > > + * processor.  Generally, the EPB is expected to be set by user space through
> > > + * the generic MSR interface (with the help of the x86_energy_perf_policy tool),
> > > + * but there are two reasons for the kernel to touch it.
> >
> > So I hate /dev/msr with a passion. It is absolute atrocious crap.
> >
> > Please, just make a real interface for this if it is important.
> 
> That's the plan going forward, this is just documenting the current situation.
> 
> Do you have any particular concerns regarding this patch?

No.

Acked-by: Thomas Gleixner <tglx@linutronix.de>
