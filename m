From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH v2 1/6] mfd: max77843: Add max77843 MFD driver core driver
Date: Wed, 04 Feb 2015 08:57:08 +0900
Message-ID: <54D16054.6070806@samsung.com>
References: <1422939846-29955-1-git-send-email-jaewon02.kim@samsung.com>
 <1422939846-29955-2-git-send-email-jaewon02.kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:44651 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752223AbbBCX5M (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 3 Feb 2015 18:57:12 -0500
In-reply-to: <1422939846-29955-2-git-send-email-jaewon02.kim@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jaewon Kim <jaewon02.kim@samsung.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, Inki Dae <inki.dae@samsung.com>, SangBae Lee <sangbae90.lee@samsung.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>, Mark Brown <broonie@kernel.org>, Beomho Seo <beomho.seo@samsung.com>

Hi Jaewon and Beomho,

On 02/03/2015 02:04 PM, Jaewon Kim wrote:
> This patch adds MAX77843 core/irq driver to support PMIC,
> MUIC(Micro USB Interface Controller), Charger, Fuel Gauge,
> LED and Haptic device.
> 
> Cc: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Jaewon Kim <jaewon02.kim@samsung.com>
> Signed-off-by: Beomho Seo <beomho.seo@samsung.com>
> ---
>  drivers/mfd/Kconfig                  |   14 ++
>  drivers/mfd/Makefile                 |    1 +
>  drivers/mfd/max77843.c               |  247 ++++++++++++++++++++
>  include/linux/mfd/max77843-private.h |  422 ++++++++++++++++++++++++++++++++++
>  4 files changed, 684 insertions(+)
>  create mode 100644 drivers/mfd/max77843.c
>  create mode 100644 include/linux/mfd/max77843-private.h
> 
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 2e6b731..0c67c79 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -442,6 +442,20 @@ config MFD_MAX77693
>  	  additional drivers must be enabled in order to use the functionality
>  	  of the device.
>  

[snip]

> +
> +	ret = regmap_read(max77843->regmap,
> +			MAX77843_SYS_REG_PMICID, &reg_data);
> +	if (ret < 0) {
> +		dev_err(&i2c->dev, "Failed to read PMIC ID\n");
> +		goto err_pmic_id;
> +	}
> +	dev_info(&i2c->dev, "device ID: 0x%x\n", reg_data);
> +
> +	ret = max77843_chg_init(max77843);
> +	if (ret) {
> +		dev_err(&i2c->dev, "Failed to init Charger\n");
> +		goto err_pmic_id;
> +	}
> +
> +	reg = MAX77843_INTSRC_MASK_MASK;
> +	ret = regmap_update_bits(max77843->regmap,
> +			MAX77843_SYS_REG_INTSRCMASK,
> +			MAX77843_INTSRC_MASK_MASK,
> +			(unsigned int)~reg);

I think that you don't need to allocate MAX77843_INTSRC_MASK_MASK to 'reg' variable.
You can use MAX77843_INTSRC_MASK_MASK directly without any variable.

> +	if (ret < 0) {
> +		dev_err(&i2c->dev, "Failed to unmask interrupt source\n");
> +		goto err_pmic_id;
> +	}
> +
> +	ret = mfd_add_devices(max77843->dev, -1, max77843_devs,
> +			ARRAY_SIZE(max77843_devs), NULL, 0, NULL);
> +	if (ret < 0) {
> +		dev_err(&i2c->dev, "Failed to add mfd device\n");
> +		goto err_pmic_id;
> +	}
> +
> +	device_init_wakeup(max77843->dev, 1);
> +
> +	return 0;
> +
> +err_pmic_id:
> +	regmap_del_irq_chip(max77843->irq, max77843->irq_data);
> +
> +	return ret;
> +}

[snip]

> +MODULE_AUTHOR("Jaewon Kim <jaewon02.kim@samsung.com>");
> +MODULE_AUTHOR("Beomho Seo <beomho.seo@samsung.com>");
> +MODULE_DESCRIPTION("Maxim MAX77843 multi-function core driver");
> +MODULE_LICENSE("GPL");
> diff --git a/include/linux/mfd/max77843-private.h b/include/linux/mfd/max77843-private.h
> new file mode 100644
> index 0000000..0f4cfa4
> --- /dev/null
> +++ b/include/linux/mfd/max77843-private.h
> @@ -0,0 +1,422 @@
> +/*
> + * max77843-private.h - Common API for the Maxim MAX77843 internal sub chip

API?

> + *
> + * Copyright (C) 2014 Samsung Electrnoics

s/2014/2015

> + * Author: Jaewon Kim <jaewon02.kim@samsung.com>
> + * Author: Beomho Seo <beomho.seo@samsung.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + */
> +
> +#ifndef __MAX77843_PRIVATE_H_
> +#define __MAX77843_PRIVATE_H_
> +
> +#include <linux/i2c.h>
> +#include <linux/regmap.h>
> +
> +#define I2C_ADDR_TOPSYS	(0xCC >> 1)
> +#define I2C_ADDR_CHG	(0xD2 >> 1)
> +#define I2C_ADDR_FG	(0x6C >> 1)
> +#define I2C_ADDR_MUIC	(0x4A >> 1)
> +
> +/* Topsys, Haptic and LED registers */
> +enum max77843_sys_reg {
> +	MAX77843_SYS_REG_PMICID		= 0x00,
> +	MAX77843_SYS_REG_PMICREV	= 0x01,
> +	MAX77843_SYS_REG_MAINCTRL1	= 0x02,
> +	MAX77843_SYS_REG_INTSRC		= 0x22,
> +	MAX77843_SYS_REG_INTSRCMASK	= 0x23,
> +	MAX77843_SYS_REG_SYSINTSRC	= 0x24,
> +	MAX77843_SYS_REG_SYSINTMASK	= 0x26,
> +	MAX77843_SYS_REG_TOPSYS_STAT	= 0x28,
> +	MAX77843_SYS_REG_SAFEOUTCTRL	= 0xC6,
> +
> +	MAX77843_SYS_REG_END,
> +};
> +
> +enum max77843_haptic_reg {
> +	MAX77843_HAP_REG_MCONFIG	= 0x10,
> +
> +	MAX77843_HAP_REG_END,
> +};
> +
> +enum max77843_led_reg {
> +	MAX77843_LED_REG_LEDEN		= 0x30,
> +	MAX77843_LED_REG_LED0BRT	= 0x31,
> +	MAX77843_LED_REG_LED1BRT	= 0x32,
> +	MAX77843_LED_REG_LED2BRT	= 0x33,
> +	MAX77843_LED_REG_LED3BRT	= 0x34,
> +	MAX77843_LED_REG_LEDBLNK	= 0x38,
> +	MAX77843_LED_REG_LEDRAMP	= 0x36,
> +
> +	MAX77843_LED_REG_END,
> +};
> +
> +/* Charger registers */
> +enum max77843_charger_reg {
> +	MAX77843_CHG_REG_CHG_INT	= 0xB0,
> +	MAX77843_CHG_REG_CHG_INT_MASK	= 0xB1,
> +	MAX77843_CHG_REG_CHG_INT_OK	= 0xB2,
> +	MAX77843_CHG_REG_CHG_DTLS_00	= 0xB3,
> +	MAX77843_CHG_REG_CHG_DTLS_01	= 0xB4,
> +	MAX77843_CHG_REG_CHG_DTLS_02	= 0xB5,
> +	MAX77843_CHG_REG_CHG_CNFG_00	= 0xB7,
> +	MAX77843_CHG_REG_CHG_CNFG_01	= 0xB8,
> +	MAX77843_CHG_REG_CHG_CNFG_02	= 0xB9,
> +	MAX77843_CHG_REG_CHG_CNFG_03	= 0xBA,
> +	MAX77843_CHG_REG_CHG_CNFG_04	= 0xBB,
> +	MAX77843_CHG_REG_CHG_CNFG_06	= 0xBD,
> +	MAX77843_CHG_REG_CHG_CNFG_07	= 0xBE,
> +	MAX77843_CHG_REG_CHG_CNFG_09	= 0xC0,
> +	MAX77843_CHG_REG_CHG_CNFG_10	= 0xC1,
> +	MAX77843_CHG_REG_CHG_CNFG_11	= 0xC2,
> +	MAX77843_CHG_REG_CHG_CNFG_12	= 0xC3,
> +
> +	MAX77843_CHG_REG_END,
> +};
> +
> +/* Fuel gauge registers */
> +enum max77843_fuelgauge {
> +	MAX77843_FG_REG_STATUS		= 0x00,
> +	MAX77843_FG_REG_VALRT_TH	= 0x01,
> +	MAX77843_FG_REG_TALRT_TH	= 0x02,
> +	MAX77843_FG_REG_SALRT_TH	= 0x03,
> +	MAX77843_FG_RATE_AT_RATE	= 0x04,
> +	MAX77843_FG_REG_REMCAP_REP	= 0x05,
> +	MAX77843_FG_REG_SOCREP		= 0x06,
> +	MAX77843_FG_REG_AGE		= 0x07,
> +	MAX77843_FG_REG_TEMP		= 0x08,
> +	MAX77843_FG_REG_VCELL		= 0x09,
> +	MAX77843_FG_REG_CURRENT		= 0x0A,
> +	MAX77843_FG_REG_AVG_CURRENT	= 0x0B,
> +	MAX77843_FG_REG_SOCMIX		= 0x0D,
> +	MAX77843_FG_REG_SOCAV		= 0x0E,
> +	MAX77843_FG_REG_REMCAP_MIX	= 0x0F,
> +	MAX77843_FG_REG_FULLCAP		= 0x10,
> +	MAX77843_FG_REG_AVG_TEMP	= 0x16,
> +	MAX77843_FG_REG_CYCLES		= 0x17,
> +	MAX77843_FG_REG_AVG_VCELL	= 0x19,
> +	MAX77843_FG_REG_CONFIG		= 0x1D,
> +	MAX77843_FG_REG_REMCAP_AV	= 0x1F,
> +	MAX77843_FG_REG_FULLCAP_NOM	= 0x23,
> +	MAX77843_FG_REG_MISCCFG		= 0x2B,
> +	MAX77843_FG_REG_RCOMP		= 0x38,
> +	MAX77843_FG_REG_FSTAT		= 0x3D,
> +	MAX77843_FG_REG_DQACC		= 0x45,
> +	MAX77843_FG_REG_DPACC		= 0x46,
> +	MAX77843_FG_REG_OCV		= 0xEE,
> +	MAX77843_FG_REG_VFOCV		= 0xFB,
> +	MAX77843_FG_SOCVF		= 0xFF,
> +
> +	MAX77843_FG_END,
> +};
> +
> +/* Muic registers */

Use capital letter (s/Muic/MUIC)

> +enum max77843_muic_reg {
> +	MAX77843_MUIC_REG_ID		= 0x00,
> +	MAX77843_MUIC_REG_INT1		= 0x01,
> +	MAX77843_MUIC_REG_INT2		= 0x02,
> +	MAX77843_MUIC_REG_INT3		= 0x03,
> +	MAX77843_MUIC_REG_STATUS1	= 0x04,
> +	MAX77843_MUIC_REG_STATUS2	= 0x05,
> +	MAX77843_MUIC_REG_STATUS3	= 0x06,
> +	MAX77843_MUIC_REG_INTMASK1	= 0x07,
> +	MAX77843_MUIC_REG_INTMASK2	= 0x08,
> +	MAX77843_MUIC_REG_INTMASK3	= 0x09,
> +	MAX77843_MUIC_REG_CDETCTRL1	= 0x0A,
> +	MAX77843_MUIC_REG_CDETCTRL2	= 0x0B,
> +	MAX77843_MUIC_REG_CONTROL1	= 0x0C,
> +	MAX77843_MUIC_REG_CONTROL2	= 0x0D,
> +	MAX77843_MUIC_REG_CONTROL3	= 0x0E,
> +	MAX77843_MUIC_REG_CONTROL4	= 0x16,
> +	MAX77843_MUIC_REG_HVCONTROL1	= 0x17,
> +	MAX77843_MUIC_REG_HVCONTROL2	= 0x18,
> +
> +	MAX77843_MUIC_REG_END,
> +};
> +
> +enum max77843_irq {
> +	/* Topsys: SYSTEM */
> +	MAX77843_SYS_IRQ_SYSINTSRC_SYSUVLO_INT,
> +	MAX77843_SYS_IRQ_SYSINTSRC_SYSOVLO_INT,
> +	MAX77843_SYS_IRQ_SYSINTSRC_TSHDN_INT,
> +	MAX77843_SYS_IRQ_SYSINTSRC_TM_INT,
> +
> +	/* Charger: CHG_INT */
> +	MAX77843_CHG_IRQ_CHG_INT_BYP_I,
> +	MAX77843_CHG_IRQ_CHG_INT_BATP_I,
> +	MAX77843_CHG_IRQ_CHG_INT_BAT_I,
> +	MAX77843_CHG_IRQ_CHG_INT_CHG_I,
> +	MAX77843_CHG_IRQ_CHG_INT_WCIN_I,
> +	MAX77843_CHG_IRQ_CHG_INT_CHGIN_I,
> +	MAX77843_CHG_IRQ_CHG_INT_AICL_I,
> +
> +	MAX77843_IRQ_NUM,
> +};
> +
> +enum max77843_irq_muic {
> +	/* MUIC: INT1 */
> +	MAX77843_MUIC_IRQ_INT1_ADC,
> +	MAX77843_MUIC_IRQ_INT1_ADCERROR,
> +	MAX77843_MUIC_IRQ_INT1_ADC1K,
> +
> +	/* MUIC: INT2 */
> +	MAX77843_MUIC_IRQ_INT2_CHGTYP,
> +	MAX77843_MUIC_IRQ_INT2_CHGDETRUN,
> +	MAX77843_MUIC_IRQ_INT2_DCDTMR,
> +	MAX77843_MUIC_IRQ_INT2_DXOVP,
> +	MAX77843_MUIC_IRQ_INT2_VBVOLT,
> +
> +	/* MUIC: INT3 */
> +	MAX77843_MUIC_IRQ_INT3_VBADC,
> +	MAX77843_MUIC_IRQ_INT3_VDNMON,
> +	MAX77843_MUIC_IRQ_INT3_DNRES,
> +	MAX77843_MUIC_IRQ_INT3_MPNACK,
> +	MAX77843_MUIC_IRQ_INT3_MRXBUFOW,
> +	MAX77843_MUIC_IRQ_INT3_MRXTRF,
> +	MAX77843_MUIC_IRQ_INT3_MRXPERR,
> +	MAX77843_MUIC_IRQ_INT3_MRXRDY,
> +
> +	MAX77843_MUIC_IRQ_NUM,
> +};
> +
> +/* MAX77843 interrupts */
> +#define MAX77843_SYS_IRQ_SYSUVLO_INT		BIT(0)
> +#define MAX77843_SYS_IRQ_SYSOVLO_INT		BIT(1)
> +#define MAX77843_SYS_IRQ_TSHDN_INT		BIT(2)
> +#define MAX77843_SYS_IRQ_TM_INT			BIT(3)
> +
> +/* Max77843 charger insterrupts */
> +#define MAX77843_CHG_BYP_I			BIT(0)
> +#define MAX77843_CHG_BATP_I			BIT(2)
> +#define MAX77843_CHG_BAT_I			BIT(3)
> +#define MAX77843_CHG_CHG_I			BIT(4)
> +#define MAX77843_CHG_WCIN_I			BIT(5)
> +#define MAX77843_CHG_CHGIN_I			BIT(6)
> +#define MAX77843_CHG_AICL_I			BIT(7)
> +
> +/* MAX77843 CHG_INT_OK register */
> +#define MAX77843_CHG_BYP_OK			BIT(0)
> +#define MAX77843_CHG_BATP_OK			BIT(2)
> +#define MAX77843_CHG_BAT_OK			BIT(3)
> +#define MAX77843_CHG_CHG_OK			BIT(4)
> +#define MAX77843_CHG_WCIN_OK			BIT(5)
> +#define MAX77843_CHG_CHGIN_OK			BIT(6)
> +#define MAX77843_CHG_AICL_OK			BIT(7)
> +
> +/* MAX77843 CHG_DETAILS_00 register */
> +#define MAX77843_CHG_BAT_DTLS			BIT(0)
> +
> +/* MAX77843 CHG_DETAILS_01 register */
> +#define MAX77843_CHG_DTLS_MASK			0x0f
> +#define MAX77843_CHG_PQ_MODE			0x00
> +#define MAX77843_CHG_CC_MODE			0x01
> +#define MAX77843_CHG_CV_MODE			0x02
> +#define MAX77843_CHG_TO_MODE			0x03
> +#define MAX77843_CHG_DO_MODE			0x04
> +#define MAX77843_CHG_HT_MODE			0x05
> +#define MAX77843_CHG_TF_MODE			0x06
> +#define MAX77843_CHG_TS_MODE			0x07
> +#define MAX77843_CHG_OFF_MODE			0x08
> +
> +#define MAX77843_CHG_BAT_DTLS_MASK		0xf0
> +#define MAX77843_CHG_NO_BAT			(0x00 << 4)
> +#define MAX77843_CHG_LOW_VOLT_BAT		(0x01 << 4)
> +#define MAX77843_CHG_LONG_BAT_TIME		(0x02 << 4)
> +#define MAX77843_CHG_OK_BAT			(0x03 << 4)
> +#define MAX77843_CHG_OK_LOW_VOLT_BAT		(0x04 << 4)
> +#define MAX77843_CHG_OVER_VOLT_BAT		(0x05 << 4)
> +#define MAX77843_CHG_OVER_CURRENT_BAT		(0x06 << 4)
> +
> +/* MAX77843 CHG_CNFG_00 register */
> +#define MAX77843_CHG_DISABLE			0x00
> +#define MAX77843_CHG_ENABLE			0x05
> +#define MAX77843_CHG_MASK			0x01
> +#define MAX77843_CHG_BUCK_MASK			0x04
> +
> +/* MAX77843 CHG_CNFG_01 register */
> +#define MAX77843_CHG_RESTART_THRESHOLD_100	0x00
> +#define MAX77843_CHG_RESTART_THRESHOLD_150	0x10
> +#define MAX77843_CHG_RESTART_THRESHOLD_200	0x20
> +#define MAX77843_CHG_RESTART_THRESHOLD_DISABLE	0x30
> +
> +/* MAX77843 CHG_CNFG_02 register */
> +#define MAX77843_CHG_FAST_CHG_CURRENT_MIN	100000
> +#define MAX77843_CHG_FAST_CHG_CURRENT_MAX	3150000
> +#define MAX77843_CHG_FAST_CHG_CURRENT_STEP	50000
> +#define MAX77843_CHG_FAST_CHG_CURRENT_MASK	0x3f
> +#define MAX77843_CHG_OTG_ILIMIT_500		(0x00 << 6)
> +#define MAX77843_CHG_OTG_ILIMIT_900		(0x01 << 6)
> +#define MAX77843_CHG_OTG_ILIMIT_1200		(0x02 << 6)
> +#define MAX77843_CHG_OTG_ILIMIT_1500		(0x03 << 6)
> +#define MAX77843_CHG_OTG_ILIMIT_MASK		0xc0
> +
> +/* MAX77843 CHG_CNFG_03 register */
> +#define MAX77843_CHG_TOP_OFF_CURRENT_MIN	125000
> +#define MAX77843_CHG_TOP_OFF_CURRENT_MAX	650000
> +#define MAX77843_CHG_TOP_OFF_CURRENT_STEP	75000
> +#define MAX77843_CHG_TOP_OFF_CURRENT_MASK	0x07
> +
> +/* MAX77843 CHG_CNFG_06 register */
> +#define MAX77843_CHG_WRITE_CAP_BLOCK		0x10
> +#define MAX77843_CHG_WRITE_CAP_UNBLOCK		0x0C
> +
> +/* MAX77843_CHG_CNFG_09_register */
> +#define MAX77843_CHG_INPUT_CURRENT_LIMIT_MIN	100000
> +#define MAX77843_CHG_INPUT_CURRENT_LIMIT_MAX	4000000
> +#define MAX77843_CHG_INPUT_CURRENT_LIMIT_REF	3367000
> +#define MAX77843_CHG_INPUT_CURRENT_LIMIT_STEP	33000
> +
> +#define MAX77843_MUIC_ADC			BIT(0)
> +#define MAX77843_MUIC_ADCERROR			BIT(2)
> +#define MAX77843_MUIC_ADC1K			BIT(3)
> +
> +#define MAX77843_MUIC_CHGTYP			BIT(0)
> +#define MAX77843_MUIC_CHGDETRUN			BIT(1)
> +#define MAX77843_MUIC_DCDTMR			BIT(2)
> +#define MAX77843_MUIC_DXOVP			BIT(3)
> +#define MAX77843_MUIC_VBVOLT			BIT(4)
> +
> +#define MAX77843_MUIC_VBADC			BIT(0)
> +#define MAX77843_MUIC_VDNMON			BIT(1)
> +#define MAX77843_MUIC_DNRES			BIT(2)
> +#define MAX77843_MUIC_MPNACK			BIT(3)
> +#define MAX77843_MUIC_MRXBUFOW			BIT(4)
> +#define MAX77843_MUIC_MRXTRF			BIT(5)
> +#define MAX77843_MUIC_MRXPERR			BIT(6)
> +#define MAX77843_MUIC_MRXRDY			BIT(7)
> +
> +/* MAX77843 INTSRCMASK register */
> +#define MAX77843_INTSRCMASK_CHGR		0
> +#define MAX77843_INTSRCMASK_SYS			1
> +#define MAX77843_INTSRCMASK_FG			2
> +#define MAX77843_INTSRCMASK_MUIC		3
> +
> +#define MAX77843_INTSRCMASK_CHGR_MASK          BIT(MAX77843_INTSRCMASK_CHGR)
> +#define MAX77843_INTSRCMASK_SYS_MASK           BIT(MAX77843_INTSRCMASK_SYS)
> +#define MAX77843_INTSRCMASK_FG_MASK            BIT(MAX77843_INTSRCMASK_FG)
> +#define MAX77843_INTSRCMASK_MUIC_MASK          BIT(MAX77843_INTSRCMASK_MUIC)
> +
> +#define MAX77843_INTSRC_MASK_MASK \
> +		(MAX77843_INTSRCMASK_MUIC_MASK | MAX77843_INTSRCMASK_FG_MASK | \
> +		MAX77843_INTSRCMASK_SYS_MASK | MAX77843_INTSRCMASK_CHGR_MASK)
> +
> +/* MAX77843 STATUS register*/
> +#define STATUS1_ADC_SHIFT			0
> +#define STATUS1_ADCERROR_SHIFT			6
> +#define STATUS1_ADC1K_SHIFT			7
> +#define STATUS2_CHGTYP_SHIFT			0
> +#define STATUS2_CHGDETRUN_SHIFT			3
> +#define STATUS2_DCDTMR_SHIFT			4
> +#define STATUS2_DXOVP_SHIFT			5
> +#define STATUS2_VBVOLT_SHIFT			6
> +#define STATUS3_VBADC_SHIFT			0
> +#define STATUS3_VDNMON_SHIFT			4
> +#define STATUS3_DNRES_SHIFT			5
> +#define STATUS3_MPNACK_SHIFT			6
> +
> +#define MAX77843_MUIC_STATUS1_ADC_MASK		(0x1f << STATUS1_ADC_SHIFT)
> +#define MAX77843_MUIC_STATUS1_ADCERROR_MASK	BIT(STATUS1_ADCERROR_SHIFT)
> +#define MAX77843_MUIC_STATUS1_ADC1K_MASK	BIT(STATUS1_ADC1K_SHIFT)
> +#define MAX77843_MUIC_STATUS2_CHGTYP_MASK	(0x7 << STATUS2_CHGTYP_SHIFT)
> +#define MAX77843_MUIC_STATUS2_CHGDETRUN_MASK	BIT(STATUS2_CHGDETRUN_SHIFT)
> +#define MAX77843_MUIC_STATUS2_DCDTMR_MASK	BIT(STATUS2_DCDTMR_SHIFT)
> +#define MAX77843_MUIC_STATUS2_DXOVP_MASK	BIT(STATUS2_DXOVP_SHIFT)
> +#define MAX77843_MUIC_STATUS2_VBVOLT_MASK	BIT(STATUS2_VBVOLT_SHIFT)
> +#define MAX77843_MUIC_STATUS3_VBADC_MASK	(0xf << STATUS3_VBADC_SHIFT)
> +#define MAX77843_MUIC_STATUS3_VDNMON_MASK	BIT(STATUS3_VDNMON_SHIFT)
> +#define MAX77843_MUIC_STATUS3_DNRES_MASK	BIT(STATUS3_DNRES_SHIFT)
> +#define MAX77843_MUIC_STATUS3_MPNACK_MASK	BIT(STATUS3_MPNACK_SHIFT)
> +
> +/* MAX77843 CONTROL register */
> +#define CONTROL1_COMP1SW_SHIFT			0
> +#define CONTROL1_COMP2SW_SHIFT			3
> +#define CONTROL1_IDBEN_SHIFT			7
> +#define CONTROL2_LOWPWR_SHIFT			0
> +#define CONTROL2_ADCEN_SHIFT			1
> +#define CONTROL2_CPEN_SHIFT			2
> +#define CONTROL2_ACC_DET_SHIFT			5
> +#define CONTROL2_USBCPINT_SHIFT			6
> +#define CONTROL2_RCPS_SHIFT			7
> +#define CONTROL3_JIGSET_SHIFT			0
> +#define CONTROL4_ADCDBSET_SHIFT			0
> +#define CONTROL4_USBAUTO_SHIFT			4
> +#define CONTROL4_FCTAUTO_SHIFT			5
> +#define CONTROL4_ADCMODE_SHIFT			6
> +
> +#define MAX77843_MUIC_CONTROL1_COMP1SW_MASK	(0x7 << CONTROL1_COMP1SW_SHIFT)
> +#define MAX77843_MUIC_CONTROL1_COMP2SW_MASK	(0x7 << CONTROL1_COMP2SW_SHIFT)
> +#define MAX77843_MUIC_CONTROL1_IDBEN_MASK	BIT(CONTROL1_IDBEN_SHIFT)
> +#define MAX77843_MUIC_CONTROL2_LOWPWR_MASK	BIT(CONTROL2_LOWPWR_SHIFT)
> +#define MAX77843_MUIC_CONTROL2_ADCEN_MASK	BIT(CONTROL2_ADCEN_SHIFT)
> +#define MAX77843_MUIC_CONTROL2_CPEN_MASK	BIT(CONTROL2_CPEN_SHIFT)
> +#define MAX77843_MUIC_CONTROL2_ACC_DET_MASK	BIT(CONTROL2_ACC_DET_SHIFT)
> +#define MAX77843_MUIC_CONTROL2_USBCPINT_MASK	BIT(CONTROL2_USBCPINT_SHIFT)
> +#define MAX77843_MUIC_CONTROL2_RCPS_MASK	BIT(CONTROL2_RCPS_SHIFT)
> +#define MAX77843_MUIC_CONTROL3_JIGSET_MASK	(0x3 << CONTROL3_JIGSET_SHIFT)
> +#define MAX77843_MUIC_CONTROL4_ADCDBSET_MASK	(0x3 << CONTROL4_ADCDBSET_SHIFT)
> +#define MAX77843_MUIC_CONTROL4_USBAUTO_MASK	BIT(CONTROL4_USBAUTO_SHIFT)
> +#define MAX77843_MUIC_CONTROL4_FCTAUTO_MASK	BIT(CONTROL4_FCTAUTO_SHIFT)
> +#define MAX77843_MUIC_CONTROL4_ADCMODE_MASK	(0x3 << CONTROL4_ADCMODE_SHIFT)
> +
> +/* MAX77843 switch port */
> +#define CONTROL1_COM_SW \
> +(MAX77843_MUIC_CONTROL1_COMP1SW_MASK | MAX77843_MUIC_CONTROL1_COMP2SW_MASK)

You need to add a tab for indentation.

> +
> +#define CONTROL1_SW_OPEN \
> +		(0 << CONTROL1_COMP1SW_SHIFT | 0 << CONTROL1_COMP2SW_SHIFT)
> +#define CONTROL1_SW_USB \
> +		(1 << CONTROL1_COMP1SW_SHIFT | 1 << CONTROL1_COMP2SW_SHIFT)
> +#define CONTROL1_SW_AUDIO \
> +		(2 << CONTROL1_COMP1SW_SHIFT | 2 << CONTROL1_COMP2SW_SHIFT)
> +#define CONTROL1_SW_UART \
> +		(3 << CONTROL1_COMP1SW_SHIFT | 3 << CONTROL1_COMP2SW_SHIFT)
> +#define CONTROL1_SW_AUX_USB \
> +		(4 << CONTROL1_COMP1SW_SHIFT | 4 << CONTROL1_COMP2SW_SHIFT)
> +#define CONTROL1_SW_AUX_UART \
> +		(5 << CONTROL1_COMP1SW_SHIFT | 5 << CONTROL1_COMP2SW_SHIFT)

You have to define some definition variable for 0, 1, 2, 3, 4, 5.
If you don' define some variable, we could catch the meaning of 0, 1, 2, 3, 4, 5.

> +
> +#define CONTROL4_AUTO_DISABLE \
> +		(0 << CONTROL4_USBAUTO_SHIFT) | (0 << CONTROL4_FCTAUTO_SHIFT)
> +#define CONTROL4_AUTO_ENABLE \
> +		(1 << CONTROL4_USBAUTO_SHIFT) | (1 << CONTROL4_FCTAUTO_SHIFT)

ditto.

> +
> +/* MAX77843 SAFEOUT LDO Control register */
> +#define SAFEOUTCTRL_SAFEOUT1_SHIFT		0
> +#define SAFEOUTCTRL_SAFEOUT2_SHIFT		2
> +#define SAFEOUTCTRL_ENSAFEOUT1_SHIFT		6
> +#define SAFEOUTCTRL_ENSAFEOUT2_SHIFT		7

[snip]

Thanks,
Chanwoo Choi

