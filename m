Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E0A848593F;
	Thu, 10 Sep 2026 14:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789050123; cv=none; b=Y3bwa+Hy43yzhKzvRTJBVV2M0gTipIzjGeYPAvLb041hE5gGo1NWvqUPsjXJ3ysKNYZOGnjK4EoaFRFN5yP9giOVe+piN+8Sin6q/4kL7DqOgH67XDkqnQrhWJ3zzMNWtV9uekXC3yYA5dFINxlTAISABBZwNXwGj2p0dT0u+rU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789050123; c=relaxed/simple;
	bh=TsjGcXQ8Gm9PjVuaw8DkS7g1SRhz8YqLgzvE0WLVABU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uKlcRfI3/8I+KFSfsON/ZND+eZF8ES7u9N/Em6n30zYFvA2EU/iG4OipDWdgyj0R6a4fFhVDnKbNGv4QPC1S5GU/sJeiRWSXOqLS+PTEiimnkOZGV22XnSnZekdyCtKi8LOJZwJ5dI96Ns3dEVHdxIi4YtwTeXX3p4XXkJylwZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M6lEFhFP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M6lEFhFP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57EE01F000FF;
	Thu, 10 Sep 2026 14:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789050121;
	bh=3GA3VBxYsAdWyRrkEkHQX1wHmh0RFEv+jCHyRHk2lUc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=M6lEFhFPI0HqQqh792hXfyIkouPRsBrvGOM6hkXa66AA677QkuX2dHr6P+t34qQm5
	 gMHY95utCfz1PBOzanOh0qDkC/v/bMl89U2GBjqIE55miQ4pQB0l+98q7ixVEqFhsL
	 zI3y/2ICZCEBB2rYWThHLp+NfJOOCoNorYDnVYm66lzIKUWj954ueuNG+UJhwrYxuL
	 BgzI77gCw83JDYl/UNeSmwJQ9IQ4GsDrDPC00Y8ooN9nQwZQxVuBwSm3v8P9T+CO8H
	 tnZoz6jchdxj5iYBQDncU1lA7TvhLBApCUNq+onWVA1t+nbczLh7Wx0boSg0Qe5R97
	 WRHqBg1N6A2hg==
Date: Thu, 10 Sep 2026 15:21:53 +0100
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
	linux-pm@vger.kernel.org, mfd@lists.linux.dev
Subject: Re: [PATCH v11 3/6] mfd: khadas-mcu: Add support for VIM4 MCU variant
Message-ID: <20260910142153.GF1051768@google.com>
References: <20260902-add-mcu-fan-khadas-vim4-v11-0-5f1610d83bf0@aliel.fr>
 <20260902-add-mcu-fan-khadas-vim4-v11-3-5f1610d83bf0@aliel.fr>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260902-add-mcu-fan-khadas-vim4-v11-3-5f1610d83bf0@aliel.fr>

On Wed, 02 Sep 2026, Ronald Claveau via B4 Relay wrote:

> From: Ronald Claveau <linux-kernel-dev@aliel.fr>
> 
> Refactor probe() to use per-variant values
> instead of hardcoded globals.
> 
> Add dedicated regmap configuration for the VIM4 MCU,
> with its own volatile/writeable registers.
> 
> Introduce struct khadas_mcu_fan_pdata to pass the fan
> control register and duty-cycle levels per variant.
> VIM4 uses a different register and level set (0-100)
>  declared as a list (0, 30, 40, 55, 75, 100) compared
>  to previous boards (0-3).
> 
> Add a new compatible string "khadas,vim4-mcu".
> 
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
> Signed-off-by: Ronald Claveau <linux-kernel-dev@aliel.fr>

Generally fine.

> ---
>  drivers/mfd/khadas-mcu.c | 120 +++++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 106 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/mfd/khadas-mcu.c b/drivers/mfd/khadas-mcu.c
> index 0e74efe14f367..4cb305ac915e1 100644
> --- a/drivers/mfd/khadas-mcu.c
> +++ b/drivers/mfd/khadas-mcu.c
> @@ -75,47 +75,138 @@ static const struct regmap_config khadas_mcu_regmap_config = {
>  	.cache_type	= REGCACHE_MAPLE,
>  };
>  
> +static const unsigned int khadas_mcu_fan_levels[] = {
> +	0, 1, 2, 3,
> +};
> +
> +static const struct khadas_mcu_fan_pdata khadas_mcu_fan_pdata = {
> +	.fan_reg	= KHADAS_MCU_CMD_FAN_STATUS_CTRL_REG,
> +	.levels		= khadas_mcu_fan_levels,
> +	.nlevels	= ARRAY_SIZE(khadas_mcu_fan_levels),
> +};

I still don't think these belong in here.

>  static const struct mfd_cell khadas_mcu_fan_cells[] = {
>  	/* VIM1/2 Rev13+ and VIM3 only */
> -	MFD_CELL_NAME("khadas-mcu-fan-ctrl"),
> +	MFD_CELL_BASIC("khadas-mcu-fan-ctrl", NULL, &khadas_mcu_fan_pdata,
> +		       sizeof(khadas_mcu_fan_pdata), 0),
>  };
>  
>  static const struct mfd_cell khadas_mcu_cells[] = {
>  	MFD_CELL_NAME("khadas-mcu-user-mem"),
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
> +static const unsigned int khadas_mcu_vim4_fan_levels[] = {
> +	0, 30, 40, 55, 75, 100,
> +};
> +
> +static const struct khadas_mcu_fan_pdata khadas_mcu_vim4_fan_pdata = {
> +	.fan_reg	= KHADAS_MCU_VIM4_FAN_CTRL_REG,
> +	.levels		= khadas_mcu_vim4_fan_levels,
> +	.nlevels	= ARRAY_SIZE(khadas_mcu_vim4_fan_levels),
> +};
> +
> +static const struct mfd_cell khadas_mcu_vim4_fan_cells[] = {
> +	MFD_CELL_BASIC("khadas-mcu-fan-ctrl", NULL, &khadas_mcu_vim4_fan_pdata,
> +		       sizeof(khadas_mcu_vim4_fan_pdata), 0),
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
> +	const void *match;
>  
>  	ddata = devm_kzalloc(dev, sizeof(*ddata), GFP_KERNEL);
>  	if (!ddata)
>  		return -ENOMEM;
>  
> +	match = i2c_get_match_data(client);

The nomenclature can be improved here.

What are these?  Device ID?  Chip ID?  Revision?

> +	if (!match)
> +		return -ENODEV;
> +
> +	switch ((uintptr_t)match) {
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
> +		fan_cells	= khadas_mcu_vim4_fan_cells;
> +		nfan_cells	= ARRAY_SIZE(khadas_mcu_vim4_fan_cells);
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
> @@ -123,7 +214,8 @@ static int khadas_mcu_probe(struct i2c_client *client)
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
