From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v7 06/14] sched/topology: Reference the Energy Model of
 CPUs when available
Date: Tue, 2 Oct 2018 14:36:17 +0200
Message-ID: <20181002123617.GB3439@hirez.programming.kicks-ass.net>
References: <20180912091309.7551-1-quentin.perret@arm.com>
 <20180912091309.7551-7-quentin.perret@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180912091309.7551-7-quentin.perret@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Quentin Perret <quentin.perret@arm.com>
Cc: rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, gregkh@linuxfoundation.org, mingo@redhat.com, dietmar.eggemann@arm.com, morten.rasmussen@arm.com, chris.redpath@arm.com, patrick.bellasi@arm.com, valentin.schneider@arm.com, vincent.guittot@linaro.org, thara.gopinath@linaro.org, viresh.kumar@linaro.org, tkjos@google.com, joel@joelfernandes.org, smuckle@google.com, adharmap@codeaurora.org, skannan@codeaurora.org, pkondeti@codeaurora.org, juri.lelli@redhat.com, edubezval@gmail.com, srinivas.pandruvada@linux.intel.com, currojerez@riseup.net, javi.merino@kernel.org
List-Id: linux-pm@vger.kernel.org

On Wed, Sep 12, 2018 at 10:13:01AM +0100, Quentin Perret wrote:
> +struct perf_domain {
> +	struct em_perf_domain *obj;
> +	struct perf_domain *next;
> +	struct rcu_head rcu;
> +};

Maybe s/obj/em_pd/ or something like that? @obj is so very opaque.
