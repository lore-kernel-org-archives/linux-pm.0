From: sathyanarayanan kuppuswamy
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: Re: [PATCH v1 6/7] mfd: intel_soc_pmic_bxtwc: use chained irqs for
 second level irq chips
Date: Thu, 13 Apr 2017 14:45:29 -0700
Message-ID: <269a4e06-1030-1a19-6722-22be513d6918@linux.intel.com>
References: <b8e952de94ed1902b922224de11f0814371b08b0.1491848776.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <7a0d428dbf05596a5e553ed0f06567b64c77c9c8.1491848776.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <20170412115354.jkyzy26kv7pobtn2@dell>
Reply-To: sathyanarayanan.kuppuswamy@linux.intel.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:65345 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751778AbdDMVsz (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 13 Apr 2017 17:48:55 -0400
In-Reply-To: <20170412115354.jkyzy26kv7pobtn2@dell>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>, tglx@linutronix.de
Cc: gnurou@gmail.com, linus.walleij@linaro.org, edubezval@gmail.com, dvhart@infradead.org, rui.zhang@intel.com, andy@infradead.org, hdegoede@redhat.com, linux-gpio@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, sathyaosid@gmail.com



On 04/12/2017 04:53 AM, Lee Jones wrote:
> On Mon, 10 Apr 2017, sathyanarayanan.kuppuswamy@linux.intel.com wrote:
>
>> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>>
>> Whishkey cove PMIC has support to mask/unmask interrupts at two levels.
>> At first level we can mask/unmask interrupt domains like TMU, GPIO, ADC,
>> CHGR, BCU THERMAL and PWRBTN and at second level, it provides facility
>> to mask/unmask individual interrupts belong each of this domain. For
>> example, in case of TMU, at first level we have TMU interrupt domain,
>> and at second level we have two interrupts, wake alarm, system alarm that
>> belong to the TMU interrupt domain.
>>
>> Currently, in this driver all first level irqs are registered as part of
>> irq chip(bxtwc_regmap_irq_chip). By default, after you register the irq
>> chip from your driver, all irqs in that chip will masked and can only be
>> enabled if that irq is requested using request_irq call. This is the
>> default Linux irq behavior model. And whenever a dependent device that
>> belongs to PMIC requests only the second level irq and not explicitly
>> unmask the first level irq, then in essence the second level irq will
>> still be disabled. For example, if TMU device driver request wake_alarm
>> irq and not explicitly unmask TMU level 1 irq then according to the default
>> Linux irq model,  wake_alarm irq will still be disabled. So the proper
>> solution to fix this issue is to use the chained irq chip concept. We
>> should chain all the second level chip irqs to the corresponding first
>> level irq. To do this, we need to create separate irq chips for every
>> group of second level irqs.
>>
>> In case of TMU, when adding second level irq chip, instead of using pmic
>> irq we should use the corresponding first level irq. So the following
>> code will change from
>>
>> ret = regmap_add_irq_chip(pmic->regmap, pmic->irq, ...)
>>
>> to,
>>
>> virq = regmap_irq_get_virq(&pmic->irq_chip_data, BXTWC_TMU_LVL1_IRQ);
>>
>> ret = regmap_add_irq_chip(pmic->regmap, virq, ...)
>>
>> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>> ---
>>   drivers/mfd/intel_soc_pmic_bxtwc.c | 212 ++++++++++++++++++++++++++++++-------
>>   include/linux/mfd/intel_soc_pmic.h |   5 +
>>   2 files changed, 176 insertions(+), 41 deletions(-)
>>
>> diff --git a/drivers/mfd/intel_soc_pmic_bxtwc.c b/drivers/mfd/intel_soc_pmic_bxtwc.c
>> index dc8af1d..807eba3 100644
>> --- a/drivers/mfd/intel_soc_pmic_bxtwc.c
>> +++ b/drivers/mfd/intel_soc_pmic_bxtwc.c
>> @@ -81,18 +81,26 @@ enum bxtwc_irqs {
>>   	BXTWC_PWRBTN_IRQ,
>>   };
>>   
>> -enum bxtwc_irqs_level2 {
>> -	/* Level 2 */
>> +enum bxtwc_irqs_tmu {
>> +	BXTWC_TMU_IRQ = 0,
>> +};
>> +
>> +enum bxtwc_irqs_bcu {
>>   	BXTWC_BCU_IRQ = 0,
>> -	BXTWC_ADC_IRQ,
>> -	BXTWC_USBC_IRQ,
>> +};
>> +
>> +enum bxtwc_irqs_adc {
>> +	BXTWC_ADC_IRQ = 0,
>> +};
>> +
>> +enum bxtwc_irqs_chgr {
>> +	BXTWC_USBC_IRQ = 0,
>>   	BXTWC_CHGR0_IRQ,
>>   	BXTWC_CHGR1_IRQ,
>> -	BXTWC_CRIT_IRQ,
>>   };
>>   
>> -enum bxtwc_irqs_tmu {
>> -	BXTWC_TMU_IRQ = 0,
>> +enum bxtwc_irqs_crit {
>> +	BXTWC_CRIT_IRQ = 0,
>>   };
>>   
>>   static const struct regmap_irq bxtwc_regmap_irqs[] = {
>> @@ -107,17 +115,26 @@ static const struct regmap_irq bxtwc_regmap_irqs[] = {
>>   	REGMAP_IRQ_REG(BXTWC_PWRBTN_IRQ, 1, 0x03),
>>   };
>>   
>> -static const struct regmap_irq bxtwc_regmap_irqs_level2[] = {
>> +static const struct regmap_irq bxtwc_regmap_irqs_tmu[] = {
>> +	REGMAP_IRQ_REG(BXTWC_TMU_IRQ, 0, 0x06),
>> +};
>> +
>> +static const struct regmap_irq bxtwc_regmap_irqs_bcu[] = {
>>   	REGMAP_IRQ_REG(BXTWC_BCU_IRQ, 0, 0x1f),
>> -	REGMAP_IRQ_REG(BXTWC_ADC_IRQ, 1, 0xff),
>> -	REGMAP_IRQ_REG(BXTWC_USBC_IRQ, 2, BIT(5)),
>> -	REGMAP_IRQ_REG(BXTWC_CHGR0_IRQ, 2, 0x1f),
>> -	REGMAP_IRQ_REG(BXTWC_CHGR1_IRQ, 3, 0x1f),
>> -	REGMAP_IRQ_REG(BXTWC_CRIT_IRQ, 6, 0x03),
>>   };
>>   
>> -static const struct regmap_irq bxtwc_regmap_irqs_tmu[] = {
>> -	REGMAP_IRQ_REG(BXTWC_TMU_IRQ, 0, 0x06),
>> +static const struct regmap_irq bxtwc_regmap_irqs_adc[] = {
>> +	REGMAP_IRQ_REG(BXTWC_ADC_IRQ, 0, 0xff),
>> +};
>> +
>> +static const struct regmap_irq bxtwc_regmap_irqs_chgr[] = {
>> +	REGMAP_IRQ_REG(BXTWC_USBC_IRQ, 0, BIT(5)),
>> +	REGMAP_IRQ_REG(BXTWC_CHGR0_IRQ, 0, 0x1f),
>> +	REGMAP_IRQ_REG(BXTWC_CHGR1_IRQ, 1, 0x1f),
>> +};
>> +
>> +static const struct regmap_irq bxtwc_regmap_irqs_crit[] = {
>> +	REGMAP_IRQ_REG(BXTWC_CRIT_IRQ, 0, 0x03),
>>   };
>>   
>>   static struct regmap_irq_chip bxtwc_regmap_irq_chip = {
>> @@ -129,15 +146,6 @@ static struct regmap_irq_chip bxtwc_regmap_irq_chip = {
>>   	.num_regs = 2,
>>   };
>>   
>> -static struct regmap_irq_chip bxtwc_regmap_irq_chip_level2 = {
>> -	.name = "bxtwc_irq_chip_level2",
>> -	.status_base = BXTWC_BCUIRQ,
>> -	.mask_base = BXTWC_MBCUIRQ,
>> -	.irqs = bxtwc_regmap_irqs_level2,
>> -	.num_irqs = ARRAY_SIZE(bxtwc_regmap_irqs_level2),
>> -	.num_regs = 10,
>> -};
>> -
>>   static struct regmap_irq_chip bxtwc_regmap_irq_chip_tmu = {
>>   	.name = "bxtwc_irq_chip_tmu",
>>   	.status_base = BXTWC_TMUIRQ,
>> @@ -147,6 +155,42 @@ static struct regmap_irq_chip bxtwc_regmap_irq_chip_tmu = {
>>   	.num_regs = 1,
>>   };
>>   
>> +static struct regmap_irq_chip bxtwc_regmap_irq_chip_bcu = {
>> +	.name = "bxtwc_irq_chip_bcu",
>> +	.status_base = BXTWC_BCUIRQ,
>> +	.mask_base = BXTWC_MBCUIRQ,
>> +	.irqs = bxtwc_regmap_irqs_bcu,
>> +	.num_irqs = ARRAY_SIZE(bxtwc_regmap_irqs_bcu),
>> +	.num_regs = 1,
>> +};
>> +
>> +static struct regmap_irq_chip bxtwc_regmap_irq_chip_adc = {
>> +	.name = "bxtwc_irq_chip_adc",
>> +	.status_base = BXTWC_ADCIRQ,
>> +	.mask_base = BXTWC_MADCIRQ,
>> +	.irqs = bxtwc_regmap_irqs_adc,
>> +	.num_irqs = ARRAY_SIZE(bxtwc_regmap_irqs_adc),
>> +	.num_regs = 1,
>> +};
>> +
>> +static struct regmap_irq_chip bxtwc_regmap_irq_chip_chgr = {
>> +	.name = "bxtwc_irq_chip_chgr",
>> +	.status_base = BXTWC_CHGR0IRQ,
>> +	.mask_base = BXTWC_MCHGR0IRQ,
>> +	.irqs = bxtwc_regmap_irqs_chgr,
>> +	.num_irqs = ARRAY_SIZE(bxtwc_regmap_irqs_chgr),
>> +	.num_regs = 2,
>> +};
>> +
>> +static struct regmap_irq_chip bxtwc_regmap_irq_chip_crit = {
>> +	.name = "bxtwc_irq_chip_crit",
>> +	.status_base = BXTWC_CRITIRQ,
>> +	.mask_base = BXTWC_MCRITIRQ,
>> +	.irqs = bxtwc_regmap_irqs_crit,
>> +	.num_irqs = ARRAY_SIZE(bxtwc_regmap_irqs_crit),
>> +	.num_regs = 1,
>> +};
>> +
>>   static struct resource gpio_resources[] = {
>>   	DEFINE_RES_IRQ_NAMED(BXTWC_GPIO_LVL1_IRQ, "GPIO"),
>>   };
>> @@ -358,6 +402,34 @@ static const struct regmap_config bxtwc_regmap_config = {
>>   	.reg_read = regmap_ipc_byte_reg_read,
>>   };
>>   
>> +static int bxtwc_add_chained_irq_chip(struct intel_soc_pmic *pmic,
>> +				struct regmap_irq_chip_data *pdata,
>> +				int pirq,
>> +				int irq_flags,
> Nit: These do not need to be on separate lines.
Will fix it in next version.
>
>> +				const struct regmap_irq_chip *chip,
>> +				struct regmap_irq_chip_data **data,
>> +				int *irq)
>> +{
>> +	int ret;
>> +
>> +	ret = regmap_irq_get_virq(pdata, pirq);
>> +	if (ret < 0) {
>> +		dev_err(pmic->dev, "failed to get virtual interrupt=%d\n", ret);
> s/=/: /
Will fix it in next version.
>
>> +		return ret;
>> +	}
>> +
>> +	*irq = ret;
>> +
>> +	ret = regmap_add_irq_chip(pmic->regmap, *irq, irq_flags, 0,
>> +				  chip, data);
>> +	if (ret) {
>> +		dev_err(pmic->dev, "Failed to add %s irq chip\n", chip->name);
> s/irq/IRQ/
Will fix it in next version.
>
>> +		return -ENODEV;
> Why aren't you returning ret?
>
> In fact, remove this line and ...
>
>> +	}
>> +
>> +	return 0;
> ... return ret;
>
>> +}
>> +
>>   static int bxtwc_probe(struct platform_device *pdev)
>>   {
>>   	int ret;
>> @@ -409,22 +481,71 @@ static int bxtwc_probe(struct platform_device *pdev)
>>   		return ret;
>>   	}
>>   
>> -	ret = regmap_add_irq_chip(pmic->regmap, pmic->irq,
>> -				  IRQF_ONESHOT | IRQF_SHARED,
>> -				  0, &bxtwc_regmap_irq_chip_level2,
>> -				  &pmic->irq_chip_data_level2);
>> +	ret = bxtwc_add_chained_irq_chip(pmic, pmic->irq_chip_data,
>> +					 BXTWC_TMU_LVL1_IRQ,
>> +					 IRQF_ONESHOT,
>> +					 &bxtwc_regmap_irq_chip_tmu,
>> +					 &pmic->irq_chip_data_tmu,
>> +					 &pmic->tmu_irq);
> Isn't there a generic API for chained IRQs already?
I don't think we have regmap add IRQ chip API for nested IRQ chips. May 
be we can create one now ? I think we have something similar in gpio 
domain (gpiochip_irqchip_add_nested).
>
>>   	if (ret) {
>> -		dev_err(&pdev->dev, "Failed to add secondary IRQ chip\n");
>> -		goto err_irq_chip_level2;
>> +		dev_err(&pdev->dev, "Failed to add TMU IRQ chip\n");
>> +		goto err_irq_chip_tmu;
>>   	}
>>   
>> -	ret = regmap_add_irq_chip(pmic->regmap, pmic->irq,
>> -				  IRQF_ONESHOT | IRQF_SHARED,
>> -				  0, &bxtwc_regmap_irq_chip_tmu,
>> -				  &pmic->irq_chip_data_tmu);
>> +	/* add chained irq handler for BCU irqs */
> Use proper grammar.
>
> "Add chained IRQ handler for BCU IRQs"
will fix it next version.
>
>> +	ret = bxtwc_add_chained_irq_chip(pmic, pmic->irq_chip_data,
>> +					 BXTWC_BCU_LVL1_IRQ,
>> +					 IRQF_ONESHOT,
>> +					 &bxtwc_regmap_irq_chip_bcu,
>> +					 &pmic->irq_chip_data_bcu,
>> +					 &pmic->bcu_irq);
>> +
>> +
>>   	if (ret) {
>> -		dev_err(&pdev->dev, "Failed to add TMU IRQ chip\n");
>> -		goto err_irq_chip_tmu;
>> +		dev_err(&pdev->dev, "Failed to add BUC IRQ chip\n");
>> +		goto err_irq_chip_bcu;
>> +	}
>> +
>> +	/* add chained irq handler for ADC irqs */
> Grammar.
will fix it next version.
>
>> +	ret = bxtwc_add_chained_irq_chip(pmic, pmic->irq_chip_data,
>> +					 BXTWC_ADC_LVL1_IRQ,
>> +					 IRQF_ONESHOT,
>> +					 &bxtwc_regmap_irq_chip_adc,
>> +					 &pmic->irq_chip_data_adc,
>> +					 &pmic->adc_irq);
>> +
>> +
>> +	if (ret) {
>> +		dev_err(&pdev->dev, "Failed to add ADC IRQ chip\n");
>> +		goto err_irq_chip_adc;
>> +	}
>> +
>> +	/* add chained irq handler for CHGR irqs */
>> +	ret = bxtwc_add_chained_irq_chip(pmic, pmic->irq_chip_data,
>> +					 BXTWC_CHGR_LVL1_IRQ,
>> +					 IRQF_ONESHOT,
>> +					 &bxtwc_regmap_irq_chip_chgr,
>> +					 &pmic->irq_chip_data_chgr,
>> +					 &pmic->chgr_irq);
>> +
>> +
>> +	if (ret) {
>> +		dev_err(&pdev->dev, "Failed to add CHGR IRQ chip\n");
>> +		goto err_irq_chip_chgr;
>> +	}
>> +
>> +	/* add chained irq handler for CRIT irqs */
>> +	ret = bxtwc_add_chained_irq_chip(pmic, pmic->irq_chip_data,
>> +					 BXTWC_CRIT_LVL1_IRQ,
>> +					 IRQF_ONESHOT,
>> +					 &bxtwc_regmap_irq_chip_crit,
>> +					 &pmic->irq_chip_data_crit,
>> +					 &pmic->crit_irq);
>> +
>> +
>> +	if (ret) {
>> +		dev_err(&pdev->dev, "Failed to add CRIT irq chip\n");
> s/irq/IRQ/
will fix it next version.
>
>> +		goto err_irq_chip_crit;
>>   	}
>>   
>>   	ret = mfd_add_devices(&pdev->dev, PLATFORM_DEVID_NONE, bxt_wc_dev,
>> @@ -456,10 +577,16 @@ static int bxtwc_probe(struct platform_device *pdev)
>>   err_sysfs:
>>   	mfd_remove_devices(&pdev->dev);
>>   err_mfd:
>> -	regmap_del_irq_chip(pmic->irq, pmic->irq_chip_data_tmu);
>> +	regmap_del_irq_chip(pmic->crit_irq, pmic->irq_chip_data_crit);
>> +err_irq_chip_crit:
>> +	regmap_del_irq_chip(pmic->chgr_irq, pmic->irq_chip_data_chgr);
>> +err_irq_chip_chgr:
>> +	regmap_del_irq_chip(pmic->adc_irq, pmic->irq_chip_data_adc);
>> +err_irq_chip_adc:
>> +	regmap_del_irq_chip(pmic->bcu_irq, pmic->irq_chip_data_bcu);
>> +err_irq_chip_bcu:
>> +	regmap_del_irq_chip(pmic->tmu_irq, pmic->irq_chip_data_tmu);
>>   err_irq_chip_tmu:
>> -	regmap_del_irq_chip(pmic->irq, pmic->irq_chip_data_level2);
>> -err_irq_chip_level2:
>>   	regmap_del_irq_chip(pmic->irq, pmic->irq_chip_data);
>>   
>>   	return ret;
>> @@ -472,8 +599,11 @@ static int bxtwc_remove(struct platform_device *pdev)
>>   	sysfs_remove_group(&pdev->dev.kobj, &bxtwc_group);
>>   	mfd_remove_devices(&pdev->dev);
>>   	regmap_del_irq_chip(pmic->irq, pmic->irq_chip_data);
>> -	regmap_del_irq_chip(pmic->irq, pmic->irq_chip_data_level2);
>> -	regmap_del_irq_chip(pmic->irq, pmic->irq_chip_data_tmu);
>> +	regmap_del_irq_chip(pmic->tmu_irq, pmic->irq_chip_data_tmu);
>> +	regmap_del_irq_chip(pmic->bcu_irq, pmic->irq_chip_data_bcu);
>> +	regmap_del_irq_chip(pmic->adc_irq, pmic->irq_chip_data_adc);
>> +	regmap_del_irq_chip(pmic->chgr_irq, pmic->irq_chip_data_chgr);
>> +	regmap_del_irq_chip(pmic->crit_irq, pmic->irq_chip_data_crit);
>>   
>>   	return 0;
>>   }
>> diff --git a/include/linux/mfd/intel_soc_pmic.h b/include/linux/mfd/intel_soc_pmic.h
>> index 956caa0..63e1270 100644
>> --- a/include/linux/mfd/intel_soc_pmic.h
>> +++ b/include/linux/mfd/intel_soc_pmic.h
>> @@ -23,10 +23,15 @@
>>   
>>   struct intel_soc_pmic {
>>   	int irq;
>> +	int tmu_irq, bcu_irq, adc_irq, chgr_irq, crit_irq;
> Each attribute should be on a line of their own.
ok. will fix it next version.
>
>>   	struct regmap *regmap;
>>   	struct regmap_irq_chip_data *irq_chip_data;
>>   	struct regmap_irq_chip_data *irq_chip_data_level2;
>>   	struct regmap_irq_chip_data *irq_chip_data_tmu;
>> +	struct regmap_irq_chip_data *irq_chip_data_bcu;
>> +	struct regmap_irq_chip_data *irq_chip_data_adc;
>> +	struct regmap_irq_chip_data *irq_chip_data_chgr;
>> +	struct regmap_irq_chip_data *irq_chip_data_crit;
>>   	struct device *dev;
>>   };
>>   

-- 
Sathyanarayanan Kuppuswamy
Android kernel developer
