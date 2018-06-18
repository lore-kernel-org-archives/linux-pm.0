From: "Prakash, Prashanth" <pprakash@codeaurora.org>
Subject: Re: [PATCH v2] cpufreq / CPPC: Add cpuinfo_cur_freq support for CPPC
Date: Mon, 18 Jun 2018 14:21:51 -0600
Message-ID: <67822500-0c9d-ac24-71bc-2717831ab29d@codeaurora.org>
References: <1529056995-122792-1-git-send-email-george.cherian@cavium.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1529056995-122792-1-git-send-email-george.cherian@cavium.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: George Cherian <george.cherian@cavium.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: viresh.kumar@linaro.org, rjw@rjwysocki.net
List-Id: linux-pm@vger.kernel.org

Hi George,

On 6/15/2018 4:03 AM, George Cherian wrote:
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
There should be another if () here to check if the reference counters are equal.
We cannot assume, there was a overflow when the counters are equal. As I
mentioned on last patch, the counters *may* pause in idle states.
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
> +
> +	if (delta_reference)  /* Check to avoid divide-by zero */
> +		delivered_perf = (reference_perf * delta_delivered) /
> +					delta_reference;
> +	else
> +		delivered_perf = reference_perf;

If we cannot compute delivered performance then we should return
desired/requested perf and not reference_perf.

> +
> +	return cppc_cpufreq_perf_to_khz(cpu, delivered_perf);
> +}
> +
> +static unsigned int cppc_cpufreq_get_rate(unsigned int cpunum)
> +{
> +	struct cppc_perf_fb_ctrs fb_ctrs_t0 = {0}, fb_ctrs_t1 = {0};
> +	struct cppc_cpudata *cpu = all_cpu_data[cpunum];
> +	int ret;
> +
> +	ret = cppc_get_perf_ctrs(cpunum, &fb_ctrs_t0);
> +	if (ret)
> +		return ret;
> +
> +	udelay(2); /* 2usec delay between sampling */
> +
> +	ret = cppc_get_perf_ctrs(cpunum, &fb_ctrs_t1);
> +	if (ret)
> +		return ret;
> +
> +	return cppc_get_rate_from_fbctrs(cpu, fb_ctrs_t0, fb_ctrs_t1);
> +}
> +
>  static struct cpufreq_driver cppc_cpufreq_driver = {
>  	.flags = CPUFREQ_CONST_LOOPS,
>  	.verify = cppc_verify_policy,
>  	.target = cppc_cpufreq_set_target,
> +	.get = cppc_cpufreq_get_rate,
>  	.init = cppc_cpufreq_cpu_init,
>  	.stop_cpu = cppc_cpufreq_stop_cpu,
>  	.name = "cppc_cpufreq",

Thanks,
Prashanth
