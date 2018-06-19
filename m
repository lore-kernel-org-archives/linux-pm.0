From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH v3 03/10] PM: Introduce an Energy Model management
 framework
Date: Tue, 19 Jun 2018 13:34:08 +0200
Message-ID: <20180619113408.GQ2458@hirez.programming.kicks-ass.net>
References: <20180521142505.6522-1-quentin.perret@arm.com>
 <20180521142505.6522-4-quentin.perret@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180521142505.6522-4-quentin.perret@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Quentin Perret <quentin.perret@arm.com>
Cc: rjw@rjwysocki.net, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, mingo@redhat.com, dietmar.eggemann@arm.com, morten.rasmussen@arm.com, chris.redpath@arm.com, patrick.bellasi@arm.com, valentin.schneider@arm.com, vincent.guittot@linaro.org, thara.gopinath@linaro.org, viresh.kumar@linaro.org, tkjos@google.com, joelaf@google.com, smuckle@google.com, adharmap@quicinc.com, skannan@quicinc.com, pkondeti@codeaurora.org, juri.lelli@redhat.com, edubezval@gmail.com, srinivas.pandruvada@linux.intel.com, currojerez@riseup.net, javi.merino@kernel.org
List-Id: linux-pm@vger.kernel.org

On Mon, May 21, 2018 at 03:24:58PM +0100, Quentin Perret wrote:
> +struct em_freq_domain *em_cpu_get(int cpu)
> +{
> +	struct em_freq_domain *fd;
> +	unsigned long flags;
> +
> +	read_lock_irqsave(&em_data_lock, flags);
> +	fd = per_cpu(em_data, cpu);
> +	read_unlock_irqrestore(&em_data_lock, flags);

Why can't this use RCU? This is the exact thing read_locks are terrible
at and RCU excells at.

> +
> +	return fd;
> +}
> +EXPORT_SYMBOL_GPL(em_cpu_get);
