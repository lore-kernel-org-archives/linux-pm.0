Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454CE359A91
	for <linux-pm@vger.kernel.org>; Fri, 24 Apr 2026 09:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777024345; cv=none; b=JOn/T0Mw0SJEsB40luuo21lT2wzsemtK8EtxEUXuehMl0g6sLhEFgHtic+J/wventW7VH6w1M8yIMfKfNf1ImCwM48etSW0ZVwKkRVbhsTpn/SsZXop5Yx1WJvgYam4sQo6fgdupYfWQQyTuiQ9xPwlqaSaTLE4HiRvgcmBKCd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777024345; c=relaxed/simple;
	bh=OKOMS6uEmoakFSSKNFIEtAdzcaFcM11NJCjQzupQ/HE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Ag3WJN3SHxTfG6Je4E4P+1c/MkW+rSyf5lP1mjiZIrL+vxqXOjL9kCJsl0vliN64QqdyQvyMfc6l4r1Z5XKU2YfiJ4mjd+kqOvMEYncm6GF1t3M6E8HPj+z0zj6LEnvIyz6Sf2yZ3K5F29MZXNHx/dbk+Z2w7YgQ1YM5pJuxqXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZwcQX8lT; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZwcQX8lT"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-48374014a77so99457915e9.3
        for <linux-pm@vger.kernel.org>; Fri, 24 Apr 2026 02:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1777024342; x=1777629142; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7dSVP6vW9j9Y0EuiVzA7IMsg/jf0E4hSdGwD0NTLWuI=;
        b=ZwcQX8lT/f+g0y1Xo/BJ08Wsw/LBQ+As82AmKIcaU5a4jFnF403KkEaOtWxlnhe11H
         XlzPeCyt/O0ssJRZPndvP84B20Y+m2e8OlyIUMx7NPlM1Shilnv4ifGut+egcmE0LZqj
         wSX4jyTMBsl3/u7tRKRmv47cPNPm0EVDP9YpKgKbDCsU4Je+/tbCuEm4EdV9LTWZoCEK
         9S8/ELdEer09IoPvv8cnQoavPFz6EPFofn9Yy3HMd+RqIvUICIo9+MTr51aQ7LyqTnmD
         XIlZx0SuxNQhIB4H4lbBT7NERAL+zlB3kJ6XQxEupWQpyM3hQ0aeC1rJJ0cdjVFgmILv
         KAQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777024342; x=1777629142;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7dSVP6vW9j9Y0EuiVzA7IMsg/jf0E4hSdGwD0NTLWuI=;
        b=Lq9wJMNSNjPsf5LLbYJMvrdU2cw5eHxNVLafgmtXhn51h3ZxoIrSYD11qvhNMPLhYp
         p2tGr1ayc6adTkLftBKLq/8hRwFyjq8Z0PY4fLbDi92UJHra1eidqaR0vh9MMwbb00at
         ybwnCakewlLHWdNcZMM3qH3MmfeYJbWO8HzkPNsa+4d7JM5s40O8dVsa2J4c7mLcLWlF
         3oIXKpjhQh8h6525i2CRTT7ztVKtD3KVZG8OTGIVJ1gc0jBxuGXplCt7ydB62IPoWPhp
         ZZ3fUNLtMEUSv2IoePTFA91mqRdAkZShqNLEU9KmhnJniNU31wzZhX5EsdyY5MUqsdYA
         MBVQ==
X-Gm-Message-State: AOJu0YzUpGoFODUmqLdkg5AnKhkLH+VB5UwuZsgNfk+5m/WuZvg3fORo
	dL1mY5O8I+NYCd0wN7389U2AnWPlO6VGjGHSYlibm0N+zqbd8F36Q9dahmb2hLcw9Pc=
X-Gm-Gg: AeBDiesUnkWPpo+WMQm3UuVtj+s9l2asck9/exELcHnfnWmoNMNZnzop+YSA4tapzJ6
	hGrwcz4V2Sf6BBin/yHDjV3rYxR6wjN5W+7dOlV9sBAWYjFC0/CzHzZ4Pfq4efTrvhQ5x4v5d7G
	bNUCv0SF7brpR5PPd44UIkmv0xUMdnbOL5GaRdYQIh+Z0oQx3iMc8snVTEl72TG7Ysj59hNiuFJ
	brZKxvDL6FcBPn2R+RLma8etIShi83B6IGL9WvGvivPzGokTUftTszNPFr9rs4NACdoUTnzCOn2
	5fPlbm1MGC0DkZHNNpH5aLfd08myDzi1yh05pCudZK5Y7KduQ5M06Tr8lL6CcXAUp/M8Dp9urCX
	vnUk3bSLKGhRpHVFRSNeNEbvfB/FUvy96jla4AmgK86+c4aL2cCPEb8xu1FwiRBROoGHvWokb1D
	mME7jgVS4SjzwT0QSjB1vig0QhceWy+zov+3WD8uNu2XVG5vJxRqKExz2z32bYIN2NtKrq4sy+W
	AQS42aIYxhzXn02fw==
X-Received: by 2002:a05:600c:a305:b0:48a:53cb:85f4 with SMTP id 5b1f17b1804b1-48a53cb8734mr195298735e9.24.1777024341572;
        Fri, 24 Apr 2026 02:52:21 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:79e1:f56b:445c:ca9c? ([2a01:e0a:106d:1080:79e1:f56b:445c:ca9c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a55b8baaesm389489665e9.10.2026.04.24.02.52.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Apr 2026 02:52:21 -0700 (PDT)
Message-ID: <6d734851-6f0b-4351-832c-4ee08dfcc10d@linaro.org>
Date: Fri, 24 Apr 2026 11:52:20 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v4 5/8] arm64: dts: amlogic: t7: Add cooling cells to all
 CPUs
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
 <20260423-add-thermal-t7-vim4-v4-5-d4c1528d5044@aliel.fr>
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
In-Reply-To: <20260423-add-thermal-t7-vim4-v4-5-d4c1528d5044@aliel.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/23/26 18:07, Ronald Claveau via B4 Relay wrote:
> From: Ronald Claveau <linux-kernel-dev@aliel.fr>
> 
> Add #cooling-cells = <2> to all CPU nodes (both little and big cluster)
> to allow them to be used as cooling devices in thermal zone mappings.
> 
> Signed-off-by: Ronald Claveau <linux-kernel-dev@aliel.fr>
> ---
>   arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi b/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi
> index 560c9dce35266..7aec65f036a9c 100644
> --- a/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi
> @@ -63,6 +63,7 @@ cpu100: cpu@100 {
>   			i-cache-size = <0x8000>;
>   			i-cache-sets = <32>;
>   			next-level-cache = <&l2_cache_l>;
> +			#cooling-cells = <2>;
>   		};
>   
>   		cpu101: cpu@101 {
> @@ -77,6 +78,7 @@ cpu101: cpu@101 {
>   			i-cache-size = <0x8000>;
>   			i-cache-sets = <32>;
>   			next-level-cache = <&l2_cache_l>;
> +			#cooling-cells = <2>;
>   		};
>   
>   		cpu102: cpu@102 {
> @@ -91,6 +93,7 @@ cpu102: cpu@102 {
>   			i-cache-size = <0x8000>;
>   			i-cache-sets = <32>;
>   			next-level-cache = <&l2_cache_l>;
> +			#cooling-cells = <2>;
>   		};
>   
>   		cpu103: cpu@103 {
> @@ -105,6 +108,7 @@ cpu103: cpu@103 {
>   			i-cache-size = <0x8000>;
>   			i-cache-sets = <32>;
>   			next-level-cache = <&l2_cache_l>;
> +			#cooling-cells = <2>;
>   		};
>   
>   		cpu0: cpu@0 {
> @@ -119,6 +123,7 @@ cpu0: cpu@0 {
>   			i-cache-size = <0x10000>;
>   			i-cache-sets = <64>;
>   			next-level-cache = <&l2_cache_b>;
> +			#cooling-cells = <2>;
>   		};
>   
>   		cpu1: cpu@1 {
> @@ -133,6 +138,7 @@ cpu1: cpu@1 {
>   			i-cache-size = <0x10000>;
>   			i-cache-sets = <64>;
>   			next-level-cache = <&l2_cache_b>;
> +			#cooling-cells = <2>;
>   		};
>   
>   		cpu2: cpu@2 {
> @@ -147,6 +153,7 @@ cpu2: cpu@2 {
>   			i-cache-size = <0x10000>;
>   			i-cache-sets = <64>;
>   			next-level-cache = <&l2_cache_b>;
> +			#cooling-cells = <2>;
>   		};
>   
>   		cpu3: cpu@3 {
> @@ -161,6 +168,7 @@ cpu3: cpu@3 {
>   			i-cache-size = <0x10000>;
>   			i-cache-sets = <64>;
>   			next-level-cache = <&l2_cache_b>;
> +			#cooling-cells = <2>;
>   		};
>   
>   		l2_cache_l: l2-cache-cluster0 {
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
