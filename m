Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609F51A8F97
	for <linux-pm@vger.kernel.org>; Fri, 24 Apr 2026 09:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777024051; cv=none; b=cm1cd2FgCZ7U/lT9WAjrQ6x5kYVth3+sG4OPbFc/ZCOeR9j3R8FPAzPikPaP7XGAXnDblFAiAYFpRCJPjWD59xEoDGGfiNTmt2ycgs51LWWmLI21z6CNoAsqQMkn9QLiRbioj8e/jGROX/dQ2tnuQx7/cOlGAnVrb5zvji/+6IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777024051; c=relaxed/simple;
	bh=9r7mDfMvhAeVGI9/OtMtccMrtDzPQz+MyGD9CQhVa/8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=SRuN8HCLV3vzTpbJkTJsUURI1N3vh/rCSWbGDnFCMX70Lgx14fMxPjY97VkGF7OZrmsYPnQBFH8jamF7TSQ7rb6TXybMjsPJE/b9+Js/1M0VbT+N6Zm3wt8lOpab5u9oT9QtlSfu+fFpqMnwcKVNrM99Tv4xaH8NY/o6pCSYSJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=k8JggPqM; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="k8JggPqM"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-43cfbd17589so6084937f8f.0
        for <linux-pm@vger.kernel.org>; Fri, 24 Apr 2026 02:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1777024049; x=1777628849; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1cXOyeqVZTuYmkbP/VNEswETXiZyV/j1DeIymNd6Gck=;
        b=k8JggPqM+k09/Fhg7CNSfXmlfn4DYS+GY4eGn+u9BizDCgAiZRdRGpFBgjkKg0ngLS
         dpmEr8wDPCDCS+9O2I6z10Or68sAY0dJJKyt7CAJPPNR5ULB4rDQyxvNDz3gMESg6E70
         X9FQZ/n4tl26SdeGlFZZM/P0W/L1/HzAZzFAKDUN3TiU/aTTWPYY8PUyWuXMDCi2BKqO
         GQO9VoyoNSqNgilS3/MEn6oGe00qWmuNbT4gL3/13NZcUcbYU18Wb1IqzyhtU0bMhxLR
         kRL9aF73qeh6fOMQc7+DVTQBpW5WydbfwhR1atZ3Mdsufjlze+tNsaOuw0eN4l+lFIja
         uoTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777024049; x=1777628849;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1cXOyeqVZTuYmkbP/VNEswETXiZyV/j1DeIymNd6Gck=;
        b=B7eEnIpQ6ouR2YtU7eDFtWdElfbYvz2CQyg8QmCq2iPhEgftgbd51ixvqAsQa+KZNn
         IaZFP4sPmeo3r3XaarSHqWmbRMWesXnpYlEkOiqE9F9cV6pYGRqAunxxGYRTC74FOBg3
         Y3C0Ts36nct64UDWW+qU6AnKvixAIyq43pr6DedTCYmlixj/Cl5A4tNbNBX1bcW+06Ov
         cwjFnOda664r7SeoG/h7OaHP+je3Aq6Acf27MYvDnBPhU4iccXWwm37XEouPfTxYv7IA
         s5cPBYd4dnIfLi+mtaV4VSb9FvGUG1y4ox2wD2VE761POlulu+5vuAbBP/U7stN05NGh
         +Z2Q==
X-Gm-Message-State: AOJu0YzRYfV71TG3VPqhcfuYfx9Ow+FcNsSOBRvDtIeTTh7P+zWrZQV4
	oxKwyqiF4k/SvJPAwOMF0hNYBD2THgPRKb/k9b1tp2FIEtZvMZhbJNv5YtkSnzW+zMo=
X-Gm-Gg: AeBDiespV3yB0JfwZf1hJZJ9qkYK2IZ56hktx2o6SFmdin6l/2PWu8CwR9FGSfTa0Ha
	FG2BZnJgvgE30uIAPEAr04FMWnmBFSCxgpmzo4S2/1nfhZYS4dBtMHqK8nv4dsFE7rZyGXFqwHy
	lNmkpIB3zyJSe59stnBL/RATUIPrFsQ3DgbuLoCzJ/+CyL6NLnni5A+CyqN5Wb3TXEMLzsdBbPp
	JV4OWD6Tq6/ZA3tSmKAnx7pELBap1v77K4sb7gMLZuYXOcRe5j1ONWhlapq1WCo4KOtTFHxaHCO
	tHIicwEwwZpcSo2Pk4btJdLJlDMI+nWFR8oDunSuQC8pBJoG5nfQTJM3/Z+YpYNY0nmwg1r61mm
	MxJlC4NmzU56WZMxFFzQL38ub2+EuhreTf3VBVU7tne1l8w9N3IEkQtcvbgjg69VLhFiIyBcwNe
	FMIVe5MlQiYD/GB0PUrwE7ckxUVZMifDGIRfDUC2rGjcG7gyAkueGGsOAkRPTgD6TYJIk+GMRJY
	cX3f/JWVgeHmSzLeu/5Cv9hu0hh
X-Received: by 2002:a05:6000:288c:b0:43e:a69b:d804 with SMTP id ffacd0b85a97d-43fe3df26b1mr48732901f8f.29.1777024048585;
        Fri, 24 Apr 2026 02:47:28 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:79e1:f56b:445c:ca9c? ([2a01:e0a:106d:1080:79e1:f56b:445c:ca9c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4cb1176sm60412901f8f.3.2026.04.24.02.47.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Apr 2026 02:47:28 -0700 (PDT)
Message-ID: <86adec56-2234-44c0-b165-71fa91b17e96@linaro.org>
Date: Fri, 24 Apr 2026 11:47:27 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v4 2/8] firmware: meson: sm: Thermal calibration read via
 secure monitor
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
 <20260423-add-thermal-t7-vim4-v4-2-d4c1528d5044@aliel.fr>
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
In-Reply-To: <20260423-add-thermal-t7-vim4-v4-2-d4c1528d5044@aliel.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/23/26 18:07, Ronald Claveau via B4 Relay wrote:
> From: Ronald Claveau <linux-kernel-dev@aliel.fr>
> 
> Add SM_THERMAL_CALIB_READ to the secure monitor command enum and
> introduce meson_sm_get_thermal_calib() to allow drivers to retrieve
> thermal sensor calibration data through the firmware interface.
> 
> Signed-off-by: Ronald Claveau <linux-kernel-dev@aliel.fr>
> ---
>   include/linux/firmware/meson/meson_sm.h | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/include/linux/firmware/meson/meson_sm.h b/include/linux/firmware/meson/meson_sm.h
> index 8eaf8922ab020..3ebc2bd9a9760 100644
> --- a/include/linux/firmware/meson/meson_sm.h
> +++ b/include/linux/firmware/meson/meson_sm.h
> @@ -12,6 +12,7 @@ enum {
>   	SM_EFUSE_WRITE,
>   	SM_EFUSE_USER_MAX,
>   	SM_GET_CHIP_ID,
> +	SM_THERMAL_CALIB_READ,
>   	SM_A1_PWRC_SET,
>   	SM_A1_PWRC_GET,
>   };
> @@ -27,5 +28,7 @@ int meson_sm_call_read(struct meson_sm_firmware *fw, void *buffer,
>   		       unsigned int bsize, unsigned int cmd_index, u32 arg0,
>   		       u32 arg1, u32 arg2, u32 arg3, u32 arg4);
>   struct meson_sm_firmware *meson_sm_get(struct device_node *firmware_node);
> +int meson_sm_get_thermal_calib(struct meson_sm_firmware *fw, u32 *trim_info,
> +			       u32 tsensor_id);
>   
>   #endif /* _MESON_SM_FW_H_ */
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
