From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: Drop unnecessary check from
 cpufreq_policy_alloc()
Date: Wed, 31 Aug 2016 09:26:54 +0530
Message-ID: <20160831035654.GD5539@vireshk-i7>
References: <3010935.IpTCVVCXDt@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f176.google.com ([209.85.192.176]:35698 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756892AbcHaD47 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 30 Aug 2016 23:56:59 -0400
Received: by mail-pf0-f176.google.com with SMTP id x72so14689990pfd.2
        for <linux-pm@vger.kernel.org>; Tue, 30 Aug 2016 20:56:58 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <3010935.IpTCVVCXDt@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On 31-08-16, 03:11, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Since cpufreq_policy_alloc() doesn't use its dev variable for
> anything useful, drop that variable from there along with the
> NULL check against it.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/cpufreq/cpufreq.c |    4 ----
>  1 file changed, 4 deletions(-)
> 
> Index: linux-pm/drivers/cpufreq/cpufreq.c
> ===================================================================
> --- linux-pm.orig/drivers/cpufreq/cpufreq.c
> +++ linux-pm/drivers/cpufreq/cpufreq.c
> @@ -1073,13 +1073,9 @@ static void handle_update(struct work_st
>  
>  static struct cpufreq_policy *cpufreq_policy_alloc(unsigned int cpu)
>  {
> -	struct device *dev = get_cpu_device(cpu);
>  	struct cpufreq_policy *policy;
>  	int ret;
>  
> -	if (WARN_ON(!dev))
> -		return NULL;
> -
>  	policy = kzalloc(sizeof(*policy), GFP_KERNEL);
>  	if (!policy)
>  		return NULL;

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
