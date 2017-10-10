From: Leonard Crestez <leonard.crestez@nxp.com>
Subject: Re: [PATCH] ARM: imx: Enable cpuidle for i.MX6DL starting at 1.1
Date: Tue, 10 Oct 2017 14:57:35 +0300
Message-ID: <1507636655.20816.8.camel@nxp.com>
References: <bbd72503f0e79cc6df4ba12db41b980d50415caf.1507634288.git.leonard.crestez@nxp.com>
         <1507635857.2745.12.camel@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-sn1nam01on0041.outbound.protection.outlook.com ([104.47.32.41]:59520
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755144AbdJJL5v (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 10 Oct 2017 07:57:51 -0400
In-Reply-To: <1507635857.2745.12.camel@pengutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lucas Stach <l.stach@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>, Fabio Estevam <fabio.estevam@nxp.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de, Bai Ping <ping.bai@nxp.com>

On Tue, 2017-10-10 at 13:44 +0200, Lucas Stach wrote:
> Am Dienstag, den 10.10.2017, 14:20 +0300 schrieb Leonard Crestez:

> > Enable cpuidle support on i.MX6DL starting from
> > IMX_CHIP_REVISION_1_1.

> Did you mean 1.0 here and in the subject? This would make sense AFAICS,
>  and is also in line with what the code change does.

No, I do mean "1.1" for 6dl. It's a bit confusing because the code uses
> instead of >= for comparison.

This patch results in imx6q_cpuidle_init getting called if
(cpu_is_imx6dl() && imx_get_soc_revision() == IMX_CHIP_REVISION_1_1);
without this patch it was skipped.

> > --- a/arch/arm/mach-imx/mach-imx6q.c
> > +++ b/arch/arm/mach-imx/mach-imx6q.c
> > @@ -374,7 +374,8 @@ static void __init imx6q_init_late(void)
> > > 
> > >  	 * WAIT mode is broken on TO 1.0 and 1.1, so there is no point
> > >  	 * to run cpuidle on them.
> > >  	 */
> > > -	if (imx_get_soc_revision() > IMX_CHIP_REVISION_1_1)
> > > +	if ((cpu_is_imx6q() && imx_get_soc_revision() > IMX_CHIP_REVISION_1_1) ||
> > > +	    (cpu_is_imx6dl() && imx_get_soc_revision() > IMX_CHIP_REVISION_1_0))
> > >  		imx6q_cpuidle_init();
