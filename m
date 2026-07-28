Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208DB40BCA0
	for <linux-pm@vger.kernel.org>; Tue, 28 Jul 2026 08:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785227711; cv=none; b=pftGLZupbyQnLziEVM5zjvOKu9a8VjketGTY/738cm0DT5wSupBCf1pwCrdgLtY2uQYa4QgEkbmxqaYofCqKgRYwld85DBTHzsPCEK9xRUeXw7ZBmFsbTSKF+3KwIYSiAupJBMQebFOIYxkGScaXQSDm4CCRkNS7XpP0APFKQ98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785227711; c=relaxed/simple;
	bh=yabufoZK8u9hePQWxMzzHGKntdw7m6M1/TtBCKKrnVY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=C8b+KZmLSgiEBY47PPnZeo6R7epA5sbDYnT7/0OwQBBWuKvMkSTE+pwNWivW8nB0ps1OTgcthsOmVabYENu49H2cL9IMdQUCzISPsBTwdKGP44qi3DY7MD8DqgMvVgkVfyTLkLhqwYaceayyGXeirirOH0yVzJPOCbjQYhQXG2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fbpFdYu6; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fbpFdYu6"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-49555a0e68bso18014765e9.2
        for <linux-pm@vger.kernel.org>; Tue, 28 Jul 2026 01:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1785227698; x=1785832498; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :autocrypt:content-language:references:cc:to:subject:reply-to:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lceCMquYfWGQoKHrpWrtsA8ES4itoEqcbDu5tjp1DxI=;
        b=fbpFdYu6jdQmVl5H4p2P/MBTl4+RcZNlc/CWX0YnkYOXmW4gCqVAg3zJFM5mR+EkOF
         atxzR2yTnNSCwpGXodVqUYwbMdOaLVgFK6exC52zlH+iGKADAfhPqO6w405pLi25m+N8
         BVctftgJH1OFxXfx/SUSkT4mkoskenPqKTwYlAQTHK7pMuwZCQEtp20AWUOc32Fmv8hd
         ZbBllHQTmOHZW1dkmZcoXr3W3Ykxs2FEzcnoQPVO/JXGYpXL9ZDF7sFuWeChoMAd4hcV
         eiUL5DqWLE5yDzbGIjWJFogxR7FhE39V49hLvuuSJQOFomsiBKiaGOfYF7Li9+/hjupt
         6CLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785227698; x=1785832498;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :autocrypt:content-language:references:cc:to:subject:reply-to:from
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=lceCMquYfWGQoKHrpWrtsA8ES4itoEqcbDu5tjp1DxI=;
        b=bn8a1cMB8o1u1audlh/2QS9vKxlTnHANA3eSGkHzzBpkxshL2YKV9+RK189hu3BfmL
         Yi3O1/VKDnb5AMjI7F7vy/lBcO4dWEr8F2a0dk+d0uODpi0kYUmZCxD/Y/p2r6UZji3z
         u1WJXn1ze46WoqbuLcIeSzRdHVrsjgzq903LON/bKocchPEReiauiBBOvSU+/P/YjKvx
         vl96et8hVBPaiLlyo4TKWKKe/8g3+BUH3XMTgSd8UJwT1aA42NgoxWnM9xM6XAhy1HTi
         UnQ3lD/Tdd3McgTD4QZn1UlkEbgdEgw/YM7MS3QS1KjOHL+IiYS1nGxo0Tnc9PEWh15E
         vIew==
X-Forwarded-Encrypted: i=1; AHgh+RrGK7cejgNOqYIc39dnTDaORfH+p7gV8tRJCMwEiobn57ODQw63HhONdn0FUJgEx4d7xuL2HvRnAw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxOolCrRXQH9ZxJKg/wq3+hJSd7+oMLQfe5I24wLFOEgLRTjkNX
	w4/reSE0vX4H6mxtDpHRwEwOBTAkoGMmFmmY1TnGfqo2X8p8mNgcUPdMQ4P9U/sw8aU=
X-Gm-Gg: AR+sD13ir3m77h89SNk8oqxOpmqTOkGe/xyDr6W9R1nZsmONeUCq6sBmFJIF9p/p5Pa
	u1zW45/e6Jl5zZPp57D7T9CG5cdYKFahD9cA7z7d23cseqeJ+3IJDj4yWBvrl4q+6INDjl614Ub
	9C120qPYLyDkn6ESwuxijpeGmt5nfCSLUT0TjqzJahwYw9qeM/YV8woO6V/hWf9bLsyINTdnUig
	QmD316+FyqmtepN1oxegDU3PXdY0rjuC0F23foOokSely0yfLptgG86Qqsgq8Eswmxo/STEcAzs
	yY94CN47iuBE6DERnYgloW+F2+iljsIhEGt1qHRDVxoI1tnpFG52xCxh+XF6oupBVerx0mDImst
	kxTm1uw7bbM5aOwqYWB/l60CDbHb4u0/+CZ8igpsW9NyA6tQkoSPjsV+0oPzC2xpwFm5xy2ein9
	A/lT4d9h64IT/GUr0l9TMh1JRw7gSdb38bg2PPrZ3oY6ukOonJntufh+bnelzWysWhmweE
X-Received: by 2002:a05:600c:1384:b0:495:6e68:5df2 with SMTP id 5b1f17b1804b1-496c643be67mr15873355e9.12.1785227698475;
        Tue, 28 Jul 2026 01:34:58 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:5788:c4e1:cf35:7211? ([2a01:e0a:106d:1080:5788:c4e1:cf35:7211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85b9a5c4sm56310759f8f.8.2026.07.28.01.34.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jul 2026 01:34:58 -0700 (PDT)
Message-ID: <9dffc605-2ab6-42b4-a7f9-565bc16d8c07@linaro.org>
Date: Tue, 28 Jul 2026 10:34:57 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 3/3] arm64: dts: amlogic: a9: Add power domain controller
 node
To: xianwei.zhao@amlogic.com, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Kevin Hilman <khilman@baylibre.com>,
 Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Jianxin Pan <jianxin.pan@amlogic.com>, Ulf Hansson <ulfh@kernel.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org
References: <20260722-a9-pm-v1-0-1fe20a44bf2d@amlogic.com>
 <20260722-a9-pm-v1-3-1fe20a44bf2d@amlogic.com>
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
In-Reply-To: <20260722-a9-pm-v1-3-1fe20a44bf2d@amlogic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/22/26 10:39, Xianwei Zhao via B4 Relay wrote:
> From: Xianwei Zhao <xianwei.zhao@amlogic.com>
> 
> Add power domain controller node for Amlogic A9 SoC.
> 
> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
> ---
>   arch/arm64/boot/dts/amlogic/amlogic-a9.dtsi | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/amlogic-a9.dtsi b/arch/arm64/boot/dts/amlogic/amlogic-a9.dtsi
> index b0e0fadeed82..3652b2034c96 100644
> --- a/arch/arm64/boot/dts/amlogic/amlogic-a9.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/amlogic-a9.dtsi
> @@ -7,6 +7,7 @@
>   #include <dt-bindings/interrupt-controller/arm-gic.h>
>   #include <dt-bindings/gpio/gpio.h>
>   #include <dt-bindings/pinctrl/amlogic,pinctrl.h>
> +#include <dt-bindings/power/amlogic,a9-pwrc.h>
>   
>   / {
>   	interrupt-parent = <&gic>;
> @@ -72,6 +73,15 @@ cpu7: cpu@700 {
>   		};
>   	};
>   
> +	sm: secure-monitor {
> +		compatible = "amlogic,meson-gxbb-sm";
> +
> +		pwrc: power-controller {
> +			compatible = "amlogic,a9-pwrc";
> +			#power-domain-cells = <1>;
> +		};
> +	};
> +
>   	timer {
>   		compatible = "arm,armv8-timer";
>   		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>,
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
