Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9056D37AA9C
	for <linux-pm@vger.kernel.org>; Thu,  7 May 2026 19:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778182752; cv=none; b=OCKJv+4G4GGyJwlTwZ9Uwm21nt0qdcfUTC5/rnaPZ6cZZseVetXqvTlkQZY2393fG2+oDh3GDt53d1yuYPPRZNQ/uY4gTdFpcdar6I7spRlySx3Ni0/Zti2QYiufUQxmH4pNQf3nV2sGK0w4bXycurdtVs3asBV8mpTayz56m9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778182752; c=relaxed/simple;
	bh=jKnGNKLqkB8e0df/XKOKodfYrWmIj9cCVvEjPQpZrkI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UUc7SpeE+Reol+oJuH7n4OVQ2ntoclnEMRJIjV/IZjybK+U5mpHPK0wtrz2+xCISDuDrvujhSLUWLgkcJleh8ic5TwPbXkhGJ3fvq8LG1A7mUmdCR1Ihewvsff3lZfwQEgWivZhwGyiQ/m19Iyo5TMLXH3RlGD0s7pjmIfhoXAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CspOxCzI; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CspOxCzI"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b8f97c626aaso217502266b.2
        for <linux-pm@vger.kernel.org>; Thu, 07 May 2026 12:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778182749; x=1778787549; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HtUJyWhJ561fYSVag2QyjsbPKhV41JyyzBoUWpnRnL0=;
        b=CspOxCzIqfROLf+4CckaCs5hMw3yebEWWKkwREfo/8CzFRLP6/EMaVHyvXWHv2JkQ0
         wFjsyX0WqYdCOdpuQeAHg5oO1p9+wJd9bv8aL/8z0DdCA79ET8YEASxuKGGnYIzQutDP
         iNGgLC+au7l+P42D5SHkjuxez8eSXoNUGk9gQh4p0EWdfPlEtXKFOxPmKNGAj2zJQUTB
         74YXUPABMCj2b2KjwbBGW/OJzPtu9NRzL+2qEent+58w2XMvSvFf+PBhUwDPFI4USwd5
         MsoI2k0Q6rvMK/2Gsb7kCI+bNaelvHUkUzAlfzlW4bEoNqteFqtiNnTXJGKnWAA/FJsB
         jQ9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778182749; x=1778787549;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HtUJyWhJ561fYSVag2QyjsbPKhV41JyyzBoUWpnRnL0=;
        b=aK92QG4xp9VU+dvSLHu2gb4Ar2gFXu80z9ICbnAbdIiFfcRNrmuUqRB17DbbrJEPMM
         Ce9zNHobashFCJ5Z26C95zc9PEGmhHFgntntxc+XOzoYKjIs6VA6fEZ2sOds8soFiPHY
         LsMYqBd/tepRmPcB0H/UKwkDFP0zH+/O/Ykm9WuDNQf7cjmiszGxOQfZcNgDqbhI9Pj9
         wSZEby5UGS2yyUJQWnp47Mp8VCSmoNkD8djfaTQlEZKr6RVYV+tX0xC5H6+gklstVYLz
         EfCS1LiCW+jhAj6ScnX/ZucHoSV20MP2ZNsCb3xWRTdsX7x9tFTmmZU9xtLNanln5DS4
         jSJA==
X-Forwarded-Encrypted: i=1; AFNElJ+FLSRbYTfeZSWtJwo2JeEcjp+CD5Cm3P8p2SRFWvWIFcut2/AigEPc7Fkef1QWFU71RET1+BVEjA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2M4G8s41TcECdrZQWnbRJSYeYcAGNwkclmhAvV0XLe4dTAH0I
	5c3fM0n/H/crRTrfxLuru3PDzhJ2I6MHViPuF9990WvPfxtsrtiNPkzA
X-Gm-Gg: AeBDieufdSvvDfsCD2g5lqztmpfEd1QGIUJwTovZJ413idOYLJ28/AFbXKyUnGHt3+j
	wYwDmev+YwCvo2eBGft5W0Zn1Up8cFG1UQUG+uEEKdvipo5lSW0JhP4dSq1kKWk+zZrtRn5L7lw
	8qE4cezJnkE2aQmqVvnBKiQu8T9PhifqK/76hlm44XC4MSLW0/2BEpZOhxBqI9pHAk+WRUNL7Ev
	7jDOvi2tWSQH/1yx5nhdmswz37s517hNBJLuKI355Ts5ta1fgJq4/1wQsqrP0i9lWtLCXkzpC6A
	osEW9TauudIxCwrayaZK7LXR2usPyaNLz+uGVa5CNN9qJCeREEWhgbtbnvomHPkS5IxcWPWjnZr
	rJv5eN0iCkWI3X+HFzhaYez9FCxh8ajUemlA5i1Dro9Z+5qwF84OrhNgFW7DzI3ivO8yekK/XZd
	fdFSMJwf1R0Y/uXWizUUqbroxDimg0Nl88Xs+8ChxnEiO4Vg==
X-Received: by 2002:a17:906:6a26:b0:b9d:e301:20db with SMTP id a640c23a62f3a-bc56e316a92mr576277166b.25.1778182748538;
        Thu, 07 May 2026 12:39:08 -0700 (PDT)
Received: from [192.168.0.193] ([194.183.54.57])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bca578b332fsm20347966b.33.2026.05.07.12.39.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 May 2026 12:39:07 -0700 (PDT)
Message-ID: <80d85385-f5af-44e3-b9ed-d4489542d4da@gmail.com>
Date: Thu, 7 May 2026 21:39:05 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 07/11] leds: flash: add support for Samsung S2M series
 PMIC flash LED device
To: Lee Jones <lee@kernel.org>, Kaustabh Chakraborty <kauschluss@disroot.org>
Cc: Pavel Machek <pavel@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, MyungJoo Ham <myungjoo.ham@samsung.com>,
 Chanwoo Choi <cw00.choi@samsung.com>, Sebastian Reichel <sre@kernel.org>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Nam Tran <trannamatk@gmail.com>, =?UTF-8?B?xYF1a2FzeiBMZWJpZWR6acWEc2tp?=
 <kernel@lvkasz.us>, linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-samsung-soc@vger.kernel.org, linux-rtc@vger.kernel.org,
 linux-doc@vger.kernel.org
References: <20260424-s2mu005-pmic-v5-0-fcbc9da5a004@disroot.org>
 <20260424-s2mu005-pmic-v5-7-fcbc9da5a004@disroot.org>
 <20260507164654.GS305027@google.com>
Content-Language: en-US
From: Jacek Anaszewski <jacek.anaszewski@gmail.com>
In-Reply-To: <20260507164654.GS305027@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Lee,

On 5/7/26 6:46 PM, Lee Jones wrote:
> On Fri, 24 Apr 2026, Kaustabh Chakraborty wrote:
> 
>> Add support for flash LEDs in certain Samsung S2M series PMICs.
>> The device has two channels for LEDs, typically for the back and front
>> cameras in mobile devices. Both channels can be independently
>> controlled, and can be operated in torch or flash modes.
>>
>> The driver includes initial support for the S2MU005 PMIC flash LEDs.
>>
>> Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
>> ---
>>   drivers/leds/flash/Kconfig          |  12 ++
>>   drivers/leds/flash/Makefile         |   1 +
>>   drivers/leds/flash/leds-s2m-flash.c | 358 ++++++++++++++++++++++++++++++++++++
>>   3 files changed, 371 insertions(+)
>>
>> diff --git a/drivers/leds/flash/Kconfig b/drivers/leds/flash/Kconfig
>> index 5e08102a67841..be62e05277429 100644
>> --- a/drivers/leds/flash/Kconfig
>> +++ b/drivers/leds/flash/Kconfig
>> @@ -114,6 +114,18 @@ config LEDS_RT8515
>>   	  To compile this driver as a module, choose M here: the module
>>   	  will be called leds-rt8515.
>>   
>> +config LEDS_S2M_FLASH
>> +	tristate "Samsung S2M series PMICs flash/torch LED support"
>> +	depends on LEDS_CLASS
>> +	depends on MFD_SEC_CORE
>> +	depends on V4L2_FLASH_LED_CLASS || !V4L2_FLASH_LED_CLASS
> 
> The `|| !V4L2_FLASH_LED_CLASS` part of this dependency makes it
> unconditionally true. Was this intended? Perhaps this dependency can be
> removed entirely.
This is for a reason to allow building the driver if
V4L2_FLASH_LED_CLASS is turned off, or build it as a module
if V4L2_FLASH_LED_CLASS=m. You will get nice explanation from
Google AI if you type just
"V4L2_FLASH_LED_CLASS || !V4L2_FLASH_LED_CLASS".

See e.g. [0], which fixes undefined symbol error by adding this.

[0] 
https://git.paulk.fr/projects/linux.git/commit/drivers?h=sunxi/cedrus/jpeg-nv16&id=dbeb02a0bc41b9e9b9c05e460890351efecf1352

-- 
Best regards,
Jacek Anaszewski

