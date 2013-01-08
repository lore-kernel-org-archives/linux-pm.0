From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 1/3] PM / OPP: Export more symbols for module usage
Date: Tue, 8 Jan 2013 08:47:21 -0600
Message-ID: <20130108144720.GA6062@kahuna>
References: <1357628043-19256-1-git-send-email-shawn.guo@linaro.org>
 <1357628043-19256-2-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:48540 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756455Ab3AHOrh (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 8 Jan 2013 09:47:37 -0500
Content-Disposition: inline
In-Reply-To: <1357628043-19256-2-git-send-email-shawn.guo@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Sascha Hauer <s.hauer@pengutronix.de>, Mark Langsdorf <mark.langsdorf@calxeda.com>

On 14:54-20130108, Shawn Guo wrote:
> Export opp_init_cpufreq_table and opp_free_cpufreq_table for module
> usage.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---
>  drivers/base/power/opp.c |    2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/base/power/opp.c b/drivers/base/power/opp.c
> index 50b2831..d16db9a 100644
> --- a/drivers/base/power/opp.c
> +++ b/drivers/base/power/opp.c
> @@ -661,6 +661,7 @@ int opp_init_cpufreq_table(struct device *dev,
>  
>  	return 0;
>  }
> +EXPORT_SYMBOL(opp_init_cpufreq_table);
>  
>  /**
>   * opp_free_cpufreq_table() - free the cpufreq table
> @@ -678,6 +679,7 @@ void opp_free_cpufreq_table(struct device *dev,
>  	kfree(*table);
>  	*table = NULL;
>  }
> +EXPORT_SYMBOL(opp_free_cpufreq_table);
>  #endif		/* CONFIG_CPU_FREQ */

Is'nt this already covered in 
https://patchwork.kernel.org/patch/1847261/
?
-- 
Regards,
Nishanth Menon
