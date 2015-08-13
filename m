From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFCv5 PATCH 25/46] sched: Add over-utilization/tipping point
 indicator
Date: Thu, 13 Aug 2015 19:35:33 +0200
Message-ID: <20150813173533.GZ19282@twins.programming.kicks-ass.net>
References: <1436293469-25707-1-git-send-email-morten.rasmussen@arm.com>
 <1436293469-25707-26-git-send-email-morten.rasmussen@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1436293469-25707-26-git-send-email-morten.rasmussen@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Morten Rasmussen <morten.rasmussen@arm.com>
Cc: mingo@redhat.com, vincent.guittot@linaro.org, daniel.lezcano@linaro.org, Dietmar Eggemann <Dietmar.Eggemann@arm.com>, yuyang.du@intel.com, mturquette@baylibre.com, rjw@rjwysocki.net, Juri Lelli <Juri.Lelli@arm.com>, sgurrappadi@nvidia.com, pang.xunlei@zte.com.cn, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tue, Jul 07, 2015 at 07:24:08PM +0100, Morten Rasmussen wrote:
> Energy-aware scheduling is only meant to be active while the system is
> _not_ over-utilized. That is, there are spare cycles available to shift
> tasks around based on their actual utilization to get a more
> energy-efficient task distribution without depriving any tasks. When
> above the tipping point task placement is done the traditional way,
> spreading the tasks across as many cpus as possible based on priority
> scaled load to preserve smp_nice.
> 
> The over-utilization condition is conservatively chosen to indicate
> over-utilization as soon as one cpu is fully utilized at it's highest
> frequency. We don't consider groups as lumping usage and capacity
> together for a group of cpus may hide the fact that one or more cpus in
> the group are over-utilized while group-siblings are partially idle. The
> tasks could be served better if moved to another group with completely
> idle cpus. This is particularly problematic if some cpus have a
> significantly reduced capacity due to RT/IRQ pressure or if the system
> has cpus of different capacity (e.g. ARM big.LITTLE).

I might be tired, but I'm having a very hard time deciphering this
second paragraph.
