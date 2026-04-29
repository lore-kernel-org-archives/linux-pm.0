Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC7A374E76
	for <linux-pm@vger.kernel.org>; Wed, 29 Apr 2026 17:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777482173; cv=none; b=DcbnQWb/L2bZ2EvIKW7xtC+iCmkbmN3v9DiIjBIFTsYgPGKS9tVOz4rl8P7EYgGUkTo9jQmcmF6UvUhJ0jOi4fOOggSMV0Qui8OMDNlOVe1Ymc3zdchETBv4rL1VEs71lb53qtnTyvtPgcsQ5wBGpEeo5PkWzC5ydAHqyajaA6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777482173; c=relaxed/simple;
	bh=oP0CV+puQtnqAudPjWQ6eG2kcGlvGEf4j8WHFrP4gG4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GdsgG92ZPzS/1pMO8wOCYCJG5NLjvJICtOIPdGX1wf3d3bq4mngJDfIsdlGwkkyu7y3q7jaC5LGjnR58yJfeEGULsGRZYUYYSLws7lIn0HbGUj6p9vgzUR8z1L228D9MQvOZEUBAa4he/7U3W1DZqEKupdBfdw7fTNnhcU4E+1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=M8ZDn9J8; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M8ZDn9J8"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-488b0046078so115811955e9.1
        for <linux-pm@vger.kernel.org>; Wed, 29 Apr 2026 10:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1777482168; x=1778086968; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0DSk2ikmD/TKHxP326DjLJj6TQaKaQdWjt46lW8P0oM=;
        b=M8ZDn9J8Msr3NDylCnVIxwOwQz08PjGveWyRb7/XjqkWB5UDx082NPsg34OU9g6aPJ
         TqcQJpVTaakQuUf9Y2g6yj5Isf7op9kV6MbFG6wACZofFn8TMj35e5KyPoSFl5pwuuQH
         6sBItpme8djYXD0GoY5kYPmKOhFpbKCPS4EJ17m5wVjlZBSMk+CDzN8c5Zr0jz5tJdkS
         u9taszG5vc0LCQ2EzpSe3MoyXYj0Uv4DSNEEmOVtt5oJTf1jy6mfnPWkvb/UkjmGs/D1
         NN3BAwVUlMXWaxesZAR6VG/PGwIDyqYgC2PevACW14bE7u61kuE0DbDN5FruguT3Y4Zz
         Mqjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777482168; x=1778086968;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0DSk2ikmD/TKHxP326DjLJj6TQaKaQdWjt46lW8P0oM=;
        b=eG5/yEHVX3+XH3F48kWgI032N5Locvn/2xeDjlaoviHz9UQ7aj/oHWt4wPPxEaDspn
         /6qyZ0td4uDWR/GohcjPvP3Pl7gxe8Z2PV1tG8oIWKy4zmrz0vp/+UvQt20yQKum79sI
         dM0y5TlAjPbMiroeI9LgyAZeN89oDT9+N6cL8aEz9+Eqo5j9ZJC4BkQLx/ykgCEH9mvm
         CAjOL3Y26/Z91N5g76PpCa+pRsA9ibHf/BetlwF1pIPtsmjG4IB4ZKPm0+xusZYJQku/
         Rbzr0xST7pap123CTuyilPjREvg0eHwdUHovRhzltzLKZqSiYYrbk65nmoyciooTbL9A
         IDjQ==
X-Forwarded-Encrypted: i=1; AFNElJ8fAg0vCu5nacgKId0vH2t7D2j0BiIgJUYPmAiuALWI5KxnaW6smIbsIoaexXP3SNRBmP+q4qV1tw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwPHQkFgjVUvT8TGAwLKtVxyUCPCvOUrcB/WKxhHv1HO9rRNC0D
	u92NpFrhNupVDr39aY+gAVkS0l+HfsS9+0RqCFqFVL6B30hRzI5zz7hQsqjjcfstPcs=
X-Gm-Gg: AeBDiev8zzl+R7AYu8s2f5SONFRsw9MgysK8f5sC1frHcoYd1/hBpZqqNGmUA/tKswU
	FDtFgpucODQu9em/9qziF4WAZbt0wGCnmmCeMsBBBxog5WZJpMCuKhGZFPgcTQ+tprde3uJeeBl
	/Zkk2u/VvKmRyzpUK/KUjR0qvRKNnfm4lOIk/Bc2L4OaH4KZ7O6ZNWB9YnS9LNw7U5cRL4ult2p
	pjHj9+ZVEIfhPwWfuD5Itu/hBRuX/9IsA9ifpfMfS93soSZfd6yAa03LG8n1y+9WUvIXXf6xpM7
	MeBcH5kFwUwa+wq99glodC6rM5/QyDNxcEcsgaJDb3OO5lI6HtORRFGguPmSDQxzWmLZXx+B8Rg
	EAt+miG7fBG/uHjlDAqLsvoO7tRqw5vHR+7GPgSnNR2kTVdEtshE0fY3EL5Cd1vrP5+RnwMD+xD
	FTm6N7a9c87qESxFwnyawnmsvmJP43I0H1PRjR4K4qDZk=
X-Received: by 2002:a05:600c:4f0c:b0:489:1c2d:211e with SMTP id 5b1f17b1804b1-48a77ae5386mr141380935e9.5.1777482168330;
        Wed, 29 Apr 2026 10:02:48 -0700 (PDT)
Received: from [10.11.12.108] ([79.115.63.228])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-447b3d481fdsm7255405f8f.8.2026.04.29.10.02.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Apr 2026 10:02:47 -0700 (PDT)
Message-ID: <83c64dc4-6dd8-4edb-8acf-3c731048d73d@linaro.org>
Date: Wed, 29 Apr 2026 20:02:44 +0300
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/11] firmware: samsung: acpm: Consolidate transfer
 initialization helper
To: Krzysztof Kozlowski <krzk@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>,
 Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Kees Cook <kees@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Peter Griffin <peter.griffin@linaro.org>,
 =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
 Daniel Lezcano <daniel.lezcano@kernel.org>,
 Sylwester Nawrocki <s.nawrocki@samsung.com>,
 Chanwoo Choi <cw00.choi@samsung.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Lee Jones <lee@kernel.org>
Cc: willmcvicker@google.com, jyescas@google.com, shin.son@samsung.com,
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-hardening@vger.kernel.org,
 linux-clk@vger.kernel.org
References: <20260423-acpm-tmu-v4-0-8b59f8548634@linaro.org>
 <20260423-acpm-tmu-v4-2-8b59f8548634@linaro.org>
 <a63d4dc7-b01a-4da2-ac1f-6679c9030db6@kernel.org>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <a63d4dc7-b01a-4da2-ac1f-6679c9030db6@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/28/26 12:25 PM, Krzysztof Kozlowski wrote:
> On 23/04/2026 17:22, Tudor Ambarus wrote:
>>  	acpm_dvfs_init_get_rate_cmd(cmd, clk_id);
>> -	acpm_dvfs_set_xfer(&xfer, cmd, ARRAY_SIZE(cmd), acpm_chan_id, true);
>> +	acpm_set_xfer(&xfer, cmd, ARRAY_SIZE(cmd), acpm_chan_id, true);
>>  
>>  	ret = acpm_do_xfer(handle, &xfer);
>>  	if (ret)
>> diff --git a/drivers/firmware/samsung/exynos-acpm-pmic.c b/drivers/firmware/samsung/exynos-acpm-pmic.c
>> index 0c50993cc9a8..f032f2c69685 100644
>> --- a/drivers/firmware/samsung/exynos-acpm-pmic.c
>> +++ b/drivers/firmware/samsung/exynos-acpm-pmic.c
>> @@ -58,16 +58,6 @@ static inline u32 acpm_pmic_get_bulk(u32 data, unsigned int i)
>>  	return (data >> (ACPM_PMIC_BULK_SHIFT * i)) & ACPM_PMIC_BULK_MASK;
>>  }
>>  
>> -static void acpm_pmic_set_xfer(struct acpm_xfer *xfer, u32 *cmd, size_t cmdlen,
>> -			       unsigned int acpm_chan_id)
>> -{
>> -	xfer->txd = cmd;
>> -	xfer->rxd = cmd;
>> -	xfer->txcnt = cmdlen;
>> -	xfer->rxcnt = cmdlen;
>> -	xfer->acpm_chan_id = acpm_chan_id;
> 
> The code is not equivalent. RX bits were always cleared. This should be
> explained in the commit msg which would also provide a proof that you
> actually analyzed if it has any impact.
> 
Indeed, my commit message is inaccurate because I claimed the
acpm_pmic/dvfs_set_xfer() were identical.

There's no change in functionality: in the original
`acpm_pmic_set_xfer()`, the RX parameters were unconditionally assigned
(`xfer->rxd = cmd;` and `xfer->rxcnt = cmdlen;`). In this patch, all the
updated PMIC call sites now pass `true` for the `response` argument.
This ensures the unified helper takes the `if (response)` branch, which
performs those exact same assignments, preserving the original PMIC
behavior.

Will update the commit message. And revisit the other patches when
splitting the firmware patches into their own set.

Thanks,
ta
