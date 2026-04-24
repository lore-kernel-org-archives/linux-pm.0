Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F9253264E2
	for <linux-pm@vger.kernel.org>; Fri, 24 Apr 2026 09:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777024367; cv=none; b=VsOy5kuuyCzciu0skIVtEqFq8c+cK9RV7ex45K6oDvmBfZ5zMn+9WEYUnD4GL/UY7VQ9rnLANgEyvAaBJU7Q5XfmSY94puWDYmYGXhBXt1cE0oDsrkIlamxueYKsPV2wGBj2rmexTEEDzhpQ8936aRKWLqEkXr2pB3KG/nGxBQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777024367; c=relaxed/simple;
	bh=5bYaiZfMdKnvObHoH0/u5S0m6lVRbfeApzAjflJzhco=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=V9gfOgkV/puRy/Eu+UMTad4tXNOxLUT4kwhcoaEW85FjnGJ+dbaLY2t4supjHxweYeMVzG+ygM3qvrxR5oxJ3mldl8Yqo/EYQ8TCIC7QdTvzNvvd6F+k1QYePyUN4A6yP7KYiUub742hsM3As6oglhxvEaXOEQn//14usxdS6gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=edt3Wv98; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="edt3Wv98"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4891d7164ddso34720505e9.3
        for <linux-pm@vger.kernel.org>; Fri, 24 Apr 2026 02:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1777024365; x=1777629165; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EsX8mB8kXzV2ktDRmOdWBbgr/FAAsBVBHTUYMUDzRZI=;
        b=edt3Wv98Sch0Et6/oXREplspanzLoNkAJ58HwKwwNV/DruaWOn1BUx6wQ4D0P2gtOI
         /ShCV6ZZbYe7IMYezdc5z0bAkUF8zjCOxid6SG7Qr3JJ2ZUl6a6tltA5DngP7ddb9/Et
         /d0vmF5GZW+YUT+onyWKhxyN8hKaJxqvtLcf3/DwDC+lwk3rjQ9S2Ae0N+VSV8Kcce93
         ZVKpBcx+k0kT5CxevOEgNgRhIQ7H6o1rQciHwErTrxfQu/Y9mLXcixxJSMgvuKMaau8U
         SzOd4xVpC9AJIQ3gFTEA4bllZL+57tvNGuKoXQcW2GDU5SqWtLi341cLEzqyiAoeGSFD
         Z0dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777024365; x=1777629165;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EsX8mB8kXzV2ktDRmOdWBbgr/FAAsBVBHTUYMUDzRZI=;
        b=CV1/K6TfBJgoU3gz6OY2weLAJaYi3bAPFNLivStEZVipaBn0zyVetobMyZB7XtcDxz
         C510EOhsd4e4YvyQwbbXSqUvcyHw5Ta5ge9xQLoGl5xHPA/G+++GnPLIZaKnJi2jvLVs
         Zms7p6pIwVVrkR4eJxZabdVityHW0LYE/fiERKvrtLswmFpoSiCfJfU3L7Hty/5px8l/
         HcpWY9vvSbxKuCyvriZh6Qzpe1z6Ksn5ao2usES6g613b/aINPl4zzIJs9/RtUdilfN6
         knPslLGzkI3aXpTcYDbDCe2d2dBSoTN0CK1lH5JLhdqfOR5uLGGYD7zHT4JMc/MA3OLN
         eCzA==
X-Gm-Message-State: AOJu0YxaPoMmXp5RHwmKpY41r6XFIRgwo3YzCGg5LbHfx0cDasX5r0az
	aEtsT2ruEhBu6dgG/bFqSqx5KjEwCpd4tnqI5TVqQk4IFqbJXReXQ7QQBGpzobiNQrs=
X-Gm-Gg: AeBDieucpkSkXmLoLgZykCTZdg4I3tTiNvIZET9RjuCsyjjVdHNPWIGYDrR+2hgNTzU
	Opzywu6O+eSZha2m4I3tK0ccUZC2lvD4qKL8VapY9hzvh56eo2VLd9XCGBt7CGtyZ2f9UsqK4KT
	cYSK8O6zXjJvVt/O1Fd+1eKNPHswgUKmgq/JeqQ4Q2fl7OltPM8B05pwAe0NrgWOUg4X9bKSsUC
	LGlXJBs1A6LvavKalSHIRhE2KNA9WM9fPW0+D0lpVIC8kEAGgYp49Ddn6uLyY+EJnq+fGheAcGb
	jEFE0Sn2K7/0teQ9r2vIQvQR3UCa+CLrQe8PRZFjF5cs+IB2z5NNegTKnm+tqlo0/OdIll+jQpp
	KZLoY4etX5iFfzFMerH8GxrN5M72UvxlDkJLwQtJWKuj+euS4uN+lyadlTTfqiYjV1bMafa0lZl
	Bg20ApG4Xld4w0upC9w+AwBFnIgNarOn0EWM19W+qyCzQ/B+AluQVa6lKZkRCI0QqyH1IfQWuNW
	m+IZr43yQvOF/boSg==
X-Received: by 2002:a05:600c:a108:b0:480:69b6:dfed with SMTP id 5b1f17b1804b1-488fb78ba6fmr374022025e9.24.1777024364611;
        Fri, 24 Apr 2026 02:52:44 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:79e1:f56b:445c:ca9c? ([2a01:e0a:106d:1080:79e1:f56b:445c:ca9c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4891cc84a1bsm141108575e9.0.2026.04.24.02.52.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Apr 2026 02:52:44 -0700 (PDT)
Message-ID: <80f93779-17fd-4fab-a887-b5f88e82b2d7@linaro.org>
Date: Fri, 24 Apr 2026 11:52:43 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v4 6/8] arm64: dts: amlogic: t7: Add thermal sensor nodes
To: linux-kernel-dev@aliel.fr, Guillaume La Roque <glaroque@baylibre.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Kevin Hilman <khilman@baylibre.com>,
 Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-pm@vger.kernel.org, linux-amlogic@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20260423-add-thermal-t7-vim4-v4-0-d4c1528d5044@aliel.fr>
 <20260423-add-thermal-t7-vim4-v4-6-d4c1528d5044@aliel.fr>
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
In-Reply-To: <20260423-add-thermal-t7-vim4-v4-6-d4c1528d5044@aliel.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/23/26 18:07, Ronald Claveau via B4 Relay wrote:
> From: Ronald Claveau <linux-kernel-dev@aliel.fr>
> 
> Add six temperature sensor nodes using the amlogic,t7-thermal compatible:
> a73, a53, gpu, nna, vpu, and hevc. Each sensor retrieves its calibration
> data from the secure monitor via the amlogic,secure-monitor phandle with
> the corresponding tsensor_id argument.
> 
> Signed-off-by: Ronald Claveau <linux-kernel-dev@aliel.fr>
> ---
>   arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi | 58 +++++++++++++++++++++++++++++
>   1 file changed, 58 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi b/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi
> index 7aec65f036a9c..62f259b2b17d2 100644
> --- a/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi
> @@ -656,6 +656,24 @@ sec_ao: ao-secure@10220 {
>   				amlogic,has-chip-id;
>   			};
>   
> +			a73_tsensor: temperature-sensor@20000 {
> +				compatible = "amlogic,t7-thermal";
> +				reg = <0x0 0x20000 0x0 0x50>;
> +				interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&clkc_periphs CLKID_TS>;
> +				#thermal-sensor-cells = <0>;
> +				amlogic,secure-monitor = <&sm 1>;
> +			};
> +
> +			a53_tsensor: temperature-sensor@22000 {
> +				compatible = "amlogic,t7-thermal";
> +				reg = <0x0 0x22000 0x0 0x50>;
> +				interrupts = <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&clkc_periphs CLKID_TS>;
> +				#thermal-sensor-cells = <0>;
> +				amlogic,secure-monitor = <&sm 2>;
> +			};
> +
>   			pwm_ao_ef: pwm@30000 {
>   				compatible = "amlogic,t7-pwm", "amlogic,meson-s4-pwm";
>   				reg = <0x0 0x30000 0x0 0x24>;
> @@ -770,6 +788,46 @@ sd_emmc_c: mmc@8c000 {
>   				assigned-clock-parents = <&xtal>;
>   				status = "disabled";
>   			};
> +
> +			gpu_tsensor: temperature-sensor@94000 {
> +				compatible = "amlogic,t7-thermal";
> +				reg = <0x0 0x94000 0x0 0x50>;
> +				interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&clkc_periphs CLKID_TS>;
> +				power-domains = <&pwrc PWRC_T7_MALI_TOP_ID>;
> +				#thermal-sensor-cells = <0>;
> +				amlogic,secure-monitor = <&sm 3>;
> +			};
> +
> +			nna_tsensor: temperature-sensor@96000 {
> +				compatible = "amlogic,t7-thermal";
> +				reg = <0x0 0x96000 0x0 0x50>;
> +				interrupts = <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&clkc_periphs CLKID_TS>;
> +				power-domains = <&pwrc PWRC_T7_NNA_TOP_ID>;
> +				#thermal-sensor-cells = <0>;
> +				amlogic,secure-monitor = <&sm 4>;
> +			};
> +
> +			vpu_tsensor: temperature-sensor@98000 {
> +				compatible = "amlogic,t7-thermal";
> +				reg = <0x0 0x98000 0x0 0x50>;
> +				interrupts = <GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&clkc_periphs CLKID_TS>;
> +				power-domains = <&pwrc PWRC_T7_VPU_HDMI_ID>;
> +				#thermal-sensor-cells = <0>;
> +				amlogic,secure-monitor = <&sm 6>;
> +			};
> +
> +			hevc_tsensor: temperature-sensor@9a000 {
> +				compatible = "amlogic,t7-thermal";
> +				reg = <0x0 0x9a000 0x0 0x50>;
> +				interrupts = <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&clkc_periphs CLKID_TS>;
> +				power-domains = <&pwrc PWRC_T7_DOS_HEVC_ID>;
> +				#thermal-sensor-cells = <0>;
> +				amlogic,secure-monitor = <&sm 5>;
> +			};
>   		};
>   
>   	};
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
