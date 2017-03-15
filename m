From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: Fix and clean up show_cpuinfo_cur_freq()
Date: Wed, 15 Mar 2017 08:30:21 +0530
Message-ID: <20170315030021.GA27811@vireshk-i7>
References: <2254422.RMefVc1hHr@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f170.google.com ([209.85.192.170]:34674 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750942AbdCODA1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Mar 2017 23:00:27 -0400
Received: by mail-pf0-f170.google.com with SMTP id v190so2506755pfb.1
        for <linux-pm@vger.kernel.org>; Tue, 14 Mar 2017 20:00:26 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <2254422.RMefVc1hHr@aspire.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

On 15-03-17, 00:12, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> There is a missing newline in show_cpuinfo_cur_freq(), so add it,
> but while at it clean it up somewhat too.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/cpufreq/cpufreq.c |    8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> Index: linux-pm/drivers/cpufreq/cpufreq.c
> ===================================================================
> --- linux-pm.orig/drivers/cpufreq/cpufreq.c
> +++ linux-pm/drivers/cpufreq/cpufreq.c
> @@ -680,9 +680,11 @@ static ssize_t show_cpuinfo_cur_freq(str
>  					char *buf)
>  {
>  	unsigned int cur_freq = __cpufreq_get(policy);
> -	if (!cur_freq)
> -		return sprintf(buf, "<unknown>");
> -	return sprintf(buf, "%u\n", cur_freq);
> +
> +	if (cur_freq)
> +		return sprintf(buf, "%u\n", cur_freq);
> +
> +	return sprintf(buf, "<unknown>\n");
>  }

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
-- 
viresh
