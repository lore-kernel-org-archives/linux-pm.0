From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 6/12] cpufreq: governor: Fix CPU load information updates
 via ->store
Date: Thu, 18 Feb 2016 11:14:42 +0530
Message-ID: <20160218054442.GL2610@vireshk-i7>
References: <2938006.67J0esUvOA@vostro.rjw.lan>
 <1474960.ULEHzzY9qD@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f179.google.com ([209.85.192.179]:36693 "EHLO
	mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1424610AbcBRFoz (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 18 Feb 2016 00:44:55 -0500
Received: by mail-pf0-f179.google.com with SMTP id e127so24947413pfe.3
        for <linux-pm@vger.kernel.org>; Wed, 17 Feb 2016 21:44:55 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1474960.ULEHzzY9qD@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On 18-02-16, 02:26, Rafael J. Wysocki wrote:
> Index: linux-pm/drivers/cpufreq/cpufreq_ondemand.c
> ===================================================================
> --- linux-pm.orig/drivers/cpufreq/cpufreq_ondemand.c
> +++ linux-pm/drivers/cpufreq/cpufreq_ondemand.c
> @@ -29,6 +29,7 @@
>  
>  static DEFINE_PER_CPU(struct od_cpu_dbs_info_s, od_cpu_dbs_info);
>  
> +static struct dbs_governor od_dbs_gov;
>  static struct od_ops od_ops;
>  
>  static unsigned int default_powersave_bias;
> @@ -222,7 +223,6 @@ static ssize_t store_io_is_busy(struct d
>  {
>  	unsigned int input;
>  	int ret;
> -	unsigned int j;
>  
>  	ret = sscanf(buf, "%u", &input);
>  	if (ret != 1)
> @@ -230,12 +230,8 @@ static ssize_t store_io_is_busy(struct d
>  	dbs_data->io_is_busy = !!input;
>  
>  	/* we need to re-evaluate prev_cpu_idle */
> -	for_each_online_cpu(j) {
> -		struct od_cpu_dbs_info_s *dbs_info = &per_cpu(od_cpu_dbs_info,
> -									j);
> -		dbs_info->cdbs.prev_cpu_idle = get_cpu_idle_time(j,
> -			&dbs_info->cdbs.prev_cpu_wall, dbs_data->io_is_busy);
> -	}

We weren't doing ignore_nice_load check here, but will be done after
this patch. Will that make a different? And then this should be
mentioned in the log as well ?

Apart from that.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
