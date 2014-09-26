From: Lucas Stach <l.stach@pengutronix.de>
Subject: Re: [PATCH 3/5] clk: imx: add CPU clock type
Date: Fri, 26 Sep 2014 12:10:58 +0200
Message-ID: <1411726258.2761.1.camel@pengutronix.de>
References: <1411143381-10516-1-git-send-email-l.stach@pengutronix.de>
 <1411143381-10516-4-git-send-email-l.stach@pengutronix.de>
 <20140926025933.GA31948@dragon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20140926025933.GA31948@dragon>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Shawn Guo <shawn.guo@freescale.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Am Freitag, den 26.09.2014, 10:59 +0800 schrieb Shawn Guo:
> On Fri, Sep 19, 2014 at 06:16:19PM +0200, Lucas Stach wrote:
> > From: Lucas Stach <dev@lynxeye.de>
> > 
> > This implements a virtual clock used to abstract away
> > all the steps needed in order to change the ARM clock,
> > so we don't have to push all this clock handling into
> > the cpufreq driver.
> > 
> > While it will be used for i.MX53 at first it is generic
> > enough to be used on i.MX6 later on.
> > 
> > Signed-off-by: Lucas Stach <dev@lynxeye.de>
> 
> Is this intentional to use a different email address than your usual
> one?

Urgh no. That's a remnant from starting this code at home without
setting the proper git environment. Thanks for the hint.

> 
> > ---
> >  arch/arm/mach-imx/Makefile  |   2 +-
> >  arch/arm/mach-imx/clk-cpu.c | 104 ++++++++++++++++++++++++++++++++++++++++++++
> >  arch/arm/mach-imx/clk.h     |   4 ++
> >  3 files changed, 109 insertions(+), 1 deletion(-)
> >  create mode 100644 arch/arm/mach-imx/clk-cpu.c
> > 
> > diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
> > index ac88599ca080..4d6071351f4f 100644
> > --- a/arch/arm/mach-imx/Makefile
> > +++ b/arch/arm/mach-imx/Makefile
> > @@ -12,7 +12,7 @@ obj-$(CONFIG_SOC_IMX31) += mm-imx3.o cpu-imx31.o clk-imx31.o iomux-imx31.o ehci-
> >  obj-$(CONFIG_SOC_IMX35) += mm-imx3.o cpu-imx35.o clk-imx35.o ehci-imx35.o pm-imx3.o
> >  
> >  imx5-pm-$(CONFIG_PM) += pm-imx5.o
> > -obj-$(CONFIG_SOC_IMX5) += cpu-imx5.o clk-imx51-imx53.o $(imx5-pm-y)
> > +obj-$(CONFIG_SOC_IMX5) += cpu-imx5.o clk-imx51-imx53.o clk-cpu.o $(imx5-pm-y)
> >  
> >  obj-$(CONFIG_COMMON_CLK) += clk-pllv1.o clk-pllv2.o clk-pllv3.o clk-gate2.o \
> >  			    clk-pfd.o clk-busy.o clk.o \
> > diff --git a/arch/arm/mach-imx/clk-cpu.c b/arch/arm/mach-imx/clk-cpu.c
> > new file mode 100644
> > index 000000000000..ffba96228d3b
> > --- /dev/null
> > +++ b/arch/arm/mach-imx/clk-cpu.c
> > @@ -0,0 +1,104 @@
> > +/*
> > + * Copyright (c) 2014 Lucas Stach <l.stach@pengutronix.de>, Pengutronix
> > + *
> > + * The code contained herein is licensed under the GNU General Public
> > + * License. You may obtain a copy of the GNU General Public License
> > + * Version 2 or later at the following locations:
> > + *
> > + * http://www.opensource.org/licenses/gpl-license.html
> > + * http://www.gnu.org/copyleft/gpl.html
> > + */
> > +
> > +#include <linux/clk.h>
> > +#include <linux/clk-provider.h>
> > +#include <linux/slab.h>
> > +
> > +struct clk_cpu {
> > +	struct clk_hw	hw;
> > +	struct clk	*div, *mux, *pll, *step;
> 
> This is personal taste, so I'm not strong on this.  But I feel having
> them on multiple lines makes the later addition/removal of struct clk
> pointers a bit easier.
> 
> Other than these trivial comments, the patch looks good to me.
> 
> Shawn
> 
> > +};
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Pengutronix e.K.             | Lucas Stach                 |
Industrial Linux Solutions   | http://www.pengutronix.de/  |
