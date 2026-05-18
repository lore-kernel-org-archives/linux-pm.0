Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E11048A2D9
	for <linux-pm@vger.kernel.org>; Mon, 18 May 2026 14:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779113876; cv=none; b=EZXY1hAH33ywVI6mZWKPxJzQ7BMS4qIO6x6DYaGju2MBUYiXNfccQFWTzelsgkgqRmWuPHWJjlrYye9UKV2+kucHVZrDvJrkUIRJAP8hYoBBaNTHKw+kxjR6cfLUwiOkziBEqDBmHv74n2DfCrkQL9VrB+TJJ8j4KHG1kW2j9eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779113876; c=relaxed/simple;
	bh=p6t+ieUyKC8rxQyKdq9dg7btTe32mXAmgHg44ljzq8g=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=RhCZEu5h96nh+iYIbD18JYg1Z7Bmsi1dhEyfiHp/Kj/dx3yAtLj1VUWxiyu2Ysvlf/ba9loapVwKgBXl+dQwAZWpdDbS1E/JBGhUxHyjQktMRDiKTM0i4UyRx2V57e30PUIkp7GjqEeQOnUXf9sGYbNX18I5yHdf8hhs8sSR8GY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nUWJ2vCU; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nUWJ2vCU"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-45e7c636e74so767991f8f.0
        for <linux-pm@vger.kernel.org>; Mon, 18 May 2026 07:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1779113869; x=1779718669; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ap6+yPzKT0WeFxFH9OI4zXlnbIBpH1fA8AyGWnx8G38=;
        b=nUWJ2vCU8btkPVm9oZN27LcaL9NxFcBOXLPD/8whEpMVrX8zjl9KeIXnZ89O1tRoh0
         o1+5zEkReku8Z79u1sh9DylkeAECzFzpf3m+UkD9Sn3WvuNEscTZApAbfMWDUeqaG3zJ
         AF7wJLsyRxGFkes93sC9VwSFFClv+ZjFIZMcwHWo05KXeuZv2U1HafztCFRajWGd7lj0
         qeGt6BTbFvWOUC2WuU5fKNP142YEor9fa0T8HLCtw31ZpqibWxM/YnDWKKcyCqIArKJQ
         81wMMHLarY8dzgVMDAIRZ5WjvuXD8Y8sRpTLCXjuXaVXjFkJPrqRjJfwEM0YnTkBjJRc
         D/FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779113869; x=1779718669;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ap6+yPzKT0WeFxFH9OI4zXlnbIBpH1fA8AyGWnx8G38=;
        b=s3vAW4WhNSHTNaLk12kl+iYKTsLuXJCGUYCjUXZVu516zjfTldm2wKUMiSzgpZuq28
         SfpZJi/DCYk01eZ61B5nDwm4ceEniSxWPSBMUNI+XP5qI0WNA+MFF2WNXah0cyAdv7UE
         8oFCisXyFpnrEuKz0V8B5WfDCELNAVhl2GMFvm9JyfT+VuvDmqx/ClvZqfAgM5sWJ0Wk
         SQKg9gsNMwV/TtXZPSbf/QsYUTphwpjYjhHdewL1jUy1RqnW6Q5pN0MkdiQZeiUcyMev
         QPgjI7nUTx07APcy5rUeKTL4vrxHz/J0MhCyH3K+5wKgpHUkto63rknAD0eDE3bF8mGa
         vgUw==
X-Forwarded-Encrypted: i=1; AFNElJ+JcncCS4H59NXhrw/d9OS3BYw3ysYI81FRoY80YCGe6c2WXRYmje3z16k2p9w+AysTSej2f7jOBw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7Xa3mOXbl00DdOq+jbae1/70tqdMo57tkKX7F+qPueCj8PcNu
	mUoEdk893DwUzOXzuY7Oa/sAOupqg28tF9YBPlBi3ADUYPAv/30elTje1t+9QbKe3nc=
X-Gm-Gg: Acq92OEQXp0PnmEE7PWzq1+Lb1tTTQNWiet91blH/81BFF+6OtRS1kesgzWemVCARpu
	Hmrxc3GfZ6XxMtsyy9lIowCWKVdwR53sIbrcIRTDy+5Ant/FGquwx18UcT3MouAmWAwwURrgYR0
	JNdPljQ5n4vtY8y6nJbEob8LmW1Gwuc+oIYpMDuqGdQ2jneKn0IVaiqYj4opsZiILOQ33BTlSrm
	uneUQV7bG6Kj6Hncsp2towss4Y68lbGbKMNdU39r/thORFUwOe/5P2/9GNKZSvigVIpfRgcmnYy
	N4BsYY1DRz/LsocHit/Z5QOoXqtWlr2AhEyuOoFPmSxUHhi3adcxZGcscA1XZnabbkgMBJL+tFf
	5BARrvfWlgawHOjslpycV2zy1IEAeJlt3g5xAwz7F1R6MLBJmBgKcyoZx2z0hBW/SGq5zCpGUOV
	IQl67ypjk62JgcKHiTxvWwH6nMbmLrqrs5qEadaCL8j1bHObuQCxj5SGrTdui/UOrOiYZtY43PZ
	18XvDk=
X-Received: by 2002:a05:600c:4e46:b0:48f:e230:8cab with SMTP id 5b1f17b1804b1-48fe6626cfbmr237786615e9.31.1779113869320;
        Mon, 18 May 2026 07:17:49 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:1029:e3c5:362e:1250? ([2a01:e0a:106d:1080:1029:e3c5:362e:1250])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4900c16c62dsm66435415e9.11.2026.05.18.07.17.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2026 07:17:48 -0700 (PDT)
Message-ID: <4df49ad2-797b-4971-a8a9-13fd438e7c6f@linaro.org>
Date: Mon, 18 May 2026 16:17:47 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v6 0/8] Add VIM4 MCU/FAN support
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
 Conor Dooley <conor.dooley@microchip.com>
References: <20260516-add-mcu-fan-khadas-vim4-v6-0-cccc9b61f465@aliel.fr>
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
In-Reply-To: <20260516-add-mcu-fan-khadas-vim4-v6-0-cccc9b61f465@aliel.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

On 5/16/26 19:17, Ronald Claveau via B4 Relay wrote:
> The Khadas VIM4 board features a different MCU variant compared to
> previous VIM boards.
> While it shares the same I2C-based communication model,
> it differs in some ways:
> 
>    - A distinct register map with its own volatile/writeable register set
>    - A fan control with 0–100 levels instead of the 0–3 levels previously
>    - A fan power supply gated through a regulator
> 
> This series adds support for this new variant by:
> 
>    1. Refactoring the khadas-mcu MFD driver to use per-variant data
>       structures (regmap config, cells, fan platform data),
>       and adding the khadas,vim4-mcu compatible string.
> 
>    2. Extending the fan thermal driver to retrieve the fan register
>       and maximum level from platform_data,
>       and to optionally manage a power regulator for the fan supply.
> 
>    3. Adding the corresponding DTS node for the VIM4, wiring the MCU to
>       the I2C AO_A bus and exposing it as a thermal cooling device.

I will directly pick patch 6 now, and patch 7 & 8 later when patches 1,2,3,4 are picked
by the i2c & mfd maintainers.

Patch 5 should not be applied without path 4.

Neil

> 
> Signed-off-by: Ronald Claveau <linux-kernel-dev@aliel.fr>
> ---
> Changes in v6:
> - PATCH 4: Address Lee's review comments:
>    - Use an enum to discriminate between MCU types instead of passing
>      MFD data through the DT match table
>    - Fix error code from -EINVAL to -ENODEV when no MCU type is matched
>    - Make khadas_mcu_fan_cells and khadas_mcu_cells const
>    - Use dev_err_probe() for regmap initialization error
>    - Document fan speed levels for max_level
> - Link to v5: https://lore.kernel.org/r/20260424-add-mcu-fan-khadas-vim4-v5-0-afcfa7157b23@aliel.fr
> 
> Changes in v5:
> - PATCH 5: Replace devm_regulator_get_optional() with devm_regulator_get()
>             to simplify error handling and remove NULL checks, also
>             ordering as reverse christmas according to Neil's feedback.
> - Link to v4: https://lore.kernel.org/r/20260421-add-mcu-fan-khadas-vim4-v4-0-447114a28f2d@aliel.fr
> 
> Changes in v4:
> - PATCH 1: limit fan-supply property by compatible according to Conor's feedback.
> - Link to v3: https://lore.kernel.org/r/20260417-add-mcu-fan-khadas-vim4-v3-0-a6a7f570b11b@aliel.fr
> 
> Changes in v3:
> - PATCH 1: adding comment on vim4 compatible saying it is not discoverable,
>             thanks to Rob's and Neil's feedback.
> - Link to v2: https://lore.kernel.org/r/20260403-add-mcu-fan-khadas-vim4-v2-0-70536b22439a@aliel.fr
> 
> Changes in v2:
> - PATCH 5: Add regulator_disable on suspend thanks to Neil's feedback.
> - Link to v1: https://lore.kernel.org/r/20260402-add-mcu-fan-khadas-vim4-v1-0-2b12eb4ac7b0@aliel.fr
> 
> ---
> Ronald Claveau (8):
>        dt-bindings: mfd: khadas: Add new compatible for Khadas VIM4 MCU
>        dt-bindings: i2c: amlogic: Add compatible for T7 SOC
>        mfd: khadas-mcu: Add per-variant configuration infrastructure and VIM4 support
>        mfd: khadas-mcu: Add support for VIM4 MCU variant
>        thermal: khadas-mcu-fan: Add fan config from platform data Add regulator support
>        arm64: dts: amlogic: t7: Add i2c pinctrl node
>        arm64: dts: amlogic: t7: Add i2c controller node
>        arm64: dts: amlogic: t7: khadas-vim4: Add i2c MCU fan node
> 
>   .../bindings/i2c/amlogic,meson6-i2c.yaml           |  13 ++-
>   .../devicetree/bindings/mfd/khadas,mcu.yaml        |  18 ++++
>   .../dts/amlogic/amlogic-t7-a311d2-khadas-vim4.dts  |  13 +++
>   arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi        |  20 ++++
>   drivers/mfd/khadas-mcu.c                           | 119 ++++++++++++++++++---
>   drivers/thermal/khadas_mcu_fan.c                   |  37 +++++--
>   include/linux/mfd/khadas-mcu.h                     |  44 +++++++-
>   7 files changed, 236 insertions(+), 28 deletions(-)
> ---
> base-commit: f7b64ed948718290209074a50bb0df17e5944873
> change-id: 20260402-add-mcu-fan-khadas-vim4-ac1cbe553c9b
> prerequisite-message-id: <20260326092645.1053261-1-jian.hu@amlogic.com>
> prerequisite-patch-id: f03a086b4137158412b2d47b3de793b858de8dde
> prerequisite-patch-id: 123970c9b29c2090440f2fd71c85d3c6fd8e36de
> prerequisite-patch-id: 3e2e56b0926ba327b520f935df4ced5089bbe503
> prerequisite-patch-id: 65a5d76ffdbc9b3aab3385bb65cb027004c30e7e
> prerequisite-patch-id: 237269801826dd3ad7fb16eb4d7d6d4eab504278
> prerequisite-patch-id: 57e9b08a968aedf543d3d0d56cf1ca4db20b2a16
> prerequisite-change-id: 20260326-add-bcm43752-compatible-e264a4f7973a:v2
> prerequisite-patch-id: cd98b74fa56af72af2553f391c400981d83cd4f4
> prerequisite-patch-id: b730f5e42be1d89d193e63a0265495cdbf2c7d7b
> prerequisite-change-id: 20260330-fix-invalid-property-bbe54d933f71:v2
> prerequisite-patch-id: 8d675e7a239985c762843515b241f0a2f45f9c92
> prerequisite-change-id: 20260331-fix-aml-t7-null-reset-2b608ebf9da4:v1
> prerequisite-patch-id: 5b5de77af11747ce964404fb827d2ee2bff47ea5
> prerequisite-patch-id: 1e37fc75fed1e533adee0f3e7e6ead1f8ff3c55c
> prerequisite-patch-id: 65a5d76ffdbc9b3aab3385bb65cb027004c30e7e
> prerequisite-patch-id: 2daf583fb5e7449a02bd217d8aca330171b598aa
> prerequisite-patch-id: 237269801826dd3ad7fb16eb4d7d6d4eab504278
> prerequisite-patch-id: d1ddf9b7710e91f8062de83bd7ba55afb2c4c112
> prerequisite-patch-id: 57e9b08a968aedf543d3d0d56cf1ca4db20b2a16
> prerequisite-patch-id: cd98b74fa56af72af2553f391c400981d83cd4f4
> prerequisite-patch-id: b730f5e42be1d89d193e63a0265495cdbf2c7d7b
> prerequisite-patch-id: 9debd88fa60febed9cd7208f86603b4c2d270520
> prerequisite-patch-id: 314ef9ff0c4d1d15dab1dea9d92aa065f1eac3e9
> 
> Best regards,

