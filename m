From: Lukasz Majewski <l.majewski@samsung.com>
Subject: Re: [PATCH 4/6] thermal: Support for TMU regulator defined at device
 tree
Date: Tue, 23 Apr 2013 08:23:12 +0200
Message-ID: <20130423082312.3caf60e0@amdc308.digital.local>
References: <1366389493-8239-1-git-send-email-l.majewski@samsung.com>
 <1366389493-8239-5-git-send-email-l.majewski@samsung.com>
 <51717D89.3090303@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <51717D89.3090303@ti.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Eduardo Valentin <eduardo.valentin@ti.com>
Cc: Kukjin Kim <kgene.kim@samsung.com>, Mike Turquette <mturquette@linaro.org>, Zhang Rui <rui.zhang@intel.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Amit Daniel Kachhap <amit.kachhap@linaro.org>, Kyungmin Park <kyungmin.park@samsung.com>
List-Id: linux-pm@vger.kernel.org

Hi Eduardo,

> On 19-04-2013 12:38, Lukasz Majewski wrote:
> > TMU probe function now checks for a device tree defined regulator.
> > For compatibility reasons it is allowed to probe driver even without
> > this regulator defined.
> >
> > Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
> > Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> > ---
> >   drivers/thermal/exynos_thermal.c |   19 +++++++++++++++++++
> >   1 file changed, 19 insertions(+)
> >
> > diff --git a/drivers/thermal/exynos_thermal.c
> > b/drivers/thermal/exynos_thermal.c index ba6094c..e922fa4 100644
> > --- a/drivers/thermal/exynos_thermal.c
> > +++ b/drivers/thermal/exynos_thermal.c
> > @@ -38,6 +38,7 @@
> >   #include <linux/cpufreq.h>
> >   #include <linux/cpu_cooling.h>
> >   #include <linux/of.h>
> > +#include <linux/regulator/consumer.h>
> >
> >   #include <plat/cpu.h>
> >
> > @@ -119,6 +120,8 @@
> >
> >   #define EXYNOS_ZONE_COUNT	3
> >
> > +#define EXYNOS_TMU_REGULATOR "vdd_ts"
> > +
> >   struct exynos_tmu_data {
> >   	struct exynos_tmu_platform_data *pdata;
> >   	struct resource *mem;
> > @@ -944,6 +947,7 @@ static int exynos_tmu_probe(struct
> > platform_device *pdev) {
> >   	struct exynos_tmu_data *data;
> >   	struct exynos_tmu_platform_data *pdata =
> > pdev->dev.platform_data;
> > +	struct regulator *reg;
> >   	int ret, i;
> >
> >   	if (!pdata)
> > @@ -953,6 +957,21 @@ static int exynos_tmu_probe(struct
> > platform_device *pdev) dev_err(&pdev->dev, "No platform init data
> > supplied.\n"); return -ENODEV;
> >   	}
> > +
> > +	reg = regulator_get(&pdev->dev, EXYNOS_TMU_REGULATOR);
> > +	if (!IS_ERR(reg)) {
> > +		ret = regulator_enable(reg);
> > +		if (ret) {
> > +			dev_err(&pdev->dev, "Regulator %s not
> > enabled.\n",
> > +				EXYNOS_TMU_REGULATOR);
> > +			return ret;
> > +		}
> > +	} else {
> > +		dev_info(&pdev->dev,
> > +			 "Regulator %s not defined at device
> > tree.\n",
> > +			 EXYNOS_TMU_REGULATOR);
> Maybe a dev_warn would fit better?

This is a bit tricky. I first wanted to return -ENODEV when regulator
is not available. Then I understood, that some other SoCs (e.g.
Exynos5) will not work. 

The info here shall give a clear warn signal, that providing a
regulator for VDD_TS is crucial (since by default it can be connected
to other PMIC outputs and when other device puts down this regulator
the TMU will crash and shut down a system). 

> 
> > +	}
> > +
> >   	data = devm_kzalloc(&pdev->dev, sizeof(struct
> > exynos_tmu_data), GFP_KERNEL);
> >   	if (!data) {
> >



-- 
Best regards,

Lukasz Majewski

Samsung R&D Poland (SRPOL) | Linux Platform Group
