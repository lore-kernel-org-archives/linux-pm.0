Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 751693E1CE7
	for <linux-pm@vger.kernel.org>; Thu,  2 Apr 2026 15:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775144354; cv=none; b=tltGxETv4GrkE5TU5r9bYn1gUc1zLWu9QAFPeSh0YPx9wKnCkngPf1hPrxx7OueKBzafrE7aJnjXhYKcNJUPJh2X5kRywgFCJZIdkd0qiPQOabCHMHQRi5t//rbsPYSFSrF2LhZ9/02V+WLIjucPNgdW4MH/cH147/2QsmZVtzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775144354; c=relaxed/simple;
	bh=X5xP4mH4gp9Nk6yWni1CQCZV7BD84tNaYS8aUYMymWw=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=O9AZWBkZp/zrNXEc0E9sLMe4gS2lcIM6op20t9SN1Jj9DnjDpkGBL92vx515sYcVcywhi3DJMJ8IaaEC3ZfLAbg3Z4s61ZX1Xm/fKccdYyTIt2bYa9r5O2MhEuY32bXTg8vEsJIbU4+0+JzRlDj6I3oF6BFQ8aD9eZkLWTrgbKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QW4Y2tJ9; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QW4Y2tJ9"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-43b87970468so885521f8f.3
        for <linux-pm@vger.kernel.org>; Thu, 02 Apr 2026 08:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1775144351; x=1775749151; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AwqyVdkU5xmyU+XRaxwsr9L7DuUGafXosoFXRqh5wTY=;
        b=QW4Y2tJ9GyvI3ZYIflHgFzx6oC7++BpuETK+mbT7e3znsu62gjd9EHSl+OlqEREgZz
         l7NVlBuZx4+gxIMK+yPLznaftDc13c9/oqtIFyEbuBKRpt7YlHUyrSCg9JSqsSscglXm
         v3/U27gOfKuY0Z6C3GWnPeBTQwTGvGtHqBmRuoOEx8Xm1q3nEoQvTRXTGHlN5ZEqTOhd
         LMhJ6QTQ19XwqjpdkTEfqBzOcOUXmSkFBtZCkvrX2Z6BX8bfs08jjJOEKdUoV2VL1Ptk
         P1AJFwPvExaTIzHcHFj032PK9V2W6hPVN4UaT+U2BV6E5MDtfvwuiTf02yCdH/ft+7sD
         vdFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775144351; x=1775749151;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AwqyVdkU5xmyU+XRaxwsr9L7DuUGafXosoFXRqh5wTY=;
        b=HtPx9JflZYaMFQRlgTl1f6Y9mWlAzlYKb2cEQDoRc4+lbn3lioN6xwPtpA726aWl1L
         PrZggCL5GiLfYm33+F3LW8mR0MnjSqiqOyMQ211VTZFLfWY8kmkdObAZ40rZvXPq6QJD
         dKLJTRBekZ2Kg09fpV7uQb2cnQlXQ24Fnbi/Qh30QLWmCtjqi1vmOVkcESc4TGMX2ZPo
         g7XN0mjCHGQz9mwo+CFCvEoHXJCfTacPMbw1HJCYWDhQUf9cF5HEIKcuLWTeQ1zxiiRJ
         u6E1na/QN/pWFanfxtwcnMgIP8+l+p0IqVUQCEufZTU+bf8kbiv780WAumsLdvLHWI2q
         khqA==
X-Forwarded-Encrypted: i=1; AJvYcCUMNj/EpW6cJXp9fxe+ielVokJfERlZiTM70fE/UdJHqeBCtEepqAaaK4zh0v33DuQYSM8y2qN//w==@vger.kernel.org
X-Gm-Message-State: AOJu0YxDRN5lPZMVOEHOy0r/o/ZxWDdiHZal2ckLwDY544VZEFC34XVQ
	EV4Xb6pcoY3H5zRwWfOzsqHRytemR8n/vzyU0aG6JUUfrZHCFMHcMeVl/F7kA0ruyNo=
X-Gm-Gg: AeBDieutzL9d4V9iPA68x+eP1bFDqVmFW0B5M+lOh9/K2Zn0eHbK46USvbwIYD5qUu8
	04BIA4omyDHEla6OtdSpDzIPjVmB8LochDhpfFBV7emznj39Ba+WNniS9anzyErDcirqUQrUbIN
	qWuo0F84ngoPRcjtvlbjC6ZfhKoWPTUJ1NpS5OAbnHJ4BRzZchyoNBWcxrAGrgUVLGRJ3G6H35v
	A+OED+m2ZJCsavwtHcj+T9Nc1scPiHypEv9W0LCnQPRk1USCB4rmjfoNp7abIWFSKj3/+ngV+P9
	WCLn8rEnt7/C5kIBjA+7hJcnv2SXjq3VufGRCPPhmLwgDNAHPKvTKYsC+EKu2q3DJuU6X5nMLJA
	y61uBE+lJkWmsf2CoA+Eeu/f7rBS/UPxevuEchJoImnDWFUyhWI6Ucvqj+z+LXS56O9y56E1vGy
	jaT7avopznDoYhTvmncfQ9YNumPgRs0qsOXdEJzRxfJHWpDMe9bk17KrWz+dLWFEeOXAgguQtkR
	ggsEEQ=
X-Received: by 2002:a5d:5f45:0:b0:43c:fc5c:aa0b with SMTP id ffacd0b85a97d-43d150fb173mr16260734f8f.42.1775144350679;
        Thu, 02 Apr 2026 08:39:10 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:ac0e:65b8:7f89:413a? ([2a01:e0a:106d:1080:ac0e:65b8:7f89:413a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e4e52a0sm8533616f8f.30.2026.04.02.08.39.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Apr 2026 08:39:10 -0700 (PDT)
Message-ID: <5e3e8684-f893-4fb0-879e-9661820f72dd@linaro.org>
Date: Thu, 2 Apr 2026 17:39:09 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 5/8] thermal: khadas-mcu-fan: Add fan config from platform
 data Add regulator support
To: Ronald Claveau <linux-kernel-dev@aliel.fr>, Lee Jones <lee@kernel.org>,
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
References: <20260402-add-mcu-fan-khadas-vim4-v1-0-2b12eb4ac7b0@aliel.fr>
 <20260402-add-mcu-fan-khadas-vim4-v1-5-2b12eb4ac7b0@aliel.fr>
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
In-Reply-To: <20260402-add-mcu-fan-khadas-vim4-v1-5-2b12eb4ac7b0@aliel.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/2/26 16:27, Ronald Claveau wrote:
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
>   drivers/thermal/khadas_mcu_fan.c | 43 ++++++++++++++++++++++++++++++++++------
>   1 file changed, 37 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/thermal/khadas_mcu_fan.c b/drivers/thermal/khadas_mcu_fan.c
> index d35e5313bea41..55b496625e3bd 100644
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
> +
>   	platform_set_drvdata(pdev, ctx);
>   
>   	cdev = devm_thermal_of_cooling_device_register(dev->parent,
> @@ -130,6 +154,13 @@ static int khadas_mcu_fan_suspend(struct device *dev)
>   static int khadas_mcu_fan_resume(struct device *dev)
>   {
>   	struct khadas_mcu_fan_ctx *ctx = dev_get_drvdata(dev);
> +	int ret;
> +
> +	if (ctx->power) {
> +		ret = regulator_enable(ctx->power);

Seems you're missing a regulator_disable() on suspend.

Neil

> +		if (ret)
> +			return ret;
> +	}
>   
>   	return khadas_mcu_fan_set_level(ctx, ctx->level);
>   }
> 

