From: Yuyang Du <yuyang.du@intel.com>
Subject: Re: [PATCH 3/4] intel_pstate: add sample time scaling
Date: Fri, 30 May 2014 02:17:04 +0800
Message-ID: <20140529181704.GA4691@intel.com>
References: <1401381145-17745-1-git-send-email-dirk.j.brandewie@intel.com>
 <1401381145-17745-4-git-send-email-dirk.j.brandewie@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1401381145-17745-4-git-send-email-dirk.j.brandewie@intel.com>
Sender: stable-owner@vger.kernel.org
To: dirk.brandewie@gmail.com
Cc: linux-pm@vger.kernel.org, rjw@rjwysocki.net, dsmythies@telus.net, Dirk Brandewie <dirk.j.brandewie@intel.com>, stable@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

>  static inline int32_t intel_pstate_get_scaled_busy(struct cpudata *cpu)
>  {
> -	int32_t core_busy, max_pstate, current_pstate;
> +	int32_t core_busy, max_pstate, current_pstate, sample_ratio;
> +	u32 duration_us;
> +	u32 sample_time;
>  
>  	core_busy = cpu->sample.core_pct_busy;
>  	max_pstate = int_tofp(cpu->pstate.max_pstate);
>  	current_pstate = int_tofp(cpu->pstate.current_pstate);
>  	core_busy = mul_fp(core_busy, div_fp(max_pstate, current_pstate));
> +
> +	sample_time = (pid_params.sample_rate_ms  * USEC_PER_MSEC);
> +	duration_us = (u32) ktime_us_delta(cpu->sample.time,
> +					cpu->last_sample_time);
> +	if (duration_us > sample_time * 3) {
> +		sample_ratio = div_fp(int_tofp(sample_time),
> +				int_tofp(duration_us));
> +		core_busy = mul_fp(core_busy, sample_ratio);
> +	}
> +
>  	return core_busy;
>  }

Hi Dirk,

I am afraid I need to question again since you did not address my concern.

So generally, this new patch will factor (sample_rate / duration) in
(last_freq / last_request) if duration > 3*sample_time.

This sample_rate / duration thing looks random. And otherwise it is still
effectively performance governor behavior if what I reasoned before is right.

So my opinion is, the C0 tracking is not the (true) root cause to perf regression.
But if you really need this patch as a temp workaround, it is ok.

Thanks,
Yuyang
