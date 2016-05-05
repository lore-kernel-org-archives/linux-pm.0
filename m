From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] Fix CONFIG_PM_OPP without CONFIG_OF build failure
Date: Thu, 5 May 2016 08:31:09 +0530
Message-ID: <20160505030109.GG2573@vireshk-i7>
References: <1462281278-8553-1-git-send-email-eric.engestrom@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:34753 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755160AbcEEDBN (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 4 May 2016 23:01:13 -0400
Received: by mail-pa0-f42.google.com with SMTP id r5so31712070pag.1
        for <linux-pm@vger.kernel.org>; Wed, 04 May 2016 20:01:13 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1462281278-8553-1-git-send-email-eric.engestrom@imgtec.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eric Engestrom <eric.engestrom@imgtec.com>
Cc: linux-kernel@vger.kernel.org, Rufus Hamade <rufus.hamade@imgtec.com>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org

On 03-05-16, 14:14, Eric Engestrom wrote:
> diff --git a/drivers/base/power/opp/cpu.c b/drivers/base/power/opp/cpu.c
> index ba2bdbd..8aae170 100644
> --- a/drivers/base/power/opp/cpu.c
> +++ b/drivers/base/power/opp/cpu.c
> @@ -119,6 +119,7 @@ void dev_pm_opp_free_cpufreq_table(struct device *dev,
>  EXPORT_SYMBOL_GPL(dev_pm_opp_free_cpufreq_table);
>  #endif	/* CONFIG_CPU_FREQ */
>  
> +#ifdef CONFIG_OF
>  /* Required only for V1 bindings, as v2 can manage it from DT itself */
>  int dev_pm_opp_set_sharing_cpus(struct device *cpu_dev, cpumask_var_t cpumask)
>  {
> @@ -160,7 +161,6 @@ int dev_pm_opp_set_sharing_cpus(struct device *cpu_dev, cpumask_var_t cpumask)
>  }
>  EXPORT_SYMBOL_GPL(dev_pm_opp_set_sharing_cpus);
>  
> -#ifdef CONFIG_OF
>  void dev_pm_opp_of_cpumask_remove_table(cpumask_var_t cpumask)
>  {
>  	struct device *cpu_dev;

This change was incorrect as this API can be used for non-OF case.
Some things have already changed, can you please rebase on linux-next
and resend this patch?

-- 
viresh
