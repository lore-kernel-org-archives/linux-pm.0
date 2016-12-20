From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH 2/7] PM / devfreq: exynos-ppmu: Use the regmap interface to
 handle the registers
Date: Tue, 20 Dec 2016 17:26:49 +0900
Message-ID: <5858EB49.3010609@samsung.com>
References: <1481794243-5046-1-git-send-email-cw00.choi@samsung.com>
 <1481794243-5046-3-git-send-email-cw00.choi@samsung.com>
 <CGME20161219194750epcas2p46c42c6d79a6fc088c78daa693756af87@epcas2p4.samsung.com>
 <58583941.1040809@math.uni-bielefeld.de> <585898FB.7050801@samsung.com>
 <5858E70B.2000902@math.uni-bielefeld.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:39842 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753728AbcLTI13 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 20 Dec 2016 03:27:29 -0500
In-reply-to: <5858E70B.2000902@math.uni-bielefeld.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>, myungjoo.ham@samsung.com, kyungmin.park@samsung.com
Cc: rjw@rjwysocki.net, chanwoo@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Javier Martinez Canillas <javier@osg.samsung.com>, linux-samsung-soc@vger.kernel.org

On 2016년 12월 20일 17:08, Tobias Jakobi wrote:
> Hello Chanwoo,
> 
> 
> Chanwoo Choi wrote:
>> Hi,
>>
>> On 2016년 12월 20일 04:47, Tobias Jakobi wrote:
>>> Hello,
>>>
>>> I was just wondering what is improved by moving to regmap. For me this
>>> looks like it only complicates the code. Lots of regmap_{read,write}()
>>> and for each one of these we need to check the return code.
>>
>> It is correct to check the return value. It cover all of exception.
> that doesn't really answer my question. Which 'exceptions' are we
> talking about? What can go wrong with  __raw_{writel,readl}(), that

When using __raw_readl/writel() don't check the any return value, it it not correct.
When calling the function, basically we should check whether return value is error or success.
What is problem to check the return value?

> makes it necessary to put another layer on top of it? AFAIK regmap was
> introduced to handle read/writes to slow busses like I2C and SPI. I
> don't see that this applies here.

The regmap support the MMIO on following driver.
- drivers/base/regmap/regmap-mmio.c

> 
> 
>>> Also when exactly did __raw_writel() and friends become legacy?
>>
>> Also, I want to use the regmap interface (regmap-io) instead of __raw_readl/__raw_writel using the base address 
>> directly.
> I see, but why are __raw_{writel,readl}() legacy as you say? I don't see
> this anywhere else in the kernel.

If you just don't like the 'legacy' expression. I'll remove it.
It is not any important. The key point of this patch uses the regmap interface.
Usually, when adding new device driver, I use the regmap mmio interface
instead of __raw_readl/writel. So, this patch changes it.

Regards,
Chanwoo Choi

> 
> 
> With best wishes,
> Tobias
> 
> 
>>
>> Regards,
>> Chanwoo Choi
>>
>>>
>>> With best wishes,
>>> Tobias
>>>
>>>
>>> Chanwoo Choi wrote:
>>>> This patch uses the regmap interface to read and write the registers for exynos
>>>> PPMU device instead of the legacy memory map functions.
>>>>
>>>> Cc: Kukjin Kim <kgene@kernel.org>
>>>> Cc: Krzysztof Kozlowski <krzk@kernel.org>
>>>> Cc: Javier Martinez Canillas <javier@osg.samsung.com>
>>>> Cc: linux-samsung-soc@vger.kernel.org
>>>> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
>>>> ---
>>>>  drivers/devfreq/event/exynos-ppmu.c | 326 ++++++++++++++++++++++++++----------
>>>>  1 file changed, 237 insertions(+), 89 deletions(-)
>>>>
>>>> diff --git a/drivers/devfreq/event/exynos-ppmu.c b/drivers/devfreq/event/exynos-ppmu.c
>>>> index 107eb91a9415..fb3706faf5bd 100644
>>>> --- a/drivers/devfreq/event/exynos-ppmu.c
>>>> +++ b/drivers/devfreq/event/exynos-ppmu.c
>>>> @@ -17,13 +17,13 @@
>>>>  #include <linux/module.h>
>>>>  #include <linux/of_address.h>
>>>>  #include <linux/platform_device.h>
>>>> +#include <linux/regmap.h>
>>>>  #include <linux/suspend.h>
>>>>  #include <linux/devfreq-event.h>
>>>>  
>>>>  #include "exynos-ppmu.h"
>>>>  
>>>>  struct exynos_ppmu_data {
>>>> -	void __iomem *base;
>>>>  	struct clk *clk;
>>>>  };
>>>>  
>>>> @@ -33,6 +33,7 @@ struct exynos_ppmu {
>>>>  	unsigned int num_events;
>>>>  
>>>>  	struct device *dev;
>>>> +	struct regmap *regmap;
>>>>  
>>>>  	struct exynos_ppmu_data ppmu;
>>>>  };
>>>> @@ -107,20 +108,28 @@ static int exynos_ppmu_find_ppmu_id(struct devfreq_event_dev *edev)
>>>>  static int exynos_ppmu_disable(struct devfreq_event_dev *edev)
>>>>  {
>>>>  	struct exynos_ppmu *info = devfreq_event_get_drvdata(edev);
>>>> +	int ret;
>>>>  	u32 pmnc;
>>>>  
>>>>  	/* Disable all counters */
>>>> -	__raw_writel(PPMU_CCNT_MASK |
>>>> -		     PPMU_PMCNT0_MASK |
>>>> -		     PPMU_PMCNT1_MASK |
>>>> -		     PPMU_PMCNT2_MASK |
>>>> -		     PPMU_PMCNT3_MASK,
>>>> -		     info->ppmu.base + PPMU_CNTENC);
>>>> +	ret = regmap_write(info->regmap, PPMU_CNTENC,
>>>> +				PPMU_CCNT_MASK |
>>>> +				PPMU_PMCNT0_MASK |
>>>> +				PPMU_PMCNT1_MASK |
>>>> +				PPMU_PMCNT2_MASK |
>>>> +				PPMU_PMCNT3_MASK);
>>>> +	if (ret < 0)
>>>> +		return ret;
>>>>  
>>>>  	/* Disable PPMU */
>>>> -	pmnc = __raw_readl(info->ppmu.base + PPMU_PMNC);
>>>> +	ret = regmap_read(info->regmap, PPMU_PMNC, &pmnc);
>>>> +	if (ret < 0)
>>>> +		return ret;
>>>> +
>>>>  	pmnc &= ~PPMU_PMNC_ENABLE_MASK;
>>>> -	__raw_writel(pmnc, info->ppmu.base + PPMU_PMNC);
>>>> +	ret = regmap_write(info->regmap, PPMU_PMNC, pmnc);
>>>> +	if (ret < 0)
>>>> +		return ret;
>>>>  
>>>>  	return 0;
>>>>  }
>>>> @@ -129,29 +138,42 @@ static int exynos_ppmu_set_event(struct devfreq_event_dev *edev)
>>>>  {
>>>>  	struct exynos_ppmu *info = devfreq_event_get_drvdata(edev);
>>>>  	int id = exynos_ppmu_find_ppmu_id(edev);
>>>> +	int ret;
>>>>  	u32 pmnc, cntens;
>>>>  
>>>>  	if (id < 0)
>>>>  		return id;
>>>>  
>>>>  	/* Enable specific counter */
>>>> -	cntens = __raw_readl(info->ppmu.base + PPMU_CNTENS);
>>>> +	ret = regmap_read(info->regmap, PPMU_CNTENS, &cntens);
>>>> +	if (ret < 0)
>>>> +		return ret;
>>>> +
>>>>  	cntens |= (PPMU_CCNT_MASK | (PPMU_ENABLE << id));
>>>> -	__raw_writel(cntens, info->ppmu.base + PPMU_CNTENS);
>>>> +	ret = regmap_write(info->regmap, PPMU_CNTENS, cntens);
>>>> +	if (ret < 0)
>>>> +		return ret;
>>>>  
>>>>  	/* Set the event of Read/Write data count  */
>>>> -	__raw_writel(PPMU_RO_DATA_CNT | PPMU_WO_DATA_CNT,
>>>> -			info->ppmu.base + PPMU_BEVTxSEL(id));
>>>> +	ret = regmap_write(info->regmap, PPMU_BEVTxSEL(id),
>>>> +				PPMU_RO_DATA_CNT | PPMU_WO_DATA_CNT);
>>>> +	if (ret < 0)
>>>> +		return ret;
>>>>  
>>>>  	/* Reset cycle counter/performance counter and enable PPMU */
>>>> -	pmnc = __raw_readl(info->ppmu.base + PPMU_PMNC);
>>>> +	ret = regmap_read(info->regmap, PPMU_PMNC, &pmnc);
>>>> +	if (ret < 0)
>>>> +		return ret;
>>>> +
>>>>  	pmnc &= ~(PPMU_PMNC_ENABLE_MASK
>>>>  			| PPMU_PMNC_COUNTER_RESET_MASK
>>>>  			| PPMU_PMNC_CC_RESET_MASK);
>>>>  	pmnc |= (PPMU_ENABLE << PPMU_PMNC_ENABLE_SHIFT);
>>>>  	pmnc |= (PPMU_ENABLE << PPMU_PMNC_COUNTER_RESET_SHIFT);
>>>>  	pmnc |= (PPMU_ENABLE << PPMU_PMNC_CC_RESET_SHIFT);
>>>> -	__raw_writel(pmnc, info->ppmu.base + PPMU_PMNC);
>>>> +	ret = regmap_write(info->regmap, PPMU_PMNC, pmnc);
>>>> +	if (ret < 0)
>>>> +		return ret;
>>>>  
>>>>  	return 0;
>>>>  }
>>>> @@ -161,40 +183,64 @@ static int exynos_ppmu_get_event(struct devfreq_event_dev *edev,
>>>>  {
>>>>  	struct exynos_ppmu *info = devfreq_event_get_drvdata(edev);
>>>>  	int id = exynos_ppmu_find_ppmu_id(edev);
>>>> -	u32 pmnc, cntenc;
>>>> +	unsigned int total_count, load_count;
>>>> +	unsigned int pmcnt3_high, pmcnt3_low;
>>>> +	unsigned int pmnc, cntenc;
>>>> +	int ret;
>>>>  
>>>>  	if (id < 0)
>>>>  		return -EINVAL;
>>>>  
>>>>  	/* Disable PPMU */
>>>> -	pmnc = __raw_readl(info->ppmu.base + PPMU_PMNC);
>>>> +	ret = regmap_read(info->regmap, PPMU_PMNC, &pmnc);
>>>> +	if (ret < 0)
>>>> +		return ret;
>>>> +
>>>>  	pmnc &= ~PPMU_PMNC_ENABLE_MASK;
>>>> -	__raw_writel(pmnc, info->ppmu.base + PPMU_PMNC);
>>>> +	ret = regmap_write(info->regmap, PPMU_PMNC, pmnc);
>>>> +	if (ret < 0)
>>>> +		return ret;
>>>>  
>>>>  	/* Read cycle count */
>>>> -	edata->total_count = __raw_readl(info->ppmu.base + PPMU_CCNT);
>>>> +	ret = regmap_read(info->regmap, PPMU_CCNT, &total_count);
>>>> +	if (ret < 0)
>>>> +		return ret;
>>>> +	edata->total_count = total_count;
>>>>  
>>>>  	/* Read performance count */
>>>>  	switch (id) {
>>>>  	case PPMU_PMNCNT0:
>>>>  	case PPMU_PMNCNT1:
>>>>  	case PPMU_PMNCNT2:
>>>> -		edata->load_count
>>>> -			= __raw_readl(info->ppmu.base + PPMU_PMNCT(id));
>>>> +		ret = regmap_read(info->regmap, PPMU_PMNCT(id), &load_count);
>>>> +		if (ret < 0)
>>>> +			return ret;
>>>> +		edata->load_count = load_count;
>>>>  		break;
>>>>  	case PPMU_PMNCNT3:
>>>> -		edata->load_count =
>>>> -			((__raw_readl(info->ppmu.base + PPMU_PMCNT3_HIGH) << 8)
>>>> -			| __raw_readl(info->ppmu.base + PPMU_PMCNT3_LOW));
>>>> +		ret = regmap_read(info->regmap, PPMU_PMCNT3_HIGH, &pmcnt3_high);
>>>> +		if (ret < 0)
>>>> +			return ret;
>>>> +
>>>> +		ret = regmap_read(info->regmap, PPMU_PMCNT3_LOW, &pmcnt3_low);
>>>> +		if (ret < 0)
>>>> +			return ret;
>>>> +
>>>> +		edata->load_count = ((pmcnt3_high << 8) | pmcnt3_low);
>>>>  		break;
>>>>  	default:
>>>>  		return -EINVAL;
>>>>  	}
>>>>  
>>>>  	/* Disable specific counter */
>>>> -	cntenc = __raw_readl(info->ppmu.base + PPMU_CNTENC);
>>>> +	ret = regmap_read(info->regmap, PPMU_CNTENC, &cntenc);
>>>> +	if (ret < 0)
>>>> +		return ret;
>>>> +
>>>>  	cntenc |= (PPMU_CCNT_MASK | (PPMU_ENABLE << id));
>>>> -	__raw_writel(cntenc, info->ppmu.base + PPMU_CNTENC);
>>>> +	ret = regmap_write(info->regmap, PPMU_CNTENC, cntenc);
>>>> +	if (ret < 0)
>>>> +		return ret;
>>>>  
>>>>  	dev_dbg(&edev->dev, "%s (event: %ld/%ld)\n", edev->desc->name,
>>>>  					edata->load_count, edata->total_count);
>>>> @@ -214,36 +260,93 @@ static int exynos_ppmu_get_event(struct devfreq_event_dev *edev,
>>>>  static int exynos_ppmu_v2_disable(struct devfreq_event_dev *edev)
>>>>  {
>>>>  	struct exynos_ppmu *info = devfreq_event_get_drvdata(edev);
>>>> +	int ret;
>>>>  	u32 pmnc, clear;
>>>>  
>>>>  	/* Disable all counters */
>>>>  	clear = (PPMU_CCNT_MASK | PPMU_PMCNT0_MASK | PPMU_PMCNT1_MASK
>>>>  		| PPMU_PMCNT2_MASK | PPMU_PMCNT3_MASK);
>>>> +	ret = regmap_write(info->regmap, PPMU_V2_FLAG, clear);
>>>> +	if (ret < 0)
>>>> +		return ret;
>>>> +
>>>> +	ret = regmap_write(info->regmap, PPMU_V2_INTENC, clear);
>>>> +	if (ret < 0)
>>>> +		return ret;
>>>>  
>>>> -	__raw_writel(clear, info->ppmu.base + PPMU_V2_FLAG);
>>>> -	__raw_writel(clear, info->ppmu.base + PPMU_V2_INTENC);
>>>> -	__raw_writel(clear, info->ppmu.base + PPMU_V2_CNTENC);
>>>> -	__raw_writel(clear, info->ppmu.base + PPMU_V2_CNT_RESET);
>>>> -
>>>> -	__raw_writel(0x0, info->ppmu.base + PPMU_V2_CIG_CFG0);
>>>> -	__raw_writel(0x0, info->ppmu.base + PPMU_V2_CIG_CFG1);
>>>> -	__raw_writel(0x0, info->ppmu.base + PPMU_V2_CIG_CFG2);
>>>> -	__raw_writel(0x0, info->ppmu.base + PPMU_V2_CIG_RESULT);
>>>> -	__raw_writel(0x0, info->ppmu.base + PPMU_V2_CNT_AUTO);
>>>> -	__raw_writel(0x0, info->ppmu.base + PPMU_V2_CH_EV0_TYPE);
>>>> -	__raw_writel(0x0, info->ppmu.base + PPMU_V2_CH_EV1_TYPE);
>>>> -	__raw_writel(0x0, info->ppmu.base + PPMU_V2_CH_EV2_TYPE);
>>>> -	__raw_writel(0x0, info->ppmu.base + PPMU_V2_CH_EV3_TYPE);
>>>> -	__raw_writel(0x0, info->ppmu.base + PPMU_V2_SM_ID_V);
>>>> -	__raw_writel(0x0, info->ppmu.base + PPMU_V2_SM_ID_A);
>>>> -	__raw_writel(0x0, info->ppmu.base + PPMU_V2_SM_OTHERS_V);
>>>> -	__raw_writel(0x0, info->ppmu.base + PPMU_V2_SM_OTHERS_A);
>>>> -	__raw_writel(0x0, info->ppmu.base + PPMU_V2_INTERRUPT_RESET);
>>>> +	ret = regmap_write(info->regmap, PPMU_V2_CNTENC, clear);
>>>> +	if (ret < 0)
>>>> +		return ret;
>>>> +
>>>> +	ret = regmap_write(info->regmap, PPMU_V2_CNT_RESET, clear);
>>>> +	if (ret < 0)
>>>> +		return ret;
>>>> +
>>>> +	ret = regmap_write(info->regmap, PPMU_V2_CIG_CFG0, 0x0);
>>>> +	if (ret < 0)
>>>> +		return ret;
>>>> +
>>>> +	ret = regmap_write(info->regmap, PPMU_V2_CIG_CFG1, 0x0);
>>>> +	if (ret < 0)
>>>> +		return ret;
>>>> +
>>>> +	ret = regmap_write(info->regmap, PPMU_V2_CIG_CFG2, 0x0);
>>>> +	if (ret < 0)
>>>> +		return ret;
>>>> +
>>>> +	ret = regmap_write(info->regmap, PPMU_V2_CIG_RESULT, 0x0);
>>>> +	if (ret < 0)
>>>> +		return ret;
>>>> +
>>>> +	ret = regmap_write(info->regmap, PPMU_V2_CNT_AUTO, 0x0);
>>>> +	if (ret < 0)
>>>> +		return ret;
>>>> +
>>>> +	ret = regmap_write(info->regmap, PPMU_V2_CH_EV0_TYPE, 0x0);
>>>> +	if (ret < 0)
>>>> +		return ret;
>>>> +
>>>> +	ret = regmap_write(info->regmap, PPMU_V2_CH_EV1_TYPE, 0x0);
>>>> +	if (ret < 0)
>>>> +		return ret;
>>>> +
>>>> +	ret = regmap_write(info->regmap, PPMU_V2_CH_EV2_TYPE, 0x0);
>>>> +	if (ret < 0)
>>>> +		return ret;
>>>> +
>>>> +	ret = regmap_write(info->regmap, PPMU_V2_CH_EV3_TYPE, 0x0);
>>>> +	if (ret < 0)
>>>> +		return ret;
>>>> +
>>>> +	ret = regmap_write(info->regmap, PPMU_V2_SM_ID_V, 0x0);
>>>> +	if (ret < 0)
>>>> +		return ret;
>>>> +
>>>> +	ret = regmap_write(info->regmap, PPMU_V2_SM_ID_A, 0x0);
>>>> +	if (ret < 0)
>>>> +		return ret;
>>>> +
>>>> +	ret = regmap_write(info->regmap, PPMU_V2_SM_OTHERS_V, 0x0);
>>>> +	if (ret < 0)
>>>> +		return ret;
>>>> +
>>>> +	ret = regmap_write(info->regmap, PPMU_V2_SM_OTHERS_A, 0x0);
>>>> +	if (ret < 0)
>>>> +		return ret;
>>>> +
>>>> +	ret = regmap_write(info->regmap, PPMU_V2_INTERRUPT_RESET, 0x0);
>>>> +	if (ret < 0)
>>>> +		return ret;
>>>>  
>>>>  	/* Disable PPMU */
>>>> -	pmnc = __raw_readl(info->ppmu.base + PPMU_V2_PMNC);
>>>> +	ret = regmap_read(info->regmap, PPMU_V2_PMNC, &pmnc);
>>>> +	if (ret < 0)
>>>> +		return ret;
>>>> +
>>>>  	pmnc &= ~PPMU_PMNC_ENABLE_MASK;
>>>> -	__raw_writel(pmnc, info->ppmu.base + PPMU_V2_PMNC);
>>>> +	ret = regmap_write(info->regmap, PPMU_V2_PMNC, pmnc);
>>>> +	if (ret < 0)
>>>> +		return ret;
>>>>  
>>>>  	return 0;
>>>>  }
>>>> @@ -251,30 +354,43 @@ static int exynos_ppmu_v2_disable(struct devfreq_event_dev *edev)
>>>>  static int exynos_ppmu_v2_set_event(struct devfreq_event_dev *edev)
>>>>  {
>>>>  	struct exynos_ppmu *info = devfreq_event_get_drvdata(edev);
>>>> +	unsigned int pmnc, cntens;
>>>>  	int id = exynos_ppmu_find_ppmu_id(edev);
>>>> -	u32 pmnc, cntens;
>>>> +	int ret;
>>>>  
>>>>  	/* Enable all counters */
>>>> -	cntens = __raw_readl(info->ppmu.base + PPMU_V2_CNTENS);
>>>> +	ret = regmap_read(info->regmap, PPMU_V2_CNTENS, &cntens);
>>>> +	if (ret < 0)
>>>> +		return ret;
>>>> +
>>>>  	cntens |= (PPMU_CCNT_MASK | (PPMU_ENABLE << id));
>>>> -	__raw_writel(cntens, info->ppmu.base + PPMU_V2_CNTENS);
>>>> +	ret = regmap_write(info->regmap, PPMU_V2_CNTENS, cntens);
>>>> +	if (ret < 0)
>>>> +		return ret;
>>>>  
>>>>  	/* Set the event of Read/Write data count  */
>>>>  	switch (id) {
>>>>  	case PPMU_PMNCNT0:
>>>>  	case PPMU_PMNCNT1:
>>>>  	case PPMU_PMNCNT2:
>>>> -		__raw_writel(PPMU_V2_RO_DATA_CNT | PPMU_V2_WO_DATA_CNT,
>>>> -				info->ppmu.base + PPMU_V2_CH_EVx_TYPE(id));
>>>> +		ret = regmap_write(info->regmap, PPMU_V2_CH_EVx_TYPE(id),
>>>> +				PPMU_V2_RO_DATA_CNT | PPMU_V2_WO_DATA_CNT);
>>>> +		if (ret < 0)
>>>> +			return ret;
>>>>  		break;
>>>>  	case PPMU_PMNCNT3:
>>>> -		__raw_writel(PPMU_V2_EVT3_RW_DATA_CNT,
>>>> -				info->ppmu.base + PPMU_V2_CH_EVx_TYPE(id));
>>>> +		ret = regmap_write(info->regmap, PPMU_V2_CH_EVx_TYPE(id),
>>>> +				PPMU_V2_EVT3_RW_DATA_CNT);
>>>> +		if (ret < 0)
>>>> +			return ret;
>>>>  		break;
>>>>  	}
>>>>  
>>>>  	/* Reset cycle counter/performance counter and enable PPMU */
>>>> -	pmnc = __raw_readl(info->ppmu.base + PPMU_V2_PMNC);
>>>> +	ret = regmap_read(info->regmap, PPMU_V2_PMNC, &pmnc);
>>>> +	if (ret < 0)
>>>> +		return ret;
>>>> +
>>>>  	pmnc &= ~(PPMU_PMNC_ENABLE_MASK
>>>>  			| PPMU_PMNC_COUNTER_RESET_MASK
>>>>  			| PPMU_PMNC_CC_RESET_MASK
>>>> @@ -284,7 +400,10 @@ static int exynos_ppmu_v2_set_event(struct devfreq_event_dev *edev)
>>>>  	pmnc |= (PPMU_ENABLE << PPMU_PMNC_COUNTER_RESET_SHIFT);
>>>>  	pmnc |= (PPMU_ENABLE << PPMU_PMNC_CC_RESET_SHIFT);
>>>>  	pmnc |= (PPMU_V2_MODE_MANUAL << PPMU_V2_PMNC_START_MODE_SHIFT);
>>>> -	__raw_writel(pmnc, info->ppmu.base + PPMU_V2_PMNC);
>>>> +
>>>> +	ret = regmap_write(info->regmap, PPMU_V2_PMNC, pmnc);
>>>> +	if (ret < 0)
>>>> +		return ret;
>>>>  
>>>>  	return 0;
>>>>  }
>>>> @@ -294,37 +413,61 @@ static int exynos_ppmu_v2_get_event(struct devfreq_event_dev *edev,
>>>>  {
>>>>  	struct exynos_ppmu *info = devfreq_event_get_drvdata(edev);
>>>>  	int id = exynos_ppmu_find_ppmu_id(edev);
>>>> -	u32 pmnc, cntenc;
>>>> -	u32 pmcnt_high, pmcnt_low;
>>>> -	u64 load_count = 0;
>>>> +	int ret;
>>>> +	unsigned int pmnc, cntenc;
>>>> +	unsigned int pmcnt_high, pmcnt_low;
>>>> +	unsigned int total_count, count;
>>>> +	unsigned long load_count = 0;
>>>>  
>>>>  	/* Disable PPMU */
>>>> -	pmnc = __raw_readl(info->ppmu.base + PPMU_V2_PMNC);
>>>> +	ret = regmap_read(info->regmap, PPMU_V2_PMNC, &pmnc);
>>>> +	if (ret < 0)
>>>> +		return ret;
>>>> +
>>>>  	pmnc &= ~PPMU_PMNC_ENABLE_MASK;
>>>> -	__raw_writel(pmnc, info->ppmu.base + PPMU_V2_PMNC);
>>>> +	ret = regmap_write(info->regmap, PPMU_V2_PMNC, pmnc);
>>>> +	if (ret < 0)
>>>> +		return ret;
>>>>  
>>>>  	/* Read cycle count and performance count */
>>>> -	edata->total_count = __raw_readl(info->ppmu.base + PPMU_V2_CCNT);
>>>> +	ret = regmap_read(info->regmap, PPMU_V2_CCNT, &total_count);
>>>> +	if (ret < 0)
>>>> +		return ret;
>>>> +	edata->total_count = total_count;
>>>>  
>>>>  	switch (id) {
>>>>  	case PPMU_PMNCNT0:
>>>>  	case PPMU_PMNCNT1:
>>>>  	case PPMU_PMNCNT2:
>>>> -		load_count = __raw_readl(info->ppmu.base + PPMU_V2_PMNCT(id));
>>>> +		ret = regmap_read(info->regmap, PPMU_V2_PMNCT(id), &count);
>>>> +		if (ret < 0)
>>>> +			return ret;
>>>> +		load_count = count;
>>>>  		break;
>>>>  	case PPMU_PMNCNT3:
>>>> -		pmcnt_high = __raw_readl(info->ppmu.base + PPMU_V2_PMCNT3_HIGH);
>>>> -		pmcnt_low = __raw_readl(info->ppmu.base + PPMU_V2_PMCNT3_LOW);
>>>> -		load_count = ((u64)((pmcnt_high & 0xff)) << 32)
>>>> -			   + (u64)pmcnt_low;
>>>> +		ret = regmap_read(info->regmap, PPMU_V2_PMCNT3_HIGH,
>>>> +						&pmcnt_high);
>>>> +		if (ret < 0)
>>>> +			return ret;
>>>> +
>>>> +		ret = regmap_read(info->regmap, PPMU_V2_PMCNT3_LOW, &pmcnt_low);
>>>> +		if (ret < 0)
>>>> +			return ret;
>>>> +
>>>> +		load_count = ((u64)((pmcnt_high & 0xff)) << 32)+ (u64)pmcnt_low;
>>>>  		break;
>>>>  	}
>>>>  	edata->load_count = load_count;
>>>>  
>>>>  	/* Disable all counters */
>>>> -	cntenc = __raw_readl(info->ppmu.base + PPMU_V2_CNTENC);
>>>> +	ret = regmap_read(info->regmap, PPMU_V2_CNTENC, &cntenc);
>>>> +	if (ret < 0)
>>>> +		return 0;
>>>> +
>>>>  	cntenc |= (PPMU_CCNT_MASK | (PPMU_ENABLE << id));
>>>> -	__raw_writel(cntenc, info->ppmu.base + PPMU_V2_CNTENC);
>>>> +	ret = regmap_write(info->regmap, PPMU_V2_CNTENC, cntenc);
>>>> +	if (ret < 0)
>>>> +		return ret;
>>>>  
>>>>  	dev_dbg(&edev->dev, "%25s (load: %ld / %ld)\n", edev->desc->name,
>>>>  					edata->load_count, edata->total_count);
>>>> @@ -411,10 +554,19 @@ static int of_get_devfreq_events(struct device_node *np,
>>>>  	return 0;
>>>>  }
>>>>  
>>>> -static int exynos_ppmu_parse_dt(struct exynos_ppmu *info)
>>>> +static struct regmap_config exynos_ppmu_regmap_config = {
>>>> +	.reg_bits = 32,
>>>> +	.val_bits = 32,
>>>> +	.reg_stride = 4,
>>>> +};
>>>> +
>>>> +static int exynos_ppmu_parse_dt(struct platform_device *pdev,
>>>> +				struct exynos_ppmu *info)
>>>>  {
>>>>  	struct device *dev = info->dev;
>>>>  	struct device_node *np = dev->of_node;
>>>> +	struct resource *res;
>>>> +	void __iomem *base;
>>>>  	int ret = 0;
>>>>  
>>>>  	if (!np) {
>>>> @@ -423,10 +575,17 @@ static int exynos_ppmu_parse_dt(struct exynos_ppmu *info)
>>>>  	}
>>>>  
>>>>  	/* Maps the memory mapped IO to control PPMU register */
>>>> -	info->ppmu.base = of_iomap(np, 0);
>>>> -	if (IS_ERR_OR_NULL(info->ppmu.base)) {
>>>> -		dev_err(dev, "failed to map memory region\n");
>>>> -		return -ENOMEM;
>>>> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>>>> +	base = devm_ioremap_resource(dev, res);
>>>> +	if (IS_ERR(base))
>>>> +		return PTR_ERR(base);
>>>> +
>>>> +	exynos_ppmu_regmap_config.max_register = resource_size(res) - 4;
>>>> +	info->regmap = devm_regmap_init_mmio(dev, base,
>>>> +					&exynos_ppmu_regmap_config);
>>>> +	if (IS_ERR(info->regmap)) {
>>>> +		dev_err(dev, "failed to initialize regmap\n");
>>>> +		return PTR_ERR(info->regmap);
>>>>  	}
>>>>  
>>>>  	info->ppmu.clk = devm_clk_get(dev, "ppmu");
>>>> @@ -438,15 +597,10 @@ static int exynos_ppmu_parse_dt(struct exynos_ppmu *info)
>>>>  	ret = of_get_devfreq_events(np, info);
>>>>  	if (ret < 0) {
>>>>  		dev_err(dev, "failed to parse exynos ppmu dt node\n");
>>>> -		goto err;
>>>> +		return ret;
>>>>  	}
>>>>  
>>>>  	return 0;
>>>> -
>>>> -err:
>>>> -	iounmap(info->ppmu.base);
>>>> -
>>>> -	return ret;
>>>>  }
>>>>  
>>>>  static int exynos_ppmu_probe(struct platform_device *pdev)
>>>> @@ -463,7 +617,7 @@ static int exynos_ppmu_probe(struct platform_device *pdev)
>>>>  	info->dev = &pdev->dev;
>>>>  
>>>>  	/* Parse dt data to get resource */
>>>> -	ret = exynos_ppmu_parse_dt(info);
>>>> +	ret = exynos_ppmu_parse_dt(pdev, info);
>>>>  	if (ret < 0) {
>>>>  		dev_err(&pdev->dev,
>>>>  			"failed to parse devicetree for resource\n");
>>>> @@ -476,8 +630,7 @@ static int exynos_ppmu_probe(struct platform_device *pdev)
>>>>  	if (!info->edev) {
>>>>  		dev_err(&pdev->dev,
>>>>  			"failed to allocate memory devfreq-event devices\n");
>>>> -		ret = -ENOMEM;
>>>> -		goto err;
>>>> +		return -ENOMEM;
>>>>  	}
>>>>  	edev = info->edev;
>>>>  	platform_set_drvdata(pdev, info);
>>>> @@ -488,17 +641,13 @@ static int exynos_ppmu_probe(struct platform_device *pdev)
>>>>  			ret = PTR_ERR(edev[i]);
>>>>  			dev_err(&pdev->dev,
>>>>  				"failed to add devfreq-event device\n");
>>>> -			goto err;
>>>> +			return PTR_ERR(edev[i]);
>>>>  		}
>>>>  	}
>>>>  
>>>>  	clk_prepare_enable(info->ppmu.clk);
>>>>  
>>>>  	return 0;
>>>> -err:
>>>> -	iounmap(info->ppmu.base);
>>>> -
>>>> -	return ret;
>>>>  }
>>>>  
>>>>  static int exynos_ppmu_remove(struct platform_device *pdev)
>>>> @@ -506,7 +655,6 @@ static int exynos_ppmu_remove(struct platform_device *pdev)
>>>>  	struct exynos_ppmu *info = platform_get_drvdata(pdev);
>>>>  
>>>>  	clk_disable_unprepare(info->ppmu.clk);
>>>> -	iounmap(info->ppmu.base);
>>>>  
>>>>  	return 0;
>>>>  }
>>>>
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>>
>>>
>>
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
> 


-- 
Regards,
Chanwoo Choi
