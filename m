Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EAF854704E
	for <linux-pm@vger.kernel.org>; Fri, 18 Sep 2026 09:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789722352; cv=none; b=OorS9E8DRu2KwJLFKUXRA0o6F7rOGaVKO8DRP7OvdhLsXy3E1PruRAr8wcUV4+Cuh5uCWBW+66Uv/LHYkQSyZOCslCnkC554HAPNt/N51g5EBu6XvNqXeDHhnB/awof6tHMWeAWE0aw+XQdpWhBago/WgNzyugRpqAj4kUAVhXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789722352; c=relaxed/simple;
	bh=Ej4swH6U/hn+2J3iilCARYgFatpiiV0z/ciLvDehIOY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=B/MGrEm5+zj3YUhfUnfL3inkGC9l0R62UIqEtlS+TJzTGSr8TYzSE9gOzgwRrIJ1+G65P57yi7o5Y6TwYAzKml3kfmoUtoll6+0XR+m0VkZu5NO/kG6A+Rh+fUb7rYkzki/sxzAWZ5jBnh7Z5tBsLrVxOH5LdD4AyBZ7cKo/aus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NYK7ELnr; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NYK7ELnr"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49b912d3920so3510905e9.1
        for <linux-pm@vger.kernel.org>; Fri, 18 Sep 2026 02:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1789722349; x=1790327149; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :autocrypt:content-language:references:cc:to:subject:reply-to:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7uSQneWyD9u8uXUDCmfCQSOWQMsG1MluBHm0qVsycCg=;
        b=NYK7ELnrTbVX7If3tsGOXjSYXB9pZrvVLZ6rSVnhml8kNBQ0WOWWGhV3VEtNkzamVu
         89GGV9Y5woYv8iSbWV4fIMlMv5YU/q5Ah63Eci0mtaZqFq/pGRBBmlPtgLS8dcCq6G/C
         Tq90jKhAsNbCQq2SiySH3oIxzftz6rrrLWFMhgaZWLle1CDAVQo/r+UVTp4YpaYMvtNP
         n+lfdrEvLEcga0AzS2CCMhDmcjzrvzS0bayKOnZMF+1QfFGrlKP9ZK1iscF5+JIW763Z
         60OTlAY/EH/8rK90pwiaLi52g8LtRJtMp/nSaxSF12gWjD7xjvrUpv4T7kHOc1FUFhrZ
         fkGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789722349; x=1790327149;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :autocrypt:content-language:references:cc:to:subject:reply-to:from
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7uSQneWyD9u8uXUDCmfCQSOWQMsG1MluBHm0qVsycCg=;
        b=uINFvrgzBbgyA3Y7pE6gP23JZIBpoQDp/wVOBXuO26CLj2F1FAKph3yy/AzvZ9dwtk
         OmkXP8P3/KhBB7CHAPSAyCqgd5eqKnxMCN86ARw16qnnQqhHC3+m3j0QL5+NgxDp+gQ+
         rALdz0qhJ9suKuUHw2tjEUKB06NWWPggE+tLtxeHal6IajJ6WoStkHbLHhlyc2pvBtGG
         KFoXYonI6TDYxC0K0vslbKXiTrJlA8SjODLrIH6dOArTJAA5RGAJa8GnFkO/MWE6GFdX
         cYTADll/gvxm4YM/5RTjlc9IywZ/09DaPxVnJeaHkD29tjobWt2+gUGNGh4QfPXj/dY0
         XXLg==
X-Forwarded-Encrypted: i=1; AKwUvBwx6/wh/6Lz0grBr7YZMiUXxJCYzzCV1Ro7fsdMJhExVrwOfO/IctLCXAWtlk61Dcoh+E6WTbd7Lw==@vger.kernel.org
X-Gm-Message-State: AFuF++mo50EObofeoJsVEgrZK1BbQuZwLsQ8129DTThlA+voy68I3Sli
	tFD4ztoY7AIZrpwZgkRKeO10ahB4oHx8Gmp7kJN2MhVWGStJaH//mBqPkWkgFKahdz8=
X-Gm-Gg: AYBFou2N4E/dlMpHiLnARtaTZyxHUjLv+dbU+o0VfEY/TsStbAj8qZbtOawvWo5P9/B
	0zXXwXzX8lo+x/NU+mSpGvaxIrsqEgqfw1Udv8GudgVs+GdQz7+PgboPLodavQtNNVEk74DO/Ty
	o/gyEhJ/CbBasibyj7tx4mehjJWU+mvAc0XnHNh56cMNcIYqx68qM7qd8mQIjT7/Gf3kNUKiGks
	XSp2YU2TxcIFRh0sL3JKa1TBEM8nkPCnifbLR/3pCiNu13D4NJBYgMNzh2Dbk9IqWvAsXoaCRJc
	eUoNXsiRSn+HRP9d6n7ZT9Pb88bax2va/rRMU317VeFHKB7c6hjxT+xFdx3PMT+frzzyOXH3LWM
	gJk4si+23BgsysRiC+Dac7OSArGIB35U/LPgkhP20CGGVsHf5HYU1/pVVdoY/YC3kZsh3TApOrk
	PldJWFYcS1dDKUcuRtppSt8KwgoUKgCOO+seRDMi4JBxpOhAJ0Lx+txsyiiIuEJqUDxjvIiGvV7
	g2qb1L6Uka6Lll9G+gzEHb8DYAS8OWpiPr9O11Im65f5D6UiZeSOg==
X-Received: by 2002:a05:600c:1f8f:b0:49e:8354:26fb with SMTP id 5b1f17b1804b1-49fc574c729mr22905995e9.32.1789722348545;
        Fri, 18 Sep 2026 02:05:48 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:c55f:cb91:1ca5:54dc? ([2a01:e0a:106d:1080:c55f:cb91:1ca5:54dc])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fc471b9a2sm26149925e9.0.2026.09.18.02.05.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Sep 2026 02:05:48 -0700 (PDT)
Message-ID: <43f75100-b255-462b-aed2-b3f19fb19342@linaro.org>
Date: Fri, 18 Sep 2026 11:05:46 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v12 2/6] mfd: khadas-mcu: Use MFD_CELL_* macros for cell
 declarations
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
 linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
 mfd@lists.linux.dev
References: <20260917-add-mcu-fan-khadas-vim4-v12-0-497cd543a148@aliel.fr>
 <20260917-add-mcu-fan-khadas-vim4-v12-2-497cd543a148@aliel.fr>
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
In-Reply-To: <20260917-add-mcu-fan-khadas-vim4-v12-2-497cd543a148@aliel.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/17/26 09:59, Ronald Claveau via B4 Relay wrote:
> From: Ronald Claveau <linux-kernel-dev@aliel.fr>
> 
> Convert khadas_mcu_fan_cells[] and khadas_mcu_cells[] to use the
> MFD_CELL_NAME() helper macro instead of open-coding the struct
> mfd_cell initialisers. While at it, make both arrays const since
> they are never modified after initialisation.
> 
> This is a pure cleanup with no functional change, done in
> preparation for a subsequent patch which will need to attach
> platform_data to the fan cell.
> 
> Signed-off-by: Ronald Claveau <linux-kernel-dev@aliel.fr>
> ---
>   drivers/mfd/khadas-mcu.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mfd/khadas-mcu.c b/drivers/mfd/khadas-mcu.c
> index ba981a7886921..0e74efe14f367 100644
> --- a/drivers/mfd/khadas-mcu.c
> +++ b/drivers/mfd/khadas-mcu.c
> @@ -75,13 +75,13 @@ static const struct regmap_config khadas_mcu_regmap_config = {
>   	.cache_type	= REGCACHE_MAPLE,
>   };
>   
> -static struct mfd_cell khadas_mcu_fan_cells[] = {
> +static const struct mfd_cell khadas_mcu_fan_cells[] = {
>   	/* VIM1/2 Rev13+ and VIM3 only */
> -	{ .name = "khadas-mcu-fan-ctrl", },
> +	MFD_CELL_NAME("khadas-mcu-fan-ctrl"),
>   };
>   
> -static struct mfd_cell khadas_mcu_cells[] = {
> -	{ .name = "khadas-mcu-user-mem", },
> +static const struct mfd_cell khadas_mcu_cells[] = {
> +	MFD_CELL_NAME("khadas-mcu-user-mem"),
>   };
>   
>   static int khadas_mcu_probe(struct i2c_client *client)
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
