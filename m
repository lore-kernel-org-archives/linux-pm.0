Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5729A26E6E1
	for <linux-pm@vger.kernel.org>; Fri,  1 May 2026 14:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777646005; cv=none; b=psOBAaomAqVr9tojldsQyNpZDoUaWCAxKo//DntV0r3pvJvXHA6BJhEBZPofnvqrd13uURt5+EQFHpaphTc41MtqxsHPQOqwqcRYC682lGZKZmKq8sIQ2xLWAjks/0YwHnOe4Kz+v051wmX4DnL4mrMzfSR4V2JcP1kQx6N7XYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777646005; c=relaxed/simple;
	bh=rM+ohjUAcsn8dXq0mb8PfyO9eXL54RezXFWp9ONY54M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RIo6ikJug98IhR7mCrIEYM2xWvWMfe3iE/wtxtWjZL/TZZCCUIoWyaR4oCB1ZXfhagBsYWDUTnp7pD3KL1u4/LRuMYn73WZk1tWHP8bZIq7Dn5U3o55rGkgYjwK5i7aCJlDW3QHlHz5GujwQ8cXRvZbXBTjGMzoLcbjD1TCoUBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tEcbau33; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tEcbau33"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4852b81c73aso13975025e9.3
        for <linux-pm@vger.kernel.org>; Fri, 01 May 2026 07:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1777646003; x=1778250803; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+5SFIqaEshVlX9LzlwHH+wo3PqHlpQWvbDIgoSHoIug=;
        b=tEcbau33Ob5YtTyQcrz2W+Cl6OvOVYR7jq6iHBP+ST0ZA1zGQ1+VJ/LtcCDszZkKiW
         4e3S4DEmvlsOPJZXUeJyQOjRxDtsyCMXaQvw76U5RpoWrAtcqzOPnYJISFPyP0CwZozN
         gkZv17Vkk2x04EhITaJZ8M/G3yCg8ZewkyittQ1M9A5eItqHtMIlFqLs1m55c1LHWKGf
         EAmVDvfS6NTSZsxk24AUeM9k1n7Z2FpJmYbTjKYc5K09JvrxPGqaWVlVN39OuIeI8tJQ
         sVAFPr5OxLZFXD7VSLd5xBMHPSm6witUm1McH4ptuvLooE9Y/S13wWj2vJmGEIvEknJA
         KzVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777646003; x=1778250803;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+5SFIqaEshVlX9LzlwHH+wo3PqHlpQWvbDIgoSHoIug=;
        b=ZaX3XrfScrCiS23z6QBTf/xxSaL0KU+E9Lm4WCZpNo0zSukr1Lzb1qrDUqJXR2HKyj
         jV0r3DvJTvozcHiL0XkS2wNBSau3kEuILogNQKDGTLWEIJQ0MKgSLv3/YuBrgVhKynVt
         8yGn6Ftvlu78yPM+lGDA8zFhQq0vPZYKnclVIYHRNwwGETsp2mqalbT6VDkc/2Xfbs1D
         myGef1DElzW/txM/JbSYvT6NsnnLbwpttx/Q+1o8RvqY422B6hPQBhFG+Ob6abdgpZp9
         Ga0cjAAzmV91Rc7ghR5mkJvpDnEAG8eW+8ckPNEngt/EUOGUAVwLlP2SANFkvDKq5oE+
         NlRA==
X-Forwarded-Encrypted: i=1; AFNElJ/VRoG88PtEuxEnYvGDDmQw4PRCJIHIGREMnU1bn87SMJyI0OiVFdCkDQYEkUBBa4uhKDrWAgH3cA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzboUibEHY5tfFOibWj6rvHcUlf0dh3tf9jgrBaU8vBQfuYqGJl
	gmJp+NiIs5DTUjeMK58CfDepw+MVb9vQinOiJ8Lm91r+abOOBQm7bjBbMk4X9L7Vbiw=
X-Gm-Gg: AeBDievcJ7F24Rw71LuxOVWAkw9PavEeiJ9RAlPPBHW4ZyeBxXPcwkFtUfPyLeZeQDB
	H88S2wucGkr6Jpip2dYamEoDq0VATWKFR1K7ejUbrBj//YpDHSFvq75XPgAKSLf2yLJu+jWUG55
	H4Lt85H4iTTDK20Ow6PSqg6GRmsOuCN+7zgykmauiPiAoPBsAG/R1YngA7o2R4lzwqR06akzwYO
	EbNv8eiM6sm5Ejxan8HZjI+cDUVPo5CZaxmMNU9Ht9a4HIH7n69r4mRCGm+xOy8ay/oRjMYUSl6
	fPdRODrQC21WfRUM0xOAmOAaHFgaxALkZe2vsfJ0L62OasrhP6WyvA/g1xTIomp0aKJQkRXI9ek
	isuV1NjsCoiSmWjSDPUZ1kXIN+JnIl4l93nBrWqHVBp2FIC/98qyY7qhphzIoiMMjnKo0/6wmWG
	rJ2R75cbmzjVVrWhZ1tyfh/RmjNMzXmqNwz8vE2syICE0=
X-Received: by 2002:a05:600c:49a3:b0:48a:8b02:ae91 with SMTP id 5b1f17b1804b1-48a8b02aeaamr51995435e9.11.1777646002848;
        Fri, 01 May 2026 07:33:22 -0700 (PDT)
Received: from [10.11.12.108] ([79.115.63.228])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a820c8556sm132049825e9.4.2026.05.01.07.33.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 May 2026 07:33:22 -0700 (PDT)
Message-ID: <b9fa48f1-0ace-4a8b-b2bf-b5e01f789f7b@linaro.org>
Date: Fri, 1 May 2026 17:33:15 +0300
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/11] thermal: samsung: Add support for Google GS101
 TMU
To: Alexey Klimov <alexey.klimov@linaro.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
 Alim Akhtar <alim.akhtar@samsung.com>,
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
 linux-clk@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
References: <20260423-acpm-tmu-v4-0-8b59f8548634@linaro.org>
 <DI7D7JXW4RGK.XB0BE6ZXNMHS@linaro.org>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <DI7D7JXW4RGK.XB0BE6ZXNMHS@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/1/26 4:13 PM, Alexey Klimov wrote:
>> Dependencies
>> ============
>> - context dependency on the ACPM fixes sent at:
>>   Link: https://lore.kernel.org/linux-samsung-soc/20260423-acpm-fixes-sashiko-reports-v1-0-2217b790925e@linaro.org/T/#t

cut

> I've took series locally using b4 and result doesn't compile:

take the set linked above as well please.

Cheers,
ta
