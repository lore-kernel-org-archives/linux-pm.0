From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH v4 08/12] sched: Add over-utilization/tipping point
 indicator
Date: Fri, 6 Jul 2018 13:41:58 +0200
Message-ID: <20180706114158.GU2458@hirez.programming.kicks-ass.net>
References: <20180628114043.24724-1-quentin.perret@arm.com>
 <20180628114043.24724-9-quentin.perret@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180628114043.24724-9-quentin.perret@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Quentin Perret <quentin.perret@arm.com>
Cc: rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, gregkh@linuxfoundation.org, mingo@redhat.com, dietmar.eggemann@arm.com, morten.rasmussen@arm.com, chris.redpath@arm.com, patrick.bellasi@arm.com, valentin.schneider@arm.com, vincent.guittot@linaro.org, thara.gopinath@linaro.org, viresh.kumar@linaro.org, tkjos@google.com, joel@joelfernandes.org, smuckle@google.com, adharmap@quicinc.com, skannan@quicinc.com, pkondeti@codeaurora.org, juri.lelli@redhat.com, edubezval@gmail.com, srinivas.pandruvada@linux.intel.com, currojerez@riseup.net, javi.merino@kernel.org
List-Id: linux-pm@vger.kernel.org

On Thu, Jun 28, 2018 at 12:40:39PM +0100, Quentin Perret wrote:
> @@ -698,6 +698,9 @@ struct root_domain {
>  	/* Indicate more than one runnable task for any CPU */
>  	bool			overload;

While there, make that an int.

> +	/* Indicate one or more cpus over-utilized (tipping point) */
> +	int			overutilized;
> +
>  	/*
>  	 * The bit corresponding to a CPU gets set here if such CPU has more
>  	 * than one runnable -deadline task (as it is below for RT tasks).
> -- 
> 2.17.1
> 
