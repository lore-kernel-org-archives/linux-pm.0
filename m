From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: governor: Drop pointless goto from
 cpufreq_governor_init()
Date: Tue, 9 Feb 2016 09:20:35 +0530
Message-ID: <20160209035035.GB10843@vireshk>
References: <121264863.5TXTuENuar@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:35567 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756428AbcBIDui (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 8 Feb 2016 22:50:38 -0500
Received: by mail-pa0-f44.google.com with SMTP id ho8so84319309pac.2
        for <linux-pm@vger.kernel.org>; Mon, 08 Feb 2016 19:50:38 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <121264863.5TXTuENuar@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On 08-02-16, 23:57, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> It is silly to jump around "return 0", so don't do that.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> On top of the bleeding-edge branch of linux-pm.git.
> 
> Thanks,
> Rafael
> 
> ---
>  drivers/cpufreq/cpufreq_governor.c |    7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> Index: linux-pm/drivers/cpufreq/cpufreq_governor.c
> ===================================================================
> --- linux-pm.orig/drivers/cpufreq/cpufreq_governor.c
> +++ linux-pm/drivers/cpufreq/cpufreq_governor.c
> @@ -394,12 +394,11 @@ static int cpufreq_governor_init(struct
>  
>  	ret = sysfs_create_group(get_governor_parent_kobj(policy),
>  				 get_sysfs_attr(gov));
> -	if (ret)
> -		goto reset_gdbs_data;
> +	if (!ret)
> +		return 0;
>  
> -	return 0;
> +	/* Failure, so roll back. */
>  
> -reset_gdbs_data:
>  	policy->governor_data = NULL;
>  
>  	if (!have_governor_per_policy())

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
