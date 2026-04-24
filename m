Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54CE83128CC
	for <linux-pm@vger.kernel.org>; Fri, 24 Apr 2026 10:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777024851; cv=none; b=IH1kuWaKsQbKPVSfWCIL6HQ6K7QjKQrDUeFA4B2wqWoWnIvcyv2YFiHu21SJy9v+dipaHlAgcvoNb88kAHZx9V9zk1+LBV0ejIxfVDyXimbinNOWMi3twk6vAWkRIDLE2jGv8PGZjOPfX036YTVhwlVSk/5u0YX5LbpBWGuIiKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777024851; c=relaxed/simple;
	bh=t9GpYR5T/MbOcfhkn+FQD5aargxAD0uAv82boDZ4aQ0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=St2rqh5gFuaF+IOmCAJ8h2iYBPeOtr/EAtVlBw8rAG+zxAxrf6KBGBa2qq/aJJZe+5u164E9zIoaAAiYjxJdgOMwfrLZXwi1Jo9i4ZWhTBsTwuHVLlcj+24c4VdlPd6CM4TVty+lsXD/jXQAJ1tzU6QzTe/GCFSx9gDA+w7OaZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dHlfl1vY; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dHlfl1vY"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4891f625344so62885435e9.0
        for <linux-pm@vger.kernel.org>; Fri, 24 Apr 2026 03:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1777024848; x=1777629648; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9cwRtmDAbT4Y+He6JfFqenlNmTZcScEAW3BnQ0sfKIA=;
        b=dHlfl1vYFONN8q0CI9JprHJtZgrZGJeqbjDPkotWso3sQREWeJ6VKPQXI2f1Qyqb3E
         3aj/hDM754wQxfKTdcRoWB95yHbiCI6FubX4dKcne4pylr4DpZhZNcV5JuijP9u38xdH
         BukRjVP9w34g69ESj4GVmH1K3ggykFNVu7BlFife63RjkeBJ097DkE2FcbYBs0yj2bDw
         +26Z+FQW7upZkwPAXLv8Af4RzthYHFUUOU+5X494Jz93TGW5FcJ965/MTCbh0MvG/w4m
         qcByPen64cF3WWDWmm+hB8PMncVZ3d6aSusyYbSt5lA1ghf/ioO3PK/IXXL6WdOyBRUi
         tTaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777024848; x=1777629648;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9cwRtmDAbT4Y+He6JfFqenlNmTZcScEAW3BnQ0sfKIA=;
        b=BKx8R59zKPYF+Jb7QYuN/2jlKj8GPpXoLCWbF0u+fIjDoPeiTg47SSZnU2W5vPBEFj
         KJAKCBkJ/oSRuRHmUBsU0TEZbq5RYn7IZZZQkp9ZUoWCJiXsuDqPkrxxonJJjayMs69N
         GdB3vzL2r7x7UY5yUKUk1LKESkRPQSaYrPaRjrooLP7Gy/sPECHdshyVslsLyyZUPiBr
         AvcwIRCxb2GHOW/9ZM5/dKgf6dp1OChPT6mNSJxTdIGH7G8ToPo4ZskUS3TOEiKw0bwM
         jlrvjNnm1ZolNPyKLT7F2l37NPv8RyowUyhb2cke5TkZSWBBuljxcHeJQGP/YiT9WBHr
         GwrA==
X-Forwarded-Encrypted: i=1; AFNElJ/29hNf/pU4AyWptDIiyHnsI4bw4p+ZI/licACZJ3EVltKxEi2Ixi/mOnV7Dphd3uzuiExWY2ONYg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxAn8k+wgiXuckLNeIA3dDE8KjMSxfdDd6uG/99S5O8WtHLU7yp
	wzLKvU+2B7W3Q+rKTnGqGcbwcHMq8igbmb3CAdOrVNjwQsP5DfJq1ulUIyJUEdO0j/E=
X-Gm-Gg: AeBDietFLsjmpcugfWU0SXyQnzqqWLD/MUsbP9hqisFz85MQA7UB79CqA1kiOCiltV7
	6L8Ys/Gq2PCBh3ku6BJwV5aghyKWBgoHXOf568trI4yDRDTkirDyKlC9Gb6GYHyMh1iq6v8SVf8
	CPjjzIm2tTHnla07zDagDFiXDsyGUNH2UW85dsWoujYATVuFLTRSXQ0UXtFRzyjXMeDk+63K6P+
	rvPstgGT97gDX8mZKYQIT9F65g6+nD/t3H7qRkjNnafUmN1F85dhxYyt7mkjnDkp7ZcdInEvEeC
	2J00J4p0mPfAeTqriqU0ewa6HpENhfcdnpfEMAc1SWcFh2fnPsABwqMNQ3kaOnMIzlhsBM8n7A2
	TbPNXvBGnK9Czx5tLOBCrWR8qShsZ6EgR5QyrQFIa4DE1ssj+ATTskl0xAnYm8F5xHIKd3GMyDG
	2G2s09QupcVu2prWSaIO8N/MfGqdtxVITtQL7iFEgx7sF/4EaBJPl2n3Eeba0IJiENBh3JkRuxL
	qTET5ej+1VhC8xLBrsRW5ZM0Qqz
X-Received: by 2002:a05:600c:1d05:b0:489:1baf:8c03 with SMTP id 5b1f17b1804b1-4891baf8d2cmr288416295e9.11.1777024847607;
        Fri, 24 Apr 2026 03:00:47 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:79e1:f56b:445c:ca9c? ([2a01:e0a:106d:1080:79e1:f56b:445c:ca9c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fb7a0b60sm169961765e9.17.2026.04.24.03.00.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Apr 2026 03:00:47 -0700 (PDT)
Message-ID: <f057dbd9-5fa7-414f-98f4-1bbb691e2fc7@linaro.org>
Date: Fri, 24 Apr 2026 12:00:44 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v4 5/8] thermal: khadas-mcu-fan: Add fan config from
 platform data Add regulator support
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
 <20260421-add-mcu-fan-khadas-vim4-v4-5-447114a28f2d@aliel.fr>
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
In-Reply-To: <20260421-add-mcu-fan-khadas-vim4-v4-5-447114a28f2d@aliel.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/21/26 13:49, Ronald Claveau via B4 Relay wrote:
> From: Ronald Claveau <linux-kernel-dev@aliel.fr>
> 
> Replace the hardcoded MAX_LEVEL constant and fan register
> with values read from platform_data (fan_reg, max_level),
> as new MCUs need different values.
> 
> Optionally acquire and enable a "fan" regulator supply
> at probe time and on resume,
> so boards that gate fan power through a regulator are handled.
> 
> Signed-off-by: Ronald Claveau <linux-kernel-dev@aliel.fr>
> ---
>   drivers/thermal/khadas_mcu_fan.c | 49 +++++++++++++++++++++++++++++++++++-----
>   1 file changed, 43 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/thermal/khadas_mcu_fan.c b/drivers/thermal/khadas_mcu_fan.c
> index d35e5313bea41..24559bf65de46 100644
> --- a/drivers/thermal/khadas_mcu_fan.c
> +++ b/drivers/thermal/khadas_mcu_fan.c
> @@ -13,13 +13,15 @@
>   #include <linux/regmap.h>
>   #include <linux/sysfs.h>
>   #include <linux/thermal.h>
> -
> -#define MAX_LEVEL 3
> +#include <linux/regulator/consumer.h>
>   
>   struct khadas_mcu_fan_ctx {
>   	struct khadas_mcu *mcu;
> +	unsigned int fan_reg;
>   	unsigned int level;
> +	unsigned int max_level;
>   	struct thermal_cooling_device *cdev;
> +	struct regulator *power;
>   };
>   
>   static int khadas_mcu_fan_set_level(struct khadas_mcu_fan_ctx *ctx,
> @@ -27,8 +29,7 @@ static int khadas_mcu_fan_set_level(struct khadas_mcu_fan_ctx *ctx,
>   {
>   	int ret;
>   
> -	ret = regmap_write(ctx->mcu->regmap, KHADAS_MCU_CMD_FAN_STATUS_CTRL_REG,
> -			   level);
> +	ret = regmap_write(ctx->mcu->regmap, ctx->fan_reg, level);
>   	if (ret)
>   		return ret;
>   
> @@ -40,7 +41,9 @@ static int khadas_mcu_fan_set_level(struct khadas_mcu_fan_ctx *ctx,
>   static int khadas_mcu_fan_get_max_state(struct thermal_cooling_device *cdev,
>   					unsigned long *state)
>   {
> -	*state = MAX_LEVEL;
> +	struct khadas_mcu_fan_ctx *ctx = cdev->devdata;
> +
> +	*state = ctx->max_level;
>   
>   	return 0;
>   }
> @@ -61,7 +64,7 @@ khadas_mcu_fan_set_cur_state(struct thermal_cooling_device *cdev,
>   {
>   	struct khadas_mcu_fan_ctx *ctx = cdev->devdata;
>   
> -	if (state > MAX_LEVEL)
> +	if (state > ctx->max_level)
>   		return -EINVAL;
>   
>   	if (state == ctx->level)
> @@ -83,11 +86,32 @@ static int khadas_mcu_fan_probe(struct platform_device *pdev)
>   	struct device *dev = &pdev->dev;
>   	struct khadas_mcu_fan_ctx *ctx;
>   	int ret;
> +	const struct khadas_mcu_fan_pdata *pdata = dev_get_platdata(&pdev->dev);

Move this on top to respect reverse christmas ordering.

>   
>   	ctx = devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
>   	if (!ctx)
>   		return -ENOMEM;
> +
>   	ctx->mcu = mcu;
> +	ctx->fan_reg   = pdata->fan_reg;
> +	ctx->max_level = pdata->max_level;
> +
> +	ctx->power = devm_regulator_get_optional(dev->parent, "fan");
> +	if (IS_ERR(ctx->power)) {
> +		if (PTR_ERR(ctx->power) == -ENODEV)
> +			ctx->power = NULL;
> +		else
> +			return PTR_ERR(ctx->power);
> +	}
> +
> +	if (ctx->power) {
> +		ret = regulator_enable(ctx->power);
> +		if (ret) {
> +			dev_err(dev, "Failed to enable fan power supply: %d\n", ret);
> +			return ret; 
> +		}
> +	}

Or you can request with devm_regulator_get(dev->parent, "fan"); which will
return a dummy regulator, and then you can just call regulator_enable & disable
and remove all those checks.

> +
>   	platform_set_drvdata(pdev, ctx);
>   
>   	cdev = devm_thermal_of_cooling_device_register(dev->parent,
> @@ -124,12 +148,25 @@ static int khadas_mcu_fan_suspend(struct device *dev)
>   
>   	ctx->level = level_save;
>   
> +	if (ctx->power) {
> +		ret = regulator_disable(ctx->power);
> +		if (ret)
> +			return ret;
> +	}

if (ctx->power)
	return regulator_disable(ctx->power);

> +
>   	return 0;
>   }
>   
>   static int khadas_mcu_fan_resume(struct device *dev)
>   {
>   	struct khadas_mcu_fan_ctx *ctx = dev_get_drvdata(dev);
> +	int ret;
> +
> +	if (ctx->power) {
> +		ret = regulator_enable(ctx->power);
> +		if (ret)
> +			return ret;
> +	}
>   
>   	return khadas_mcu_fan_set_level(ctx, ctx->level);
>   }
> 

Thanks,
Neil
