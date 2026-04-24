Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739E2359A91
	for <linux-pm@vger.kernel.org>; Fri, 24 Apr 2026 09:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777024530; cv=none; b=Wf1KwZVPDAhTnmwqq1RM83KCpkJ0jZL1yYz4RKAzGV7JYwHqnQMBKL//dJLjn4tB3CTfxqxlKi0MLf+R/I9C7dIkAaarX1f+akkID0cQ0Dtbk/lbx2ROcRllYjF5KIiKxCXCciJyLXVx0CYJTWXRnwe5FlBYBCNRE/7zV5k8Y14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777024530; c=relaxed/simple;
	bh=gIAdKe0F+IakN1RAdeIBJqZrOyHN/ChnLknpLbjY0rg=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=fJ/2Q1eeIiMBjrpzs23bSfCUglm1bq/KuiH9rMl+SruMZBJXWtxM28Jv+sXuBHXso0noOAH94iihwLlLueJmMlissxs2YDy5IscLuiETwu7AiUAKluamWrDQyLBzw5WcoLirMxUEaxLFTppLyRkf/Mi6C4/r9ppudnEySAC3dHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IOuLbdtm; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IOuLbdtm"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-488af96f6b2so97881335e9.0
        for <linux-pm@vger.kernel.org>; Fri, 24 Apr 2026 02:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1777024527; x=1777629327; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OrfueS0M3ksdEe4kTwzYyRrLHN8xQEsX3ULqrEC+KDU=;
        b=IOuLbdtm/w8/TTltTJc2bQ8hVf6MQTIIygroyII+Ume7Idpj17vCcDGiYSbMTeW0Kt
         86LbkYKl24WQNkFpWejvLYSDVfDzNpCHqFbzk1QcNtag8nsZ5bGJYZCnRQTnscWg27r0
         wDohvU7Ld7+FEUVTkQGwPnh+42+HUazAehDtf9zqNyoWKJwJq5LnArS51c64RqcIiB3K
         AgJnrgqhfmxiWp1rWbLD+9wXLCOTB4E1UYd7q+sLeYe2BWIJVTctGrF5wJM/pV6KMWd9
         ruYemngy9UodorZU3qsyp4U/JABrGSdADswEYbQNvUvzcB9eyRHGFh1uHYiYya8pGAW+
         QaYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777024527; x=1777629327;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OrfueS0M3ksdEe4kTwzYyRrLHN8xQEsX3ULqrEC+KDU=;
        b=BzJ5qZMU+QfqhNv4ggAuQhAE7RH+T8oM1YisYD8Y6nxp9oU3F6UXSWmEG2/RvLyqvu
         Iln/hLOgj2zikTL34hdJzA7ctk1VmnAjRSyHzaABjvZO43pOHjKE/laKSIlof9GYIkhc
         BqJ+RTiUL0AOFTTUir3r6IyjizhkVvyIyPBH1Mcche1Gc9TKgDrbwHJ/yCCINr0JAAp6
         pifrjXvsyVwIp8nDZgM71ffeRk/4f09YH2xCAIxlzWV+HyFsQRjOReFTAcWxQA6DrFNw
         +AO3uTEYX6782pBqhTcCKs2CKYY+zNpZbxjvthKRoqeQBaE1tcUxcR8NcXE3KJ14E/m8
         okAw==
X-Forwarded-Encrypted: i=1; AFNElJ8QXlj6LrAFCPbbRx+wCwiax3g4R1ydMJ+gUyhfWZruNRahGtuiJjd4tvTe+IavGajfI2cI36AHPA==@vger.kernel.org
X-Gm-Message-State: AOJu0YywZkh1Ml7E4f+KWRdNkoTq8kaBHae1ueDQAwYTPJ680WkPvIuz
	6cHL6KQMSTp1ri61/pJ4lkICTW7a0oOeShpbWP6JkBHCgUBzfyOsBaE2XoB+9FdIK50=
X-Gm-Gg: AeBDieuCTjSwpJyRKw4BtfLchymyzBFh3ZR8rhI0vxSm0iyxPKIdCtLCWs7h+iyXArQ
	Y93j27/QBeYOJOEZP8i2kFVfJlm59ZAJA5kyl2w2o3828JzvuYANdDJGsX+Cm2AufJGddc6Sauy
	IC3C+Nixd5mMeMgpHl7pTjZ44SP/eC1S1NfE0NQmek7TNOMkGu/alpKatWAhMKkWQ106+Cb8NCm
	TEjPvPUIE8DwL4dUu1TA4iSZQ88qbsr7Ga4A73wHK84T8cTn6tPrhZ7dSJMNk8A9u8Ex2AfQ2ud
	7/FxDJSQwB9An51Pus2VOJ8VVmX+2r3kMap4M8fMPz+CH0kWxmjcFQ/A6BDBVaq/FuIyGyWRuoD
	XBrlEKiig9lhujEpCkX1Wz+ANseXu5kEy3YdUMfDGQam0Qj4Auvb6lAsAjeXf+fLGGtbQ8el7Kz
	PuufxSQK2bloplw9RcVWvJzMEpLz3VV5tcvMQDgmtR/L5vQEKILPAFmpydeD7oM3UuSsFpT70MJ
	06YgISEflosz+xcgA==
X-Received: by 2002:a05:600c:34c7:b0:489:1c32:210d with SMTP id 5b1f17b1804b1-4891c32266amr308527675e9.15.1777024526813;
        Fri, 24 Apr 2026 02:55:26 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:79e1:f56b:445c:ca9c? ([2a01:e0a:106d:1080:79e1:f56b:445c:ca9c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4891bb3d121sm583739045e9.14.2026.04.24.02.55.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Apr 2026 02:55:26 -0700 (PDT)
Message-ID: <4ba28eee-db47-436a-9008-605cae805f81@linaro.org>
Date: Fri, 24 Apr 2026 11:55:25 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v4 4/8] mfd: khadas-mcu: Add support for VIM4 MCU variant
To: linux-kernel-dev@aliel.fr, Lee Jones <lee@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Beniamino Galvani <b.galvani@gmail.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>
Cc: linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
References: <20260421-add-mcu-fan-khadas-vim4-v4-0-447114a28f2d@aliel.fr>
 <20260421-add-mcu-fan-khadas-vim4-v4-4-447114a28f2d@aliel.fr>
Content-Language: en-US, fr
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro
In-Reply-To: <20260421-add-mcu-fan-khadas-vim4-v4-4-447114a28f2d@aliel.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/21/26 13:49, Ronald Claveau via B4 Relay wrote:
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
> Signed-off-by: Ronald Claveau <linux-kernel-dev@aliel.fr>
> ---
>   drivers/mfd/khadas-mcu.c | 106 ++++++++++++++++++++++++++++++++++++++++++-----
>   1 file changed, 95 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/mfd/khadas-mcu.c b/drivers/mfd/khadas-mcu.c
> index ba981a7886921..b36b3b3ab73c0 100644
> --- a/drivers/mfd/khadas-mcu.c
> +++ b/drivers/mfd/khadas-mcu.c
> @@ -75,15 +75,91 @@ static const struct regmap_config khadas_mcu_regmap_config = {
>   	.cache_type	= REGCACHE_MAPLE,
>   };
>   
> +static const struct khadas_mcu_fan_pdata khadas_mcu_fan_pdata = {
> +	.fan_reg	= KHADAS_MCU_CMD_FAN_STATUS_CTRL_REG,
> +	.max_level	= 3,
> +};
> +
>   static struct mfd_cell khadas_mcu_fan_cells[] = {
>   	/* VIM1/2 Rev13+ and VIM3 only */
> -	{ .name = "khadas-mcu-fan-ctrl", },
> +	{
> +		.name = "khadas-mcu-fan-ctrl",
> +		.platform_data = &khadas_mcu_fan_pdata,
> +		.pdata_size    = sizeof(khadas_mcu_fan_pdata),
> +	},
>   };
>   
>   static struct mfd_cell khadas_mcu_cells[] = {
>   	{ .name = "khadas-mcu-user-mem", },
>   };
>   
> +static const struct khadas_mcu_data khadas_mcu_data = {
> +	.regmap_config	= &khadas_mcu_regmap_config,
> +	.cells		= khadas_mcu_cells,
> +	.ncells		= ARRAY_SIZE(khadas_mcu_cells),
> +	.fan_cells	= khadas_mcu_fan_cells,
> +	.nfan_cells	= ARRAY_SIZE(khadas_mcu_fan_cells),
> +};
> +
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
>   static int khadas_mcu_probe(struct i2c_client *client)
>   {
>   	struct device *dev = &client->dev;
> @@ -94,28 +170,35 @@ static int khadas_mcu_probe(struct i2c_client *client)
>   	if (!ddata)
>   		return -ENOMEM;
>   
> +	ddata->data = i2c_get_match_data(client);
> +	if (!ddata->data)
> +		return -EINVAL;
> +
>   	i2c_set_clientdata(client, ddata);
>   
>   	ddata->dev = dev;
>   
> -	ddata->regmap = devm_regmap_init_i2c(client, &khadas_mcu_regmap_config);
> +	ddata->regmap = devm_regmap_init_i2c(client,
> +					     ddata->data->regmap_config);
>   	if (IS_ERR(ddata->regmap)) {
>   		ret = PTR_ERR(ddata->regmap);
>   		dev_err(dev, "Failed to allocate register map: %d\n", ret);
>   		return ret;
>   	}
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
>   	if (of_property_present(dev->of_node, "#cooling-cells"))
>   		return devm_mfd_add_devices(dev, PLATFORM_DEVID_NONE,
> -					    khadas_mcu_fan_cells,
> -					    ARRAY_SIZE(khadas_mcu_fan_cells),
> +					    ddata->data->fan_cells,
> +					    ddata->data->nfan_cells,
>   					    NULL, 0, NULL);
>   
>   	return 0;
> @@ -123,7 +206,8 @@ static int khadas_mcu_probe(struct i2c_client *client)
>   
>   #ifdef CONFIG_OF
>   static const struct of_device_id khadas_mcu_of_match[] = {
> -	{ .compatible = "khadas,mcu", },
> +	{ .compatible = "khadas,mcu", .data = &khadas_mcu_data },
> +	{ .compatible = "khadas,vim4-mcu", .data = &khadas_vim4_mcu_data },
>   	{},
>   };
>   MODULE_DEVICE_TABLE(of, khadas_mcu_of_match);
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
