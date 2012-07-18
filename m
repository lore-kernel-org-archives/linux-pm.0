From: jonghwa3.lee@samsung.com
Subject: Re: [PATCH v5 5/5] ARM: exynos: add thermal sensor driver platform
 data support
Date: Wed, 18 Jul 2012 14:11:47 +0900
Message-ID: <50064593.1000302@samsung.com>
References: <1342177825-19006-1-git-send-email-amit.kachhap@linaro.org>
 <1342177825-19006-6-git-send-email-amit.kachhap@linaro.org>
 <CAH9JG2XGWgX-FiBacnrGXS-oG_7rbN1aum3mpW5HUAukiwaB7A@mail.gmail.com>
 <CADGdYn6SPTosESY5YXa=Q0PoHTiW28VYgSJuZODj0tj0kU_y=g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <CADGdYn6SPTosESY5YXa=Q0PoHTiW28VYgSJuZODj0tj0kU_y=g@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: amit kachhap <amit.kachhap@gmail.com>
Cc: Kyungmin Park <kmpark@infradead.org>, linux-pm@lists.linux-foundation.org, akpm@linux-foundation.org, lenb@kernel.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, lm-sensors@lm-sensors.org, SangWook Ju <sw.ju@samsung.com>, Durgadoss <durgadoss.r@intel.com>, Jean Delvare <khali@linux-fr.org>
List-Id: linux-pm@vger.kernel.org

Hi, Amit,
On 2012=EB=85=84 07=EC=9B=94 14=EC=9D=BC 16:30, amit kachhap wrote:
> On Sat, Jul 14, 2012 at 7:03 AM, Kyungmin Park <kmpark@infradead.org>=
 wrote:
>> On Fri, Jul 13, 2012 at 8:10 PM, Amit Daniel Kachhap
>> <amit.kachhap@linaro.org> wrote:
>>> Add necessary default platform data support needed for TMU driver. =
 This
>>> dt/non-dt values are tested for origen exynos4210 and smdk exynos52=
50
>>> platforms.
>> Looks good to me.
> Thanks.
>
>> just nitpicks below.
>>
>> Thank you,
>> Kyungmin Park
>>> Signed-off-by: Amit Daniel Kachhap <amit.kachhap@linaro.org>
>>> Cc: Donggeun Kim <dg77.kim@samsung.com>
>>> Acked-by: Guenter Roeck <guenter.roeck@ericsson.com>
>>> Cc: SangWook Ju <sw.ju@samsung.com>
>>> Cc: Durgadoss <durgadoss.r@intel.com>
>>> Cc: Len Brown <lenb@kernel.org>
>>> Cc: Jean Delvare <khali@linux-fr.org>
>>> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
>>> ---
>>>  drivers/thermal/exynos_thermal.c |  111 ++++++++++++++++++++++++++=
+++++++++++-
>>>  1 files changed, 110 insertions(+), 1 deletions(-)
>>>
>>> diff --git a/drivers/thermal/exynos_thermal.c b/drivers/thermal/exy=
nos_thermal.c
>>> index 9ef8c37..07736ea 100644
>>> --- a/drivers/thermal/exynos_thermal.c
>>> +++ b/drivers/thermal/exynos_thermal.c
>>> @@ -662,14 +662,121 @@ static irqreturn_t exynos_tmu_irq(int irq, v=
oid *id)
>>>  static struct thermal_sensor_conf exynos_sensor_conf =3D {
>>>         .name                   =3D "exynos-therm",
>>>         .read_temperature       =3D (int (*)(void *))exynos_tmu_rea=
d,
>>> +};
>>> +
>>> +#if defined(CONFIG_CPU_EXYNOS4210)
>> BTW, doesn't it same as exynos4412? does it different from exynos441=
2?
> Currently I only tested this only for origen and exynos5250 board.
> Maybe somebody can add 4412 support also.
Recently, I applied this patchset with exynos4412 and found it uses sam=
e
register map with exynos5250.
So, I think it should rename the any type of name containing exynos4 an=
d
exynos5 (e.g. SOC_ARCH_EXYNOS4)
In my local, i renamed SOC_ARCH_EXYNOS4 to SOC_ARCH_EXYNOS4210 and
SOC_ARCH_EXYNOS5 to SOC_ARCH_EXYNOS and
other related name also. I recommend you to change all of name
>> If it's same, it's better to use CONFIG_SOC_EXYNOS4?
>>> +static struct exynos_tmu_platform_data const exynos4_default_tmu_d=
ata =3D {
>>> +       .threshold =3D 80,
>>> +       .trigger_levels[0] =3D 5,
>>> +       .trigger_levels[1] =3D 20,
>>> +       .trigger_levels[2] =3D 30,
>>> +       .trigger_level0_en =3D 1,
>>> +       .trigger_level1_en =3D 1,
>>> +       .trigger_level2_en =3D 1,
>>> +       .trigger_level3_en =3D 0,
>>> +       .gain =3D 15,
>>> +       .reference_voltage =3D 7,
>>> +       .cal_type =3D TYPE_ONE_POINT_TRIMMING,
>>> +       .freq_tab[0] =3D {
>>> +               .freq_clip_max =3D 800 * 1000,
>>> +               .temp_level =3D 85,
>>> +       },
>>> +       .freq_tab[1] =3D {
>>> +               .freq_clip_max =3D 200 * 1000,
>>> +               .temp_level =3D 100,
>>> +       },
>>> +       .freq_tab_count =3D 2,
>>> +       .type =3D SOC_ARCH_EXYNOS4,
>>> +};
>>> +#define EXYNOS4_TMU_DRV_DATA (&exynos4_default_tmu_data)
>>> +#else
>>> +#define EXYNOS4_TMU_DRV_DATA (NULL)
>>> +#endif
>>> +
>>> +#if defined(CONFIG_SOC_EXYNOS5250)
>> similar.
>>> +static struct exynos_tmu_platform_data const exynos5_default_tmu_d=
ata =3D {
>>> +       .trigger_levels[0] =3D 85,
>>> +       .trigger_levels[1] =3D 103,
>>> +       .trigger_levels[2] =3D 110,
>>> +       .trigger_level0_en =3D 1,
>>> +       .trigger_level1_en =3D 1,
>>> +       .trigger_level2_en =3D 1,
>>> +       .trigger_level3_en =3D 0,
>>> +       .gain =3D 8,
>>> +       .reference_voltage =3D 16,
>>> +       .noise_cancel_mode =3D 4,
>>> +       .cal_type =3D TYPE_ONE_POINT_TRIMMING,
>>> +       .efuse_value =3D 55,
>>> +       .freq_tab[0] =3D {
>>> +               .freq_clip_max =3D 800 * 1000,
>>> +               .temp_level =3D 85,
>>> +       },
>>> +       .freq_tab[1] =3D {
>>> +               .freq_clip_max =3D 200 * 1000,
>>> +               .temp_level =3D 103,
>>> +       },
>>> +       .freq_tab_count =3D 2,
>>> +       .type =3D SOC_ARCH_EXYNOS5,
>>> +};
>>> +#define EXYNOS5_TMU_DRV_DATA (&exynos5_default_tmu_data)
>>> +#else
>>> +#define EXYNOS5_TMU_DRV_DATA (NULL)
>>> +#endif
>>> +
>>> +#ifdef CONFIG_OF
>>> +static const struct of_device_id exynos_tmu_match[] =3D {
>>> +       {
>>> +               .compatible =3D "samsung,exynos4-tmu",
>>> +               .data =3D (void *)EXYNOS4_TMU_DRV_DATA,
>>> +       },
>>> +       {
>>> +               .compatible =3D "samsung,exynos5-tmu",
>>> +               .data =3D (void *)EXYNOS5_TMU_DRV_DATA,
>>> +       },
>>> +       {},
>>> +};
>>> +MODULE_DEVICE_TABLE(of, exynos_tmu_match);
>>> +#else
>>> +#define  exynos_tmu_match NULL
>>> +#endif
>>> +
>>> +static struct platform_device_id exynos_tmu_driver_ids[] =3D {
>>> +       {
>>> +               .name           =3D "exynos4-tmu",
>>> +               .driver_data    =3D (kernel_ulong_t)EXYNOS4_TMU_DRV=
_DATA,
>>> +       },
>>> +       {
>>> +               .name           =3D "exynos5-tmu",
>>> +               .driver_data    =3D (kernel_ulong_t)EXYNOS5_TMU_DRV=
_DATA,
>>> +       },
>>> +       { },
>>> +};
>>> +MODULE_DEVICE_TABLE(platform, exynos4_tmu_driver_ids);
>>> +
>>> +static inline struct  exynos_tmu_platform_data *exynos_get_driver_=
data(
>>> +                       struct platform_device *pdev)
>>> +{
>>> +#ifdef CONFIG_OF
>>> +       if (pdev->dev.of_node) {
>>> +               const struct of_device_id *match;
>>> +               match =3D of_match_node(exynos_tmu_match, pdev->dev=
=2Eof_node);
>>> +               if (!match)
>>> +                       return NULL;
>>> +               return (struct exynos_tmu_platform_data *) match->d=
ata;
>>> +       }
>>> +#endif
>>> +       return (struct exynos_tmu_platform_data *)
>>> +                       platform_get_device_id(pdev)->driver_data;
>>>  }
>>> -;
>>>  static int __devinit exynos_tmu_probe(struct platform_device *pdev=
)
>>>  {
>>>         struct exynos_tmu_data *data;
>>>         struct exynos_tmu_platform_data *pdata =3D pdev->dev.platfo=
rm_data;
>>>         int ret, i;
>>>
>>> +       if (!pdata)
>>> +               pdata =3D exynos_get_driver_data(pdev);
>>> +
>>>         if (!pdata) {
>>>                 dev_err(&pdev->dev, "No platform init data supplied=
=2E\n");
>>>                 return -ENODEV;
>>> @@ -838,9 +945,11 @@ static struct platform_driver exynos_tmu_drive=
r =3D {
>>>                 .name   =3D "exynos-tmu",
>>>                 .owner  =3D THIS_MODULE,
>>>                 .pm     =3D EXYNOS_TMU_PM,
>>> +               .of_match_table =3D exynos_tmu_match,
>>>         },
>>>         .probe =3D exynos_tmu_probe,
>>>         .remove =3D __devexit_p(exynos_tmu_remove),
>>> +       .id_table =3D exynos_tmu_driver_ids,
>>>  };
>>>
>>>  module_platform_driver(exynos_tmu_driver);
>>> --
>>> 1.7.1
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-ker=
nel" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>> Please read the FAQ at  http://www.tux.org/lkml/
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-sams=
ung-soc" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kerne=
l" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
Thanks.
