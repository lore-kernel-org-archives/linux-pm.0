From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/12] cpufreq: governor: Close dbs_data update race
 condition
Date: Fri, 19 Feb 2016 08:39:54 +0530
Message-ID: <20160219030954.GA22242@vireshk-i7>
References: <2938006.67J0esUvOA@vostro.rjw.lan>
 <1592265.QLnTJA45ZD@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f172.google.com ([209.85.192.172]:34448 "EHLO
	mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757165AbcBSDKJ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 18 Feb 2016 22:10:09 -0500
Received: by mail-pf0-f172.google.com with SMTP id x65so42907975pfb.1
        for <linux-pm@vger.kernel.org>; Thu, 18 Feb 2016 19:10:09 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1592265.QLnTJA45ZD@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On 18-02-16, 02:19, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> It is possible for a dbs_data object to be updated after its
> usage counter has become 0.  That may happen if governor_store()
> runs (via a govenor tunable sysfs attribute write) in parallel
> with cpufreq_governor_exit() called for the last cpufreq policy
> associated with the dbs_data in question.  In that case, if
> governor_store() acquires dbs_data->mutex right after
> cpufreq_governor_exit() has released it, the ->store() callback
> invoked by it may operate on dbs_data with no users.  Although
> sysfs will cause the kobject_put() in cpufreq_governor_exit() to
> block until governor_store() has returned, that situation may
> lead to some unexpected results, depending on the implementation
> of the ->store callback, and therefore it should be avoided.
> 
> To that end, modify governor_store() to check the dbs_data's
> usage count before invoking the ->store() callback and return
> an error if it is 0 at that point.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/cpufreq/cpufreq_governor.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Index: linux-pm/drivers/cpufreq/cpufreq_governor.c
> ===================================================================
> --- linux-pm.orig/drivers/cpufreq/cpufreq_governor.c
> +++ linux-pm/drivers/cpufreq/cpufreq_governor.c
> @@ -112,7 +112,7 @@ static ssize_t governor_store(struct kob
>  
>  	mutex_lock(&dbs_data->mutex);
>  
> -	if (gattr->store)
> +	if (dbs_data->usage_count && gattr->store)
>  		ret = gattr->store(dbs_data, buf, count);
>  
>  	mutex_unlock(&dbs_data->mutex);

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
