From: "Jon Medhurst (Tixy)" <tixy@linaro.org>
Subject: Re: [PATCH] cpufreq: Initialize the governor again while restoring
 policy
Date: Wed, 08 Jul 2015 10:27:09 +0100
Message-ID: <1436347629.2844.12.camel@linaro.org>
References: <f428ecb0927075b25cf7e2ea5fb00eab3d254fdd.1436333568.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from queue01c.mail.zen.net.uk ([212.23.3.237]:56115 "EHLO
	queue01c.mail.zen.net.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932710AbbGHJ1P (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 8 Jul 2015 05:27:15 -0400
In-Reply-To: <f428ecb0927075b25cf7e2ea5fb00eab3d254fdd.1436333568.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Pi-Cheng Chen <pi-cheng.chen@linaro.org>, open list <linux-kernel@vger.kernel.org>

On Wed, 2015-07-08 at 11:23 +0530, Viresh Kumar wrote:
> When all CPUs of a policy are hot-unplugged, we EXIT the governor but
> don't mark policy->governor as NULL. This was done in order to keep last
> used governor's information intact in sysfs, while the CPUs are offline.
> 
> We also missed marking policy->governor as NULL while restoring the
> policy. Because of that, we call __cpufreq_governor(CPUFREQ_GOV_LIMITS)
> for an uninitialized policy. Which eventually returns -EBUSY.
> 
> Fix this by setting policy->governor to NULL while restoring the policy.
> 
> Reported-by: Pi-Cheng Chen <pi-cheng.chen@linaro.org>
> Reported-by: "Jon Medhurst (Tixy)" <tixy@linaro.org>
> Fixes: 18bf3a124ef8 ("cpufreq: Mark policy->governor = NULL for inactive policies")
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---

Tested-by: Jon Medhurst <tixy@linaro.org>

Thanks for that.

I believe this also fixes the other issue I mentioned (nullptr deref in
in arm_big_little driver). To test that, after applying this patch, I
modified the code to force __cpufreq_governor to still return an error
when a cpu is hotpluged back in. Now the arm_big_little driver doesn't
get called when I manually poke scaling_setspeed, presumably because
policy->governor==NULL prevents that from reaching the driver?

> For 4.2-rc
> 
>  drivers/cpufreq/cpufreq.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index b612411655f9..2c22e3902e72 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1132,6 +1132,7 @@ static struct cpufreq_policy *cpufreq_policy_restore(unsigned int cpu)
>  
>  		down_write(&policy->rwsem);
>  		policy->cpu = cpu;
> +		policy->governor = NULL;
>  		up_write(&policy->rwsem);
>  	}
>  


