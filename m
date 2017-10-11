From: Lucas Stach <l.stach@pengutronix.de>
Subject: Re: [PATCH v2] ARM: imx: Enable cpuidle for i.MX6DL starting at 1.1
Date: Wed, 11 Oct 2017 14:09:57 +0200
Message-ID: <1507723797.2398.8.camel@pengutronix.de>
References: <800ef25ed868f303bb2aece5dba59d395340f25d.1507722933.git.leonard.crestez@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:49621 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751962AbdJKMKC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 11 Oct 2017 08:10:02 -0400
In-Reply-To: <800ef25ed868f303bb2aece5dba59d395340f25d.1507722933.git.leonard.crestez@nxp.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Leonard Crestez <leonard.crestez@nxp.com>, Shawn Guo <shawnguo@kernel.org>, Fabio Estevam <fabio.estevam@nxp.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@pengutronix.de, Bai Ping <ping.bai@nxp.com>

Am Mittwoch, den 11.10.2017, 15:08 +0300 schrieb Leonard Crestez:
> Enable cpuidle support on i.MX6DL starting from
> IMX_CHIP_REVISION_1_1.
> 
> This also makes the code cleaner because 6q and 6dl actually have
> different revision histories.
> 
> Signed-off-by: Bai Ping <ping.bai@nxp.com>
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>

Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

> ---
> 
> Changes since v1: https://www.spinics.net/lists/arm-kernel/msg610461.
> html
> * Clarified comment but kept > instead of >= because that's what the
> old code used. Would be OK to change with further feedback.
> 
>  arch/arm/mach-imx/mach-imx6q.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/mach-imx/mach-imx6q.c b/arch/arm/mach-imx/mach-
> imx6q.c
> index 45801b2..5707113 100644
> --- a/arch/arm/mach-imx/mach-imx6q.c
> +++ b/arch/arm/mach-imx/mach-imx6q.c
> @@ -371,10 +371,13 @@ static struct platform_device
> imx6q_cpufreq_pdev = {
>  static void __init imx6q_init_late(void)
>  {
>  	/*
> -	 * WAIT mode is broken on TO 1.0 and 1.1, so there is no
> point
> -	 * to run cpuidle on them.
> +	 * WAIT mode is broken on imx6 Dual/Quad revision 1.0 and
> 1.1 so
> +	 * there is no point to run cpuidle on them.
> +	 *
> +	 * It does work on imx6 Solo/DualLite starting from 1.1
>  	 */
> -	if (imx_get_soc_revision() > IMX_CHIP_REVISION_1_1)
> +	if ((cpu_is_imx6q() && imx_get_soc_revision() >
> IMX_CHIP_REVISION_1_1) ||
> +	    (cpu_is_imx6dl() && imx_get_soc_revision() >
> IMX_CHIP_REVISION_1_0))
>  		imx6q_cpuidle_init();
>  
>  	if (IS_ENABLED(CONFIG_ARM_IMX6Q_CPUFREQ)) {
