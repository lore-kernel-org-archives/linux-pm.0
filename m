From: Lucas Stach <l.stach@pengutronix.de>
Subject: Re: [PATCH 1/5] ARM: imx: gpc: Do not print error message for
 EPROBE_DEFER
Date: Tue, 04 Apr 2017 12:30:15 +0200
Message-ID: <1491301815.2367.21.camel@pengutronix.de>
References: <cover.1490987945.git.leonard.crestez@nxp.com>
 <ac58dbed203260f9bb93d7685c8f0e08407e0019.1490987945.git.leonard.crestez@nxp.com>
 <1491299184.2367.12.camel@pengutronix.de> <1491301683.1654.8.camel@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1491301683.1654.8.camel@nxp.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Leonard Crestez <leonard.crestez@nxp.com>
Cc: Anson Huang <Anson.Huang@nxp.com>, Irina Tirdea <irina.tirdea@nxp.com>, Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, Octavian Purdila <octavian.purdila@nxp.com>, Sascha Hauer <kernel@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>, Robin Gong <yibin.gong@nxp.com>, Shawn Guo <shawnguo@kernel.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Am Dienstag, den 04.04.2017, 13:28 +0300 schrieb Leonard Crestez:
> On Tue, 2017-04-04 at 11:46 +0200, Lucas Stach wrote:
> > Am Freitag, den 31.03.2017, 22:25 +0300 schrieb Leonard Crestez:
> > > 
> > > The pu regulator request will return -EPROBE_DEFER if it has a supply
> > > from PMIC and this supply is not yet registered. This does not represent
> > > an error since the driver will call probe again later, so only print a
> > > warning message in this case.
> > > 
> > > Signed-off-by: Irina Tirdea <irina.tirdea@nxp.com>
> > > Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> > > ---
> > >  arch/arm/mach-imx/gpc.c | 6 +++++-
> > The driver moved places, together with a large rewrite, to
> > drivers/soc/imx/.
> > 
> > This issue isn't present in the new driver, so this patch can just be
> > dropped.
> 
> Wait, I'm confused. In what tree did that happen? This patch is against
> linus's tree as of last week and there is nothing in drivers/soc/imx.
> 
> I saw patches for a new gpcv2 driver but that seems to be only for
> imx7. This patch is for imx6. Will that driver also support imx6?

Shawns maintainer tree:

https://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git/log/?h=imx/drivers

This is what is staged for the next merge window.

Regards,
Lucas
