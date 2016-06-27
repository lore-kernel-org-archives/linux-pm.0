From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH][RFC] cpufreq: Avoid warning during resume by return
 EAGAIN if cpufreq is unavailable
Date: Mon, 27 Jun 2016 12:50:27 +0530
Message-ID: <20160627072027.GC3341@vireshk-i7>
References: <1466872128-14566-1-git-send-email-yu.c.chen@intel.com>
 <2394728.0JDBHijQ6J@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:33012 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751784AbcF0HUa (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 27 Jun 2016 03:20:30 -0400
Received: by mail-pa0-f52.google.com with SMTP id b13so56566223pat.0
        for <linux-pm@vger.kernel.org>; Mon, 27 Jun 2016 00:20:30 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <2394728.0JDBHijQ6J@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Chen Yu <yu.c.chen@intel.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On 27-06-16, 03:12, Rafael J. Wysocki wrote:
> ---
>  drivers/cpufreq/cpufreq.c |    7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> Index: linux-pm/drivers/cpufreq/cpufreq.c
> ===================================================================
> --- linux-pm.orig/drivers/cpufreq/cpufreq.c
> +++ linux-pm/drivers/cpufreq/cpufreq.c
> @@ -1544,9 +1544,6 @@ static unsigned int cpufreq_update_curre
>  {
>  	unsigned int new_freq;
>  
> -	if (cpufreq_suspended)
> -		return 0;
> -
>  	new_freq = cpufreq_driver->get(policy->cpu);
>  	if (!new_freq)
>  		return 0;
> @@ -2280,6 +2277,10 @@ int cpufreq_update_policy(unsigned int c
>  	 * -> ask driver for current freq and notify governors about a change
>  	 */
>  	if (cpufreq_driver->get && !cpufreq_driver->setpolicy) {
> +		if (cpufreq_suspended) {
> +			ret = -EAGAIN;
> +			goto unlock;
> +		}
>  		new_policy.cur = cpufreq_update_current_freq(policy);
>  		if (WARN_ON(!new_policy.cur)) {
>  			ret = -EIO;

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
-- 
viresh
