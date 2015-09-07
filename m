From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH V2 1/9] cpufreq: Use __func__ to print function's name
Date: Tue, 08 Sep 2015 01:42:23 +0200
Message-ID: <2255089.Zk01N0S7pW@vostro.rjw.lan>
References: <cover.1437999691.git.viresh.kumar@linaro.org> <a131c99933f5dd7eefbd39358a2dc2b13663ca7b.1437999691.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:45667 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751135AbbIGXOf (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 7 Sep 2015 19:14:35 -0400
In-Reply-To: <a131c99933f5dd7eefbd39358a2dc2b13663ca7b.1437999691.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, preeti.lkml@gmail.com, open list <linux-kernel@vger.kernel.org>

On Monday, July 27, 2015 05:58:06 PM Viresh Kumar wrote:
> Its better to use __func__ to print functions name instead of writing
> the name in the print statement. This also has the advantage that a
> change in function's name doesn't force us to change the print message
> as well.
> 
> Reviewed-by: Preeti U Murthy <preeti@linux.vnet.ibm.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

OK, this is simple enough.  Applied, thanks!

> ---
>  drivers/cpufreq/cpufreq.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 46251e8d30f2..f620055279f3 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -2074,8 +2074,7 @@ static int __cpufreq_governor(struct cpufreq_policy *policy,
>  		if (!try_module_get(policy->governor->owner))
>  			return -EINVAL;
>  
> -	pr_debug("__cpufreq_governor for CPU %u, event %u\n",
> -		 policy->cpu, event);
> +	pr_debug("%s: for CPU %u, event %u\n", __func__, policy->cpu, event);
>  
>  	mutex_lock(&cpufreq_governor_lock);
>  	if ((policy->governor_enabled && event == CPUFREQ_GOV_START)
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
