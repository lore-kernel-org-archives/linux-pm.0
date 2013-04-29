From: amit daniel kachhap <amit.daniel@samsung.com>
Subject: Re: [PATCH v2 2/4] Thermal: exynos: Support for TMU regulator defined
 at device tree
Date: Mon, 29 Apr 2013 10:05:00 +0530
Message-ID: <CADGdYn4QGBHKJuvf6oaMhM5YfK+wPzjEK94mEm5j+My1dSaZTg@mail.gmail.com>
References: <1366389493-8239-1-git-send-email-l.majewski@samsung.com>
	<1366893045-31586-1-git-send-email-l.majewski@samsung.com>
	<1366893045-31586-3-git-send-email-l.majewski@samsung.com>
	<CADGdYn6g5Lggkcbq9WMMfbqN-NBb_14_b1bfcd=7+CJrxJcquA@mail.gmail.com>
	<20130425152934.5041cc98@amdc308.digital.local>
	<51794F48.5040401@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ie0-f172.google.com ([209.85.223.172]:35746 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752549Ab3D2EfB (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 29 Apr 2013 00:35:01 -0400
In-Reply-To: <51794F48.5040401@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <eduardo.valentin@ti.com>
Cc: Lukasz Majewski <l.majewski@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, Zhang Rui <rui.zhang@intel.com>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, t.figa@samsung.com, Sachin Kamat <sachin.kamat@linaro.org>, Myungjoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>

Hi Lukasz/Eduardo,

On Thu, Apr 25, 2013 at 9:14 PM, Eduardo Valentin
<eduardo.valentin@ti.com> wrote:
> Amit, Lukasz,
>
>
> On 25-04-2013 09:29, Lukasz Majewski wrote:
>>
>> Hi Amit,
>>
>>> Hi Lukasz Majewski,
>>>
>>> Sorry for late review but I am currently working on restructuring the
>>> whole exynos thermal driver and this support of LDO can be added as
>>> feature as not all socs support this. This is also suggested by
>>> Eduardo. All your other patches looks fine.
>>
>>
>> But this is how it is already done. The VDD_TS is optional, so
>> Exynos5440 and Exynos4210 will not be broken.
>>
>> This shall preserve the correct behavior of the thermal driver.
Yes lukasz I saw your code that vdd_ts is optional but adding
regulator support in submitted TMU V2 re-structured is more easier and
even regulator_get function call can be avoided. If you are ok I can
re-submit your patch series with regulator support present.
>>
>
> If you guys plan to move to feature based approach, like suggested in V1,
> then Id recommend adding a /* TODO: */ entry in your driver.
>
> Amit, are you including this LDO support on your rework?

I just submitted the re-structured patches without the LDO support. I
will add the regulator support in a new patch.

Thanks,
Amit Daniel
>
>
>>>
>>> Thanks,
>>> Amit Daniel
>>>
>>> On Thu, Apr 25, 2013 at 6:00 PM, Lukasz Majewski
>>> <l.majewski@samsung.com> wrote:
>>>>
>>>> TMU probe function now checks for a device tree defined regulator.
>>>> For compatibility reasons it is allowed to probe driver even without
>>>> this regulator defined.
>>>>
>>>> Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
>>>> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
>>>> ---
>>>> Changes for v2:
>>>> - Change dev_info() to dev_warn()
>>>> ---
>>>>   drivers/thermal/exynos_thermal.c |   19 +++++++++++++++++++
>>>>   1 file changed, 19 insertions(+)
>>>>
>>>> diff --git a/drivers/thermal/exynos_thermal.c
>>>> b/drivers/thermal/exynos_thermal.c index 3d6e32a..328fe7e 100644
>>>> --- a/drivers/thermal/exynos_thermal.c
>>>> +++ b/drivers/thermal/exynos_thermal.c
>>>> @@ -38,6 +38,7 @@
>>>>   #include <linux/cpufreq.h>
>>>>   #include <linux/cpu_cooling.h>
>>>>   #include <linux/of.h>
>>>> +#include <linux/regulator/consumer.h>
>>>>
>>>>   #include <plat/cpu.h>
>>>>
>>>> @@ -119,6 +120,8 @@
>>>>
>>>>   #define EXYNOS_ZONE_COUNT      3
>>>>
>>>> +#define EXYNOS_TMU_REGULATOR "vdd_ts"
>>>> +
>>>>   struct exynos_tmu_data {
>>>>          struct exynos_tmu_platform_data *pdata;
>>>>          struct resource *mem;
>>>> @@ -948,6 +951,7 @@ static int exynos_tmu_probe(struct
>>>> platform_device *pdev) {
>>>>          struct exynos_tmu_data *data;
>>>>          struct exynos_tmu_platform_data *pdata =
>>>> pdev->dev.platform_data;
>>>> +       struct regulator *reg;
>>>>          int ret, i;
>>>>
>>>>          if (!pdata)
>>>> @@ -957,6 +961,21 @@ static int exynos_tmu_probe(struct
>>>> platform_device *pdev) dev_err(&pdev->dev, "No platform init data
>>>> supplied.\n"); return -ENODEV;
>>>>          }
>>>> +
>>>> +       reg = regulator_get(&pdev->dev, EXYNOS_TMU_REGULATOR);
>>>> +       if (!IS_ERR(reg)) {
>>>> +               ret = regulator_enable(reg);
>>>> +               if (ret) {
>>>> +                       dev_err(&pdev->dev, "Regulator %s not
>>>> enabled.\n",
>>>> +                               EXYNOS_TMU_REGULATOR);
>>>> +                       return ret;
>>>> +               }
>>>> +       } else {
>>>> +               dev_warn(&pdev->dev,
>>>> +                        "Regulator %s not defined at device
>>>> tree.\n",
>>>> +                        EXYNOS_TMU_REGULATOR);
>>>> +       }
>>>> +
>>>>          data = devm_kzalloc(&pdev->dev, sizeof(struct
>>>> exynos_tmu_data), GFP_KERNEL);
>>>>          if (!data) {
>>>> --
>>>> 1.7.10.4
>>>>
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe
>>>> linux-samsung-soc" in the body of a message to
>>>> majordomo@vger.kernel.org More majordomo info at
>>>> http://vger.kernel.org/majordomo-info.html
>>
>>
>>
>>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
