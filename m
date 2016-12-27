From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH 5/9] pinctrl: samsung: Move retention control from
 mach-exynos to the pinctrl driver
Date: Tue, 27 Dec 2016 11:15:02 +0100
Message-ID: <e7e17dd2-2a44-b863-70fa-6d62d7ba3029@samsung.com>
References: <1482495889-6201-1-git-send-email-m.szyprowski@samsung.com>
 <CGME20161223122531epcas1p4b8fad6664dad3408acb7a1b9f140884a@epcas1p4.samsung.com>
 <1482495889-6201-6-git-send-email-m.szyprowski@samsung.com>
 <20161225134228.qlp553c7cdqy6256@kozik-lap>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <20161225134228.qlp553c7cdqy6256@kozik-lap>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Sylwester Nawrocki <s.nawrocki@samsung.com>, Linus Walleij <linus.walleij@linaro.org>, Tomasz Figa <tomasz.figa@gmail.com>, Ulf Hansson <ulf.hansson@linaro.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-Id: linux-pm@vger.kernel.org

Hi Krzysztof,


On 2016-12-25 14:42, Krzysztof Kozlowski wrote:
> On Fri, Dec 23, 2016 at 01:24:45PM +0100, Marek Szyprowski wrote:
>> Pad retention control after suspend/resume cycle should be done from pin
>> controller driver instead of PMU (power management unit) driver to avoid
>> possible ordering and logical dependencies. Till now it worked fine only
>> because PMU driver registered its sys_ops after pin controller.
>>
>> This patch moves pad retention control from PMU driver to Exynos pin
>> controller driver. This is a preparation for adding new features to Exynos
>> pin controller driver, like runtime power management and suspending
>> individual pin controllers, which might be a part of some power domain.
>>
>> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
>> ---
>>   .../bindings/pinctrl/samsung-pinctrl.txt           |   4 +
>>   arch/arm/mach-exynos/suspend.c                     |  64 ---------
>>   drivers/pinctrl/samsung/pinctrl-exynos.c           | 148 +++++++++++++++++++++
>>   drivers/pinctrl/samsung/pinctrl-samsung.c          |  16 ++-
>>   drivers/pinctrl/samsung/pinctrl-samsung.h          |  13 ++
>>   5 files changed, 178 insertions(+), 67 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/pinctrl/samsung-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/samsung-pinctrl.txt
>> index 1baf19eecabf..b7bd2e12a269 100644
>> --- a/Documentation/devicetree/bindings/pinctrl/samsung-pinctrl.txt
>> +++ b/Documentation/devicetree/bindings/pinctrl/samsung-pinctrl.txt
>> @@ -43,6 +43,10 @@ Required Properties:
>>   		};
>>   	};
>>   
>> +- samsung,pmu-syscon: Phandle to the PMU system controller, to let driver
>> +  to control pad retention after system suspend/resume cycle (only for Exynos
>> +  SoC series).
>> +
>>   - Pin banks as child nodes: Pin banks of the controller are represented by child
>>     nodes of the controller node. Bank name is taken from name of the node. Each
>>     bank node must contain following properties:
>> diff --git a/arch/arm/mach-exynos/suspend.c b/arch/arm/mach-exynos/suspend.c

 > [...]

>> diff --git a/drivers/pinctrl/samsung/pinctrl-exynos.c b/drivers/pinctrl/samsung/pinctrl-exynos.c
>> index 12f7d1eb65bc..55c1104a1ccf 100644
>> --- a/drivers/pinctrl/samsung/pinctrl-exynos.c
>> +++ b/drivers/pinctrl/samsung/pinctrl-exynos.c
>> @@ -24,11 +24,15 @@
>>   #include <linux/irqdomain.h>
>>   #include <linux/irq.h>
>>   #include <linux/irqchip/chained_irq.h>
>> +#include <linux/mfd/syscon.h>
>>   #include <linux/of_irq.h>
>>   #include <linux/io.h>
>>   #include <linux/slab.h>
>>   #include <linux/spinlock.h>
>> +#include <linux/regmap.h>
>>   #include <linux/err.h>
>> +#include <linux/soc/samsung/exynos-regs-pmu.h>
>> +
>>   
>>   #include "pinctrl-samsung.h"
>>   #include "pinctrl-exynos.h"
>> @@ -633,6 +637,46 @@ static void exynos_pinctrl_resume(struct samsung_pinctrl_drv_data *drvdata)
>>   			exynos_pinctrl_resume_bank(drvdata, bank);
>>   }
>>   
>> +static atomic_t exynos_retention_refcnt;
>> +static struct regmap *pmu_regs;
>> +
>> +static int exynos_retention_init(struct samsung_pinctrl_drv_data *drvdata)
>> +{
>> +	struct device *dev = drvdata->dev;
>> +
>> +	pmu_regs = syscon_regmap_lookup_by_phandle(dev->of_node,
>> +						   "samsung,pmu-syscon");
>> +	if (IS_ERR(pmu_regs)) {
>> +		dev_err(dev, "failed to lookup PMU regmap, no support for pad retention\n");
>> +		return PTR_ERR(pmu_regs);
>> +	}
>> +	return 0;
>> +}
>> +
>> +static void exynos_retention_on(struct samsung_pinctrl_drv_data *drvdata)
>> +{
>> +	atomic_inc(&exynos_retention_refcnt);
> As this does not imply memory barriers, so maybe you need smp_mb__after_atomic()?

exynos_retention_refcnt will be read/tested after suspend/resume cycle, 
so I doubt
that any kind of barrier is needed here.

>
> You didn't describe the need behind this barrier. What do you want to
> protect? Do you expect suspend (or resume) happening multiple times for
> one device? Or maybe you expect even mixing of these by different CPUs?

There are more than one instance of pinctrl devices on Exynos4+ SoCs and 
they have
common retention regs. All those controllers might be resumed in 
parallel, so this
atomic counting is needed to ensure that retention will be disabled when 
the last
instance is being resumed.

>> +}
>> +
>> +static void exynos_retention_off(struct samsung_pinctrl_drv_data *drvdata)
>> +{
>> +	int i;
>> +
>> +	if (!atomic_dec_and_test(&exynos_retention_refcnt) || IS_ERR(pmu_regs))
>> +		return;
>> +
>> +	for (i = 0; i < drvdata->nr_retention_regs; i++)
>> +		regmap_write(pmu_regs, drvdata->retention_regs[i],
>> +			     EXYNOS_WAKEUP_FROM_LOWPWR);
>> +}
>> +
>> +static void exynos_retention_audio_off(struct samsung_pinctrl_drv_data *drvdata)
>> +{
>> +	if (!IS_ERR(pmu_regs))
>> +		regmap_write(pmu_regs, S5P_PAD_RET_MAUDIO_OPTION,
>> +			     EXYNOS_WAKEUP_FROM_LOWPWR);
>> +}
>> +

 > [...]

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
