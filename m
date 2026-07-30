Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F23A3A4505
	for <linux-pm@vger.kernel.org>; Thu, 30 Jul 2026 15:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785423760; cv=none; b=Zz1DSpo4iCRSb3Y1vssyMXKQgrGGx5GaXrsxzmfZg2mv2QXvKmrLWJK1yvS+sg+T46e7MTa38eZ1R8Y4UFnxIHOFrS2u9za6joMqkPNhAorjaalJEXcB0tdI//8i9nU85LhYBR4dA+HDlgeYTIBVZpS0R4Te8nKdUKtzHL8e3mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785423760; c=relaxed/simple;
	bh=lnPmujkoSvOOLGMqjbquxyL4hLjA/ramPgRYAIoT/Kg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aqhFuzoYXKWh1ttZ53hXaOIudHm3VH6SHunCxe2iDwJmlD2AzjNMJue6ktHC/oqywqJyidQEftYpc5k9CQzhTbJFRfzncHRZJx6a+NZ7P8amIZnu3uTJoZrwlPFJgBsXSif3nO1HfPgVhm0SwZJ0SivJc3HESxtO5rKTurOQuhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hlpkFiHa; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hlpkFiHa"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2cace91f112so25518675ad.0
        for <linux-pm@vger.kernel.org>; Thu, 30 Jul 2026 08:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785423758; x=1786028558; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tLEzUW8o0U9S9X6t6tu33UKtz4CdGONFnEDfRlrAs9U=;
        b=hlpkFiHaWXAbF5gmE61wop6HWRAMKi/SOO1f4458Z81MLYAvDSOh2ONOOIPYcpeH60
         2m/9sr5wp0O/zXG7IdTYgEi50mysifIrw9ztcWO3JU2UB2BCyatNBIHRKnCINrRODNYk
         0yKmDjw+CC0njxwUMn2SR5GrqbFU8Xi7FKbEQ7TGmNwC1NsJ7Rf84YiOLwSyjJY8s8Hd
         EzL/xD5W9MoxtE/5MNVflbqKWpYCh/4gvcs0O5Qb9jtgBanTpseB8xSYgROkzjsBPkg+
         iBSjD1i1bK7nXzbeCs+YR7mTFLpiPQbjPkYsRR6ygQbtCvd6mypGmzCuEsMuXHVsQ507
         pbdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785423758; x=1786028558;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=tLEzUW8o0U9S9X6t6tu33UKtz4CdGONFnEDfRlrAs9U=;
        b=Vnw39TzLhBUozzxEBMAuMUpUBKbndCMqE0wLnGjULf3Ey/FV1Nb8z3c2mM2K9F5r35
         MkdyH11gZv0o52ykZ5qQ2k4ZuMRfN9wE0x2Y4v++kw8IUxgwX1po1xS7c01mqfD5I409
         b2TFa7HtwO6G7S1A8W1R/ZrOFOCn309fFIm0G9iNwBqk3fJuvNSpin3G2WAw5z/bbgH3
         ESCfeYC/YlYptOa6u4VN2JucO/d4l7AOCH/TbDj4/fvjU++fdKafolHvUsvZA2l42/Sp
         RzJXka65QZ2RLW0wpNMoFun4E7OID9f73AFuFKsqobq2Qojm/YYRdQO9nQ/Zt4VhgyTZ
         JyBg==
X-Forwarded-Encrypted: i=1; AHgh+RoD1tFtM0X+ZRis2wUo2pXjByZB1svNakXgCqHiJ4oIJ6fdwJSpy7TuF5tzIisZ6QZHk1gfH+MK4Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YzMWN32J5SstojthIfRIk0wSbXocPAawBSMpOi4LVMHnLaxoHBg
	QiMXzKD3gGAaPrUE5xYHK/1bWwerCekyzeFs5AA/JygQNrmvDiS81gb4
X-Gm-Gg: AR+sD13d8Kk96TIOvUi/ZhpoI+uCz+YiUCPsZvR7oOhwoKE62MxBStTq8mCe6/F1/SA
	//2XNSCXF6f882OZeH7dwDNlql/c8Okk4Q+47D8zUAmIGpwsTYNt3oxhbXbCfMCfC7Dk3mI7/y5
	g83/miwDHWWIScVeNwceG8mh8onoQmNiTHQywxorJvMX+KbXjqGfZpWa5cSyxCXBMLNuYPDoa+j
	CK2xDlbW71sLHydVFC8fJjCC6p+yW3GG/oFa2hN88CvY/E074XvBDwESJpxcfc6Dy36dbICJqZO
	iVRNwQR7cSnopH7tlZKUHlT71AI+YTJX9foVLko8Wi9EBMWeLSDg1pm0FACecXClLcOMhXLApZT
	p5c4S81sPIfmWTwm5Y1Rf/ROXkR/AhIlfW/oH1L1DW9ewsm1CKsgPGMx6AQ0PE2X8oJHWCBAts4
	nNOsHAWQm+kbSPh5QV2IzE2prMXuxIZH7UoF09IJz6tLnj6PjOPVwGsfDnjsgT1tEySaoEX5h60
	+iRymARDz86IuJhwUoaFlpDE/e9HF+wZ10ETw==
X-Received: by 2002:a05:6a20:54a1:b0:3c3:2e2b:29ee with SMTP id adf61e73a8af0-3c900948db6mr2952552637.55.1785423758227;
        Thu, 30 Jul 2026 08:02:38 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31504d37368sm41415686eec.22.2026.07.30.08.02.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jul 2026 08:02:37 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <19a2b8bd-09ea-4df9-b0ba-f78f60c44848@roeck-us.net>
Date: Thu, 30 Jul 2026 08:02:35 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] power: reset: pscrr: add watchdog pretimeout
 reason tracking
To: Oleksij Rempel <o.rempel@pengutronix.de>,
 Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Faruque Ansari <faruque.ansari@oss.qualcomm.com>,
 Sebastian Reichel <sre@kernel.org>, Wim Van Sebroeck
 <wim@linux-watchdog.org>, Benson Leung <bleung@chromium.org>,
 Tzung-Bi Shih <tzungbi@kernel.org>, Srinivas Kandagatla <srini@kernel.org>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
 linux-arm-msm@vger.org, kernel@pengutronix.de,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, =?UTF-8?Q?S=C3=B8ren_Andersen?=
 <san@skov.dk>, Guenter Roeck <groeck@chromium.org>,
 Ahmad Fatoum <a.fatoum@pengutronix.de>,
 Andrew Morton <akpm@linux-foundation.org>,
 avaneesh.dwivedi@oss.qualcomm.com,
 Umang Chheda <umang.chheda@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org
References: <20260722-pscrr-reboot-reason-v2-0-495ba3005953@oss.qualcomm.com>
 <20260722-pscrr-reboot-reason-v2-2-495ba3005953@oss.qualcomm.com>
 <98e65507-3084-4948-8096-4e2d8d20dc81@gmail.com>
 <amrgDC0s3rb5Xv4N@pengutronix.de>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <amrgDC0s3rb5Xv4N@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/29/26 22:24, Oleksij Rempel wrote:
> Hi Matti,
> 
> On Thu, Jul 30, 2026 at 07:49:41AM +0300, Matti Vaittinen wrote:
>> On 22/07/2026 18:13, Faruque Ansari wrote:
>>> Watchdog pretimeout resets are not recorded with a dedicated reset
>>> reason, causing subsequent boots to report PSCR_UNKNOWN and making it
>>> difficult to distinguish them from other unexpected resets.
>>>
>>> Add PSCR_WATCHDOG_PRETIMEOUT as a dedicated reset reason code and
>>> prevent the panic notifier from overwriting a watchdog pretimeout
>>> reason with PSCR_KERNEL_PANIC when the pretimeout governor triggers a
>>> panic.
>>>
>>> Signed-off-by: Faruque Ansari <faruque.ansari@oss.qualcomm.com>
>>> ---
>>>    drivers/power/reset/pscrr.c           | 7 ++++++-
>>>    include/linux/power/power_on_reason.h | 1 +
>>>    include/linux/reboot.h                | 1 +
>>>    kernel/reboot.c                       | 1 +
>>>    4 files changed, 9 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/power/reset/pscrr.c b/drivers/power/reset/pscrr.c
>>> index b5906f127e88..5b107c62fe82 100644
>>> --- a/drivers/power/reset/pscrr.c
>>> +++ b/drivers/power/reset/pscrr.c
>>> @@ -149,7 +149,12 @@ static int pscrr_panic_notifier(struct notifier_block *nb,
>>>    	if (!backend || !backend->ops || !backend->ops->write_reason)
>>>    		return NOTIFY_OK;
>>> -	set_psc_reason(PSCR_KERNEL_PANIC);
>>> +	/*
>>> +	 * Do not overwrite a previously recorded watchdog pretimeout reason
>>> +	 * during panic handling.
>>> +	 */
>>> +	if (get_psc_reason() != PSCR_WATCHDOG_PRETIMEOUT)
>>> +		set_psc_reason(PSCR_KERNEL_PANIC);
>>
>> Hi Faruque,
>>
>> I like the idea of adding WDG pretimeout resets in pscrr. I am just
>> wondering what makes WDG reason so special, that it shouldn't be overwritten
>> while other reasons can be? Can this notifier be called (now or in the
>> future) so, that there are other reasons getting overwritten? For some
>> reason I think the PSCRR was designed to be able to store multiple
>> reasons(?)
> 
> It depends on the backed. A simple nvmem cell, would be able to hold
> only one reason.
> 

That makes me wonder: Shouldn't the priority be a back-end decision, not a
front-end decision ?

Guenter

