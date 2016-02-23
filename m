From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFCv7 PATCH 01/10] sched: Compute cpu capacity available at
 current frequency
Date: Tue, 23 Feb 2016 10:19:16 +0100
Message-ID: <20160223091916.GF6356@twins.programming.kicks-ass.net>
References: <1456190570-4475-1-git-send-email-smuckle@linaro.org>
 <1456190570-4475-2-git-send-email-smuckle@linaro.org>
 <CAJZ5v0hB7KeUPiwie10TeB3cMSPDLVHB5PMgjFn91SCjjC_KjQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hB7KeUPiwie10TeB3cMSPDLVHB5PMgjFn91SCjjC_KjQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Steve Muckle <steve.muckle@linaro.org>, Ingo Molnar <mingo@redhat.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Michael Turquette <mturquette@baylibre.com>
List-Id: linux-pm@vger.kernel.org

On Tue, Feb 23, 2016 at 02:41:20AM +0100, Rafael J. Wysocki wrote:
> >  /*
> > + * Returns the current capacity of cpu after applying both
> > + * cpu and freq scaling.
> > + */
> > +static unsigned long capacity_curr_of(int cpu)
> > +{
> > +       return cpu_rq(cpu)->cpu_capacity_orig *
> > +              arch_scale_freq_capacity(NULL, cpu)
> 
> What about architectures that don't have this?

They get the 'default' which is a constant SCHED_CAPACITY_SCALE unit.

> Why is that an architecture feature?

Because not all archs can tell the frequency the same way. Some you
program the DVFS state and they really run at this speed, for those you
can simply report back.

For others, x86 for example, you program a DVFS 'hint' and the hardware
does whatever, we'd have to do APERF/MPERF samples to get an idea of the
actual frequency we ran at.

Also, the having of this makes the load tracking slightly more
expensive, instead of compile time constants we get function calls and
actual multiplications. Its not _too_ bad, but still.

> I can easily imagine two x86 platforms using different
> scale_freq_capacity(), for example.

That's up to the arch, if different x86 platforms need different
thingies the arch implementation needs to offer a selector -- this isn't
'hard'.
