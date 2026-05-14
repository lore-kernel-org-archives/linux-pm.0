Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2CB038F248;
	Thu, 14 May 2026 10:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778756107; cv=none; b=L6NQ5zdNlZiNJJNjSnk6djvK/W/rtxDvjwMPgUyLkG1mnWUOwv0EGNvB47rwaiVvZdwC3g7NW2ZLIY+Y/XJ25el3qzlSZ8aoSUlOX9s8o6ZBC3TqHqMKpii4auoyZAlPN8mysu8agnJUohQPJsy0Q3GWaumC0kGofCrN2V+7KYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778756107; c=relaxed/simple;
	bh=XkhZz83lofA4mVraY0m0AcH0UuZ/4Xb3/CeHB5IJ4/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ajynQZzBapadboPUNdd71BuzdZByrA+blHJsSAQoDNr931+Fb2WyNr1AZhoLogK8ReTg1zOl5qjHmSUfrIk2F3gggvmUzANk2GGtpT935g85cR1pihSaeuX9cCipXx51RezwCOY3/iFa/tn+Xdo3Ky57IQehltfoDJUAfTmr1Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nYMYg1OE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nYMYg1OE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A484C2BCB3;
	Thu, 14 May 2026 10:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778756106;
	bh=XkhZz83lofA4mVraY0m0AcH0UuZ/4Xb3/CeHB5IJ4/4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nYMYg1OEtYIi4/xJe4YkZh3xhaqx+qcobMMsNok9nKritLvV7xMMsjyA2aP/vCIE1
	 w738kCB5f3PWpnTTQtkGN7PnNZo27uGMDKFtkpizx9sSH951tH2896jBeTTtnuQtA9
	 MoyqrxDGSVpx2YadIc1HvYsMt12vHkD5iQMQPkODuO0PnrdaoJPOAK1/oxkNjR8v+v
	 83WwT5ikPIYt7VM2BLQINMX1KQIH4Z/0Xkbd7nBOxykZDJtEpCSyGLIsXAgSizbdX9
	 qXcwLa5+1vajdXGsjQQxul06yl3+PMXCkCepl2zzOwpG6ef5Ih04DMQf6BfeYwNPbD
	 4vw/3EbIj9Y0Q==
Date: Thu, 14 May 2026 11:54:59 +0100
From: Lee Jones <lee@kernel.org>
To: Ronald Claveau via B4 Relay <devnull+linux-kernel-dev.aliel.fr@kernel.org>
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
	linux-pm@vger.kernel.org,
	Ronald Claveau <linux-kernel-dev@aliel.fr>
Subject: Re: [PATCH v5 4/8] mfd: khadas-mcu: Add support for VIM4 MCU variant
Message-ID: <20260514105459.GJ305027@google.com>
References: <20260424-add-mcu-fan-khadas-vim4-v5-0-afcfa7157b23@aliel.fr>
 <20260424-add-mcu-fan-khadas-vim4-v5-4-afcfa7157b23@aliel.fr>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260424-add-mcu-fan-khadas-vim4-v5-4-afcfa7157b23@aliel.fr>

On Fri, 24 Apr 2026, Ronald Claveau via B4 Relay wrote:

> From: Ronald Claveau <linux-kernel-dev@aliel.fr>
> 
> Refactor probe() to use per-variant khadas_mcu_data
> instead of hardcoded globals.
> 
> Add dedicated regmap configuration and device data for the VIM4 MCU,
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
>  drivers/mfd/khadas-mcu.c | 106 ++++++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 95 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/mfd/khadas-mcu.c b/drivers/mfd/khadas-mcu.c
> index ba981a7886921..b36b3b3ab73c0 100644
> --- a/drivers/mfd/khadas-mcu.c
> +++ b/drivers/mfd/khadas-mcu.c
> @@ -75,15 +75,91 @@ static const struct regmap_config khadas_mcu_regmap_config = {
>  	.cache_type	= REGCACHE_MAPLE,
>  };
>  
> +static const struct khadas_mcu_fan_pdata khadas_mcu_fan_pdata = {
> +	.fan_reg	= KHADAS_MCU_CMD_FAN_STATUS_CTRL_REG,
> +	.max_level	= 3,
> +};

What is 3?

> +
>  static struct mfd_cell khadas_mcu_fan_cells[] = {
>  	/* VIM1/2 Rev13+ and VIM3 only */
> -	{ .name = "khadas-mcu-fan-ctrl", },
> +	{
> +		.name = "khadas-mcu-fan-ctrl",
> +		.platform_data = &khadas_mcu_fan_pdata,
> +		.pdata_size    = sizeof(khadas_mcu_fan_pdata),
> +	},
>  };

Worth making this const at one point.

>  
>  static struct mfd_cell khadas_mcu_cells[] = {
>  	{ .name = "khadas-mcu-user-mem", },
>  };
>  
> +static const struct khadas_mcu_data khadas_mcu_data = {
> +	.regmap_config	= &khadas_mcu_regmap_config,
> +	.cells		= khadas_mcu_cells,
> +	.ncells		= ARRAY_SIZE(khadas_mcu_cells),
> +	.fan_cells	= khadas_mcu_fan_cells,
> +	.nfan_cells	= ARRAY_SIZE(khadas_mcu_fan_cells),
> +};

This is a red flag!

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
> +	.max_level	= 0x64,
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
> +static const struct khadas_mcu_data khadas_vim4_mcu_data = {
> +	.regmap_config	= &khadas_mcu_vim4_regmap_config,
> +	.cells		= NULL,
> +	.ncells		= 0,
> +	.fan_cells	= khadas_mcu_vim4_cells,
> +	.nfan_cells	= ARRAY_SIZE(khadas_mcu_vim4_cells),
> +};
> +
>  static int khadas_mcu_probe(struct i2c_client *client)
>  {
>  	struct device *dev = &client->dev;
> @@ -94,28 +170,35 @@ static int khadas_mcu_probe(struct i2c_client *client)
>  	if (!ddata)
>  		return -ENOMEM;
>  
> +	ddata->data = i2c_get_match_data(client);
> +	if (!ddata->data)
> +		return -EINVAL;

Shouldn't this be -ENODEV?

>  	i2c_set_clientdata(client, ddata);
>  
>  	ddata->dev = dev;
>  
> -	ddata->regmap = devm_regmap_init_i2c(client, &khadas_mcu_regmap_config);
> +	ddata->regmap = devm_regmap_init_i2c(client,
> +					     ddata->data->regmap_config);

Use up to 100-chars to prevent this kind of wrapping.

>  	if (IS_ERR(ddata->regmap)) {
>  		ret = PTR_ERR(ddata->regmap);
>  		dev_err(dev, "Failed to allocate register map: %d\n", ret);
>  		return ret;
>  	}

Maybe convert this to dev_err_probe() at one point.

> -	ret = devm_mfd_add_devices(dev, PLATFORM_DEVID_NONE,
> -				   khadas_mcu_cells,
> -				   ARRAY_SIZE(khadas_mcu_cells),
> -				   NULL, 0, NULL);
> -	if (ret)
> -		return ret;
> +	if (ddata->data->cells && ddata->data->ncells) {
> +		ret = devm_mfd_add_devices(dev, PLATFORM_DEVID_NONE,
> +					   ddata->data->cells,
> +					   ddata->data->ncells,
> +					   NULL, 0, NULL);
> +		if (ret)
> +			return ret;
> +	}
>  
>  	if (of_property_present(dev->of_node, "#cooling-cells"))
>  		return devm_mfd_add_devices(dev, PLATFORM_DEVID_NONE,
> -					    khadas_mcu_fan_cells,
> -					    ARRAY_SIZE(khadas_mcu_fan_cells),
> +					    ddata->data->fan_cells,
> +					    ddata->data->nfan_cells,
>  					    NULL, 0, NULL);
>  
>  	return 0;
> @@ -123,7 +206,8 @@ static int khadas_mcu_probe(struct i2c_client *client)
>  
>  #ifdef CONFIG_OF
>  static const struct of_device_id khadas_mcu_of_match[] = {
> -	{ .compatible = "khadas,mcu", },
> +	{ .compatible = "khadas,mcu", .data = &khadas_mcu_data },
> +	{ .compatible = "khadas,vim4-mcu", .data = &khadas_vim4_mcu_data },

We don't allow data from one registration API (MFD) to be shoved through
another (DT).  Pass a value to match on instead, then use a switch()
statement or similar to populate or register the devices.

>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, khadas_mcu_of_match);
> 
> -- 
> 2.49.0
> 
>
