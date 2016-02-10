From: Gautham R Shenoy <ego@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 1/10] cpufreq: Clean up default and fallback governor
 setup
Date: Wed, 10 Feb 2016 10:45:14 +0530
Message-ID: <20160210051514.GA31787@in.ibm.com>
References: <3705929.bslqXH980s@vostro.rjw.lan>
 <9008098.QDD8C89zDx@vostro.rjw.lan>
 <7056089.34C11T15Ra@vostro.rjw.lan>
Reply-To: ego@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from e33.co.us.ibm.com ([32.97.110.151]:39086 "EHLO
	e33.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751003AbcBJFPl (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 10 Feb 2016 00:15:41 -0500
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <ego@linux.vnet.ibm.com>;
	Tue, 9 Feb 2016 22:15:41 -0700
Content-Disposition: inline
In-Reply-To: <7056089.34C11T15Ra@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Juri Lelli <juri.lelli@arm.com>, Steve Muckle <steve.muckle@linaro.org>, Saravana Kannan <skannan@codeaurora.org>

Hello Rafael,

On Fri, Feb 05, 2016 at 03:11:54AM +0100, Rafael J. Wysocki wrote:
[..snip..]
> Index: linux-pm/drivers/cpufreq/cpufreq_performance.c
> ===================================================================
> --- linux-pm.orig/drivers/cpufreq/cpufreq_performance.c
> +++ linux-pm/drivers/cpufreq/cpufreq_performance.c
> @@ -33,10 +33,7 @@ static int cpufreq_governor_performance(
>  	return 0;
>  }
> 
> -#ifdef CONFIG_CPU_FREQ_GOV_PERFORMANCE_MODULE
> -static
> -#endif
> -struct cpufreq_governor cpufreq_gov_performance = {
> +static struct cpufreq_governor cpufreq_gov_performance = {
>  	.name		= "performance",
>  	.governor	= cpufreq_governor_performance,
>  	.owner		= THIS_MODULE,
> @@ -52,6 +49,19 @@ static void __exit cpufreq_gov_performan
>  	cpufreq_unregister_governor(&cpufreq_gov_performance);
>  }
> 
> +#ifdef CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE
> +struct cpufreq_governor *cpufreq_default_governor(void)
> +{
> +	return &cpufreq_gov_performance;
> +}
> +#endif
> +#ifndef CONFIG_CPU_FREQ_GOV_PERFORMANCE_MODULE

Shouldn't this be #ifdef ?

> +struct cpufreq_governor *cpufreq_fallback_governor(void)
> +{
> +	return &cpufreq_gov_performance;
> +}
> +#endif


--
Thanks and Regards
gautham.

