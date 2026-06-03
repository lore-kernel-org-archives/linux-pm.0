Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A1C628F5
	for <linux-pm@vger.kernel.org>; Wed,  3 Jun 2026 09:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780478776; cv=none; b=GrJLV8bVjiP7HAsNK2pBndswaTpExspwQ/3EaQryM2St8ydEWXfPQ9tu5EqyN4CpgXqBkZj1ykZmF1n44GUkvcV+yXJAK9/zohrmNr0EnhxVnK4wBpJFpI7etYP/qK6N8KbCELKHhsQTnPwDkBehIWIxdFvN2IQ4fPMwPjhthhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780478776; c=relaxed/simple;
	bh=IRixWQMwizXFdhkvvgBqMpo7g1d2nL7BH7+e0C+a08c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T3YOl/Xb/9FDUkWsDKLENbhJHLN3fFNztShsljU5TU5bbVyIApyF7GyYKBbWWLnos2hHCIgjhMdOpRamMmmQ6zEruThWKTUbeHc8hREp+4F1XIQTJc70Pe2uSsZUjkGoGKoeZ0Js0S7TSjSxG0cQrmd126L+MMKS73YR2nJDZZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lTFed7pm; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lTFed7pm"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-490b2b037d2so14233405e9.3
        for <linux-pm@vger.kernel.org>; Wed, 03 Jun 2026 02:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1780478773; x=1781083573; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LVv22gZyTmtymIxhoGte2pKFNDZ9dT7qVuNtoXNbMUA=;
        b=lTFed7pmMZ9uNCoZyARWr5g75M74ezYc785BMdLbnW3+GprgZFXL2z7BiQMkkClVQy
         kE0iWjhW/CCeFhJORITaU0rp7nqJo0uF1x1xyeg8komFjBHumA6y+wjMuuktiw0u2dHt
         hjotIolEewzWLC1X+8uvAK4/jrwTQNrqL6SHEIACpfNQwJCKKTcp8hW4gxN2HcbGWzuL
         gCs35UAASBnHOSmjRoJ9uWtApnrrnUpTc4kpGKnghjOSml/WecpQWqkTSbV8BpyA780j
         jOQuE2YvFApmYQJl7O1Gk5sfcvkcx/a/kBC9Qm1cdkAiPYIMzVqCWlRX2g+ee/kS+G8i
         SQmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780478773; x=1781083573;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LVv22gZyTmtymIxhoGte2pKFNDZ9dT7qVuNtoXNbMUA=;
        b=WYgN4jTMMW+cBqddoMNnQiOGfRotWu6Xl7htN1oB2Slq8cQCxjFGxNcGQIPIpFuRje
         v7VYLdOOM5LKcY7IweFB3HcFIkpWXrVUxB2TeN6iCvLtQijChF5rbNlXOWSn/gwVKsSI
         zlsGTqsc3csBhviacpq+BEucomg/mQWlApiPMPl+GFw2zzif2aea6weCgmTV8i9OKHDW
         It0CA9Q4nX9VzIioMmE89oSO5AmHNaJc/tCgY8OmnRDF09gctPAjQrHyI111Irc5YnUw
         Dq1o20cgP8a3YMTLhp/jNiY08bn/S/C+l481FKC3oTsTxsH8n91qVYw3WmGza+CWXuBL
         9/tg==
X-Forwarded-Encrypted: i=1; AFNElJ+ceDshRle0owsqh6heLNBA6ad7OdY+wk/jlOO5yI4yKX0dd3zy3mXfikVIaOWX2rxubTgw8UAnAg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwlgjFy9s2jXhNXJfOcXCmL36az4Q+dh3Zx2tcnhOR3HXXYNcYA
	0erINcHtzOV5qUY2quFO6/asAFSvoGHVL4RkR1PIE89/l2LQivmTPxZWshgPSHfzEqg=
X-Gm-Gg: Acq92OEI1PKokxgD6RnfmLm37DJmCwwsOsRksHklVhVCGc9AJUz8ZcQnCwiKn7NfU4v
	mbDWYgVxytDkt/m8wMMPWHIUTf4Y9wTq7o1WymSqIDNw9mheK+i9M5ERbDa2cY4/RewwyUAEJnz
	fgaEqmO6rOvjPvUXucS+5fHHqR6/55T2v59cWMCevwPGj8W3SJL+KpANP32UfttKxCEL/LVl+RN
	gYgpZAUzsqjn9fWtcbIVcXgF8ovYFO1mvkl+f1nJVvhrIhRwb6qspYT05cc0U9mLeKLYf7eWxjM
	5DtJCkD/isWjHMe7T7f1CuU9CnwmGGDd0uhngqWsAkvzBh40sVvWFcCdQPq34/ELTFe4o+9Y/zD
	Zi2nmEpn+8A81U3S9Q5miTycoXoH3jWmquThmvDo8BiewJlr/RvWBFqHr4Dgx5YLEgjZ5n/OIsh
	iu829k1dFytvJULTpC3izY1KEh2DBWlMBuJx+LkLH61g==
X-Received: by 2002:a05:600c:45d4:b0:490:5074:651e with SMTP id 5b1f17b1804b1-490b60ef350mr41726765e9.25.1780478773360;
        Wed, 03 Jun 2026 02:26:13 -0700 (PDT)
Received: from [10.11.12.110] ([82.76.215.73])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b79d64e8sm35451535e9.0.2026.06.03.02.26.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jun 2026 02:26:12 -0700 (PDT)
Message-ID: <c76c8f9b-bdd1-4006-aa28-735254f0409a@linaro.org>
Date: Wed, 3 Jun 2026 12:26:08 +0300
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/5] thermal: samsung: Add Exynos ACPM TMU driver GS101
To: Alexey Klimov <alexey.klimov@linaro.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
 Krzysztof Kozlowski <krzk@kernel.org>, Kees Cook <kees@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Peter Griffin <peter.griffin@linaro.org>,
 =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: jyescas@google.com, linux-kernel@vger.kernel.org,
 linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-hardening@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
References: <20260602-acpm-tmu-v7-0-8047dd54b0e9@linaro.org>
 <20260602-acpm-tmu-v7-2-8047dd54b0e9@linaro.org>
 <DIYTOGU8I2DV.1GKZ59F7AJWTE@linaro.org>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <DIYTOGU8I2DV.1GKZ59F7AJWTE@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/2/26 10:49 PM, Alexey Klimov wrote:
> On Tue Jun 2, 2026 at 6:00 PM BST, Tudor Ambarus wrote:
>> Add driver for the Thermal Management Unit (TMU) managed via the Alive
>> Clock and Power Manager (ACPM), found on Samsung Exynos SoCs such as
>> Google GS101 (and Exynos850, autov920, etc.).
>>
>> The TMU on utilizes a hybrid management model shared between the
>> Application Processor (AP) and the ACPM firmware. The driver maintains
>> direct memory-mapped access to the TMU interrupt pending registers to
>> identify thermal events, while delegating functional tasks - such as
>> sensor initialization, threshold configuration, and temperature
>> acquisition - to the ACPM firmware via the ACPM IPC protocol.
>>
>> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
>> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
>> ---
>>  drivers/thermal/samsung/Kconfig    |  19 ++
>>  drivers/thermal/samsung/Makefile   |   2 +
>>  drivers/thermal/samsung/acpm-tmu.c | 618 +++++++++++++++++++++++++++++++++++++
>>  3 files changed, 639 insertions(+)
>>
>> diff --git a/drivers/thermal/samsung/Kconfig b/drivers/thermal/samsung/Kconfig
>> index f4eff5a41a84..383ae3f56cbb 100644
>> --- a/drivers/thermal/samsung/Kconfig
>> +++ b/drivers/thermal/samsung/Kconfig
>> @@ -9,3 +9,22 @@ config EXYNOS_THERMAL
>>  	  the TMU, reports temperature and handles cooling action if defined.
>>  	  This driver uses the Exynos core thermal APIs and TMU configuration
>>  	  data from the supported SoCs.
>> +
>> +config EXYNOS_ACPM_THERMAL
>> +	tristate "Exynos ACPM thermal management unit driver"
>> +	depends on THERMAL_OF
>> +	depends on HAS_IOMEM
>> +	depends on EXYNOS_ACPM_PROTOCOL || (COMPILE_TEST && !EXYNOS_ACPM_PROTOCOL)

I forgot to drop "|| (COMPILE_TEST && !EXYNOS_ACPM_PROTOCOL)", ACPM is NOT
optional for this driver. I will comply this way with Arnd's solution from:

https://lore.kernel.org/linux-samsung-soc/178006367096.55906.16678510397337205828.b4-ty@b4/T/#t

>> +	default ARCH_EXYNOS
>> +	help
>> +	  Support for the Thermal Management Unit (TMU) on Samsung Exynos SoCs
>> +	  (such as Google GS101 and Exynos850).
> 
> This driver doesn't support Exynos850. There is no initialisation sequence
> and etc, moreover the next section is also not entirely correct for Exynos850.
> Not sure why it is mentioned here in such way.
> (Not even mentioning that ACPM TMU part is not aligned for Exynos850)
> 

Okay, I'll drop the reference to e850.

Cheers,
ta
