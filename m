Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01176490BF4;
	Tue,  1 Sep 2026 17:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788285540; cv=none; b=uOsuwpWGEXFzmNGXEPfGHHpAHzvtq2bfWwrieHVOy+7WgcJ2tX4Jh42GHibKlICeogkBsN8XIeGXtVeJXArZ2AJ/6CCN0nF8y5Xe0QforZ6eJSEpbZe2e04iWshXYaEt9k8tWp9gr3XrjpOm2RJmxVMWZkbYy0riA4CKVLs7iso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788285540; c=relaxed/simple;
	bh=SFftTY28xng0TqAs0+/d6fgvhXTiZq29gcPBy5wVyio=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t3njhnQCI4HWgo5p9021s4Ra4/V0/85xDzzT95/NPZrdHDDNkJ9HULdztMWlwlloyB2bESWrgHb4Q0oe3MP2AObUb4FHLptQ1aDJNMd5yrC0jyWeoWkMzVKMroSaH8MGsjHubl07Dp5Ilby94kPc6WkXvDcYcqiCER+mzptNvFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=M4vOQmDP; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="M4vOQmDP"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 35BEB11D4BB;
	Tue, 01 Sep 2026 19:58:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1788285532;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=n/7cN7BJcI04hefEhKdm0Ws+9Mi+O5JMycLuLM+ZCnE=;
	b=M4vOQmDPH3Mv+k6rRUIyqM/Je75b3M8F3pesqvgcdcIzTYEgQBCGBjOfCnrU8M/HXRiLGV
	UqEKKL4R0LxDisIe0HJMtpisz0nwbRbm8hp/l4yIrXSevO/Gj6k7EMpJQy1cb3hAL7SDc1
	enEePUWr6Ezj1EvOGWpJxSDF5/iRlVawgeBRMm1lYLN0owaPwxPUw5vm8Gx12ZLSf72y+k
	yoIpwk5TvO494f8tsJAjXCn6ngwVFjQjCpusSuq2N2DVVXrKPWyuxOrVJiIha6qwVOoVmI
	AQFEzVCSxix0Fwx+lO1+SxzgCmrwYDGydMVJwI8W3EKGW4jF3ZdxnV81Atj4YA==
Message-ID: <2e3f7dab-5f64-4dcf-b995-82fcc3a5e780@nabladev.com>
Date: Tue, 1 Sep 2026 19:58:51 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] dt-bindings: hwmon: tmp102: Document TMP113
To: Guenter Roeck <linux@roeck-us.net>, Conor Dooley <conor@kernel.org>
Cc: linux-pm@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
 Flaviu Nistor <flaviu.nistor@gmail.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>,
 devicetree@vger.kernel.org, linux-hwmon@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260901161008.46948-1-marex@nabladev.com>
 <20260901-untimely-wake-578b1a86b9fe@spud>
 <4bbcc5fe-86a1-4299-a0df-e9f44d5c237f@roeck-us.net>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <4bbcc5fe-86a1-4299-a0df-e9f44d5c237f@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

On 9/1/26 7:48 PM, Guenter Roeck wrote:

Hello Guenter,

>>> @@ -13,11 +13,12 @@ properties:
>>>     compatible:
>>>       oneOf:
>>>         - items:
>>> +          - enum:
>>> +              - ti,tmp110
>>> +              - ti,tmp113
>>>             - const: ti,tmp102
>>> -          - const: ti,tmp103
>>> -          - const: ti,tmp110
>>> -      - enum:
>>> -          - ti,tmp102
>>> +      - const: ti,tmp102
>>> +      - const: ti,tmp103
>>
>> Should this not be two patches, one fixing the existing stuff and one
>> adding the 113?
>>
> 
> It is all in -next. Looks like I resolved the conflict when combining
> "dt-bindings: hwmon: tmp102: move ti,tmp103 out of trivial-devices.yaml"
> and "dt-bindings: hwmon: tmp102: Document TMP110" the wrong way.
> Sorry for that.

No worries, I hope V3 I just sent fixes it up.

> Instead of adding more patches on top of it, how about providing a
> single patch moving tmp103 and adding tmp110 as well as tmp113
> together ? Alternatively, I could drop "dt-bindings: hwmon: tmp102:
> Document TMP110", apply the original (non-conflicting version) of
> "dt-bindings: hwmon: tmp102: move ti,tmp103 out of trivial-devices.yaml",
> and then tmp110 and tmp113 could be added in a single patch.
> 
> Please let me know.
I think the broken commit is d67ec24d3f07 ("dt-bindings: hwmon: tmp102: 
move ti,tmp103 out of trivial-devices.yaml") and v3 1/2 is the fix for 
that broken commit. V3 2/2 only adds the missing TMP113 .

So I think there are two options:
- The complicated one -- squash d67ec24d3f07 ("dt-bindings: hwmon: 
tmp102: move ti,tmp103 out of trivial-devices.yaml") and V3 1/2 (and 
either do it in tree, or drop d67ec24d3f07 ("dt-bindings: hwmon: tmp102: 
move ti,tmp103 out of trivial-devices.yaml") and ask for it to be 
updated and resent), then apply that, and apply V3 2/2 (or newer) .
- The simple one -- apply both V3 patches (or whatever newer version is 
good enough) and move on.

Just let me know what you like better.
