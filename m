From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RFCv7 PATCH 01/10] sched: Compute cpu capacity available at current frequency
Date: Fri, 26 Feb 2016 02:37:19 +0100
Message-ID: <1913831.CWh4G0m0Lj@vostro.rjw.lan>
References: <1456190570-4475-1-git-send-email-smuckle@linaro.org> <CAJZ5v0hB7KeUPiwie10TeB3cMSPDLVHB5PMgjFn91SCjjC_KjQ@mail.gmail.com> <20160223091916.GF6356@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:65467 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752550AbcBZBfo (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 25 Feb 2016 20:35:44 -0500
In-Reply-To: <20160223091916.GF6356@twins.programming.kicks-ass.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Steve Muckle <steve.muckle@linaro.org>, Ingo Molnar <mingo@redhat.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Michael Turquette <mturquette@baylibre.com>

On Tuesday, February 23, 2016 10:19:16 AM Peter Zijlstra wrote:
> On Tue, Feb 23, 2016 at 02:41:20AM +0100, Rafael J. Wysocki wrote:
> > >  /*
> > > + * Returns the current capacity of cpu after applying both
> > > + * cpu and freq scaling.
> > > + */
> > > +static unsigned long capacity_curr_of(int cpu)
> > > +{
> > > +       return cpu_rq(cpu)->cpu_capacity_orig *
> > > +              arch_scale_freq_capacity(NULL, cpu)
> > 
> > What about architectures that don't have this?
> 
> They get the 'default' which is a constant SCHED_CAPACITY_SCALE unit.
> 
> > Why is that an architecture feature?
> 
> Because not all archs can tell the frequency the same way. Some you
> program the DVFS state and they really run at this speed, for those you
> can simply report back.
> 
> For others, x86 for example, you program a DVFS 'hint' and the hardware
> does whatever, we'd have to do APERF/MPERF samples to get an idea of the
> actual frequency we ran at.
> 
> Also, the having of this makes the load tracking slightly more
> expensive, instead of compile time constants we get function calls and
> actual multiplications. Its not _too_ bad, but still.

That's all correct, but my question should rather be: is arch the right
granularity?

In theory, there may be ARM64-based platforms using ACPI and behaving
like x86 in that respect in the future.

Thanks,
Rafael

