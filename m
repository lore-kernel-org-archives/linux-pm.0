From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 1/2] cpufreq: Return error if ->get() failed in cpufreq_update_policy()
Date: Mon, 17 Feb 2014 01:28:43 +0100
Message-ID: <4772234.6D4cUIJHX4@vostro.rjw.lan>
References: <15ccc0609cb9ee3db0ad3a95b29bf69d11ea197c.1392375504.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <15ccc0609cb9ee3db0ad3a95b29bf69d11ea197c.1392375504.git.viresh.kumar@linaro.org>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, pierre-list@ossman.eu
List-Id: linux-pm@vger.kernel.org

On Friday, February 14, 2014 04:30:40 PM Viresh Kumar wrote:
> cpufreq_update_policy() calls cpufreq_driver->get() to get current frequency of
> a CPU and it is not supposed to fail or return zero. Return error in case that
> happens.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> Pierre,
> 
> I don't think this will fix the issue you were facing but might supress it :)..
> And so you need to understand what causes your ->get() to return zero.
> 
> @Rafael: I got to these patches while looking at code recently after Pierre
> complained about. Came to this conclusion after having discussions with Srivatsa
> over IRC..

Good to know that you chat with each other, but it really is not a useful piece
of information until you say what *exactly* you were talking about.

>  drivers/cpufreq/cpufreq.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 08ca8c9..383362b 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -2151,6 +2151,13 @@ int cpufreq_update_policy(unsigned int cpu)
>  	 */
>  	if (cpufreq_driver->get) {
>  		new_policy.cur = cpufreq_driver->get(cpu);
> +
> +		if (!new_policy.cur) {
> +			pr_err("%s: ->get() returned 0 KHz\n", __func__);
> +			ret = -EINVAL;

That isn't -EINVAL.  It may be -EIO or -ENODEV, but not -EINVAL.  Please.

> +			goto no_policy;

And is it unsafe to continue here?  Or can we continue regardless of getting 0?

> +		}
> +
>  		if (!policy->cur) {
>  			pr_debug("Driver did not initialize current freq");
>  			policy->cur = new_policy.cur;
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
