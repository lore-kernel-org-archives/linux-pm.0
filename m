From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFCv5 PATCH 36/46] sched: Prevent unnecessary active balance of
 single task in sched group
Date: Sat, 15 Aug 2015 11:46:17 +0200
Message-ID: <20150815094617.GD10304@worktop.programming.kicks-ass.net>
References: <1436293469-25707-1-git-send-email-morten.rasmussen@arm.com>
 <1436293469-25707-37-git-send-email-morten.rasmussen@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1436293469-25707-37-git-send-email-morten.rasmussen@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Morten Rasmussen <morten.rasmussen@arm.com>
Cc: mingo@redhat.com, vincent.guittot@linaro.org, daniel.lezcano@linaro.org, Dietmar Eggemann <Dietmar.Eggemann@arm.com>, yuyang.du@intel.com, mturquette@baylibre.com, rjw@rjwysocki.net, Juri Lelli <Juri.Lelli@arm.com>, sgurrappadi@nvidia.com, pang.xunlei@zte.com.cn, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tue, Jul 07, 2015 at 07:24:19PM +0100, Morten Rasmussen wrote:
> Scenarios with the busiest group having just one task and the local
> being idle on topologies with sched groups with different numbers of
> cpus manage to dodge all load-balance bailout conditions resulting the
> nr_balance_failed counter to be incremented. This eventually causes an
> pointless active migration of the task. This patch prevents this by not
> incrementing the counter when the busiest group only has one task.
> ASYM_PACKING migrations and migrations due to reduced capacity should
> still take place as these are explicitly captured by
> need_active_balance().
> 
> A better solution would be to not attempt the load-balance in the first
> place, but that requires significant changes to the order of bailout
> conditions and statistics gathering.

*groan*, and this is of course triggered by your 2+3 core TC2 thingy.

Yes, asymmetric groups like that are a pain.
