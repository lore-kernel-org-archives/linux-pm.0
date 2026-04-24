Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B588532D0F5
	for <linux-pm@vger.kernel.org>; Fri, 24 Apr 2026 09:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777024399; cv=none; b=kg2tI1hIYp05oQFGcaf+t6RJPkTJP8TGXbcmaw14MqCFEuGqS90nwO6sz63Sr2POgVmzmBlhDDWhzd8/xh54h8XHkAW5tKrfcBHO9OwTBG1qVOj1XZqSm3Vfzxn3nluApVrtMVdUHquJBB07hIk14h6o1NM/YQDRL/m0EFlvR6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777024399; c=relaxed/simple;
	bh=qqaeXtSxiTWa6nb7odE0NNpzwlxBegSvuphPOAi08mM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=rTQLerYIvPB06UO+7GIFqtRHEUA5yYXz+b2ILxux333hVz3Jqz/Dv7So91ocohmHOEiwSf10jHUMC0Uy5b1pM3KFLskEmDJFSp987wQa9+Y/G122jS0YPkm2kOqNeyjFS13ZYweN/pb+ZzV5KFvB0/HmzxlH70gCPTcZfX2OiqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=i3xMf6pC; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i3xMf6pC"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4893940bb5eso35645485e9.3
        for <linux-pm@vger.kernel.org>; Fri, 24 Apr 2026 02:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1777024396; x=1777629196; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SBpa+OY6Vx3uYT0JNDbcMHz2F1hz9Z/Yh2ubTX1Ek2I=;
        b=i3xMf6pC/yWp5I5iwAhUhnaiF2/HSZ3D+ez+RTy59Sv8Ii/d3JG/0vx/XQNX42Agor
         1il1Blez2DM3KeFOtqLSGp/HFMhvq+Ht9GT7njc2ZM6tmeaYNGj3FSdQvaxif4gEB5V7
         TDYCzDhM7B0f2Lx5S2rFoG0LuI3tYvQM4HZT3rjGUCzbxE7DZQFOpOCnoJ4cPomodj9n
         mNSykWaJItC46WQaRpAU5M4FiYD9r0liQuZV8jh0l/svScpONeljTRB4x8SIuBlieLAj
         D2prx9SeSvQZyARSXFzerhlR3FnFG8GwyzPNrGgxV3EVAcu5t5BKFwhbbdK0wQty0TGK
         si4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777024396; x=1777629196;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SBpa+OY6Vx3uYT0JNDbcMHz2F1hz9Z/Yh2ubTX1Ek2I=;
        b=NHKmiihHRKMd9fVCRDbpuMnz3qU6M+I1dRcWk2zCZJfzhJArRpyIn6g6fuxH0VK7j5
         p3oWhxd2Bxf+Hy1rM4vBqzsyAjycuDpX10xkJVjxG0Fb9xG79ZI4QSlo+9NV8PFg35ng
         TYDTC9a3eQ+kN57PEZ70HWVBE9Tbf2Chgg+ICFViVvFay+1iZ0yvJHblWufQaCFbdUMe
         JomBN81MPeeoXpUTDWz13nxn++Hq5L3PjFD3idvLtek7TZ9IzwzW2RxNFNiTsiOjFFKj
         j/cRYI2x0i0dZGb2tLNxozMaYM2iyB1mr0tDaCrhzrcUCxAcSVOfgK99u4DwnzD9cHUf
         SGCg==
X-Gm-Message-State: AOJu0YzR6nV8gx8osRyg8IVFd58h5z7jpRScelt1xTbcwDbvGpnbvmUC
	Gp5ZcOhL2N34PbrB8EyCIBokJI66PDqSijZFe36CcBwbNIpSWtH6tJnjXkctkcoAS4s=
X-Gm-Gg: AeBDievSVEHA8zQkqZ6iymJr80JG5CXuZDqpgYNqYywQdXfpyxjSta0YHix+C47Yb3R
	cMDo9OtPb5UGyd8SQVD0J8cTgqNpP988Ma9aC1YTZqQUSUSJa8zDrDUQ46PiE9+IevHC186z6IZ
	QQ7EWK/uy06ntA2TR5/3jT6JoU+CTm3QHAKDCQxAEGRIDMGcRDPUhKZLGP1dthwPS7ZEpBJ7Jaj
	ojijoAOExM7C4VEGjAHNn+9NGK5uLHpGzisCM2m8R3P/Zq58hXlUPrXDneyJCYu36XgbfumWAJb
	bYdIFuMs6tv2yblATKz1dWbL4pUK9ErjqfRAwjpSWbf7dxkNUpUs+EBRyNDZtCLBqSHiH/rgPP2
	ezwic2ExteEKv9pjYGKVlYzXRHsiWecpDOPLB65oKgJX96mhGMf8Vxk70+Az2kqO7WZg7xv0rhh
	TXuQPK5IUZiocH7GxzmvXJjpedtVbgklbpZ1ejC88yEz+Sk9JFEdCIyrklB2Edle4JEuWW/snmc
	2Iap5drTkfe5kHqyQ==
X-Received: by 2002:a05:600c:34c3:b0:485:41c4:e2e4 with SMTP id 5b1f17b1804b1-488fb792dd0mr421536775e9.23.1777024395930;
        Fri, 24 Apr 2026 02:53:15 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:79e1:f56b:445c:ca9c? ([2a01:e0a:106d:1080:79e1:f56b:445c:ca9c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4891f98728dsm106060925e9.23.2026.04.24.02.53.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Apr 2026 02:53:14 -0700 (PDT)
Message-ID: <3768fc2a-ae1b-4e58-a1a5-1b49d0f0c90c@linaro.org>
Date: Fri, 24 Apr 2026 11:53:13 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v4 7/8] arm64: dts: amlogic: t7: Add thermal zones
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
 <20260423-add-thermal-t7-vim4-v4-7-d4c1528d5044@aliel.fr>
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
In-Reply-To: <20260423-add-thermal-t7-vim4-v4-7-d4c1528d5044@aliel.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/23/26 18:07, Ronald Claveau via B4 Relay wrote:
> From: Ronald Claveau <linux-kernel-dev@aliel.fr>
> 
> Add thermal zones for all six sensors: a53, a73, gpu, nna, vpu, and hevc.
> 
> Signed-off-by: Ronald Claveau <linux-kernel-dev@aliel.fr>
> ---
>   arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi | 179 ++++++++++++++++++++++++++++
>   1 file changed, 179 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi b/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi
> index 62f259b2b17d2..c6ea0f20a879f 100644
> --- a/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi
> @@ -9,6 +9,7 @@
>   #include <dt-bindings/clock/amlogic,t7-scmi.h>
>   #include <dt-bindings/clock/amlogic,t7-pll-clkc.h>
>   #include <dt-bindings/clock/amlogic,t7-peripherals-clkc.h>
> +#include <dt-bindings/thermal/thermal.h>
>   
>   / {
>   	interrupt-parent = <&gic>;
> @@ -829,6 +830,184 @@ hevc_tsensor: temperature-sensor@9a000 {
>   				amlogic,secure-monitor = <&sm 5>;
>   			};
>   		};
> +	};
> +
> +	thermal-zones {
> +		a53_thermal: a53-thermal {
> +			polling-delay = <1000>;
> +			polling-delay-passive = <100>;
> +			thermal-sensors = <&a53_tsensor>;
> +
> +			trips {
> +				a53_passive: a53-passive {
> +					temperature = <85000>; /* millicelsius */
> +					hysteresis = <2000>; /* millicelsius */
> +					type = "passive";
> +				};
> +
> +				a53_hot: a53-hot {
> +					temperature = <95000>; /* millicelsius */
> +					hysteresis = <2000>; /* millicelsius */
> +					type = "hot";
> +				};
> +
> +				a53_critical: a53-critical {
> +					temperature = <110000>; /* millicelsius */
> +					hysteresis = <2000>; /* millicelsius */
> +					type = "critical";
> +				};
> +			};
> +
> +			cooling-maps {
> +				map-a53 {
> +					trip = <&a53_passive>;
> +					cooling-device =
> +						<&cpu100 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +						<&cpu101 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +						<&cpu102 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +						<&cpu103 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +				};
> +			};
> +		};
> +
> +		a73_thermal: a73-thermal {
> +			polling-delay = <1000>;
> +			polling-delay-passive = <100>;
> +			thermal-sensors = <&a73_tsensor>;
> +
> +			trips {
> +				a73_passive: a73-passive {
> +					temperature = <85000>; /* millicelsius */
> +					hysteresis = <2000>; /* millicelsius */
> +					type = "passive";
> +				};
> +
> +				a73_hot: a73-hot {
> +					temperature = <95000>; /* millicelsius */
> +					hysteresis = <2000>; /* millicelsius */
> +					type = "hot";
> +				};
> +
> +				a73_critical: a73-critical {
> +					temperature = <110000>; /* millicelsius */
> +					hysteresis = <2000>; /* millicelsius */
> +					type = "critical";
> +				};
> +			};
> +
> +			cooling-maps {
> +				map-a73 {
> +					trip = <&a73_passive>;
> +					cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&cpu2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +				};
> +			};
> +		};
> +
> +		gpu_thermal: gpu-thermal {
> +			polling-delay = <1000>;
> +			polling-delay-passive = <100>;
> +			thermal-sensors = <&gpu_tsensor>;
> +
> +			trips {
> +				gpu_passive: gpu-passive {
> +					temperature = <95000>;
> +					hysteresis = <5000>;
> +					type = "passive";
> +				};
> +
> +				gpu_hot: gpu-hot {
> +					temperature = <105000>;
> +					hysteresis = <5000>;
> +					type = "passive";
> +				};
>   
> +				gpu_critical: gpu-critical {
> +					temperature = <115000>;
> +					hysteresis = <1000>;
> +					type = "critical";
> +				};
> +			};
> +		};
> +
> +		hevc_thermal: hevc-thermal {
> +			polling-delay = <1000>;
> +			polling-delay-passive = <100>;
> +			thermal-sensors = <&hevc_tsensor>;
> +
> +			trips {
> +				hevc_passive: hevc-passive {
> +					temperature = <95000>;
> +					hysteresis = <5000>;
> +					type = "passive";
> +				};
> +
> +				hevc_hot: hevc-hot {
> +					temperature = <105000>;
> +					hysteresis = <5000>;
> +					type = "passive";
> +				};
> +
> +				hevc_critical: hevc-critical {
> +					temperature = <115000>;
> +					hysteresis = <1000>;
> +					type = "critical";
> +				};
> +			};
> +		};
> +
> +		nna_thermal: nna-thermal {
> +			polling-delay = <1000>;
> +			polling-delay-passive = <100>;
> +			thermal-sensors = <&nna_tsensor>;
> +
> +			trips {
> +				nna_passive: nna-passive {
> +					temperature = <95000>;
> +					hysteresis = <5000>;
> +					type = "passive";
> +				};
> +
> +				nna_hot: nna-hot {
> +					temperature = <105000>;
> +					hysteresis = <5000>;
> +					type = "passive";
> +				};
> +
> +				nna_critical: nna-critical {
> +					temperature = <115000>;
> +					hysteresis = <1000>;
> +					type = "critical";
> +				};
> +			};
> +		};
> +
> +		vpu_thermal: vpu-thermal {
> +			polling-delay = <1000>;
> +			polling-delay-passive = <100>;
> +			thermal-sensors = <&vpu_tsensor>;
> +
> +			trips {
> +				vpu_passive: vpu-passive {
> +					temperature = <95000>;
> +					hysteresis = <5000>;
> +					type = "passive";
> +				};
> +
> +				vpu_hot: vpu-hot {
> +					temperature = <105000>;
> +					hysteresis = <5000>;
> +					type = "passive";
> +				};
> +
> +				vpu_critical: vpu-critical {
> +					temperature = <115000>;
> +					hysteresis = <1000>;
> +					type = "critical";
> +				};
> +			};
> +		};
>   	};
>   };
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
