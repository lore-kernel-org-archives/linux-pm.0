Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69BEC292B44
	for <linux-pm@vger.kernel.org>; Fri, 24 Apr 2026 09:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777024073; cv=none; b=IU6KCBTtyB9xVkOWkZ9t/lbPKfQFIDtNLDi4pcUi1hbPZ4enF942u1nVCxk9k6CxkQGp6L/D/Z9w7FaGkYj8Xl8XJKsYzA+nYAzd/pKUEP0xPntMVIdHaRxRbUZaYrReAUXdLe63yeZfFC3oHzmFlwMPcoaoIYna9dAYGHrNOVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777024073; c=relaxed/simple;
	bh=vaGTJ5tzUPJhD2ZETg3sJdRRIS4DbouAp3GQJsTd2MU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=IoEX3ZeLWvnfSkZ4hgwSqj3VFXvDzkJFqTAbRlt0v5cwmotopYnM+oNztDHHtBWrCmXVPYW3miqcyxbuBrbiiJaLroFRcLRF8ZPLP82Zr2AF77FIUJ6SZaRz4jWkg3RAnCVtmOd7/U+n5Bveu/LVdV3k/CzuT8yOn3jxMOWkbfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=w1vKwBy9; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w1vKwBy9"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-488b0046078so69042875e9.1
        for <linux-pm@vger.kernel.org>; Fri, 24 Apr 2026 02:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1777024071; x=1777628871; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zyyE/r/iA1MwYNHXAS7P+Cj4G1v9/C9w7YzUp4f7iBc=;
        b=w1vKwBy9PI6dxwYGmiTHQ5UEGFt/XcVA9NGEgQBsw6HcdBxRntX/2e44BaXr87aFee
         ybK5Ourrfnw8PkQ4GfVHJY+VQ0opEELBdRfGLhW4s395C0zbc3FePNnaH/Qj0MMEGJ4/
         T9phmbtanqGUHOfd71zowDJSo9sNSbbBek7HjPHQ285Gk13N6oHs6dzT6CVAGDNnwOuN
         DV83OG6HVIPLNyvabfU173pjV+rRITw65IGvyBYrSJSVUDW9taTNpbF0hKaF+N96RIGW
         ER/1OFg8+frjq1vbJ9DCvc966cxm/ENailAqnJj99HWWa+8Kc3MK+E7iYS3B3NyA1UhF
         n2rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777024071; x=1777628871;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zyyE/r/iA1MwYNHXAS7P+Cj4G1v9/C9w7YzUp4f7iBc=;
        b=Y8lwnuOQq4raLsHuecJtKC8gdJ3SoMorRKRKz2ZnG2udfscf+AV+1dMCXeTAIdc9Um
         9unn5FqiJ9xS6Oksrkaloi6XIyd2hFftMdOUyJb02UN4AARic8SbEGuKofz5aGWNFnPY
         day8Ds4Efj9Kd8AXy7LBW2HYdwlDOfycz53Lye6M5V76leaYio/7/UQgvt2sCPpnEEH2
         SEnTW+xcf1XUX9qJOsUQBwQqmj9BtUWo2j7vbFKsFkIxKk+6dmT/QjA3Tsf3STWzh1kS
         aCgikr+ehlZ42eCZkGVYnj4CzqcdjT7BUkwEdDuDsEDop1Xh1xpNMbQUchD64IN5p8iR
         QlHA==
X-Gm-Message-State: AOJu0YxBeCT3j17Kn3twyREWCNgCbxOyRpvtO9C4aW6CwD4RF7T9JFuI
	0AFcXbAxtIDPeS4l1Wuau6Vw6DFyvs61M67PRe7mX2EWj2LWyR3HOgBOKk9BHrR7EUI=
X-Gm-Gg: AeBDievrx0twaGKJFr00Aq7ic2n5dd35toiwv6sxmNFApvUTqD8enMRJb+WXvniSUer
	Zv78Igrad1coXihWvPJtZuU76Y+0jNAuBBUwT1g8vGE70B5tnsae+U+TqmGsSISJ/YYxrYUccq/
	QUkjtXKEKSuF216lZ50e6VUsJ7Dx1zSq32CmGwHThfgGU86PxnCyJsyYUzeLOBKxY5hXm2Dbpjy
	PKp458o6E8ZT660ePhQr4QZ9guDQwbCbV+lb2pbLoeHw+LJ60mXIsD9GymH4ebgC0KGz73cUyfd
	6Jryp3SoyAUcgzWf2LzQahPPCGnyT+bHEXasjV5LoEFOTilQQoEw+1zOjTEMndoPwJJOgmrsukB
	8KMRLuZemFdrejQMTISfQN2akDQwpPC9d7C8JuNlZ5XhSp6O1MGbpQXiL7i7u6Nx36pCnDPaPmr
	WIl0zJGEDEqWV0Q/bcri+3ubDGTyvvtc2Pgr9qKDENmdn7GCU+x9bxT7qv/3SRnxh+IxJbRA0i3
	4J1hDaViqeMVwt4uA==
X-Received: by 2002:a05:600c:c4a2:b0:488:c078:bfda with SMTP id 5b1f17b1804b1-488fb78eebdmr426779015e9.26.1777024070744;
        Fri, 24 Apr 2026 02:47:50 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:79e1:f56b:445c:ca9c? ([2a01:e0a:106d:1080:79e1:f56b:445c:ca9c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fb75ab25sm179552435e9.11.2026.04.24.02.47.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Apr 2026 02:47:50 -0700 (PDT)
Message-ID: <fe284566-5a71-4b9e-940b-a36c58cb94a5@linaro.org>
Date: Fri, 24 Apr 2026 11:47:49 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v4 3/8] firmware: meson: sm: Add thermal calibration SMC
 call
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
 <20260423-add-thermal-t7-vim4-v4-3-d4c1528d5044@aliel.fr>
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
In-Reply-To: <20260423-add-thermal-t7-vim4-v4-3-d4c1528d5044@aliel.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/23/26 18:07, Ronald Claveau via B4 Relay wrote:
> From: Ronald Claveau <linux-kernel-dev@aliel.fr>
> 
> Add SM_THERMAL_CALIB_READ at SMC ID 0x82000047 in the command
> table and implement meson_sm_get_thermal_calib(), which forwards the
> tsensor_id argument to the secure monitor and returns the calibration data.
> 
> Also realign the CMD() column to improve readability.
> 
> Signed-off-by: Ronald Claveau <linux-kernel-dev@aliel.fr>
> ---
>   drivers/firmware/meson/meson_sm.c | 29 ++++++++++++++++++++++++-----
>   1 file changed, 24 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/firmware/meson/meson_sm.c b/drivers/firmware/meson/meson_sm.c
> index 3ab67aaa9e5da..4e57986724212 100644
> --- a/drivers/firmware/meson/meson_sm.c
> +++ b/drivers/firmware/meson/meson_sm.c
> @@ -41,12 +41,13 @@ static const struct meson_sm_chip gxbb_chip = {
>   	.cmd_shmem_in_base	= 0x82000020,
>   	.cmd_shmem_out_base	= 0x82000021,
>   	.cmd = {
> -		CMD(SM_EFUSE_READ,	0x82000030),
> -		CMD(SM_EFUSE_WRITE,	0x82000031),
> +		CMD(SM_EFUSE_READ,		0x82000030),
> +		CMD(SM_EFUSE_WRITE,		0x82000031),
>   		CMD(SM_EFUSE_USER_MAX,	0x82000033),
> -		CMD(SM_GET_CHIP_ID,	0x82000044),
> -		CMD(SM_A1_PWRC_SET,	0x82000093),
> -		CMD(SM_A1_PWRC_GET,	0x82000095),
> +		CMD(SM_GET_CHIP_ID,		0x82000044),
> +		CMD(SM_THERMAL_CALIB_READ,	0x82000047),
> +		CMD(SM_A1_PWRC_SET,		0x82000093),
> +		CMD(SM_A1_PWRC_GET,		0x82000095),
>   		{ /* sentinel */ },
>   	},
>   };
> @@ -245,6 +246,24 @@ struct meson_sm_firmware *meson_sm_get(struct device_node *sm_node)
>   }
>   EXPORT_SYMBOL_GPL(meson_sm_get);
>   
> +/**
> + *
> + * meson_sm_get_thermal_calib - Read thermal sensor calibration data.
> + * @fw:		Pointer to secure-monitor firmware.
> + * @trim_info:	Pointer to store the returned calibration data.
> + * @tsensor_id:	Sensor index to identify which sensor's calibration data
> + *		to retrieve
> + *
> + * Return: 0 on success, negative error code on failure.
> + */
> +int meson_sm_get_thermal_calib(struct meson_sm_firmware *fw, u32 *trim_info,
> +			       u32 tsensor_id)
> +{
> +	return meson_sm_call(fw, SM_THERMAL_CALIB_READ, trim_info, tsensor_id,
> +			     0, 0, 0, 0);
> +}
> +EXPORT_SYMBOL_GPL(meson_sm_get_thermal_calib);
> +
>   #define SM_CHIP_ID_LENGTH	119
>   #define SM_CHIP_ID_OFFSET	4
>   #define SM_CHIP_ID_SIZE		12
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
