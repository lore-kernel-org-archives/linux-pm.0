From: Jayachandran C <jnair@caviumnetworks.com>
Subject: Re: [v2] cpufreq / CPPC: Add cpuinfo_cur_freq support for CPPC
Date: Tue, 19 Jun 2018 13:39:11 -0700
Message-ID: <20180619203846.GA6083@jc-sabre>
References: <1529056995-122792-1-git-send-email-george.cherian@cavium.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1529056995-122792-1-git-send-email-george.cherian@cavium.com>
Sender: linux-kernel-owner@vger.kernel.org
To: George Cherian <george.cherian@cavium.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, viresh.kumar@linaro.org, rjw@rjwysocki.net, pprakash@codeaurora.org
List-Id: linux-pm@vger.kernel.org

Hi George,

Few comments on your patch:

On Fri, Jun 15, 2018 at 03:03:15AM -0700, George Cherian wrote:
> Per Section 8.4.7.1.3 of ACPI 6.2, The platform provides performance
> feedback via set of performance counters. To determine the actual
> performance level delivered over time, OSPM may read a set of
> performance counters from the Reference Performance Counter Register
> and the Delivered Performance Counter Register.
> 
> OSPM calculates the delivered performance over a given time period by
> taking a beginning and ending snapshot of both the reference and
> delivered performance counters, and calculating:
> 
> delivered_perf = reference_perf X (delta of delivered_perf counter / delta of reference_perf counter).
> 
> Implement the above and hook this to the cpufreq->get method.
> 
> Signed-off-by: George Cherian <george.cherian@cavium.com>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/cppc_cpufreq.c | 71 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 71 insertions(+)
> 
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index 3464580..3fe7625 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -296,10 +296,81 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
>  	return ret;
>  }
>  
> +static int cppc_get_rate_from_fbctrs(struct cppc_cpudata *cpu,
> +				     struct cppc_perf_fb_ctrs fb_ctrs_t0,
> +				     struct cppc_perf_fb_ctrs fb_ctrs_t1)
> +{
> +	u64 delta_reference, delta_delivered;
> +	u64 reference_perf, delivered_perf;
> +
> +	reference_perf = fb_ctrs_t0.reference_perf;
> +	if (fb_ctrs_t1.reference > fb_ctrs_t0.reference) {
> +		delta_reference = fb_ctrs_t1.reference - fb_ctrs_t0.reference;
> +	} else {
> +		/*
> +		 * Counters would have wrapped-around
> +		 * We also need to find whether the low level fw
> +		 * maintains 32 bit or 64 bit counters, to calculate
> +		 * the correct delta.
> +		 */
> +		if (fb_ctrs_t0.reference > (~(u32)0))
> +			delta_reference  = (~((u64)0) - fb_ctrs_t0.reference) +
> +					fb_ctrs_t1.reference;
> +		else
> +			delta_reference  = (~((u32)0) - fb_ctrs_t0.reference) +
> +					fb_ctrs_t1.reference;
> +	}
> +
> +	if (fb_ctrs_t1.delivered > fb_ctrs_t0.delivered) {
> +		delta_delivered = fb_ctrs_t1.delivered - fb_ctrs_t0.delivered;
> +	} else {
> +		/*
> +		 * Counters would have wrapped-around
> +		 * We also need to find whether the low level fw
> +		 * maintains 32 bit or 64 bit counters, to calculate
> +		 * the correct delta.
> +		 */
> +		if (fb_ctrs_t0.delivered > (~(u32)0))
> +			delta_delivered  = (~((u64)0) - fb_ctrs_t0.delivered) +
> +					fb_ctrs_t1.delivered;
> +		else
> +			delta_delivered  = (~((u32)0) - fb_ctrs_t0.delivered) +
> +					fb_ctrs_t1.delivered;
> +	}

Having this code repeated twice does not look great. Also the math here
is not correct, since (~0 - val2 + val1) is off by one. Because of
binary representation, unsigned subtraction will work even if
val2 < val1. So cleaner way would be to do:

static inline u64 ts_sub(u64 t1, u64 t0)
{
	if (t1 > t0 || t0 > ~(u32)0)
		return t1 - t0;

	return (u32)t1 - (u32)t0;
}

And then use ts_sub in both places above.

JC.
