From: Chanwoo Choi <cwchoi00@gmail.com>
Subject: Re: [PATCH 1/2] PM / devfreq: exynos-ppmu: Add the support of PPMUv2
 for Exynos5433
Date: Thu, 23 Jul 2015 16:03:04 +0200
Message-ID: <CAGTfZH04TDR35_DTMiWnXmZyMhENmthdDSDseG-GAZ31aV+ePg@mail.gmail.com>
References: <1437616639-7448-1-git-send-email-cw00.choi@samsung.com>
	<1437616639-7448-2-git-send-email-cw00.choi@samsung.com>
	<55B0979B.50401@samsung.com>
	<55B0A26B.1000601@samsung.com>
Reply-To: cw00.choi@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <55B0A26B.1000601@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chanwoo Choi <cw00.choi@samsung.com>
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>, "myungjoo.ham@samsung.com" <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Kukjin Kim <kgene@kernel.org>, dan.carpenter@oracle.com, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Jul 23, 2015 at 10:14 AM, Chanwoo Choi <cw00.choi@samsung.com> wrote:
> Hi Krzysztof,
>
> On 07/23/2015 04:28 PM, Krzysztof Kozlowski wrote:
>> On 23.07.2015 10:57, Chanwoo Choi wrote:
>>> This patch adds the support for PPMU (Platform Performance Monitoring Unit)
>>> version 2.0 for Exynos5433 SoC. Exynos5433 SoC must need PPMUv2 which is
>>> quite different from PPMUv1.1. The exynos-ppmu.c driver supports both PPMUv1.1
>>> and PPMUv2.
>>>
>>> Cc: MyungJoo Ham <myungjoo.ham@samsung.com>
>>> Cc: Kyungmin Park <kyungmin.park@samsung.com>
>>> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
>>
>> Hi,
>>
>> Few comments at the end.
>>
>>> ---
>>>  drivers/devfreq/event/exynos-ppmu.c | 168 ++++++++++++++++++++++++++++++++++--
>>>  drivers/devfreq/event/exynos-ppmu.h |  70 +++++++++++++++
>>>  2 files changed, 231 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/drivers/devfreq/event/exynos-ppmu.c b/drivers/devfreq/event/exynos-ppmu.c
>>> index 7d99d13bacd8..6066dc18fc73 100644
>>> --- a/drivers/devfreq/event/exynos-ppmu.c
>>> +++ b/drivers/devfreq/event/exynos-ppmu.c
>>> @@ -1,7 +1,7 @@
>>>  /*
>>>   * exynos_ppmu.c - EXYNOS PPMU (Platform Performance Monitoring Unit) support
>>>   *
>>> - * Copyright (c) 2014 Samsung Electronics Co., Ltd.
>>> + * Copyright (c) 2014-2015 Samsung Electronics Co., Ltd.
>>>   * Author : Chanwoo Choi <cw00.choi@samsung.com>
>>>   *
>>>   * This program is free software; you can redistribute it and/or modify
>>> @@ -82,6 +82,15 @@ struct __exynos_ppmu_events {
>>>      PPMU_EVENT(mscl),
>>>      PPMU_EVENT(fimd0x),
>>>      PPMU_EVENT(fimd1x),
>
> (snip)
>
>>> +static int exynos_ppmu_v2_get_event(struct devfreq_event_dev *edev,
>>> +                                struct devfreq_event_data *edata)
>>> +{
>>> +    struct exynos_ppmu *info = devfreq_event_get_drvdata(edev);
>>> +    int id = exynos_ppmu_find_ppmu_id(edev);
>>> +    u32 pmnc, cntenc;
>>> +    u32 pmcnt_high, pmcnt_low;
>>> +    u64 load_count = 0;
>>> +
>>> +    /* Disable PPMU */
>>> +    pmnc = __raw_readl(info->ppmu.base + PPMUv2_PMNC);
>>> +    pmnc &= ~PPMU_PMNC_ENABLE_MASK;
>>> +    __raw_writel(pmnc, info->ppmu.base + PPMUv2_PMNC);
>>> +
>>> +    /* Read cycle count and performance count */
>>> +    edata->total_count = __raw_readl(info->ppmu.base + PPMUv2_CCNT);
>>> +
>>> +    switch (id) {
>>> +    case PPMU_PMNCNT0:
>>> +    case PPMU_PMNCNT1:
>>> +    case PPMU_PMNCNT2:
>>> +            load_count = __raw_readl(info->ppmu.base + PPMUv2_PMNCT(id));
>>> +            break;
>>> +    case PPMU_PMNCNT3:
>>> +            pmcnt_high = __raw_readl(info->ppmu.base + PPMUv2_PMCNT3_HIGH);
>>> +            pmcnt_low = __raw_readl(info->ppmu.base + PPMUv2_PMCNT3_LOW);
>>> +            load_count = (u64)((pmcnt_high & 0xff) << 32) + (u64)pmcnt_low;
>>> +            break;
>>> +    }
>>> +    edata->load_count = load_count;
>>> +
>>> +    /* Disable all counters */
>>> +    cntenc = __raw_readl(info->ppmu.base + PPMUv2_CNTENC);
>>> +    cntenc |= (PPMU_CCNT_MASK | (PPMU_ENABLE << id));
>>> +    __raw_writel(cntenc, info->ppmu.base + PPMUv2_CNTENC);
>>> +
>>> +    dev_dbg(&edev->dev, "%25s (load: %ld / %ld)\n", edev->desc->name,
>>> +                                    edata->load_count, edata->total_count);
>>> +    return 0;
>>> +}
>>> +
>>> +static struct devfreq_event_ops exynos_ppmu_v2_ops = {
>>
>> This can be const.
>
> OK.
>
>>
>>> +    .disable = exynos_ppmu_v2_disable,
>>> +    .set_event = exynos_ppmu_v2_set_event,
>>> +    .get_event = exynos_ppmu_v2_get_event,
>>> +};
>>> +
>>> +static struct of_device_id exynos_ppmu_id_match[] = {
>>
>> In the previous patch this was not present but now it can be made 'const'.
>
> OK for adding the 'const'.
> The original 'exynos_ppmu_id_match' is located on below of this patch.
>
>>
>>> +    {
>>> +            .compatible = "samsung,exynos-ppmu",
>>> +            .data = (void *)&exynos_ppmu_ops,
>>> +    }, {
>>> +            .compatible = "samsung,exynos-ppmu-v2",
>>> +            .data = (void *)&exynos_ppmu_v2_ops,
>>> +    },
>>> +    { /* sentinel */ },
>>> +};
>>> +
>>> +static struct devfreq_event_ops *exynos_bus_get_ops(struct device_node *np)
>>> +{
>>> +    const struct of_device_id *match;
>>> +
>>> +    match = of_match_node(exynos_ppmu_id_match, np);
>>> +    return (struct devfreq_event_ops *)match->data;
>>> +}
>>> +
>>>  static int of_get_devfreq_events(struct device_node *np,
>>>                               struct exynos_ppmu *info)
>>>  {
>>> @@ -238,7 +397,7 @@ static int of_get_devfreq_events(struct device_node *np,
>>>                      continue;
>>>              }
>>>
>>> -            desc[j].ops = &exynos_ppmu_ops;
>>> +            desc[j].ops = exynos_bus_get_ops(np);
>>
>> So for each ops callback (get/set/disable) you will have another layer
>> of indirection where you will be matching the device each time?
>>
>> That seems like a waste of CPU time. Just match it once here and use
>> either old ops or new ops_v2.
>
> OK. I'll rework to reduce the unneeded operation.
>
>>
>>
>>>              desc[j].driver_data = info;
>>>
>>>              of_property_read_string(node, "event-name", &desc[j].name);
>>> @@ -354,11 +513,6 @@ static int exynos_ppmu_remove(struct platform_device *pdev)
>>>      return 0;
>>>  }
>>>
>>> -static struct of_device_id exynos_ppmu_id_match[] = {
>>> -    { .compatible = "samsung,exynos-ppmu", },
>>> -    { /* sentinel */ },
>>> -};
>>> -
>>>  static struct platform_driver exynos_ppmu_driver = {
>>>      .probe  = exynos_ppmu_probe,
>>>      .remove = exynos_ppmu_remove,
>>> diff --git a/drivers/devfreq/event/exynos-ppmu.h b/drivers/devfreq/event/exynos-ppmu.h
>>> index 4e831d48c138..9a7cf6394f37 100644
>>> --- a/drivers/devfreq/event/exynos-ppmu.h
>>> +++ b/drivers/devfreq/event/exynos-ppmu.h
>>> @@ -26,6 +26,9 @@ enum ppmu_counter {
>>>      PPMU_PMNCNT_MAX,
>>>  };
>>>
>>> +/***
>>> + * PPMUv1.1 Definitions
>>> + */
>>>  enum ppmu_event_type {
>>>      PPMU_RO_BUSY_CYCLE_CNT  = 0x0,
>>>      PPMU_WO_BUSY_CYCLE_CNT  = 0x1,
>>> @@ -90,4 +93,71 @@ enum ppmu_reg {
>>>  #define PPMU_PMNCT(x)                       (PPMU_PMCNT0 + (0x10 * x))
>>>  #define PPMU_BEVTxSEL(x)            (PPMU_BEVT0SEL + (0x100 * x))
>>>
>>> +/***
>>> + * PPMUv2.0 definitions
>>> + */
>>> +enum ppmuv2_mode {
>>> +    PPMUv2_MODE_MANUAL = 0,
>>> +    PPMUv2_MODE_AUTO = 1,
>>> +    PPMUv2_MODE_CIG = 2,    /* CIG (Conditional Interrupt Generation) */
>>
>> Mixing lower-upper case looks odd to me. How about:
>> PPMU2_MODE_MANUAL = 0,
>> or
>> PPMU_V2_MODE_MANUAL = 0,
>> ?
>>
>> (here and everywhere below)
>
> As you know, after deciding the compatible name about using '-v2',
> we can decide the correct register name.

I modify the register name as PPMU_V2_* style.

Thanks,
Chanwoo Choi
