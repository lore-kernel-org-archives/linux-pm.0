Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D5B43396F4;
	Wed, 27 May 2026 14:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779893610; cv=none; b=uv9kap/6BIiAutWx0Whsb6x31hDTpJxM4RPk/UJtLPCGgeH5Efdb/hehiSAxUOuWQQk3vL0GDVJVmy/JQ4kWM/j7t8GBaW7MSjz5HFmFqtHY9RpXxhqwYPLv4QNoIl3pAAOrFc0kededVKFnj2Yen25B/piTMSxmkfb+zHGNZnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779893610; c=relaxed/simple;
	bh=QJLFjBj8qme2/me2asNcPt45ZO+t+lvUP+JzLkXB7VU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XSlOjUGTZ7aK7XM9cxr2gvdSGLxvz9mOdfdxFUDP82sErnB0TmR9EQGF1VKOShw0E05Kp/bGjAC/7qFZx3zJvxxjfXUdoTvP6UUnICoiFd5sa2qSP78XTq3IPbrq9qG3Q2TCFWYB204xf+4eqW1j8PdWNWIfvGijQHsJp37XThk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VoIEw7RD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VoIEw7RD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F3C91F000E9;
	Wed, 27 May 2026 14:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779893608;
	bh=pyf2NIpQI//sA77LnOBsyuhGhNwx3LA0tHEq3fc0Cnw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VoIEw7RD3XzhIH6CMzyv/4bAiKKqttFdvHyvdPiNZ0XkyrOXT+9Ut7v0DYrKUDIZg
	 aGIMCpZrnzU0AZ3GLCOtd1YTcFqxWmnSMc+pe3lta0BO+PdA4uZ0VNaJidzUS1t+z2
	 yDa86/jmSP5R7mGXnTWa5uByMrwyvmrxHT83fafDJLE6yDACXiXOpA8UvHBy+tYJkm
	 MdJMUgpr7I4NEA/Cph01WFoxTig42ryn2ezkpx2JZLVneAo+eLyDcyvaU/oIjARMzJ
	 MKg4ZWLOB5V06IYewhhM4QBlRhy8rf8stprH11ulOXV79MO+r925AZ1GttQ2jXfkUo
	 /CfTaiX8vpPJQ==
Date: Wed, 27 May 2026 15:53:22 +0100
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
Subject: Re: [PATCH v6 4/8] mfd: khadas-mcu: Add support for VIM4 MCU variant
Message-ID: <20260527145322.GB671544@google.com>
References: <20260516-add-mcu-fan-khadas-vim4-v6-0-cccc9b61f465@aliel.fr>
 <20260516-add-mcu-fan-khadas-vim4-v6-4-cccc9b61f465@aliel.fr>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260516-add-mcu-fan-khadas-vim4-v6-4-cccc9b61f465@aliel.fr>

On Sat, 16 May 2026, Ronald Claveau via B4 Relay wrote:

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
>  drivers/mfd/khadas-mcu.c | 119 +++++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 104 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/mfd/khadas-mcu.c b/drivers/mfd/khadas-mcu.c
> index ba981a7886921..7bc538232a445 100644
> --- a/drivers/mfd/khadas-mcu.c
> +++ b/drivers/mfd/khadas-mcu.c
> @@ -75,15 +75,91 @@ static const struct regmap_config khadas_mcu_regmap_config = {
>  	.cache_type	= REGCACHE_MAPLE,
>  };
>  
> -static struct mfd_cell khadas_mcu_fan_cells[] = {
> +static const struct khadas_mcu_fan_pdata khadas_mcu_fan_pdata = {
> +	.fan_reg	= KHADAS_MCU_CMD_FAN_STATUS_CTRL_REG,
> +	.max_level	= 3, /* Fan speed: 0 = off, 1 = low, 2 = medium, 3 = high */
> +};
> +
> +static const struct mfd_cell khadas_mcu_fan_cells[] = {
>  	/* VIM1/2 Rev13+ and VIM3 only */
> -	{ .name = "khadas-mcu-fan-ctrl", },
> +	{
> +		.name = "khadas-mcu-fan-ctrl",
> +		.platform_data = &khadas_mcu_fan_pdata,
> +		.pdata_size    = sizeof(khadas_mcu_fan_pdata),
> +	},
>  };
>  
> -static struct mfd_cell khadas_mcu_cells[] = {
> +static const struct mfd_cell khadas_mcu_cells[] = {
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

Let's not over-complicate things please.

You can do all of this with local variables inside khadas_mcu_probe()
and omit the terribly named khadas_mcu_data structure entirely.

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
> @@ -94,28 +170,40 @@ static int khadas_mcu_probe(struct i2c_client *client)
>  	if (!ddata)
>  		return -ENOMEM;
>  
> +	switch ((uintptr_t)i2c_get_match_data(client)) {
> +	case KHADAS_MCU_GENERIC:
> +		ddata->data = &khadas_mcu_data;
> +		break;
> +	case KHADAS_MCU_VIM4:
> +		ddata->data = &khadas_vim4_mcu_data;
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
> +	ddata->regmap = devm_regmap_init_i2c(client, ddata->data->regmap_config);
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
> @@ -123,7 +211,8 @@ static int khadas_mcu_probe(struct i2c_client *client)
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
