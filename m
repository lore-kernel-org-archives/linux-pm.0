From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v9 08/15] sched/topology: Make Energy Aware Scheduling
 depend on schedutil
Date: Thu, 22 Nov 2018 15:04:32 +0100
Message-ID: <20181122140432.GH2113@hirez.programming.kicks-ass.net>
References: <20181119141857.8625-1-quentin.perret@arm.com>
 <20181119141857.8625-9-quentin.perret@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181119141857.8625-9-quentin.perret@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Quentin Perret <quentin.perret@arm.com>
Cc: rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, gregkh@linuxfoundation.org, mingo@redhat.com, dietmar.eggemann@arm.com, morten.rasmussen@arm.com, chris.redpath@arm.com, patrick.bellasi@arm.com, valentin.schneider@arm.com, vincent.guittot@linaro.org, thara.gopinath@linaro.org, viresh.kumar@linaro.org, tkjos@google.com, joel@joelfernandes.org, smuckle@google.com, adharmap@codeaurora.org, skannan@codeaurora.org, pkondeti@codeaurora.org, juri.lelli@redhat.com, edubezval@gmail.com, srinivas.pandruvada@linux.intel.com, currojerez@riseup.net, javi.merino@kernel.org
List-Id: linux-pm@vger.kernel.org

On Mon, Nov 19, 2018 at 02:18:50PM +0000, Quentin Perret wrote:
> +			if (rd->pd)
> +				pr_warn("rd %*pbl: Disabling EAS, schedutil is mandatory\n",
> +						cpumask_pr_args(cpu_map));
> +			goto free;

I would have preferred just not allowing the governor to change at all,
but if you want to allow that, this is, I suppose, the best you can do.

Rafael, are you otherwise OK with the grubbing inside cpufreq?
