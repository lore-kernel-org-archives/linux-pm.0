Received: from courrier.aliel.fr (courrier.aliel.fr [65.21.61.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA42A4E3797;
	Thu,  2 Jul 2026 09:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.21.61.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782985926; cv=none; b=a1r60csJs4VMsSjjuUSS9kBJmyzTPPIjJm2Rpv8cJRkMqPbKHWn0lOF9YQmruWWDZijIefMoVRG2eg6KFvaesnWScMcEVvDXR/RFIFPx7NV6bVDzCLqXQcvBKRSWqKcd+sB6V4xzFDMHdwEBNzoj3mQx/ZeqdJj1RH6Vl3x02hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782985926; c=relaxed/simple;
	bh=p0sFjWRzjbpxT6lmgqAxIzkvqCsmBHy10xTbeag3hQw=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=ijBQumml//4y9CWAbU6zA36WXTPPRUD4u2E/ckNzARz/zjl4esESa410G1edxh6NHj+lzW1ogbuD0T99vMvElLeoZA3OGNfLv5bPzP/bbyyQ5scgyyml3/KGfGOaXf6X819JkKnwQuAI8VfrCK+WDrTw1H2+WtVJD28andhmf48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aliel.fr; spf=pass smtp.mailfrom=aliel.fr; dkim=pass (1024-bit key) header.d=aliel.fr header.i=@aliel.fr header.b=kvFLpalA; arc=none smtp.client-ip=65.21.61.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aliel.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aliel.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aliel.fr header.i=@aliel.fr header.b="kvFLpalA"
Message-ID: <18ca03a9-3876-4a6e-aaa9-2fecb9bef7e6@aliel.fr>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aliel.fr;
	s=courrier-s1; t=1782985563;
	bh=p0sFjWRzjbpxT6lmgqAxIzkvqCsmBHy10xTbeag3hQw=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To;
	b=kvFLpalAw/VxiqBUqP3rsMzId96gOHBUtGQPWiXolq9p9/en2OvdQEpEjrXfcoRti
	 0ld9TUr2IXS6RjAbqS/WXtsxzkl1hkA8NnjNo+Upr1KpCC6TcifgMmEF+m+iA/xzcS
	 L63fJdydame+xUdRPv+AYkaTWtDSd5xH1qJT2Juc=
Date: Thu, 2 Jul 2026 11:45:25 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
From: linux-kernel-dev@aliel.fr
Subject: Re: [PATCH v7 4/8] mfd: khadas-mcu: Add support for VIM4 MCU variant
To: Lee Jones <lee@kernel.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Beniamino Galvani <b.galvani@gmail.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, linux-amlogic@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-pm@vger.kernel.org
References: <20260603-add-mcu-fan-khadas-vim4-v7-0-594ba8a965d8@aliel.fr>
 <20260603-add-mcu-fan-khadas-vim4-v7-4-594ba8a965d8@aliel.fr>
 <20260611164053.GC1212816@google.com>
Content-Language: en-US
In-Reply-To: <20260611164053.GC1212816@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 6/11/26 6:40 PM, Lee Jones wrote:
> /* Sashiko Automation: Reviewed (0 Findings) */
> 
> On Wed, 03 Jun 2026, Ronald Claveau via B4 Relay wrote:
> 
>> From: Ronald Claveau <linux-kernel-dev@aliel.fr>
>>
>> Refactor probe() to use per-variant values
>> instead of hardcoded globals.
>>
>> Add dedicated regmap configuration for the VIM4 MCU,
>> with its own volatile/writeable registers.
>>
>> Add the fan control register
>> (0–100 levels vs 0–3 for previous supported boards).
>>
>> Add a new compatible string "khadas,vim4-mcu".
>>
>> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
>> Signed-off-by: Ronald Claveau <linux-kernel-dev@aliel.fr>
>> ---
>>  drivers/mfd/khadas-mcu.c | 115 ++++++++++++++++++++++++++++++++++++++++-------
>>  1 file changed, 99 insertions(+), 16 deletions(-)
>>
>> diff --git a/drivers/mfd/khadas-mcu.c b/drivers/mfd/khadas-mcu.c
>> index ba981a7886921..1bf260729d73b 100644
>> --- a/drivers/mfd/khadas-mcu.c
>> +++ b/drivers/mfd/khadas-mcu.c
>> @@ -75,47 +75,129 @@ static const struct regmap_config khadas_mcu_regmap_config = {
>>  	.cache_type	= REGCACHE_MAPLE,
>>  };
>>  
>> -static struct mfd_cell khadas_mcu_fan_cells[] = {
>> +static const struct khadas_mcu_fan_pdata khadas_mcu_fan_pdata = {
>> +	.fan_reg	= KHADAS_MCU_CMD_FAN_STATUS_CTRL_REG,
>> +	.max_level	= 3, /* Fan speed: 0 = off, 1 = low, 2 = medium, 3 = high */
> 
> Instead of this comment, you could always just define the value(s)?
> 

I will do that with define.

>> +};
>> +
>> +static const struct mfd_cell khadas_mcu_fan_cells[] = {
>>  	/* VIM1/2 Rev13+ and VIM3 only */
>> -	{ .name = "khadas-mcu-fan-ctrl", },
>> +	{
>> +		.name = "khadas-mcu-fan-ctrl",
>> +		.platform_data = &khadas_mcu_fan_pdata,
>> +		.pdata_size    = sizeof(khadas_mcu_fan_pdata),
> 
> No need to attempt to align the '=' like this, please.
> 

I will remove these extra spaces.

>> +	},
>>  };
>>  
>> -static struct mfd_cell khadas_mcu_cells[] = {
>> +static const struct mfd_cell khadas_mcu_cells[] = {
>>  	{ .name = "khadas-mcu-user-mem", },
>>  };
>>  
>> +static bool khadas_mcu_vim4_reg_volatile(struct device *dev, unsigned int reg)
>> +{
>> +	switch (reg) {
>> +	case KHADAS_MCU_PWR_OFF_CMD_REG:
>> +	case KHADAS_MCU_VIM4_REST_CONF_REG:
>> +	case KHADAS_MCU_WOL_INIT_START_REG:
>> +	case KHADAS_MCU_VIM4_LED_ON_RAM_REG:
>> +	case KHADAS_MCU_VIM4_FAN_CTRL_REG:
>> +	case KHADAS_MCU_VIM4_WDT_EN_REG:
>> +	case KHADAS_MCU_VIM4_SYS_RST_REG:
>> +		return true;
>> +	default:
>> +		return false;
>> +	}
>> +}
>> +
>> +static bool khadas_mcu_vim4_reg_writeable(struct device *dev, unsigned int reg)
>> +{
>> +	switch (reg) {
>> +	case KHADAS_MCU_VERSION_0_REG:
>> +	case KHADAS_MCU_VERSION_1_REG:
>> +	case KHADAS_MCU_SHUTDOWN_NORMAL_STATUS_REG:
>> +		return false;
>> +	default:
>> +		return true;
>> +	}
>> +}
>> +
>> +static const struct regmap_config khadas_mcu_vim4_regmap_config = {
>> +	.reg_bits	= 8,
>> +	.reg_stride	= 1,
>> +	.val_bits	= 8,
>> +	.max_register	= KHADAS_MCU_VIM4_SYS_RST_REG,
>> +	.volatile_reg	= khadas_mcu_vim4_reg_volatile,
>> +	.writeable_reg	= khadas_mcu_vim4_reg_writeable,
>> +	.cache_type	= REGCACHE_MAPLE,
>> +};
>> +
>> +static const struct khadas_mcu_fan_pdata khadas_vim4_fan_pdata = {
>> +	.fan_reg	= KHADAS_MCU_VIM4_FAN_CTRL_REG,
>> +	.max_level	= 0x64,
>> +};
>> +
>> +static const struct mfd_cell khadas_mcu_vim4_cells[] = {
>> +	{
>> +		.name		= "khadas-mcu-fan-ctrl",
>> +		.platform_data	= &khadas_vim4_fan_pdata,
>> +		.pdata_size	= sizeof(khadas_vim4_fan_pdata),
>> +	},
>> +};
>> +
>>  static int khadas_mcu_probe(struct i2c_client *client)
>>  {
>> +	const struct mfd_cell *cells, *fan_cells;
>> +	const struct regmap_config *regmap_cfg;
>>  	struct device *dev = &client->dev;
>> +	int ncells, nfan_cells, ret;
>>  	struct khadas_mcu *ddata;
>> -	int ret;
>>  
>>  	ddata = devm_kzalloc(dev, sizeof(*ddata), GFP_KERNEL);
>>  	if (!ddata)
>>  		return -ENOMEM;
>>  
>> +	switch ((uintptr_t)i2c_get_match_data(client)) {
>> +	case KHADAS_MCU_GENERIC:
>> +		regmap_cfg	= &khadas_mcu_regmap_config;
>> +		cells		= khadas_mcu_cells;
>> +		ncells		= ARRAY_SIZE(khadas_mcu_cells);
>> +		fan_cells	= khadas_mcu_fan_cells;
>> +		nfan_cells	= ARRAY_SIZE(khadas_mcu_fan_cells);
>> +		break;
>> +	case KHADAS_MCU_VIM4:
>> +		regmap_cfg	= &khadas_mcu_vim4_regmap_config;
>> +		cells		= NULL;
>> +		ncells		= 0;
>> +		fan_cells	= khadas_mcu_vim4_cells;
>> +		nfan_cells	= ARRAY_SIZE(khadas_mcu_vim4_cells);
> 
> I'm not as offended by this as I thought I would be!
> 
>> +		break;
>> +	default:
>> +		return -ENODEV;
>> +	}
>> +
>>  	i2c_set_clientdata(client, ddata);
>>  
>>  	ddata->dev = dev;
>>  
>> -	ddata->regmap = devm_regmap_init_i2c(client, &khadas_mcu_regmap_config);
>> +	ddata->regmap = devm_regmap_init_i2c(client, regmap_cfg);
>>  	if (IS_ERR(ddata->regmap)) {
>>  		ret = PTR_ERR(ddata->regmap);
>> -		dev_err(dev, "Failed to allocate register map: %d\n", ret);
>> -		return ret;
>> +		return dev_err_probe(dev, ret, "Failed to allocate register map\n");
>>  	}
>>  
>> -	ret = devm_mfd_add_devices(dev, PLATFORM_DEVID_NONE,
>> -				   khadas_mcu_cells,
>> -				   ARRAY_SIZE(khadas_mcu_cells),
>> -				   NULL, 0, NULL);
>> -	if (ret)
>> -		return ret;
>> +	if (cells && ncells) {
>> +		ret = devm_mfd_add_devices(dev, PLATFORM_DEVID_NONE,
>> +					   cells,
>> +					   ncells,
>> +					   NULL, 0, NULL);
>> +		if (ret)
>> +			return ret;
>> +	}
>>  
>>  	if (of_property_present(dev->of_node, "#cooling-cells"))
>>  		return devm_mfd_add_devices(dev, PLATFORM_DEVID_NONE,
>> -					    khadas_mcu_fan_cells,
>> -					    ARRAY_SIZE(khadas_mcu_fan_cells),
>> +					    fan_cells,
>> +					    nfan_cells,
>>  					    NULL, 0, NULL);
>>  
>>  	return 0;
>> @@ -123,7 +205,8 @@ static int khadas_mcu_probe(struct i2c_client *client)
>>  
>>  #ifdef CONFIG_OF
>>  static const struct of_device_id khadas_mcu_of_match[] = {
>> -	{ .compatible = "khadas,mcu", },
>> +	{ .compatible = "khadas,mcu", .data = (void *)KHADAS_MCU_GENERIC },
>> +	{ .compatible = "khadas,vim4-mcu", .data = (void *)KHADAS_MCU_VIM4 },
>>  	{},
>>  };
>>  MODULE_DEVICE_TABLE(of, khadas_mcu_of_match);
>>
>> -- 
>> 2.49.0
>>
>>
> 


-- 
Best regards,
Ronald
