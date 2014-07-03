From: Yuyang Du <yuyang.du@intel.com>
Subject: Re: [RFCv2 PATCH 08/23] sched: Aggregate unweighted load contributed
 by task entities on parenting cfs_rq
Date: Fri, 4 Jul 2014 07:50:45 +0800
Message-ID: <20140703235045.GB4881@intel.com>
References: <1404404770-323-1-git-send-email-morten.rasmussen@arm.com>
 <1404404770-323-9-git-send-email-morten.rasmussen@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1404404770-323-9-git-send-email-morten.rasmussen@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Morten Rasmussen <morten.rasmussen@arm.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "peterz@infradead.org" <peterz@infradead.org>, "mingo@kernel.org" <mingo@kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>, "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>, "preeti@linux.vnet.ibm.com" <preeti@linux.vnet.ibm.com>, "Dietmar.Eggemann@arm.com" <Dietmar.Eggemann@arm.com>, "pjt@google.com" <pjt@google.com>
List-Id: linux-pm@vger.kernel.org

On Fri, Jul 04, 2014 at 12:25:55AM +0800, Morten Rasmussen wrote:
> From: Dietmar Eggemann <dietmar.eggemann@arm.com>
> 
> Energy aware scheduling relies on cpu utilization and to be able to
> maintain it, we need a per run queue signal of the sum of the
> unweighted, i.e. not scaled with task priority, load contribution of
> runnable task entries.
> 
> The unweighted runnable load on a run queue is maintained alongside the
> existing (weighted) runnable load.
> 
> This patch is the unweighted counterpart of "sched: Aggregate load
> contributed by task entities on parenting cfs_rq" (commit id
> 2dac754e10a5).
> 
Hi Dietmar and Morten,

You may or may not have noticed my patch the other day:

sched: Rewrite per entity runnable load average tracking

With this new load average tracking, unweighted load average will be very much
simplifed to do.

Thanks,
Yuyang
