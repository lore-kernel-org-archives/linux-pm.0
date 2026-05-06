Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B7BC478849
	for <linux-pm@vger.kernel.org>; Wed,  6 May 2026 15:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778082924; cv=none; b=LqMYRezDXLUp/qchHm/hiS52xrPB/c90j2gUMTSYnDRx+JNLnVAZv1qJuG7zchmX4YwkhKiUEe1GxqsDssrdRSKEnHUCKPbqyu3OcvKSV4n4pLBjFvYXhsLsFpLObcCdhnSUuXh5ru8hFAjarJgs7U9OFc7t7ws7l6dN//TxgSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778082924; c=relaxed/simple;
	bh=TyBKEitXSOYpOLdZrSe1cpQT0eEqwMSxLUtGZaEeL3g=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=JXQ7RKUMggkbqK7JT1LGTS63HW+aioHg23SchZbl8QxSiy/dOZc/YXKfZlxoWMxhAa/IuCrnkEQTafJqX2kVbDWPF1SHZrh5Il2sm1FVHIJ97znu9eLvdWyYsbrUB/wR/S0UrFKty4cR3Atx4ohQzgzF1Novr0nofykpyfDmuww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uN9HbRO8; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uN9HbRO8"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-488b150559bso45936845e9.1
        for <linux-pm@vger.kernel.org>; Wed, 06 May 2026 08:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1778082917; x=1778687717; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PMDmbK31Q/cBTRDNdYVwkrUVXvsO29GTLMWDni5jKAI=;
        b=uN9HbRO8mavpljxg4HlUYeppktggwHzTaci6Grld1h0GOGZT2Bqzy/48E7RU2vyjT2
         AZKBhqodAIZ/398cfN/q0OgnvsuDm6CWYM8w/C8GRAcW4ZCqvHsdSDpwku37B0ipSQC1
         LYaYFmoIK1F9zJBMhFpDvY7noir8MASbL9265qdB2FkQFEvaNF0vXo87IZJoe+RukJvC
         HA5tUx1FVa+HiCNeCDZkiBcuuATyHwXkJuYlx3icw8VEcI4UAtnJq0HFV2/iar2WlGL0
         DYTY2vj77zR8sfYBkARuOIDqDp5mHyzrlGg2xwEbVnpliVsaIu12hKyE8AU0/UBW4lW+
         49+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778082917; x=1778687717;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PMDmbK31Q/cBTRDNdYVwkrUVXvsO29GTLMWDni5jKAI=;
        b=qO/yFRgqHaGT+mMIm9QsxIUtDMTPMogfSx9r9P5RcPQhmikn9R04J4H9nmti1jwMnm
         2Ac9g5t0p+T1vODGXljkdDCW5186xSt1raP84Dr/2RB3CHSY21PCmOimt9YlImfpiOwB
         tZ706/QSGdxziXyW3UUPKIXG2pJfO5FSTeXWrGk2HsX3j2OzvPfRQYtvK9xkVjZURRQ1
         +zjU+xYQ9FTGNogkgCGcR6jaaHAK+TbjKDwJ/GfGWmi/rNeZAqvwa0T1W9DfVEqS1290
         5Pl/yqOvt2FphxzGOIFBNmUvsSQFDeU7+BIJrNiSxtTxwxf+iAQYu6VmFp7J59AHBQM+
         Q7uA==
X-Gm-Message-State: AOJu0YyILtGS7lBJA4HWC4M7ROOD95qgdedhXvHQKodl6cqj1mvUqNQw
	LnQd4LE+ZZYfuCd7Geb1cSyvcEv+AbKenT7OL6wnMZUv75gi95oIx3PBdcT2agxdCWE=
X-Gm-Gg: AeBDietKtgD0GIHfrTDhQtfwDrnkGo/2qKoYmvy0+7T6eHZT61IoYMZ0ABGjPSTir0M
	efCu39m4Rww5eM9EdhAZMSnjqx9XC/WrcULgcz7g8gjv/kD2ykNvEdZZeKZs037cOFgCfAlfb2R
	VWTODJ+pouMoNEeZ1a08SDDhtXl7HRdJOfcmCPGkpdhj3ixBUIVLXmHzc2CevA2j/agmmZz19aN
	upVXUmFiewNodNw/lxr0c3xz8ZJMStkuvGaV0FCk/DXMZbQwzCS0u0lVs5Bp8aaMyxPbaSd3Q4C
	V5sSg9ns2/jzf8SF2HswASTzqSrOwfwgPfYlpSB72Bflg9oiRRZ45NdHy5lP3q6CizZw1LDQ6FB
	xyDlbkKeTMI44TSkpYpEV9lygus7de5soSmhZQTEsVY/ByeQhFkjzwvXXs7YzX8j+zgaDM+tZ6V
	b/rA99pkmZno2e/uOP9xEkAcyNV0QOxAeXw5tU7oECPOcQhETd+cVa7fM8cCCKxnUMKrmCOFVW6
	vIQAq0wSJdKjgYxrg==
X-Received: by 2002:a05:600c:3ba8:b0:48a:7676:30bc with SMTP id 5b1f17b1804b1-48e52bd5035mr71562705e9.14.1778082916975;
        Wed, 06 May 2026 08:55:16 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:5798:67fd:c866:b378? ([2a01:e0a:106d:1080:5798:67fd:c866:b378])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e538a547bsm62226385e9.5.2026.05.06.08.55.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 May 2026 08:55:16 -0700 (PDT)
Message-ID: <27d7363e-b8bc-4e69-a9d2-abd7e12fe562@linaro.org>
Date: Wed, 6 May 2026 17:55:14 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v5 4/8] thermal: amlogic: Add support for secure monitor
 calibration readout
To: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>,
 linux-kernel-dev@aliel.fr, Guillaume La Roque <glaroque@baylibre.com>,
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
References: <20260424-add-thermal-t7-vim4-v5-0-9040ca36afe2@aliel.fr>
 <20260424-add-thermal-t7-vim4-v5-4-9040ca36afe2@aliel.fr>
 <f4bd99bc-00c7-47f6-a914-e398dd2c3bd5@oss.qualcomm.com>
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
In-Reply-To: <f4bd99bc-00c7-47f6-a914-e398dd2c3bd5@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/6/26 17:45, Daniel Lezcano wrote:
> On 4/24/26 17:45, Ronald Claveau via B4 Relay wrote:
> 
> [ ... ]
> 
>> +static int amlogic_thermal_probe_sm(struct platform_device *pdev,
>> +                    struct amlogic_thermal *pdata)
>> +{
>> +    struct device *dev = &pdev->dev;
>> +    struct of_phandle_args ph_args;
>> +    int ret;
>> +
>> +    ret = of_parse_phandle_with_fixed_args(pdev->dev.of_node,
>> +                           "amlogic,secure-monitor",
>> +                           1, 0, &ph_args);
>> +    if (ret)
>> +        return ret;
>> +
>> +    if (!ph_args.np) {
>> +        dev_err(dev, "Failed to parse secure monitor phandle\n");
>> +        return -ENODEV;
>> +    }
>> +
>> +    pdata->sm_fw = meson_sm_get(ph_args.np);
>> +    of_node_put(ph_args.np);
>> +    if (!pdata->sm_fw) {
>> +        dev_err(dev, "Failed to get secure monitor firmware\n");
>> +        return -EPROBE_DEFER;
>> +    }
>> +
>> +    pdata->tsensor_id = ph_args.args[0];
>> +
>> +    return meson_sm_get_thermal_calib(pdata->sm_fw,
>> +                      &pdata->trim_info,
>> +                      pdata->tsensor_id);
> 
> This driver has a dependency on patch 2 and 3. Shall those being merged through the thermal tree ?

It's fine for me.

Neil

> 
> 
>> +}
> 
> 
> [ ... ]
> 

