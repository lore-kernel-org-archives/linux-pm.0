From: Shawn Guo <shawn.guo@freescale.com>
Subject: Re: [PATCH v2 6/6] ARM: imx53: add cpufreq support
Date: Sun, 28 Sep 2014 12:15:15 +0800
Message-ID: <20140928041513.GI12999@dragon>
References: <1411738864-26549-1-git-send-email-l.stach@pengutronix.de>
 <1411738864-26549-6-git-send-email-l.stach@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-bn1bon0147.outbound.protection.outlook.com ([157.56.111.147]:45116
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750733AbaI1EPp (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sun, 28 Sep 2014 00:15:45 -0400
Content-Disposition: inline
In-Reply-To: <1411738864-26549-6-git-send-email-l.stach@pengutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lucas Stach <l.stach@pengutronix.de>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Mark Brown <broonie@kernel.org>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de

On Fri, Sep 26, 2014 at 03:41:04PM +0200, Lucas Stach wrote:
> Instanciate device for the generic cpufreq-dt driver.
> 
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>

I assume that I should only apply this patch after the cpufreq-dt change
gets merged and shows up on my base.

Shawn

> ---
> v2:
> - new patch, split out from DTS changes and rebased
>   with new name for cpufreq driver
> ---
>  arch/arm/mach-imx/mach-imx53.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/mach-imx/mach-imx53.c b/arch/arm/mach-imx/mach-imx53.c
> index 03dd6ea13acc..7587cf0cba3e 100644
> --- a/arch/arm/mach-imx/mach-imx53.c
> +++ b/arch/arm/mach-imx/mach-imx53.c
> @@ -41,6 +41,8 @@ static void __init imx53_dt_init(void)
>  static void __init imx53_init_late(void)
>  {
>  	imx53_pm_init();
> +
> +	platform_device_register_simple("cpufreq-dt", -1, NULL, 0);
>  }
>  
>  static const char * const imx53_dt_board_compat[] __initconst = {
> -- 
> 2.1.0
> 
