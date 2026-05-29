Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F251F363C69;
	Fri, 29 May 2026 15:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780068607; cv=none; b=MEzIhUxSooxG/gkkxo/3IlIUrRy0w4xLHfx6IGmKrl8jE8JlMqNhVhWGUnz3IiT3upWBrgGq8ZC2BNSndO4oDr+/4ML1VRkCZIR3A7TnxS+ue4XBaNwqLpUODEqJoqqqQ+TwHfR5C5dtTSvfiiR/Bs6otLPXT6I8o0STy9glLAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780068607; c=relaxed/simple;
	bh=t8jvtGoTA6NsSG45gsni10zkQY1QqHrekli+F1qR+m4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s5A3jpmJPrB2uwMj/bwJWOAfPNX91gWt1f9P7l0Wp3ogbaXqHYpWtBntjJt/gockczzg+mr0B0pc5/PUgHmX3+2MT+XL13+G65zmcDyoq6mXDGw3Z8bAG+XaDk2T5rivepTKFKQrABn+xfc7zOIjvCqOVM9n5OM9zC7nakDQiOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Pfa4L/FK; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Pfa4L/FK"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 632AD1C00;
	Fri, 29 May 2026 08:30:00 -0700 (PDT)
Received: from [10.57.26.238] (unknown [10.57.26.238])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6E9CC3F632;
	Fri, 29 May 2026 08:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1780068605; bh=t8jvtGoTA6NsSG45gsni10zkQY1QqHrekli+F1qR+m4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Pfa4L/FKAb+5nrqjrCR+CTutNf8vkqUBDg8NLnw+djIKmp0z9ZJRRb8qsV/fb4oti
	 pUcx/vlim8s7389kqGIwwdjIFxjSgOkIh1A6KkqD0SFSEWNIFbYRydHOeImOcnDlJN
	 ELxFE21iHGzD/vR8lj4aU/H+N64SJ4IlxNuPFvmU=
Message-ID: <c66d527a-17d3-4419-a0c4-676dc92bbe43@arm.com>
Date: Fri, 29 May 2026 16:29:56 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH vs/3/4/ 00/11] Support cooling device with ID in the OF
To: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: daniel.lezcano@kernel.org, Zhang Rui <rui.zhang@intel.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Lucas Stach <l.stach@pengutronix.de>,
 Russell King <linux+etnaviv@armlinux.org.uk>,
 Christian Gmeiner <christian.gmeiner@gmail.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Guenter Roeck <linux@roeck-us.net>, Joel Stanley <joel@jms.id.au>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 Benson Leung <bleung@chromium.org>, =?UTF-8?Q?Pali_Roh=C3=A1r?=
 <pali@kernel.org>, Avi Fishman <avifishman70@gmail.com>,
 Tomer Maimon <tmaimon77@gmail.com>, Tali Perry <tali.perry1@gmail.com>,
 Patrick Venture <venture@google.com>, Nancy Yuen <yuenn@google.com>,
 Benjamin Fair <benjaminfair@google.com>, Heiko Stuebner <heiko@sntech.de>,
 Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Amit Daniel Kachhap <amit.kachhap@gmail.com>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Amit Kucheria
 <amitk@kernel.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hwmon@vger.kernel.org
References: <20260526140802.1059293-12-daniel.lezcano@oss.qualcomm.com>
 <a943706d-d413-4ed8-a0fd-a3234c66cd8d@oss.qualcomm.com>
 <CAJZ5v0hG4aNrTR1j1DX+xv7cBNwsN4Y+qa3eFfXtLrrDBZ6kCA@mail.gmail.com>
 <41eec804-5678-475d-b0b2-a5c0b3b005d4@oss.qualcomm.com>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <41eec804-5678-475d-b0b2-a5c0b3b005d4@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Rafael and Daniel,

On 5/29/26 13:41, Daniel Lezcano wrote:
> On 5/29/26 14:35, Rafael J. Wysocki wrote:
>> Hi Daniel,
>>
>> On Fri, May 29, 2026 at 10:35 AM Daniel Lezcano
>> <daniel.lezcano@oss.qualcomm.com> wrote:
>>>
>>>
>>> Hi Rafael,
>>>
>>> On 5/26/26 16:08, Daniel Lezcano wrote:
>>>
>>> [ ... ]
>>>
>>>> ---
>>>> Changelog:
>>>>    - V4
>>>>      - Reworked splitted functions to register a cooling device and
>>>>        merged separately
>>>
>>> Are you fine with the thermal core changes in this series ?
>>
>> Generally, yes, I am, but let me have one more look at it.
>>
>>> Is it ok if I pick the series in my branch (and may be send a early 
>>> PR) ?
>>
>> I have no comments, I'll respond with an Acked-by to it later today.
>>
>> Thanks!
> 
> Thanks

I have re-ordered the patch 4 <-> 5 and the compilation issue goes away.
If you decide to do that feel free to add my tag to the current patch
04/10:

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

Regards,
Lukasz
