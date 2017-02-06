From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 2/3] thermal: cpu_cooling: Check OPP for errors
Date: Mon, 06 Feb 2017 13:02:02 +0100
Message-ID: <2237771.GAr8QlFsVi@aspire.rjw.lan>
References: <232171cd9d89c2179e10e1f2aed71ad7fc1f7872.1486376756.git.viresh.kumar@linaro.org> <de7260e97192c3fb57709340cf3766366e38ae76.1486376756.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:54687 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751093AbdBFMGt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 6 Feb 2017 07:06:49 -0500
In-Reply-To: <de7260e97192c3fb57709340cf3766366e38ae76.1486376756.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Amit Daniel Kachhap <amit.kachhap@gmail.com>, Javi Merino <javi.merino@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Dan Carpenter <dan.carpenter@oracle.com>

On Monday, February 06, 2017 03:56:28 PM Viresh Kumar wrote:
> It is possible for dev_pm_opp_find_freq_exact() to return errors. It was
> all fine earlier as dev_pm_opp_get_voltage() had a check within it to
> check for invalid OPPs, but dev_pm_opp_put() doesn't have any similar
> checks and the callers need to make sure OPP is valid before calling
> them.
> 
> Also update the later dev_warn_ratelimited() to not print the error
> message as the OPP is guaranteed to be valid now.
> 
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/thermal/cpu_cooling.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
> index 85fdbf762fa0..9534540434e2 100644
> --- a/drivers/thermal/cpu_cooling.c
> +++ b/drivers/thermal/cpu_cooling.c
> @@ -431,13 +431,20 @@ static int get_static_power(struct cpufreq_cooling_device *cpufreq_device,
>  
>  	opp = dev_pm_opp_find_freq_exact(cpufreq_device->cpu_dev, freq_hz,
>  					 true);
> +	if (IS_ERR(opp)) {
> +		dev_warn_ratelimited(cpufreq_device->cpu_dev,
> +				     "Failed to find OPP for frequency %lu: %ld\n",
> +				     freq_hz, PTR_ERR(opp));

I'm quite unconvinced about the WARN level of these messages.

They seem to be mostly useful for the people who provide device trees for
platforms (ie. system integrators).  If users see them, there is not much
they can do to fix the problem by themselves and the hardware is OK,
actually.

> +		return -EINVAL;
> +	}
> +
>  	voltage = dev_pm_opp_get_voltage(opp);
>  	dev_pm_opp_put(opp);
>  
>  	if (voltage == 0) {
>  		dev_warn_ratelimited(cpufreq_device->cpu_dev,
> -				     "Failed to get voltage for frequency %lu: %ld\n",
> -				     freq_hz, IS_ERR(opp) ? PTR_ERR(opp) : 0);
> +				     "Failed to get voltage for frequency %lu\n",
> +				     freq_hz);
>  		return -EINVAL;
>  	}
>  

Thanks,
Rafael

