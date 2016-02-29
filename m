From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: Select IRQ_WORK if CPU_FREQ_GOV_COMMON is set
Date: Mon, 29 Feb 2016 08:48:16 +0530
Message-ID: <20160229031816.GJ5823@vireshk-i7>
References: <38362761.gZ1JT20KQT@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:33444 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753644AbcB2DSV (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 28 Feb 2016 22:18:21 -0500
Received: by mail-pa0-f41.google.com with SMTP id fl4so83933079pad.0
        for <linux-pm@vger.kernel.org>; Sun, 28 Feb 2016 19:18:21 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <38362761.gZ1JT20KQT@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On 28-02-16, 02:33, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Commit 8fb47ff100af (cpufreq: governor: Replace timers with utilization
> update callbacks) made CPU_FREQ select IRQ_WORK, but that's not
> necessary, as it is sufficient for IRQ_WORK to be selected by
> CPU_FREQ_GOV_COMMON, so modify the cpufreq Kconfig to that effect.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> On top of linux-next.
> 
> Thanks,
> Rafael
> 
> ---
>  drivers/cpufreq/Kconfig |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Index: linux-pm/drivers/cpufreq/Kconfig
> ===================================================================
> --- linux-pm.orig/drivers/cpufreq/Kconfig
> +++ linux-pm/drivers/cpufreq/Kconfig
> @@ -3,7 +3,6 @@ menu "CPU Frequency scaling"
>  config CPU_FREQ
>  	bool "CPU Frequency scaling"
>  	select SRCU
> -	select IRQ_WORK
>  	help
>  	  CPU Frequency scaling allows you to change the clock speed of 
>  	  CPUs on the fly. This is a nice method to save power, because 
> @@ -20,6 +19,7 @@ config CPU_FREQ
>  if CPU_FREQ
>  
>  config CPU_FREQ_GOV_COMMON
> +	select IRQ_WORK
>  	bool
>  
>  config CPU_FREQ_BOOST_SW

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
