From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2] drivers/cpufreq: Convert non-modular
 s5pv210-cpufreq.c to use builtin_platform_driver
Date: Thu, 4 Jun 2015 07:58:24 +0530
Message-ID: <20150604022824.GC6811@linux>
References: <20150512070444.GE32300@linux>
 <1433365966-29850-1-git-send-email-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:35922 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750959AbbFDC23 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 3 Jun 2015 22:28:29 -0400
Received: by pabqy3 with SMTP id qy3so19168516pab.3
        for <linux-pm@vger.kernel.org>; Wed, 03 Jun 2015 19:28:29 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1433365966-29850-1-git-send-email-paul.gortmaker@windriver.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kukjin Kim <kgene@kernel.org>, linux-arm-kernel@lists.infradead.org

On 03-06-15, 17:12, Paul Gortmaker wrote:
> This file depends on a Kconfig option which is a bool, so
> we use the appropriate registration function, which avoids us
> relying on an implicit inclusion of <module.h> which we are
> doing currently.
> 
> While this currently works, we really don't want to be including
> the module.h header in non-modular code, which we'd be forced
> to do, pending some upcoming code relocation from init.h into
> module.h.  So we fix it now by using the non-modular equivalent.
> 
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: Kukjin Kim <kgene@kernel.org>
> Cc: linux-pm@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> ---
> 
> [v2: drop exnyos part from patch, since it really was modular and
>  instead needs its implicit include fixed.]
> 
>  drivers/cpufreq/s5pv210-cpufreq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/s5pv210-cpufreq.c b/drivers/cpufreq/s5pv210-cpufreq.c
> index b0dac7d6ba31..9e231f52150c 100644
> --- a/drivers/cpufreq/s5pv210-cpufreq.c
> +++ b/drivers/cpufreq/s5pv210-cpufreq.c
> @@ -659,4 +659,4 @@ static struct platform_driver s5pv210_cpufreq_platdrv = {
>  	},
>  	.probe = s5pv210_cpufreq_probe,
>  };
> -module_platform_driver(s5pv210_cpufreq_platdrv);
> +builtin_platform_driver(s5pv210_cpufreq_platdrv);

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
