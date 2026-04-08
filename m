Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6C22F0C62
	for <linux-pm@vger.kernel.org>; Wed,  8 Apr 2026 15:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775662366; cv=none; b=ePG9NnjzBZ71bQ0/UaesGXkfu5S5QLF/52OPSlcr1D2K7FxOXnE2HxasvS4C8VIU+4IT5pVimeKZ8UQZpofkh1yqQEFJmvE2U9LAISZ1q9jnTNoq8Z/Kxh0qyI4Yc1OgOL0l+7KD442meVwUKei3aY1YHZwpfQOfJnwbYrKGIVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775662366; c=relaxed/simple;
	bh=HsdoKi1BR1a1PE/YWtiuPW5nAhnpoTcMvc/QZ5rtUqI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bnPw5h36M5DyBjraB9lxa40FJxvFz/t4Y45E+yngycUnQy/a+ruG18B5lgo33My8TiCsaxtUnd70YKr3VgHYnzg3r5ygK5J0hZlPDZzUPlIKhZGSzvvhQ2d1fIoZsaaRdHn4oztydPFReCZL4nvOZJl2Nk8jgscJHazRZhQjehI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jB3/k0n1; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jB3/k0n1"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-82cebbdbdccso636374b3a.1
        for <linux-pm@vger.kernel.org>; Wed, 08 Apr 2026 08:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775662364; x=1776267164; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=pP8mAGhbGndZoLmXPo55MB7Ai+9sL3BD4rXGUvg7Xm8=;
        b=jB3/k0n1JhLfQy+iEVwsrJZmXLAYTM7KUIPjaXNiwZi3Nw6vCR1lZBejnnxb2UCmg5
         s3yTjphWjZrcz1YvjQFsNTPlXHZq3ZLpIaQSXmjpq2BYYeukF+MQuqdRRixpL0xYLAFI
         vqZFkMkp4ZN39VvTh3O8KG4aTIsZF4ed+oEjROnJaH6xqfKXU9EJZGNfCbVUbbMcJHEj
         htvk6XKFHvotYeddbMHauRAAT87xljclibzfWP3YIkD2/CorUdx8Ecp9eS30lHSlzhXq
         LTdlc8VvDxn6DywIAl6ZLLXUdp0s9kf9JV9XvfWnaiTsmcURX+8sBPmCi3gEpUdGgyeR
         uJ+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775662364; x=1776267164;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pP8mAGhbGndZoLmXPo55MB7Ai+9sL3BD4rXGUvg7Xm8=;
        b=biTzsjgCgHuapso21YHDSKu0P4ct1Z8PF4OTXNK1TXP7HGt9C1t/cGi6jjrC8eQzLW
         YMnqRkwt9VB/AVv+pYrLiVyX75bfKKNpYQcp/ljqcjc81nbEHUB3jn+fAQ58QaVLAHNA
         Qdn/FEs+w9uBzE0RY66ppH6d9LMldDyrfRInCROK44z5M7Y9kj4ZCC07cdUkhh1FdWe5
         RQkcXdcaXN/IP635IJ0q1UNLs3tvVSA3kXwVBBFRFZ+RZmwZG53/1xOkX95/lnN8lrho
         +aFQlqZRfBSPjnKXVEc4/O7Me/uMIyWCzpNfrLHyD4UFVAtgXPsSeHMWa+y1BXT7L60D
         kqFw==
X-Forwarded-Encrypted: i=1; AJvYcCVkmz0xPBM9/GsRKwbVAw2M9qel88J2robDACyisYgD/8nmoDZ2hwZdj3hBTCLdu7aVVAJiM8KT+g==@vger.kernel.org
X-Gm-Message-State: AOJu0YyVPSqZA/OsDUu+coKGZhW8bhGHF4GFm0sSMpgEQVPYWsZe7m4i
	1scqhaUh1Tv0ePCArhB//u4wMmgYHE0W0EaU4DaCMiTcBcdYMkDzA5OT
X-Gm-Gg: AeBDieuH0t6NfanTbnQYgJuR3R314hPSl9P7DfrWB1cPpSGvVLqAhi7GgGDed3xOV3Y
	OVP0O+XcNhaEIigebIHQe1MJ1dRiTFBFegIZV9GHgWbao7scNqsgwaCn/GUNA2PtB8Oqb4koawt
	OEI+hRIOtvz9L2HYmCoKfsn9AANRoHjVKWm6T1iWmd+B5sh54qBvCdiJNXpo+yPoTyO6ARM5rVj
	8kvl/B8vNx1CZXcCMgr9BI0t6RqRDxU+Mo0ROSkbF9QvnA6qDZt2p8E8j09UGb0uTkgd1KBFCgn
	uNdD2KTjzGDlCv2e2hPrdsTiAdtBbElqEY/kKKM2+E7cowDWX6A4otYpD2bek42tEFu2r3dsG3S
	sP6XB5h305yMdJfe+KXzZLROpwVQAJoy9EO+LpFBKp9QAsbXQ3FG+TYr/2kIDIJdiPshiOew8xZ
	XctW6LcZcrWXo2yXnjMIbrLLVYnC+TMllBj6Lrc1WRIFiVliERm/Z6gKoNWGNtFNDRczAUuZ1b
X-Received: by 2002:a05:6a00:bc92:b0:827:2792:e401 with SMTP id d2e1a72fcca58-82d00268a73mr20001819b3a.15.1775662364210;
        Wed, 08 Apr 2026 08:32:44 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9ca1f28sm22038089b3a.57.2026.04.08.08.32.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Apr 2026 08:32:43 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <e2e9c203-608b-4c96-b034-ba95eec61ac5@roeck-us.net>
Date: Wed, 8 Apr 2026 08:32:42 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v1] thermal: core: fix blocking in unregistering
 zone
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Jiajia Liu <liujiajia@kylinos.cn>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Armin Wolf <w_armin@gmx.de>,
 linux-hwmon@vger.kernel.org
References: <20260402022742.17738-1-liujiajia@kylinos.cn>
 <2432224.ElGaqSPkdT@rafael.j.wysocki>
 <ebdbe040-d673-47b9-a6c9-f0fefc0b771b@roeck-us.net>
 <CAJZ5v0jZPXC5g3KY+trwmV=nXJu74y=0LaQTHaQ_MnqcfPVAGQ@mail.gmail.com>
 <ec16fc75-c5fa-4ff9-bc6b-91464e9c26cc@roeck-us.net>
 <CAJZ5v0g83UQKRcZ+u5EM13gwzktMXAxLqqcCoT8+CQLzOnChiw@mail.gmail.com>
 <e5638cf8-88ee-4b61-b032-6cf324b7c642@roeck-us.net>
 <CAJZ5v0jfi_gXPVq9E2eJe_0MG4vVojyDo6=ABv4fNFK=Q_qpug@mail.gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <CAJZ5v0jfi_gXPVq9E2eJe_0MG4vVojyDo6=ABv4fNFK=Q_qpug@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/8/26 08:05, Rafael J. Wysocki wrote:
> On Sun, Apr 5, 2026 at 5:34 AM Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> On 4/4/26 10:38, Rafael J. Wysocki wrote:
>>> On Sat, Apr 4, 2026 at 4:02 PM Guenter Roeck <linux@roeck-us.net> wrote:
>>>>
>>>> On 4/4/26 05:58, Rafael J. Wysocki wrote:
>>>>> On Fri, Apr 3, 2026 at 4:20 PM Guenter Roeck <linux@roeck-us.net> wrote:
>>>>>>
>>>>>> On 4/3/26 05:52, Rafael J. Wysocki wrote:
>>>>>> .[ ... ]
>>>>>>> It appears to work for me, but I'm not sure if having multiple hwmon class
>>>>>>> devices with the same value in the name attribute is fine.
>>>>>>
>>>>>> Like this ?
>>>>>>
>>>>>> $ cd /sys/class/hwmon
>>>>>> $ grep . */name
>>>>>> hwmon0/name:r8169_0_c00:00
>>>>>> hwmon1/name:nvme
>>>>>> hwmon2/name:nvme
>>>>>> hwmon3/name:nct6687
>>>>>> hwmon4/name:k10temp
>>>>>> hwmon5/name:spd5118
>>>>>> hwmon6/name:spd5118
>>>>>> hwmon7/name:spd5118
>>>>>> hwmon8/name:spd5118
>>>>>> hwmon9/name:mt7921_phy0
>>>>>
>>>>> Yes.
>>>>>
>>>>>> Names such as "r8169_0_c00:00" and "mt7921_phy0" are actually overkill
>>>>>> since the "sensors" command makes it
>>>>>>
>>>>>> r8169_0_c00:00-mdio-0
>>>>>> Adapter: MDIO adapter
>>>>>> temp1:        +36.0°C  (high = +120.0°C)
>>>>>>
>>>>>> mt7921_phy0-pci-0d00
>>>>>> Adapter: PCI adapter
>>>>>> temp1:        +30.0°C
>>>>>>
>>>>>> essentially duplicating the device index.
>>>>>
>>>>> Well, with the patch posted by me, the output of sensors from a test
>>>>> system looks like this:
>>>>>
>>>>> acpitz-acpi-0
>>>>> Adapter: ACPI interface
>>>>> temp1:        +16.8°C
>>>>>
>>>>> pch_cannonlake-virtual-0
>>>>> Adapter: Virtual device
>>>>> temp1:        +33.0°C
>>>>>
>>>>> acpitz-acpi-0
>>>>> Adapter: ACPI interface
>>>>> temp1:        +27.8°C
>>>>>
>>>>> (some further data excluded), which is kind of confusing (note the
>>>>> duplicate acpitz-acpi-0 entries with different values of temp1).
>>>>>
>>>>
>>>> Yes, agreed, that is confusing. I would have expected the second one
>>>> to be identified as "acpitz-acpi-1". Do they both have the same parent ?
>>>
>>> No, they don't.
>>>
>>> The parent of each of them is a thermal zone device and both parents
>>> have the same "type" value.
>>>
>>>>> That could be disambiguated by concatenating the thermal zone ID
>>>>> (possibly after a '_') to the name.  Or the "temp*" things for thermal
>>>>> zones of the same type could carry different numbers.
>>>>>
>>>>> A less attractive alternative would be to register a special virtual
>>>>> device serving as a parent for all hwmon interfaces registered
>>>>> automatically for thermal zones.
>>>>
>>>> If they all have the same parent, technically it should be a single
>>>> hwmon device with multiple sensors, as in:
>>>>
>>>> acpitz-acpi-0
>>>> Adapter: ACPI interface
>>>> temp1:        +16.8°C
>>>> temp2:        +27.8°C
>>>
>>> So somebody tried to make it look like that by registering hwmon
>>> interfaces for all of the thermal zones of the same type under one of
>>> them, but that (quite obviously) doesn't work.
>>
>> Not sure I understand why that doesn't work or why that is obvious,
>> but I'll take you by your word (I would agree that the current
>> _implementation_ looks problematic).
> 
> For example, say that there are two ACPI thermal zones on a system
> 
> /sys/devices/virtual/thermal/thermal_zone0/
> /sys/devices/virtual/thermal/thermal_zone1/
> 
> The current mainline code registers a hwmon class device for thermal_zone0 only:
> 
> /sys/devices/virtual/thermal/thermal_zone0/hwmon0/
> 
> because the type is "acpitz" for both of them, but it adds a sysfs
> attribute that belongs to thermal_zone1 under it:
> 
> /sys/devices/virtual/thermal/thermal_zone0/hwmon0/temp2_input
> 
> There is also
> 
> /sys/devices/virtual/thermal/thermal_zone0/hwmon0/temp1_input
> 
> but it belongs to thermal_zone0.
> 
> Interesting things happen when thermal_zone0 is removed, for example
> because the ACPI thermal driver is unbound from the underlying
> platform device.  Namely, the removal code skips the removal of hwmon0
> because of the temp2_input attribute belonging to thermal_zone1 which
> effectively prevents thermal_zone0 removal from making progress.
> 
> AFAICS, nothing particularly smart can be done to address this issue
> while retaining the current design of the code.  Reparenting hwmon0 to
> thermal_zone1 may confuse user space as well as removing hwmon0 along
> with temp2_input.  That's why I think that this is a design issue.
> 

The ACPI power meter driver has pretty much the same problem. A clear
solution would require making hwmon sysfs attributes dynamic in nature
(i.e., by adding the ability to change the visibility of attributes in
runtime). I have started working on that, but did not have time to
complete the work. The ACPI power meter driver uses a kludge around that:
It unregisters the hwmon device whenever it gets a METER_NOTIFY_CONFIG
event and re-registers it.

Anyway, registering separate hwmon devices, one per thermal zone,
is perfectly fine with me.

Guenter

