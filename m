From: Lucas Stach <l.stach@pengutronix.de>
Subject: Re: [PATCH] ARM: imx: Enable cpuidle for i.MX6DL starting at 1.1
Date: Tue, 10 Oct 2017 13:44:17 +0200
Message-ID: <1507635857.2745.12.camel@pengutronix.de>
References: <bbd72503f0e79cc6df4ba12db41b980d50415caf.1507634288.git.leonard.crestez@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:50215 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755165AbdJJLoW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Oct 2017 07:44:22 -0400
In-Reply-To: <bbd72503f0e79cc6df4ba12db41b980d50415caf.1507634288.git.leonard.crestez@nxp.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Leonard Crestez <leonard.crestez@nxp.com>, Shawn Guo <shawnguo@kernel.org>, Fabio Estevam <fabio.estevam@nxp.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de, Bai Ping <ping.bai@nxp.com>

Am Dienstag, den 10.10.2017, 14:20 +0300 schrieb Leonard Crestez:
> Enable cpuidle support on i.MX6DL starting from
> IMX_CHIP_REVISION_1_1.

Did you mean 1.0 here and in the subject? This would make sense AFAICS,
 and is also in line with what the code change does.

> This also makes the code cleaner because 6q and 6dl actually have
> different revision histories.
> 
> > Signed-off-by: Bai Ping <ping.bai@nxp.com>
> > Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> ---
>  arch/arm/mach-imx/mach-imx6q.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-imx/mach-imx6q.c b/arch/arm/mach-imx/mach-imx6q.c
> index 45801b2..ef0c949 100644
> --- a/arch/arm/mach-imx/mach-imx6q.c
> +++ b/arch/arm/mach-imx/mach-imx6q.c
> @@ -374,7 +374,8 @@ static void __init imx6q_init_late(void)
> >  	 * WAIT mode is broken on TO 1.0 and 1.1, so there is no point
> >  	 * to run cpuidle on them.
> >  	 */
> > -	if (imx_get_soc_revision() > IMX_CHIP_REVISION_1_1)
> > +	if ((cpu_is_imx6q() && imx_get_soc_revision() > IMX_CHIP_REVISION_1_1) ||
> > +	    (cpu_is_imx6dl() && imx_get_soc_revision() > IMX_CHIP_REVISION_1_0))
> >  		imx6q_cpuidle_init();
>  
> >  	if (IS_ENABLED(CONFIG_ARM_IMX6Q_CPUFREQ)) {
