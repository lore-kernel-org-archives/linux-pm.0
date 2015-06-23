From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Subject: Re: [PATCH 01/10] cpufreq: Use __func__ to print function's name
Date: Tue, 23 Jun 2015 21:09:27 +0530
Message-ID: <55897DAF.1010804@linux.vnet.ibm.com>
References: <cover.1434959517.git.viresh.kumar@linaro.org> <e836441d6e1ad1ba8c136dc301ee2ad9df08fa72.1434959517.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-6
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from e19.ny.us.ibm.com ([129.33.205.209]:35870 "EHLO
	e19.ny.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932675AbbFWPjh (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 23 Jun 2015 11:39:37 -0400
Received: from /spool/local
	by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <preeti@linux.vnet.ibm.com>;
	Tue, 23 Jun 2015 11:39:36 -0400
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
	by d01dlp01.pok.ibm.com (Postfix) with ESMTP id D27F738C805E
	for <linux-pm@vger.kernel.org>; Tue, 23 Jun 2015 11:39:34 -0400 (EDT)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t5NFdYkj43319368
	for <linux-pm@vger.kernel.org>; Tue, 23 Jun 2015 15:39:34 GMT
Received: from d01av02.pok.ibm.com (localhost [127.0.0.1])
	by d01av02.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t5NFdX7a014520
	for <linux-pm@vger.kernel.org>; Tue, 23 Jun 2015 11:39:34 -0400
In-Reply-To: <e836441d6e1ad1ba8c136dc301ee2ad9df08fa72.1434959517.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org

On 06/22/2015 01:32 PM, Viresh Kumar wrote:
> Its better to use __func__ to print functions name instead of writing
> the name in the print statement. This also has the advantage that a
> change in function's name doesn't force us to change the print message
> as well.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Reviewed-by: Preeti U Murthy <preeti@linux.vnet.ibm.com>
> ---
>  drivers/cpufreq/cpufreq.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 0b3c60861bdf..5863db9213aa 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -2097,8 +2097,7 @@ static int __cpufreq_governor(struct cpufreq_policy *policy,
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

