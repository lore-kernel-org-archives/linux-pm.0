From: "Prakash, Prashanth" <pprakash@codeaurora.org>
Subject: Re: [PATCH] cpufreq / CPPC: Add cpuinfo_cur_freq support for CPPC
Date: Thu, 24 May 2018 13:25:39 -0600
Message-ID: <ac2eb509-c1b0-521a-07e5-2bf8eaaa55c2@codeaurora.org>
References: <1526989324-4183-1-git-send-email-george.cherian@cavium.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1526989324-4183-1-git-send-email-george.cherian@cavium.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: George Cherian <george.cherian@cavium.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: rjw@rjwysocki.net, viresh.kumar@linaro.org
List-Id: linux-pm@vger.kernel.org

Hi George,

On 5/22/2018 5:42 AM, George Cherian wrote:
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
> ---
>  drivers/cpufreq/cppc_cpufreq.c | 44 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
>
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index b15115a..a046915 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -240,10 +240,54 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
>  	return ret;
>  }
>  
> +static int cppc_get_rate_from_fbctrs(struct cppc_perf_fb_ctrs fb_ctrs_t0,
> +				     struct cppc_perf_fb_ctrs fb_ctrs_t1)
> +{
> +	u64 delta_reference, delta_delivered;
> +	u64 reference_perf, ratio;
> +
> +	reference_perf = fb_ctrs_t0.reference_perf;
> +	if (fb_ctrs_t1.reference > fb_ctrs_t0.reference)
> +		delta_reference = fb_ctrs_t1.reference - fb_ctrs_t0.reference;
> +	else /* Counters would have wrapped-around */
> +		delta_reference  = ((u64)(~((u64)0)) - fb_ctrs_t0.reference) +
> +					fb_ctrs_t1.reference;
> +
> +	if (fb_ctrs_t1.delivered > fb_ctrs_t0.delivered)
> +		delta_delivered = fb_ctrs_t1.delivered - fb_ctrs_t0.delivered;
> +	else /* Counters would have wrapped-around */
> +		delta_delivered  = ((u64)(~((u64)0)) - fb_ctrs_t0.delivered) +
> +					fb_ctrs_t1.delivered;
We need to check that the wraparound time is long enough to make sure that
the counters cannot wrap around more than once. We can register a  get() api
only after checking that wraparound time value is reasonably high.

I am not aware of any platforms where wraparound time is soo short, but
wouldn't hurt to check once during init.
> +
> +	if (delta_reference)  /* Check to avoid divide-by zero */
> +		ratio = (delta_delivered * 1000) / delta_reference;
Why not just return the computed value here instead of *1000 and later /1000?
return (ref_per * delta_del) / delta_ref;
> +	else
> +		return -EINVAL;
Instead of EINVAL, i think we should return current frequency.

The counters can pause if CPUs are in idle state during our sampling interval, so
If the counters did not progress, it is reasonable to assume the delivered perf was
equal to desired perf.

Even if platform wanted to limit, since the CPUs were asleep(idle) we could not have
observed lower performance, so we will not throw off  any logic that could be driven
using the returned value.
> +
> +	return (reference_perf * ratio) / 1000;
This should be converted to KHz as cpufreq is not aware of CPPC abstract scale
> +}
> +
> +static unsigned int cppc_cpufreq_get_rate(unsigned int cpunum)
> +{
> +	struct cppc_perf_fb_ctrs fb_ctrs_t0 = {0}, fb_ctrs_t1 = {0};
> +	int ret;
> +
> +	ret = cppc_get_perf_ctrs(cpunum, &fb_ctrs_t0);
> +	if (ret)
> +		return ret;
> +
> +	ret = cppc_get_perf_ctrs(cpunum, &fb_ctrs_t1);
> +	if (ret)
> +		return ret;
> +
> +	return cppc_get_rate_from_fbctrs(fb_ctrs_t0, fb_ctrs_t1);
> +}
We need to make sure that we get a reasonably sample so make sure the reported
performance is accurate.
The counters can capture short transient throttling/limiting, so by sampling a really
short duration of time we could return quite inaccurate measure of performance.

We need to include some reasonable delay between the two calls. What is reasonable
is debatable - so this can be few(2-10) microseconds defined as default. If the same value
doesn't work for all the platforms, we might need to add a platform specific value.

> +
>  static struct cpufreq_driver cppc_cpufreq_driver = {
>  	.flags = CPUFREQ_CONST_LOOPS,
>  	.verify = cppc_verify_policy,
>  	.target = cppc_cpufreq_set_target,
> +	.get = cppc_cpufreq_get_rate,
>  	.init = cppc_cpufreq_cpu_init,
>  	.stop_cpu = cppc_cpufreq_stop_cpu,
>  	.name = "cppc_cpufreq",
