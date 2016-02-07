From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 3/3 v4] cpufreq: governor: Replace timers with utilization update callbacks
Date: Sun, 07 Feb 2016 15:36:02 +0100
Message-ID: <1454866843.QpS6doj9Wg@vostro.rjw.lan>
References: <3071836.JbNxX8hU6x@vostro.rjw.lan> <2848076.UWJmIl2O1K@vostro.rjw.lan> <20160207092019.GB6112@vireshk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:53802 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753314AbcBGOex (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 7 Feb 2016 09:34:53 -0500
In-Reply-To: <20160207092019.GB6112@vireshk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Juri Lelli <juri.lelli@arm.com>, Steve Muckle <steve.muckle@linaro.org>, Thomas Gleixner <tglx@linutronix.de>

On Sunday, February 07, 2016 02:50:19 PM Viresh Kumar wrote:
> On 06-02-16, 04:40, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > 
> > Instead of using a per-CPU deferrable timer for queuing up governor
> > work items, register a utilization update callback that will be
> > invoked from the scheduler on utilization changes.
> > 
> > The sampling rate is still the same as what was used for the
> > deferrable timers and the added irq_work overhead should be offset by
> > the eliminated timers overhead, so in theory the functional impact of
> > this patch should not be significant.
> > 
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> > 
> > Updated after the recent discussion with Viresh.
> > 
> > Changes from v3:
> > - The completion used for irq_work synchronization replaced with irq_work_sync()
> >   in gov_cancel_work().
> > - update_sampling_rate() now modifies shared->sample_delay_ns for all CPUs
> >   where it matters directly with a big fat comment explaining why this is
> >   actually OK.
> > - The above means the time_stamp field in struct cpu_common_dbs_info is not
> >   necessary any more, so it is dropped.
> > - A build error for !CONFIG_SMP is addressed (hopefully effectively).
> > 
> > This version was lightly tested on an x86 laptop.
> 
> Awesome work Rafael, this looks really good now.
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Thanks!

I have one small update, though.  Namely, it is more logical to initialize
irq_work along with doing INIT_WORK() on the main work item.

I'll send it in a while.

Thanks,
Rafael

