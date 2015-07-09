From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpufreq: Initialize the governor again while restoring policy
Date: Thu, 09 Jul 2015 02:33:54 +0200
Message-ID: <3814282.YWYCHNROVv@vostro.rjw.lan>
References: <f428ecb0927075b25cf7e2ea5fb00eab3d254fdd.1436333568.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:65396 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750814AbbGIAH0 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 8 Jul 2015 20:07:26 -0400
In-Reply-To: <f428ecb0927075b25cf7e2ea5fb00eab3d254fdd.1436333568.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Pi-Cheng Chen <pi-cheng.chen@linaro.org>, "Jon Medhurst (Tixy)" <tixy@linaro.org>, open list <linux-kernel@vger.kernel.org>

On Wednesday, July 08, 2015 11:23:58 AM Viresh Kumar wrote:
> When all CPUs of a policy are hot-unplugged, we EXIT the governor but
> don't mark policy->governor as NULL. This was done in order to keep last
> used governor's information intact in sysfs, while the CPUs are offline.
> 
> We also missed marking policy->governor as NULL while restoring the
> policy. Because of that, we call __cpufreq_governor(CPUFREQ_GOV_LIMITS)

How exactly does that happen?

> for an uninitialized policy. Which eventually returns -EBUSY.
> 
> Fix this by setting policy->governor to NULL while restoring the policy.
> 
> Reported-by: Pi-Cheng Chen <pi-cheng.chen@linaro.org>
> Reported-by: "Jon Medhurst (Tixy)" <tixy@linaro.org>
> Fixes: 18bf3a124ef8 ("cpufreq: Mark policy->governor = NULL for inactive policies")
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
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
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
