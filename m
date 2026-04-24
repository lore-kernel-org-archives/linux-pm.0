Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84BD3342CA2
	for <linux-pm@vger.kernel.org>; Fri, 24 Apr 2026 09:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777024519; cv=none; b=cR4ueTqVK9QpaClXMxajdZmQ4DfMEGhwokOS0/vjDEuqdIbItFZWbudlFFp2ZXBC2Icp4IzUHOxPsSsEbfQBrFbYoEKcH+/X5We//mDWcgfCGNaXuzWZvsK9P/Kw3DiR7/mPYAGo9oRHBYes1TECTMZ7A0RG6hruhD7oee4ZI68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777024519; c=relaxed/simple;
	bh=jRMM/hN8U1NhGO9xpDfgyFzsl6yuuvYEuypvB1mVf20=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=ELjLeRN4M08+cVnNhxiTgDB8lOZH55qeNE1i2yRSi3tpC2vZ0QoPmlogix4VHizIFFNKU7k9mTy94rBRJmJTejk1DwMHfroPyPbtE+qszlEy49cd7CXUJXVGoWGb8Cy8GRfg0QNoO3ZgIGv5Qmu2R9XZNeULgQ9IXr/4oJD1jaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lBI1Xh8s; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lBI1Xh8s"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-48a563e4ef7so41497085e9.0
        for <linux-pm@vger.kernel.org>; Fri, 24 Apr 2026 02:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1777024516; x=1777629316; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e+of0FE0tSbmaf7cezfG/Dp70p8BpOoi594bsa5N30Y=;
        b=lBI1Xh8sAV7sTCdwuXchyqeOFX3nHuRDVMqyYHDLNidoLcaF0RshABFEGznBGzQ/Ib
         X/jQoJeY4pa/oH+vabzeTBIU8RBk0cgqiMqA9uslitiRfQat/bDAvd9t2Ajr2TGCEVwc
         3Wuz8CULk3dtKI/MuU/3+lX8KEFR1L1cC4GK01jiAiLY8VWcP4I3aVaHb/VZdNia/gcc
         UPlELyI+45RxECpOPImegZzy2RbVj8iKkwMA7Z/Zx4/Z/Q3uIAMJ+x4VvBthw0jXBXyT
         topd7WlIMFXOCfc5Axz66vi5B2nFOPg5Xk8yUNYryGduRxfLWz871uIMOt2C8Xk04RZ2
         GwZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777024516; x=1777629316;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e+of0FE0tSbmaf7cezfG/Dp70p8BpOoi594bsa5N30Y=;
        b=hNwHksSZVWGpvQ4197vq9sGrUqNjIMzcj9kn5mu4zjPKRuJ4FVY9nk/onsZjSH80OU
         g54gH4qlO7g4vq0BOcHOUgsjIOagO4bwwG0ogDW6Ai9p3XELEzjEUwzuXiDnxGvo1eFT
         vri/XDV+lLyMoXsuMa3ajIO9Bovr7XGcLOmcf0lkKZO/C39P5XG61hj4/7eihV8qb17j
         qDHZHuvszDS3/bfmuEzoOIWjbDT4vTfIaU2Zfke7eq+ZubwuTxrl8DjHpOZajv1wKwaZ
         xai0V8LgP5UxLnbdFHJtqwXvE4GjKBEIsFDzhdr0q6dVK8FgfVhZGYIhHFsR0BNQk2e5
         sRjQ==
X-Forwarded-Encrypted: i=1; AFNElJ9yZxYnS5TgJzs8q7ib7Sp8NMYwmGhFb2BM9zXlW9292Op5KTJ934q6ACZnWghbpDEw6nxw0u8j5w==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywpxl/yEKDg/fsxZF7agj2hCFralkMstLPAICTqATecei5WKi0Z
	/p65vIDGLkIJdpw9+mQm7yLsb4ZYNbOBTG8q2hk9SI/VfYSTf45uB1bzQEA7kvblu6E=
X-Gm-Gg: AeBDiet8dVai6veR7/0Dd0RJHAfOFkyHGYqBXWk6sO4FDjg5XSQNz+Ue9W/aNeS+N0t
	PWPBouTTMav/x32O/fFmhb9BZ3ckY+PJFsiKXiBOtE0j03+JtxpNOmSkE97OptYEir+SebsJUAV
	N4OsgAj03zZeBCOcldLj9dil2H5K0WxIm9GrfFChZqrArVFvF66oJ0P+2v3S5MoMnpNw+v6oLf7
	jrRkteFBPKmP1UxpfW+CSm4U8MqaZHCYgz/9nZJM8a9Nbg53JgNrTeQxxqkvJrdvXaaJZoXSeof
	+F7gpa98GLG6QX+Vo+F6FqkhHmwuUbi+oP8Kf7sWeIEeOdlGE/LJd68dt40bYLY/1pP6ydhl/RT
	/PPzHpKvYExeWJDkvLh3QURkBv4fX5POl+Wmrf2C0+yaHcjNvcf2q0mpKCoVAy5FAQ53Uw0cn4K
	qJFIXJwuDkJLHMXshr7a6gYnwD3sutp0Z/dsnqj6CCsqqwMM/LNVM951ihIunJUZaiA4ngw0J/c
	UTwkvr+AIj0WlIHjQ==
X-Received: by 2002:a05:600c:888b:b0:488:c40b:c8bf with SMTP id 5b1f17b1804b1-488fb73d234mr372911565e9.2.1777024515945;
        Fri, 24 Apr 2026 02:55:15 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:79e1:f56b:445c:ca9c? ([2a01:e0a:106d:1080:79e1:f56b:445c:ca9c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc18bccfsm526904435e9.8.2026.04.24.02.55.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Apr 2026 02:55:15 -0700 (PDT)
Message-ID: <afd6b8b9-06b5-41e1-9b3e-e4a896d77f8c@linaro.org>
Date: Fri, 24 Apr 2026 11:55:14 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v4 3/8] mfd: khadas-mcu: Add per-variant configuration
 infrastructure and VIM4 support
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
 <20260421-add-mcu-fan-khadas-vim4-v4-3-447114a28f2d@aliel.fr>
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
In-Reply-To: <20260421-add-mcu-fan-khadas-vim4-v4-3-447114a28f2d@aliel.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/21/26 13:49, Ronald Claveau via B4 Relay wrote:
> From: Ronald Claveau <linux-kernel-dev@aliel.fr>
> 
> Introduce a per-variant configuration structure (khadas_mcu_data)
> holding the regmap config and MFD cells,
> selected at probe time via the of_device_id match data.
> This makes adding other variants straightforward.
> 
> Also introduce khadas_mcu_fan_pdata to pass fan register address and
> maximum level to the fan sub-driver, removing the hardcoded constants.
> 
> Signed-off-by: Ronald Claveau <linux-kernel-dev@aliel.fr>
> ---
>   include/linux/mfd/khadas-mcu.h | 39 +++++++++++++++++++++++++++++++++++++--
>   1 file changed, 37 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/mfd/khadas-mcu.h b/include/linux/mfd/khadas-mcu.h
> index a99ba2ed0e4e0..75e275d3fa8d9 100644
> --- a/include/linux/mfd/khadas-mcu.h
> +++ b/include/linux/mfd/khadas-mcu.h
> @@ -70,6 +70,13 @@
>   #define KHADAS_MCU_WOL_INIT_START_REG		0x87 /* WO */
>   #define KHADAS_MCU_CMD_FAN_STATUS_CTRL_REG	0x88 /* WO */
>   
> +/* VIM4 specific registers */
> +#define KHADAS_MCU_VIM4_REST_CONF_REG		0x2c /* WO - reset EEPROM */
> +#define KHADAS_MCU_VIM4_LED_ON_RAM_REG		0x89 /* WO - LED volatile */
> +#define KHADAS_MCU_VIM4_FAN_CTRL_REG		0x8a /* WO */
> +#define KHADAS_MCU_VIM4_WDT_EN_REG		0x8b /* WO */
> +#define KHADAS_MCU_VIM4_SYS_RST_REG		0x91 /* WO */
> +
>   enum {
>   	KHADAS_BOARD_VIM1 = 0x1,
>   	KHADAS_BOARD_VIM2,
> @@ -82,10 +89,38 @@ enum {
>    * struct khadas_mcu - Khadas MCU structure
>    * @device:		device reference used for logs
>    * @regmap:		register map
> + * @data:		pointer to variant-specific config
>    */
>   struct khadas_mcu {
> -	struct device *dev;
> -	struct regmap *regmap;
> +	struct device			*dev;
> +	struct regmap			*regmap;
> +	const struct khadas_mcu_data	*data;
> +};
> +
> +/**
> + * struct khadas_mcu_data - per-variant configuration
> + * @regmap_config:	regmap configuration
> + * @cells:		MFD sub-devices
> + * @ncells:		number of sub-devices
> + * @fan_cells:		MFD fan sub-devices
> + * @nfan_cells:		number of fan sub-devices
> + */
> +struct khadas_mcu_data {
> +	const struct regmap_config	*regmap_config;
> +	const struct mfd_cell		*cells;
> +	int				ncells;
> +	const struct mfd_cell		*fan_cells;
> +	int				nfan_cells;
> +};
> +
> +/**
> + * struct khadas_mcu_fan_pdata - fan sub-driver configuration
> + * @fan_reg: register address to write the fan level
> + * @max_level: maximum fan level
> + */
> +struct khadas_mcu_fan_pdata {
> +	unsigned int fan_reg;
> +	unsigned int max_level;
>   };
>   
>   #endif /* MFD_KHADAS_MCU_H */
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
