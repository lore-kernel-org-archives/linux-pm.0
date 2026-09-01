Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A9B495050
	for <linux-pm@vger.kernel.org>; Tue,  1 Sep 2026 18:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788286566; cv=none; b=VR7BQMsvt16WCy/oyt07z6O6tYQB9vNFPLkweWgptFgZ1Ob1F+SvcN2P4WWXJVf0ZazpulSainOucetanIXRx4K7BioROMZgNT7Z9DOZdQ0bLE1bwfS2VpkltYDaWdnhNAIYMViEOGi7PFLtXi/MUq+5Y+QoPEi4pdmBODFu5qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788286566; c=relaxed/simple;
	bh=VXfrcKXz79D8fy4QkXeNvDJyeW3P8UmzaxgmXsPaOss=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=agVLV2A0T+K33ksaJXXau5OgI2cxAMIfXGsIKLZt0Frmk51T8kbZwza107udFtnMRqxIpRwQwck1kA+2kiAfW1p3a2ggmQYnubeAiQf51okI/DdCO4ktr+N4vLy5PzDFucpT+ZE0DGAPaGhqX8BLAxy1nGD5A0mmBG8ExHTZMOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qt9LRBCa; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qt9LRBCa"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-8541875f596so77305b3a.0
        for <linux-pm@vger.kernel.org>; Tue, 01 Sep 2026 11:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788286564; x=1788891364; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QQ0p1Z4+MlOZ+bbdikj7z8HuA9bER05d0WZ/7CMC6BI=;
        b=qt9LRBCax3BrhZMpBbOeWUQpK8uRoxa4hS/Ym09cMLHQX5NX1SrEQn64ph/DxMgAsI
         hnCH4xWsCMcv271HzXpxD2Wj6hJh2idsqOuej5uwwm1XNP5MItiLUdQttnDEqFf8f9Dg
         snP1IcEF4Y2+jjSuqmZJfD/I7eCYq/e8dvV2QJqA+vULvw0Kl6ibwJZubEWv1EZNUcua
         zXKZ4lGU1aURUfLjhxQjoEjrJJWjdGfyAcqN13mNZnpvgK3ZqZi4zBAKCgvh37i8ftuK
         mBrqsGkanxEdMAA1bVO1SL8LqJ5TPxSA0Bsr1CrtRZzwzSyNVQIG8s0zyTq4vvHEJ/An
         mk5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788286564; x=1788891364;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=QQ0p1Z4+MlOZ+bbdikj7z8HuA9bER05d0WZ/7CMC6BI=;
        b=ldlmr3YFHFpZwjbb7Q+eQdLijaZg9q1e5PQ50igSdZ63oVeKKW9B4+xE3ga7QmTZaE
         g6pluMkGIG2MJjEAyvD5lZrQNPYrkkK6guLq0IyQyN/p+3cHhencuGJIbcqr+f7ZS+cz
         mBOpTPvB+1AooHHqpO8IyZCFmh4HvKFtdf/ayag2ukauwi2LXLVss5XeIjG7spJvEJb9
         br5AIknRukW7JN7BvrIPoqDUdBopnCsafcY8rmZQcP47gMjD9RO1DHb1w8oeesnwBmF+
         cv7dlp5vEiVtmqs1ZbqFVBwtztZl6QEpcek8H1Blkh3w/Pxu/BH4e11SU3BpnwC1jZUO
         dOzw==
X-Gm-Message-State: AFuF++lZrME3KM8rr8u/fE2v+HFrRKZ28KZVvALu3o4jNiNR+G4ZOmZB
	QyHNSmXTLm+za3gH0zE75PMBAwQiqdag7km8Y0Z/TFz7+qOiBCsM0Sv+
X-Gm-Gg: AR+sD11R4/IBMmUTOJdD+vfDLZk0Szdc0Dm12pPqbplXGGI943Dtq3tkHicC/Hq7kVL
	d0WijZ3VIrpqQBz9Uu3T0nCBrE+dAClfGSCcd0JkH5SXpa7cZgLOOTiUEKA9zwDnfAjIGfpyfb5
	k0kH+oQZt4MH26B9q+jmGNITVZcSYwPi0MwPxzShcCIFPdrA3ZYjbDFo4I6xyPZn+i752aJNBsb
	0qeldTYxixMVPqrksDfBb6s4rwhNoryyUELivQUG16M2qq06LrOZt/3Qc5H8pz7Xlw3dq4NvsaQ
	DYB0lHkZxvDZukTPqsLy1Yu4lGd0bqQpHaUw0lnaPQmwju+vcV5TqxQtA2QHTxA42eg8BPDZEta
	SrwsW3zJVpPI+Ct98KBTvR2LN8HMDz5d9aeph9ZvQV3YWUrZqeeSCDZGTJN337H6AFKIerJrX5n
	Cky/8UCM9UZc1OE9GAH8li+ZlD5Y8KYT/vOBe7RI+lSrZjznsUkJDdwhm5yrT0+iuI4A4990Pmg
	clwXvkmCAlcTbbECqwMVl5LZ5XQcVZ8mkj0Sw==
X-Received: by 2002:a05:6a00:3ccd:b0:847:770f:da4c with SMTP id d2e1a72fcca58-8562bf5a609mr53415919b3a.16.1788286563905;
        Tue, 01 Sep 2026 11:16:03 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-85dc0d050a1sm238220b3a.51.2026.09.01.11.16.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Sep 2026 11:16:03 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <3a175184-26ff-4d20-a934-40066dd1856c@roeck-us.net>
Date: Tue, 1 Sep 2026 11:16:02 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] dt-bindings: hwmon: tmp102: Document TMP113
To: Marek Vasut <marex@nabladev.com>, Conor Dooley <conor@kernel.org>
Cc: linux-pm@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
 Flaviu Nistor <flaviu.nistor@gmail.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>,
 devicetree@vger.kernel.org, linux-hwmon@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260901161008.46948-1-marex@nabladev.com>
 <20260901-untimely-wake-578b1a86b9fe@spud>
 <4bbcc5fe-86a1-4299-a0df-e9f44d5c237f@roeck-us.net>
 <2e3f7dab-5f64-4dcf-b995-82fcc3a5e780@nabladev.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <2e3f7dab-5f64-4dcf-b995-82fcc3a5e780@nabladev.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/1/26 10:58, Marek Vasut wrote:
> On 9/1/26 7:48 PM, Guenter Roeck wrote:
> 
> Hello Guenter,
> 
>>>> @@ -13,11 +13,12 @@ properties:
>>>>     compatible:
>>>>       oneOf:
>>>>         - items:
>>>> +          - enum:
>>>> +              - ti,tmp110
>>>> +              - ti,tmp113
>>>>             - const: ti,tmp102
>>>> -          - const: ti,tmp103
>>>> -          - const: ti,tmp110
>>>> -      - enum:
>>>> -          - ti,tmp102
>>>> +      - const: ti,tmp102
>>>> +      - const: ti,tmp103
>>>
>>> Should this not be two patches, one fixing the existing stuff and one
>>> adding the 113?
>>>
>>
>> It is all in -next. Looks like I resolved the conflict when combining
>> "dt-bindings: hwmon: tmp102: move ti,tmp103 out of trivial-devices.yaml"
>> and "dt-bindings: hwmon: tmp102: Document TMP110" the wrong way.
>> Sorry for that.
> 
> No worries, I hope V3 I just sent fixes it up.
> 
>> Instead of adding more patches on top of it, how about providing a
>> single patch moving tmp103 and adding tmp110 as well as tmp113
>> together ? Alternatively, I could drop "dt-bindings: hwmon: tmp102:
>> Document TMP110", apply the original (non-conflicting version) of
>> "dt-bindings: hwmon: tmp102: move ti,tmp103 out of trivial-devices.yaml",
>> and then tmp110 and tmp113 could be added in a single patch.
>>
>> Please let me know.
> I think the broken commit is d67ec24d3f07 ("dt-bindings: hwmon: tmp102: move ti,tmp103 out of trivial-devices.yaml") and v3 1/2 is the fix for that broken commit. V3 2/2 only adds the missing TMP113 .
> 
> So I think there are two options:
> - The complicated one -- squash d67ec24d3f07 ("dt-bindings: hwmon: tmp102: move ti,tmp103 out of trivial-devices.yaml") and V3 1/2 (and either do it in tree, or drop d67ec24d3f07 ("dt-bindings: hwmon: tmp102: move ti,tmp103 out of trivial-devices.yaml") and ask for it to be updated and resent), then apply that, and apply V3 2/2 (or newer) .

I'll do that, assuming that Conor is ok with both patches.
No need to resend anything.

Thanks,
Guenter

