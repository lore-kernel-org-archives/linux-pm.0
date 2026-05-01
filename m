Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844AC4279F4
	for <linux-pm@vger.kernel.org>; Fri,  1 May 2026 19:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777664433; cv=none; b=Pk8TApdoATm4tp0G+15LHPMlAnTrKy817dSmksQ6l8l3kmblB46wmmBCIEG4cARBvweEPtVP8iFw2wufsjsye8iZfnz+zypgKzd+GHqEfetrrl+kSvcaZRncUAI0MWS/gFRNAk7Gt0/qyBcFbnNOv/ItPfi9Db4ULTit97hVdfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777664433; c=relaxed/simple;
	bh=E9GFsmnekKsH/6xM/QZ53TOVyqAnriWM8ZLZsUdfH0g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RolIw5fgvyGD1OpRXEzIEe93U6RXWb90dyCDtOsnLAOn6m02T/UmBTzVbultcGyy+gtLjyZukxJILzwMOWpLJx3HDebkdZjQ/XAa9jrO3xIT7PTkGPQ6c0f+j/sIMZX3+QQzhlaNtPDtNi3382N+bY4GXDpDUe2MNYsu2ob3//M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=A6/LXLux; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A6/LXLux"
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-2d832f2f44cso2200117eec.0
        for <linux-pm@vger.kernel.org>; Fri, 01 May 2026 12:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777664431; x=1778269231; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E8+F67fOWD2tr6DD1heUFiUUyHmOTJ/tbCdix11hm8s=;
        b=A6/LXLuxJ8XcC2Fc5pdvW/0ZJL+ZBde+DkBuerXiGdL8cQI+yJo4IpV4GSYQHGtcKa
         wh11areNtoznpPdyaFxL8bT84RU0/u+vrULMzJLOi3UQ0hOjzsc4gCwrd28CursQ1qwH
         /G1FDZZt7lcCW4/WKJJXhNQNnBHc8vkmkPCBiB8+ClbohYqi0jJ1DuSf8Nm6OSKkzitQ
         Yo+9+uzibOrV8VbiMElyZYndw8Os8ZoS1/PI2vvhDDv+PUTZCLivSVi2lo4lv8is7pBK
         JVoJj9Iw6mVGe4emApKt+pdhF+FkCx/22ZR6o2fSj6eVyjJ2oF/n/BfMHCEmMWVvPNZf
         r2Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777664431; x=1778269231;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E8+F67fOWD2tr6DD1heUFiUUyHmOTJ/tbCdix11hm8s=;
        b=Ww1zQ0XcuVOHVb+4lemYvJjgGKL1G8EevPJLNX2s7iFfWpCSWrEM/xLBacMX+0yTGo
         Vc4svemqbF6cu5h09m5RJH6jhGUG5ej8vYDuuGGFRI5rTT5ZaDnNLYME2Mfnj0UAuIRA
         43QjEoQkmCQlyaibCWEMM1MSlEAMr1TFU3dDcWh1GePoqx7REuTefuMrzJLjFVeVHXpl
         5Tcr9VeqyAeQZLj2c9F4h85B+TBi4B5WCr80vhae2vo6yBDTCFcVmf0xZOrr5Z0kHrr3
         0WvjNWHvyxGBHNaceTDCAy8XgvsubyEMLwaGMHxB8uw9k2a32EGYNmraiMSnWdUo8MqU
         prOg==
X-Forwarded-Encrypted: i=1; AFNElJ86ZrPfgkhRNb/8sivmtZ7188RIAqgK1qkqwHKibgWwKxMD7y9dWIQJpZAKmfQt+6Ld5pj9GUQFwQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxcqUzV5S603pevnGzNoLZs1BvneaURvhJ7AdYe/JoyPq7F2xGS
	bHrWrmSCl2aj8At1Os4Nvst+YoE4qc7EPztfr7NYLunv3Q1kGuDwxo7qUExU3xmFLQ==
X-Gm-Gg: AeBDievuAZajOGc84yiKD5pRcbrKYYOqk3W0SE+5FMb0WDHvtsTCxG6qQLhtRScfn+N
	jLwZquV4X+rPxoyNfC3Zdk6GpQ9eVZksrLsJvc9fCvVSAvd03detq0nJHqZpzTiTCD19X7L6Hgh
	KZ85NzZCqNqCBPWoNcC3k/iVGGpBRlq/4fp+Zx1LAreQLoVOKAUsyo75iz2V07GW3qgijdx/Ada
	N4Bqo3cvBdl3p3mbjUmk6dUlz50mmazQhKEx6cmd2aFQQAnP1fCYAM5ifhPXxK5hUwwKsh0zrDz
	K7Kzf16loD+F0eqR9napA36HRZLdX7sADFPuH4vIvLhHbUecusN/jrbsdDKnt1VaRRhao4gMz08
	P/QyvtTQ0Rd3OaE51gSDKJP5ACYjvjl/TEm5csX3Q6HicEUJpWEJcqoPrn7BBPGGQgGRwFcFgm9
	Gvt7huJuktoeO1wkD4L/tMO21tfFuDd+kuFRxJ/vzObkJQuuWAd6dWCdAb47OlCqUJBU/9bcfVf
	rP2J1459bJw1IMnvgkmhIbYV1zGId4qKI+h1BjybdCDM9w=
X-Received: by 2002:a05:7300:6c12:b0:2ed:e12:376d with SMTP id 5a478bee46e88-2efba5a7316mr301846eec.35.1777664429125;
        Fri, 01 May 2026 12:40:29 -0700 (PDT)
Received: from ?IPV6:2a00:79e0:2e7c:8:5e5b:112e:7ef4:6fe2? ([2a00:79e0:2e7c:8:5e5b:112e:7ef4:6fe2])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ee3b390df0sm5587081eec.17.2026.05.01.12.40.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 May 2026 12:40:28 -0700 (PDT)
Message-ID: <d5d36882-5356-4b7f-a73f-70b8edba28d7@google.com>
Date: Fri, 1 May 2026 12:40:24 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 3/6] mfd: max77759: add register bitmasks and modify
 irq configs for charger
To: Krzysztof Kozlowski <krzk@kernel.org>, Lee Jones <lee@kernel.org>
Cc: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jagan Sridharan <badhri@google.com>, Mark Brown <broonie@kernel.org>,
 Matti Vaittinen <mazziesaccount@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>, Sebastian Reichel
 <sre@kernel.org>, Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Peter Griffin <peter.griffin@linaro.org>,
 Tudor Ambarus <tudor.ambarus@linaro.org>,
 Alim Akhtar <alim.akhtar@samsung.com>, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org, RD Babiera <rdbabiera@google.com>,
 Kyle Tso <kyletso@google.com>
References: <20260331-max77759-charger-v10-0-76f59233c369@google.com>
 <20260331-max77759-charger-v10-3-76f59233c369@google.com>
 <20260424082639.GI170138@google.com>
 <fc767096-f39d-4088-b3ad-cc85bdedf36c@google.com>
 <80599996-00e9-4e6c-9215-cf1c33a861bf@kernel.org>
Content-Language: en-US
From: Amit Sunil Dhamne <amitsd@google.com>
In-Reply-To: <80599996-00e9-4e6c-9215-cf1c33a861bf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Krzysztof,

On 4/29/26 9:59 AM, Krzysztof Kozlowski wrote:
> On 29/04/2026 02:29, Amit Sunil Dhamne wrote:
>> Hi Lee,
>>
>>
>> Thanks for your review.
>>
>>
>> On 4/24/26 1:26 AM, Lee Jones wrote:
>>> On Tue, 31 Mar 2026, Amit Sunil Dhamne via B4 Relay wrote:
>>>
>>>> From: Amit Sunil Dhamne <amitsd@google.com>
>>>>
>>>> Add register bitmasks for charger function.
>>>> In addition split the charger IRQs further such that each bit represents
>>>> an IRQ downstream of charger regmap irq chip. In addition populate the
>>>> ack_base to offload irq ack to the regmap irq chip framework.
>>> Please reword this commit messages.
>>>
>>> Using 'In addition' twice in such close proximity reads a little awkwardly.
>> Thanks for pointing it out. Unfortunately, this commit is already part
>> of the linux and linux-next so I am not sure if I could fix the commit
>> message retrospectively.
> I don't understand why you decided to put this with USB patchset. We do
> ask not to mix subsystems all the time. You made it unnecessarily
> combination of at least three subsystems.
>
> Do not do that.
Thank you for the feedback. I understand the concern regarding mixing 
subsystems, and I apologize for the extra overhead this caused during 
review.

The decision to group these was driven by tight functional 
inter-dependencies that I felt would have caused build failures or 
regressions if split:

MFD & Charger: The charger driver relies on new macros and symbols 
defined in mfd/max77759.h. Additionally, the MFD driver handles the IRQ 
chip initialization and defines the named IRQ resources that the charger 
driver requires to register its handlers.

Charger & USB Type-C: To avoid a regression, the charger driver needed 
to take over charger mode programming from the TCPC driver (where it was 
previously handled as a workaround). Merging these separately would have 
created a race condition or left the hardware in an inconsistent state 
during the transition.

I see now that this made the patchset difficult to manage across 
subsystems. For future cases involving such dependencies, would you 
recommend providing an immutable branch for maintainers to pull from, or 
is there a different preferred workflow you'd suggest?

Best regards,

Amit


>
> Best regards,
> Krzysztof
