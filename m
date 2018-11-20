From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v9 02/15] sched/cpufreq: Prepare schedutil for Energy
 Aware Scheduling
Date: Tue, 20 Nov 2018 10:16:02 +0530
Message-ID: <20181120044602.bsfsp4alswbwoweu@vireshk-i7>
References: <20181119141857.8625-1-quentin.perret@arm.com>
 <20181119141857.8625-3-quentin.perret@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181119141857.8625-3-quentin.perret@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Quentin Perret <quentin.perret@arm.com>
Cc: peterz@infradead.org, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, gregkh@linuxfoundation.org, mingo@redhat.com, dietmar.eggemann@arm.com, morten.rasmussen@arm.com, chris.redpath@arm.com, patrick.bellasi@arm.com, valentin.schneider@arm.com, vincent.guittot@linaro.org, thara.gopinath@linaro.org, tkjos@google.com, joel@joelfernandes.org, smuckle@google.com, adharmap@codeaurora.org, skannan@codeaurora.org, pkondeti@codeaurora.org, juri.lelli@redhat.com, edubezval@gmail.com, srinivas.pandruvada@linux.intel.com, currojerez@riseup.net, javi.merino@kernel.org
List-Id: linux-pm@vger.kernel.org

On 19-11-18, 14:18, Quentin Perret wrote:
> @@ -223,20 +222,33 @@ static unsigned long sugov_get_util(struct sugov_cpu *sg_cpu)

> -	if ((util + cpu_util_dl(rq)) >= max)
> -		return max;
> +	if (type == FREQUENCY_UTIL) {
> +		/*
> +		 * For frequency selection we do not make cpu_util_dl() a
> +		 * permanent part of this sum because we want to use
> +		 * cpu_bw_dl() later on, but we need to check if the
> +		 * CFS+RT+DL sum is saturated (ie. no idle time) such
> +		 * that we select f_max when there is no idle time.
> +		 *
> +		 * NOTE: numerical errors or stop class might cause us
> +		 * to not quite hit saturation when we should --
> +		 * something for later.
> +		 */
> +
> +		if ((util + cpu_util_dl(rq)) >= max)
> +			return max;
> +	} else {
> +		/*
> +		 * OTOH, for energy computation we need the estimated
> +		 * running time, so include util_dl and ignore dl_bw.
> +		 */
> +		util += cpu_util_dl(rq);
> +		if (util >= max)
> +			return max;
> +	}

Maybe write above as:

        dl_util = cpu_util_dl(rq);

        if ((util + dl_util) >= max)
                return max;

	if (type != FREQUENCY_UTIL)
		util += dl_util;


as both the if/else parts were doing almost the same thing.

-- 
viresh
