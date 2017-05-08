From: Sean Wang <sean.wang@mediatek.com>
Subject: Re: [PATCH 4/6] cpufreq: mediatek: Add support of cpufreq to
 MT2701/MT7623 SoC
Date: Mon, 8 May 2017 14:09:28 +0800
Message-ID: <1494223768.9662.4.camel@mtkswgap22>
References: <1493997974-17699-1-git-send-email-sean.wang@mediatek.com>
         <1493997974-17699-5-git-send-email-sean.wang@mediatek.com>
         <20170506100059.6003d9ef@endymion>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <20170506100059.6003d9ef@endymion>
Sender: linux-clk-owner@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>
Cc: rjw@rjwysocki.net, viresh.kumar@linaro.org, robh+dt@kernel.org, matthias.bgg@gmail.com, mark.rutland@arm.com, mturquette@baylibre.com, jamesjj.liao@mediatek.com, p.zabel@pengutronix.de, shunli.wang@mediatek.com, erin.lo@mediatek.com, devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Jean,

Appreciate your reviewing and suggestion. I added my comment inline.

On Sat, 2017-05-06 at 10:00 +0200, Jean Delvare wrote:
> Hi Sean,
> 
> On Fri, 5 May 2017 23:26:12 +0800, sean.wang@mediatek.com wrote:
> > From: Sean Wang <sean.wang@mediatek.com>
> > 
> > MT2701/MT7623 is an 32-bit ARMv7 based quad-core (4 * Cortex-A7) with
> > single cluster and this hardware is also compatible with the existing
> > driver through enabling CPU frequency feature with operating-points-v2
> > bindings.
> > 
> > Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> > ---
> >  drivers/cpufreq/Kconfig.arm      | 4 ++--
> >  drivers/cpufreq/mt8173-cpufreq.c | 2 ++
> >  2 files changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
> > index 74ed7e9..68b387a 100644
> > --- a/drivers/cpufreq/Kconfig.arm
> > +++ b/drivers/cpufreq/Kconfig.arm
> > @@ -90,11 +90,11 @@ config ARM_KIRKWOOD_CPUFREQ
> >  config ARM_MT8173_CPUFREQ
> >  	tristate "Mediatek MT8173 CPUFreq support"
> >  	depends on ARCH_MEDIATEK && REGULATOR
> > -	depends on ARM64 || (ARM_CPU_TOPOLOGY && COMPILE_TEST)
> > +	depends on (ARM || ARM64) || (ARM_CPU_TOPOLOGY && COMPILE_TEST)
> 
> Parentheses not needed. I am also curious if ARM_CPU_TOPOLOGY can
> actually be set when neither ARM nor ARM64 is. I suspect not, and then
> the above can be simplified to just:
> 

I agree with you and I will look into more whether ARM_CPU_TOPOLOGY can
be removed safely since I can't make fully sure here and then update
those into the next version.

> 	depends on ARM || ARM64
> 
> >  	depends on !CPU_THERMAL || THERMAL
> >  	select PM_OPP
> >  	help
> > -	  This adds the CPUFreq driver support for Mediatek MT8173 SoC.
> > +	  This adds the CPUFreq driver support for Mediatek SoCs.
> 
> If this driver actually support all Mediatek SoCs, the menu entry
> itself should be updated to drop "MT8173".
> 

I will drop MT8173 wording because the driver also works for those
Mediatek SoCs not belonged to MT817x series.

In fact, the driver should also be extended and being more generic to
support more Mediatek SoCs in the future.

> >  
> >  config ARM_OMAP2PLUS_CPUFREQ
> >  	bool "TI OMAP2+"
> > diff --git a/drivers/cpufreq/mt8173-cpufreq.c b/drivers/cpufreq/mt8173-cpufreq.c
> > index fd1886f..481ec77 100644
> > --- a/drivers/cpufreq/mt8173-cpufreq.c
> > +++ b/drivers/cpufreq/mt8173-cpufreq.c
> > @@ -575,6 +575,8 @@ static struct platform_driver mt8173_cpufreq_platdrv = {
> >  
> >  /* List of machines supported by this driver */
> >  static const struct of_device_id mt8173_cpufreq_machines[] __initconst = {
> > +	{ .compatible = "mediatek,mt2701", },
> > +	{ .compatible = "mediatek,mt7623", },
> >  	{ .compatible = "mediatek,mt817x", },
> >  	{ .compatible = "mediatek,mt8173", },
> >  	{ .compatible = "mediatek,mt8176", },
> 
> 


