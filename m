Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E65448B91;
	Thu, 23 Jul 2026 15:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784821763; cv=none; b=t+hhSt+uyd2E2W25kckc0A41ydkt2G1KAfPQbwzeI3Io+vhERFSbLHg49eVamWAR+uz5QBqgbpDzfe2dK91HNuhut+cwIPUQAi8YuudJmdKjsDlFM43ZtassDHTV4MNzNxKjGSjtaV347DazPK7Jt4rwgNNrlUAIQTPOH7B6B2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784821763; c=relaxed/simple;
	bh=/DSvfdI17PeLSJ9INrDWndXh3pMB9X4p73oEV1GeG3s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hLl+GbmWlo+covTVlrnAs0zjjSb2Jhl+PJN6lpXcbos0tIxzqfcbq9WcrED6SyTO3S7tILHXASkLeryvysQ92zCDv+KeOqtux/EG01cu5SEkBDamCu9cyXpP3fEmi7DAESzByAp/p99VRyNikQ7C7V3PhTf4v61qKANihxPwIk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PHCmPjDn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PHCmPjDn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AE281F000E9;
	Thu, 23 Jul 2026 15:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784821756;
	bh=U01kuOATGHA1fUMiHEUhqkKZsOtYtgmMdQbRp82P+Hk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PHCmPjDn1fSziPa+BM08GsiE+UPsJZ+fv77G5TEjtX+n6njvYj954SkQE4kKDhyD0
	 ARpcyfZBX47nlpJnStKP0X1dtnLyWywBBJGj70iLej4kgNq2vFiYkQ9S7GpIAxFLFy
	 tIbmrHq/FBnLK3zhL1iJ+NqabGwQCB4aq8klAXD01ICeeiK2g08aPTovK3PfhXQzYe
	 AJjqS3Mji+tLWvi2plC928sXlaJCD6D8OhCoYb/DKe/jhIW8jFLCfEcE+6l7YQWU8J
	 rZRD+y4Q7wxUcYQnBMYhnBWfL/bHl2JaKdzUoscYO4pCBDwvHJ1Wl1TIDaERFlc3+c
	 T4oX6zLKQLnLg==
Date: Thu, 23 Jul 2026 16:48:47 +0100
From: Lee Jones <lee@kernel.org>
To: linux-kernel-dev@aliel.fr
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Beniamino Galvani <b.galvani@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, linux-amlogic@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v8 4/8] mfd: khadas-mcu: Add support for VIM4 MCU variant
Message-ID: <20260723154847.GP3363113@google.com>
References: <20260702-add-mcu-fan-khadas-vim4-v8-0-244feee91a36@aliel.fr>
 <20260702-add-mcu-fan-khadas-vim4-v8-4-244feee91a36@aliel.fr>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260702-add-mcu-fan-khadas-vim4-v8-4-244feee91a36@aliel.fr>

/* Sashiko Automation: Reviewed (0 Findings) */

On Thu, 02 Jul 2026, Ronald Claveau via B4 Relay wrote:

> From: Ronald Claveau <linux-kernel-dev@aliel.fr>
> 
> Refactor probe() to use per-variant values
> instead of hardcoded globals.
> 
> Add dedicated regmap configuration for the VIM4 MCU,
> with its own volatile/writeable registers.
> 
> Add the fan control register
> (0–100 levels vs 0–3 for previous supported boards).
> 
> Add a new compatible string "khadas,vim4-mcu".
> 
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
> Signed-off-by: Ronald Claveau <linux-kernel-dev@aliel.fr>
> ---
> 
>  drivers/mfd/khadas-mcu.c | 118 ++++++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 102 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/mfd/khadas-mcu.c b/drivers/mfd/khadas-mcu.c
> index ba981a7886921..d2ca7deda45c6 100644
> --- a/drivers/mfd/khadas-mcu.c
> +++ b/drivers/mfd/khadas-mcu.c
> @@ -13,6 +13,9 @@
>  #include <linux/module.h>
>  #include <linux/regmap.h>
>  
> #define KHADAS_MCU_FAN_LEVEL_MAX 3
> #define KHADAS_MCU_VIM4_FAN_LEVEL_MAX 0x64
> +
>  static bool khadas_mcu_reg_volatile(struct device *dev, unsigned int reg)
>  {
>  	if (reg >= KHADAS_MCU_USER_DATA_0_REG &&
> @@ -75,47 +78,129 @@ static const struct regmap_config khadas_mcu_regmap_config = {
>  	.cache_type	= REGCACHE_MAPLE,
>  };
>  
> -static struct mfd_cell khadas_mcu_fan_cells[] = {
> +static const struct khadas_mcu_fan_pdata khadas_mcu_fan_pdata = {
> +	.fan_reg	= KHADAS_MCU_CMD_FAN_STATUS_CTRL_REG,
> +	.max_level	= KHADAS_MCU_FAN_LEVEL_MAX,
> +};
> +
> +static const struct mfd_cell khadas_mcu_fan_cells[] = {
>  	/* VIM1/2 Rev13+ and VIM3 only */
> -	{ .name = "khadas-mcu-fan-ctrl", },
> +	{
> +		.name = "khadas-mcu-fan-ctrl",
> +		.platform_data = &khadas_mcu_fan_pdata,
> +		.pdata_size = sizeof(khadas_mcu_fan_pdata),
> +	},
>  };

If you're tweaking, feel free to get more upstream creds by laying down
a prelim patch changing these to MFD_CELL_*().

> -static struct mfd_cell khadas_mcu_cells[] = {
> +static const struct mfd_cell khadas_mcu_cells[] = {
>  	{ .name = "khadas-mcu-user-mem", },
>  };
>  
> +static bool khadas_mcu_vim4_reg_volatile(struct device *dev, unsigned int reg)
> +{
> +	switch (reg) {
> +	case KHADAS_MCU_PWR_OFF_CMD_REG:
> +	case KHADAS_MCU_VIM4_REST_CONF_REG:
> +	case KHADAS_MCU_WOL_INIT_START_REG:
> +	case KHADAS_MCU_VIM4_LED_ON_RAM_REG:
> +	case KHADAS_MCU_VIM4_FAN_CTRL_REG:
> +	case KHADAS_MCU_VIM4_WDT_EN_REG:
> +	case KHADAS_MCU_VIM4_SYS_RST_REG:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
> +static bool khadas_mcu_vim4_reg_writeable(struct device *dev, unsigned int reg)
> +{
> +	switch (reg) {
> +	case KHADAS_MCU_VERSION_0_REG:
> +	case KHADAS_MCU_VERSION_1_REG:
> +	case KHADAS_MCU_SHUTDOWN_NORMAL_STATUS_REG:
> +		return false;
> +	default:
> +		return true;
> +	}
> +}
> +
> +static const struct regmap_config khadas_mcu_vim4_regmap_config = {
> +	.reg_bits	= 8,
> +	.reg_stride	= 1,
> +	.val_bits	= 8,
> +	.max_register	= KHADAS_MCU_VIM4_SYS_RST_REG,
> +	.volatile_reg	= khadas_mcu_vim4_reg_volatile,
> +	.writeable_reg	= khadas_mcu_vim4_reg_writeable,
> +	.cache_type	= REGCACHE_MAPLE,
> +};
> +
> +static const struct khadas_mcu_fan_pdata khadas_vim4_fan_pdata = {
> +	.fan_reg	= KHADAS_MCU_VIM4_FAN_CTRL_REG,
> +	.max_level	= KHADAS_MCU_VIM4_FAN_LEVEL_MAX,
> +};
> +
> +static const struct mfd_cell khadas_mcu_vim4_cells[] = {
> +	{
> +		.name		= "khadas-mcu-fan-ctrl",
> +		.platform_data	= &khadas_vim4_fan_pdata,
> +		.pdata_size	= sizeof(khadas_vim4_fan_pdata),
> +	},
> +};
> +
>  static int khadas_mcu_probe(struct i2c_client *client)
>  {
> +	const struct mfd_cell *cells, *fan_cells;
> +	const struct regmap_config *regmap_cfg;
>  	struct device *dev = &client->dev;
> +	int ncells, nfan_cells, ret;
>  	struct khadas_mcu *ddata;
> -	int ret;
>  
>  	ddata = devm_kzalloc(dev, sizeof(*ddata), GFP_KERNEL);
>  	if (!ddata)
>  		return -ENOMEM;
>  
> +	switch ((uintptr_t)i2c_get_match_data(client)) {

Let's pull this out of the switch():

	const void *match;

	match = i2c_get_match_data(client);
	if (!match)
		return -ENODEV;

This would separate the declaration from the potentially failing
function call and prevent implicitly matching 'KHADAS_MCU_GENERIC' (if
its value is 0) should the lookup fail.

> +	case KHADAS_MCU_GENERIC:
> +		regmap_cfg	= &khadas_mcu_regmap_config;
> +		cells		= khadas_mcu_cells;
> +		ncells		= ARRAY_SIZE(khadas_mcu_cells);
> +		fan_cells	= khadas_mcu_fan_cells;
> +		nfan_cells	= ARRAY_SIZE(khadas_mcu_fan_cells);
> +		break;
> +	case KHADAS_MCU_VIM4:
> +		regmap_cfg	= &khadas_mcu_vim4_regmap_config;
> +		cells		= NULL;
> +		ncells		= 0;
> +		fan_cells	= khadas_mcu_vim4_cells;
> +		nfan_cells	= ARRAY_SIZE(khadas_mcu_vim4_cells);
> +		break;
> +	default:
> +		return -ENODEV;
> +	}
> +
>  	i2c_set_clientdata(client, ddata);
>  
>  	ddata->dev = dev;
>  
> -	ddata->regmap = devm_regmap_init_i2c(client, &khadas_mcu_regmap_config);
> +	ddata->regmap = devm_regmap_init_i2c(client, regmap_cfg);
>  	if (IS_ERR(ddata->regmap)) {
>  		ret = PTR_ERR(ddata->regmap);
> -		dev_err(dev, "Failed to allocate register map: %d\n", ret);
> -		return ret;
> +		return dev_err_probe(dev, ret, "Failed to allocate register map\n");
>  	}
>  
> -	ret = devm_mfd_add_devices(dev, PLATFORM_DEVID_NONE,
> -				   khadas_mcu_cells,
> -				   ARRAY_SIZE(khadas_mcu_cells),
> -				   NULL, 0, NULL);
> -	if (ret)
> -		return ret;
> +	if (cells && ncells) {
> +		ret = devm_mfd_add_devices(dev, PLATFORM_DEVID_NONE,
> +					   cells,
> +					   ncells,
> +					   NULL, 0, NULL);
> +		if (ret)
> +			return ret;
> +	}
>  
>  	if (of_property_present(dev->of_node, "#cooling-cells"))
>  		return devm_mfd_add_devices(dev, PLATFORM_DEVID_NONE,
> -					    khadas_mcu_fan_cells,
> -					    ARRAY_SIZE(khadas_mcu_fan_cells),
> +					    fan_cells,
> +					    nfan_cells,
>  					    NULL, 0, NULL);
>  
>  	return 0;
> @@ -123,7 +208,8 @@ static int khadas_mcu_probe(struct i2c_client *client)
>  
>  #ifdef CONFIG_OF
>  static const struct of_device_id khadas_mcu_of_match[] = {
> -	{ .compatible = "khadas,mcu", },
> +	{ .compatible = "khadas,mcu", .data = (void *)KHADAS_MCU_GENERIC },
> +	{ .compatible = "khadas,vim4-mcu", .data = (void *)KHADAS_MCU_VIM4 },
>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, khadas_mcu_of_match);
> 
> -- 
> 2.49.0
> 
> 

-- 
Lee Jones
