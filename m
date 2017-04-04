From: Leonard Crestez <leonard.crestez@nxp.com>
Subject: Re: [PATCH 1/5] ARM: imx: gpc: Do not print error message for
 EPROBE_DEFER
Date: Tue, 4 Apr 2017 13:28:03 +0300
Message-ID: <1491301683.1654.8.camel@nxp.com>
References: <cover.1490987945.git.leonard.crestez@nxp.com>
         <ac58dbed203260f9bb93d7685c8f0e08407e0019.1490987945.git.leonard.crestez@nxp.com>
         <1491299184.2367.12.camel@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1491299184.2367.12.camel@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Lucas Stach <l.stach@pengutronix.de>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>, Mark Brown <broonie@kernel.org>, Robin Gong <yibin.gong@nxp.com>, Anson Huang <Anson.Huang@nxp.com>, Irina Tirdea <irina.tirdea@nxp.com>, Fabio Estevam <fabio.estevam@nxp.com>, Octavian Purdila <octavian.purdila@nxp.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tue, 2017-04-04 at 11:46 +0200, Lucas Stach wrote:
> Am Freitag, den 31.03.2017, 22:25 +0300 schrieb Leonard Crestez:
> > 
> > The pu regulator request will return -EPROBE_DEFER if it has a supply
> > from PMIC and this supply is not yet registered. This does not represent
> > an error since the driver will call probe again later, so only print a
> > warning message in this case.
> > 
> > Signed-off-by: Irina Tirdea <irina.tirdea@nxp.com>
> > Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> > ---
> >  arch/arm/mach-imx/gpc.c | 6 +++++-
> The driver moved places, together with a large rewrite, to
> drivers/soc/imx/.
> 
> This issue isn't present in the new driver, so this patch can just be
> dropped.

Wait, I'm confused. In what tree did that happen? This patch is against
linus's tree as of last week and there is nothing in drivers/soc/imx.

I saw patches for a new gpcv2 driver but that seems to be only for
imx7. This patch is for imx6. Will that driver also support imx6?

Link: https://lkml.org/lkml/2017/3/28/834

--
Regards,
Leonard
