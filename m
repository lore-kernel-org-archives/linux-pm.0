From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 3/3 v3] cpufreq: governor: Replace timers with utilization update callbacks
Date: Sat, 06 Feb 2016 00:01:23 +0100
Message-ID: <3346220.PhsC7fhrI6@vostro.rjw.lan>
References: <3071836.JbNxX8hU6x@vostro.rjw.lan> <20160205065037.GD21792@vireshk> <CAJZ5v0im=K5zVQMgOTKDUnXUTZ-ursAOQ+cu_YYAZisUbvx++g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:49042 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753251AbcBEXAR (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 5 Feb 2016 18:00:17 -0500
In-Reply-To: <CAJZ5v0im=K5zVQMgOTKDUnXUTZ-ursAOQ+cu_YYAZisUbvx++g@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Juri Lelli <juri.lelli@arm.com>, Steve Muckle <steve.muckle@linaro.org>, Thomas Gleixner <tglx@linutronix.de>

On Friday, February 05, 2016 02:36:54 PM Rafael J. Wysocki wrote:
> On Fri, Feb 5, 2016 at 7:50 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > Will suck some more blood, sorry about that :)
> >
> > On 05-02-16, 02:28, Rafael J. Wysocki wrote:
> >> The v3 addresses some review comments from Viresh and a couple of issues found
> >> by me.  Changes from the previous version:
> >> - Synchronize gov_cancel_work() with the (new) irq_work properly.
> >> - Add a comment about the (new) memory barrier.
> >> - Move samle_delay_ns to "shared" (struct cpu_common_dbs_info) so it is the
> >
> > sample_delay_ns was already there, you moved last_sample_time instead :)
> >
> >> @@ -139,7 +141,11 @@ struct cpu_common_dbs_info {
> >>       struct mutex timer_mutex;
> >>
> >>       ktime_t time_stamp;
> >> +     u64 last_sample_time;
> >> +     s64 sample_delay_ns;
> >>       atomic_t skip_work;
> >> +     struct irq_work irq_work;
> >
> > Just for my understanding, why can't we schedule a normal work directly? Is it
> > because of scheduler's hotpath and queue_work() is slow?
> 
> No, that's not the reason.
> 
> That path can't call wake_up_process() as it may be holding the locks
> this would have attempted to grab.

My answer wasn't really to the point here.

Among other things, the scheduler path cannot use normal spinlocks.  It can
only use raw spinlocks and this means no work queuing from it.

Thanks,
Rafael

