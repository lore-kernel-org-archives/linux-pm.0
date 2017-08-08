From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH V1] thermal: qcom-spmi-temp-alarm: add support for GEN2
 PMIC peripherals
Date: Tue, 08 Aug 2017 16:12:23 +0800
Message-ID: <1502179943.4296.12.camel@intel.com>
References: <1499947772-19199-1-git-send-email-kgunda@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:23152 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750818AbdHHIM3 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 8 Aug 2017 04:12:29 -0400
In-Reply-To: <1499947772-19199-1-git-send-email-kgunda@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kiran Gunda <kgunda@codeaurora.org>, Eduardo Valentin <edubezval@gmail.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, iivanov@mm-sol.com
Cc: linux-arm-msm@vger.kernel.org, David Collins <collinsd@codeaurora.org>

On Thu, 2017-07-13 at 17:39 +0530, Kiran Gunda wrote:
> From: David Collins <collinsd@codeaurora.org>
> 
> Add support for the TEMP_ALARM GEN2 PMIC peripheral subtype.  The
> GEN2 subtype defines an over temperature state with hysteresis
> instead of stage in the status register.  There are two GEN2
> states corresponding to stages 1 and 2.
> 
> Signed-off-by: David Collins <collinsd@codeaurora.org>
> Signed-off-by: Kiran Gunda <kgunda@codeaurora.org>

Ivan,

can you please review this patch and let me know your opinion?

thanks,
rui
> ---
>  drivers/thermal/qcom-spmi-temp-alarm.c | 92
> ++++++++++++++++++++++++++--------
>  1 file changed, 71 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/thermal/qcom-spmi-temp-alarm.c
> b/drivers/thermal/qcom-spmi-temp-alarm.c
> index f502419..a5e17ba 100644
> --- a/drivers/thermal/qcom-spmi-temp-alarm.c
> +++ b/drivers/thermal/qcom-spmi-temp-alarm.c
> @@ -1,5 +1,5 @@
>  /*
> - * Copyright (c) 2011-2015, The Linux Foundation. All rights
> reserved.
> + * Copyright (c) 2011-2015, 2017, The Linux Foundation. All rights
> reserved.
>   *
>   * This program is free software; you can redistribute it and/or
> modify
>   * it under the terms of the GNU General Public License version 2
> and
> @@ -11,6 +11,7 @@
>   * GNU General Public License for more details.
>   */
>  
> +#include <linux/bitops.h>
>  #include <linux/delay.h>
>  #include <linux/err.h>
>  #include <linux/iio/consumer.h>
> @@ -29,13 +30,17 @@
>  #define QPNP_TM_REG_ALARM_CTRL		0x46
>  
>  #define QPNP_TM_TYPE			0x09
> -#define QPNP_TM_SUBTYPE			0x08
> +#define QPNP_TM_SUBTYPE_GEN1		0x08
> +#define QPNP_TM_SUBTYPE_GEN2		0x09
>  
> -#define STATUS_STAGE_MASK		0x03
> +#define STATUS_GEN1_STAGE_MASK		GENMASK(1, 0)
> +#define STATUS_GEN2_STATE_MASK		GENMASK(6, 4)
> +#define STATUS_GEN2_STATE_SHIFT		4
>  
> -#define SHUTDOWN_CTRL1_THRESHOLD_MASK	0x03
> +#define SHUTDOWN_CTRL1_OVERRIDE_MASK	GENMASK(7, 6)
> +#define SHUTDOWN_CTRL1_THRESHOLD_MASK	GENMASK(1, 0)
>  
> -#define ALARM_CTRL_FORCE_ENABLE		0x80
> +#define ALARM_CTRL_FORCE_ENABLE		BIT(7)
>  
>  /*
>   * Trip point values based on threshold control
> @@ -58,6 +63,7 @@
>  struct qpnp_tm_chip {
>  	struct regmap			*map;
>  	struct thermal_zone_device	*tz_dev;
> +	unsigned int			subtype;
>  	long				temp;
>  	unsigned int			thresh;
>  	unsigned int			stage;
> @@ -66,6 +72,9 @@ struct qpnp_tm_chip {
>  	struct iio_channel		*adc;
>  };
>  
> +/* This array maps from GEN2 alarm state to GEN1 alarm stage */
> +static const unsigned int alarm_state_map[8] = {0, 1, 1, 2, 2, 3, 3,
> 3};
> +
>  static int qpnp_tm_read(struct qpnp_tm_chip *chip, u16 addr, u8
> *data)
>  {
>  	unsigned int val;
> @@ -84,30 +93,59 @@ static int qpnp_tm_write(struct qpnp_tm_chip
> *chip, u16 addr, u8 data)
>  	return regmap_write(chip->map, chip->base + addr, data);
>  }
>  
> +/**
> + * qpnp_tm_get_temp_stage() - return over-temperature stage
> + * @chip:		Pointer to the qpnp_tm chip
> + *
> + * Return: stage (GEN1) or state (GEN2) on success, or errno on
> failure.
> + */
> +static int qpnp_tm_get_temp_stage(struct qpnp_tm_chip *chip)
> +{
> +	int ret;
> +	u8 reg = 0;
> +
> +	ret = qpnp_tm_read(chip, QPNP_TM_REG_STATUS, &reg);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (chip->subtype == QPNP_TM_SUBTYPE_GEN1)
> +		ret = reg & STATUS_GEN1_STAGE_MASK;
> +	else
> +		ret = (reg & STATUS_GEN2_STATE_MASK) >>
> STATUS_GEN2_STATE_SHIFT;
> +
> +	return ret;
> +}
> +
>  /*
>   * This function updates the internal temp value based on the
>   * current thermal stage and threshold as well as the previous stage
>   */
>  static int qpnp_tm_update_temp_no_adc(struct qpnp_tm_chip *chip)
>  {
> -	unsigned int stage;
> +	unsigned int stage, stage_new, stage_old;
>  	int ret;
> -	u8 reg = 0;
>  
> -	ret = qpnp_tm_read(chip, QPNP_TM_REG_STATUS, &reg);
> +	ret = qpnp_tm_get_temp_stage(chip);
>  	if (ret < 0)
>  		return ret;
> +	stage = ret;
>  
> -	stage = reg & STATUS_STAGE_MASK;
> +	if (chip->subtype == QPNP_TM_SUBTYPE_GEN1) {
> +		stage_new = stage;
> +		stage_old = chip->stage;
> +	} else {
> +		stage_new = alarm_state_map[stage];
> +		stage_old = alarm_state_map[chip->stage];
> +	}
>  
> -	if (stage > chip->stage) {
> +	if (stage_new > stage_old) {
>  		/* increasing stage, use lower bound */
> -		chip->temp = (stage - 1) * TEMP_STAGE_STEP +
> +		chip->temp = (stage_new - 1) * TEMP_STAGE_STEP +
>  			     chip->thresh * TEMP_THRESH_STEP +
>  			     TEMP_STAGE_HYSTERESIS +
> TEMP_THRESH_MIN;
> -	} else if (stage < chip->stage) {
> +	} else if (stage_new < stage_old) {
>  		/* decreasing stage, use upper bound */
> -		chip->temp = stage * TEMP_STAGE_STEP +
> +		chip->temp = stage_new * TEMP_STAGE_STEP +
>  			     chip->thresh * TEMP_THRESH_STEP -
>  			     TEMP_STAGE_HYSTERESIS +
> TEMP_THRESH_MIN;
>  	}
> @@ -162,28 +200,37 @@ static irqreturn_t qpnp_tm_isr(int irq, void
> *data)
>   */
>  static int qpnp_tm_init(struct qpnp_tm_chip *chip)
>  {
> +	unsigned int stage;
>  	int ret;
> -	u8 reg;
> +	u8 reg = 0;
>  
> -	chip->thresh = THRESH_MIN;
> +	ret = qpnp_tm_read(chip, QPNP_TM_REG_SHUTDOWN_CTRL1, &reg);
> +	if (ret < 0)
> +		return ret;
> +
> +	chip->thresh = reg & SHUTDOWN_CTRL1_THRESHOLD_MASK;
>  	chip->temp = DEFAULT_TEMP;
>  
> -	ret = qpnp_tm_read(chip, QPNP_TM_REG_STATUS, &reg);
> +	ret = qpnp_tm_get_temp_stage(chip);
>  	if (ret < 0)
>  		return ret;
> +	chip->stage = ret;
>  
> -	chip->stage = reg & STATUS_STAGE_MASK;
> +	stage = chip->subtype == QPNP_TM_SUBTYPE_GEN1
> +		? chip->stage : alarm_state_map[chip->stage];
>  
> -	if (chip->stage)
> +	if (stage)
>  		chip->temp = chip->thresh * TEMP_THRESH_STEP +
> -			     (chip->stage - 1) * TEMP_STAGE_STEP +
> +			     (stage - 1) * TEMP_STAGE_STEP +
>  			     TEMP_THRESH_MIN;
>  
>  	/*
>  	 * Set threshold and disable software override of stage 2
> and 3
>  	 * shutdowns.
>  	 */
> -	reg = chip->thresh & SHUTDOWN_CTRL1_THRESHOLD_MASK;
> +	chip->thresh = THRESH_MIN;
> +	reg &= ~(SHUTDOWN_CTRL1_OVERRIDE_MASK |
> SHUTDOWN_CTRL1_THRESHOLD_MASK);
> +	reg |= chip->thresh & SHUTDOWN_CTRL1_THRESHOLD_MASK;
>  	ret = qpnp_tm_write(chip, QPNP_TM_REG_SHUTDOWN_CTRL1, reg);
>  	if (ret < 0)
>  		return ret;
> @@ -242,13 +289,16 @@ static int qpnp_tm_probe(struct platform_device
> *pdev)
>  		goto fail;
>  	}
>  
> -	if (type != QPNP_TM_TYPE || subtype != QPNP_TM_SUBTYPE) {
> +	if (type != QPNP_TM_TYPE || (subtype != QPNP_TM_SUBTYPE_GEN1
> +				     && subtype !=
> QPNP_TM_SUBTYPE_GEN2)) {
>  		dev_err(&pdev->dev, "invalid type 0x%02x or subtype
> 0x%02x\n",
>  			type, subtype);
>  		ret = -ENODEV;
>  		goto fail;
>  	}
>  
> +	chip->subtype = subtype;
> +
>  	ret = qpnp_tm_init(chip);
>  	if (ret < 0) {
>  		dev_err(&pdev->dev, "init failed\n");
