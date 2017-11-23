From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 4/4] cpufreq: Drop pointless return statement
Date: Thu, 23 Nov 2017 09:31:39 +0530
Message-ID: <20171123040139.GF4084@vireshk-i7>
References: <1655574.Es7zYAeW1r@aspire.rjw.lan>
 <8136755.4DucdONPzh@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:36656 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752206AbdKWEBm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 22 Nov 2017 23:01:42 -0500
Received: by mail-pf0-f195.google.com with SMTP id i15so12989860pfa.3
        for <linux-pm@vger.kernel.org>; Wed, 22 Nov 2017 20:01:42 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <8136755.4DucdONPzh@aspire.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

On 23-11-17, 01:30, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Drop a pointless return statement from cpufreq_unregister_governor().
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/cpufreq/cpufreq.c |    1 -
>  1 file changed, 1 deletion(-)
> 
> Index: linux-pm/drivers/cpufreq/cpufreq.c
> ===================================================================
> --- linux-pm.orig/drivers/cpufreq/cpufreq.c
> +++ linux-pm/drivers/cpufreq/cpufreq.c
> @@ -2168,7 +2168,6 @@ void cpufreq_unregister_governor(struct
>  	mutex_lock(&cpufreq_governor_mutex);
>  	list_del(&governor->governor_list);
>  	mutex_unlock(&cpufreq_governor_mutex);
> -	return;
>  }
>  EXPORT_SYMBOL_GPL(cpufreq_unregister_governor);

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
