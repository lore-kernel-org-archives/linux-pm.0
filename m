From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH 2/3] regulator: max77693: Also manipulate the fast charge
 current
Date: Tue, 27 Sep 2016 10:03:57 +0200
Message-ID: <20160927080357.GA4394@kozik-lap>
References: <1474932670-11953-1-git-send-email-wolfgit@wiedmeyer.de>
 <1474932670-11953-3-git-send-email-wolfgit@wiedmeyer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f66.google.com ([209.85.215.66]:33284 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751750AbcI0IEE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 27 Sep 2016 04:04:04 -0400
Content-Disposition: inline
In-Reply-To: <1474932670-11953-3-git-send-email-wolfgit@wiedmeyer.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Wolfgang Wiedmeyer <wolfgit@wiedmeyer.de>
Cc: krzk@kernel.org, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, cw00.choi@samsung.com, b.zolnierkie@samsung.com, broonie@kernel.org, lgirdwood@gmail.com, lee.jones@linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, Sep 27, 2016 at 01:31:09AM +0200, Wolfgang Wiedmeyer wrote:
> For MAX77693, the fast charge current also needs to be manipulated for
> proper charging. The fast charge current is only set in the case of
> the MAX77693 type, as the MAX77843 properly manipulates the fast
> charge current.

Are you sure it has to be manipulated? Some time I didn't dig into this.
Now I looked at the datasheet and it says that usually there is no need
for changing the charge current during the operation. Maxim recommends
to setting it to a maximum safe value for the battery. The device will
manage charge current on its own.

However I agree that the charge current should be set... maybe once, to
a maximum value appropriate for battery. Probably this should be done
by max77693_charger in max77693_dt_init().

Best regards,
Krzysztof


> The fast charge current is set to the next possible value below the
> maximum input current.


> 
> Signed-off-by: Wolfgang Wiedmeyer <wolfgit@wiedmeyer.de>
> ---
>  drivers/regulator/max77693-regulator.c | 45 +++++++++++++++++++++++++++++++---
>  1 file changed, 42 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/regulator/max77693-regulator.c b/drivers/regulator/max77693-regulator.c
> index cfbb951..e2f7584 100644
> --- a/drivers/regulator/max77693-regulator.c
> +++ b/drivers/regulator/max77693-regulator.c
> @@ -54,14 +54,19 @@ struct chg_reg_data {
>  	unsigned int linear_mask;
>  	unsigned int uA_step;
>  	unsigned int min_sel;
> +
> +	bool set_fast;
> +	unsigned int fast_reg;
> +	unsigned int fast_mask;
>  };
>  
>  /*
>   * MAX77693 CHARGER regulator - Min : 20mA, Max : 2580mA, step : 20mA
>   * 0x00, 0x01, 0x2, 0x03	= 60 mA
>   * 0x04 ~ 0x7E			= (60 + (X - 3) * 20) mA
> - * Actually for MAX77693 the driver manipulates the maximum input current,
> - * not the fast charge current (output). This should be fixed.
> + * Actually for MAX77693 the driver manipulates the maximum input current
> + * and the fast charge current (output) because the fast charge current
> + * is not set.
>   *
>   * On MAX77843 the calculation formula is the same (except values).
>   * Fortunately it properly manipulates the fast charge current.
> @@ -100,6 +105,8 @@ static int max77693_chg_set_current_limit(struct regulator_dev *rdev,
>  	const struct chg_reg_data *reg_data = rdev_get_drvdata(rdev);
>  	unsigned int chg_min_uA = rdev->constraints->min_uA;
>  	int sel = 0;
> +	unsigned int data;
> +	int ret;
>  
>  	while (chg_min_uA + reg_data->uA_step * sel < min_uA)
>  		sel++;
> @@ -110,7 +117,35 @@ static int max77693_chg_set_current_limit(struct regulator_dev *rdev,
>  	/* the first four codes for charger current are all 60mA */
>  	sel += reg_data->min_sel;
>  
> -	return regmap_write(rdev->regmap, reg_data->linear_reg, sel);
> +	ret = regmap_write(rdev->regmap, reg_data->linear_reg, sel);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (reg_data->set_fast) {
> +		/* disable fast charge if minimum value */
> +		if (sel == reg_data->min_sel)
> +			data = 0;
> +		else {
> +			/*
> +			 * set the fast charge current to the closest value
> +			 * below the input current
> +			 */
> +			ret = regmap_read(rdev->regmap, reg_data->fast_reg,
> +					  &data);
> +			if (ret < 0)
> +				return ret;
> +
> +			sel *= reg_data->uA_step / 1000; /* convert to mA */
> +			data &= ~reg_data->fast_mask;
> +			data |= sel * 10 / 333; /* 0.1A/3 steps */
> +		}
> +
> +		ret = regmap_write(rdev->regmap, reg_data->fast_reg, data);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
> +	return 0;
>  }
>  /* end of CHARGER regulator ops */
>  
> @@ -197,6 +232,9 @@ static const struct chg_reg_data max77693_chg_reg_data = {
>  	.linear_mask	= CHG_CNFG_09_CHGIN_ILIM_MASK,
>  	.uA_step	= 20000,
>  	.min_sel	= 3,
> +	.set_fast	= true,
> +	.fast_reg	= MAX77693_CHG_REG_CHG_CNFG_02,
> +	.fast_mask	= CHG_CNFG_02_CC_MASK,
>  };
>  
>  #define	max77843_regulator_desc_esafeout(num)	{			\
> @@ -237,6 +275,7 @@ static const struct chg_reg_data max77843_chg_reg_data = {
>  	.linear_mask	= MAX77843_CHG_FAST_CHG_CURRENT_MASK,
>  	.uA_step	= MAX77843_CHG_FAST_CHG_CURRENT_STEP,
>  	.min_sel	= 2,
> +	.set_fast	= false,
>  };
>  
>  static int max77693_pmic_probe(struct platform_device *pdev)
> -- 
> 2.8.0.rc3
> 
