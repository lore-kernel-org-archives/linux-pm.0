From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: Avoid unnecessary locking in show() and store()
Date: Fri, 12 Feb 2016 12:01:15 +0530
Message-ID: <20160212063115.GE16949@vireshk-i7>
References: <2946666.LCVBdOefy1@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f176.google.com ([209.85.192.176]:34516 "EHLO
	mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750735AbcBLGbT (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 12 Feb 2016 01:31:19 -0500
Received: by mail-pf0-f176.google.com with SMTP id x65so42602426pfb.1
        for <linux-pm@vger.kernel.org>; Thu, 11 Feb 2016 22:31:18 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <2946666.LCVBdOefy1@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On 11-02-16, 02:25, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The show() and store() routines in the cpufreq core don't need to
> acquire all of the locks to check if the struct freq_attr they want
> to use really provides the callbacks they need as expected, so change
> them to avoid doing that.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/cpufreq/cpufreq.c |   27 +++++++++++----------------
>  1 file changed, 11 insertions(+), 16 deletions(-)
> 
> Index: linux-pm/drivers/cpufreq/cpufreq.c
> ===================================================================
> --- linux-pm.orig/drivers/cpufreq/cpufreq.c
> +++ linux-pm/drivers/cpufreq/cpufreq.c
> @@ -862,13 +862,11 @@ static ssize_t show(struct kobject *kobj
>  	struct freq_attr *fattr = to_attr(attr);
>  	ssize_t ret;
>  
> -	down_read(&policy->rwsem);
> -
> -	if (fattr->show)
> -		ret = fattr->show(policy, buf);
> -	else
> -		ret = -EIO;
> +	if (!fattr->show)
> +		return -EIO;
>  
> +	down_read(&policy->rwsem);
> +	ret = fattr->show(policy, buf);
>  	up_read(&policy->rwsem);
>  
>  	return ret;
> @@ -881,20 +879,17 @@ static ssize_t store(struct kobject *kob
>  	struct freq_attr *fattr = to_attr(attr);
>  	ssize_t ret = -EINVAL;
>  
> -	get_online_cpus();
> -
> -	if (!cpu_online(policy->cpu))
> -		goto unlock;
> +	if (!fattr->store)
> +		return -EIO;
>  
> -	down_write(&policy->rwsem);
> +	get_online_cpus();
>  
> -	if (fattr->store)
> +	if (cpu_online(policy->cpu)) {
> +		down_write(&policy->rwsem);
>  		ret = fattr->store(policy, buf, count);
> -	else
> -		ret = -EIO;
> +		up_write(&policy->rwsem);
> +	}
>  
> -	up_write(&policy->rwsem);
> -unlock:

I have no problems with the patch as is, but how are we going to benefit from it
?

'if (fattr->show/store)' is never ever going to fail, unless we have a bug here.
So, even we may want to add a WARN_ON() for that case instead.

-- 
viresh
