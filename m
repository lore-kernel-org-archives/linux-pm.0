Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D0C5B21A
	for <linux-pm@vger.kernel.org>; Sun,  5 Apr 2026 03:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775360091; cv=none; b=i3XRFnpPzCCN+nv9JVK/yyKS38alri3N+n+NDaMyTa74aEGoVCG1u9fSRU8Vz/DE2bnma8g57ja7Yoqqobbhg1K/aW4vOAZ/7as8wNSfhA9YbBZqbWwZoUFIb5QjPSn+yNHAB/XcparmkqNBjjMIKLcIxTSPK74P2YjdE0aE0wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775360091; c=relaxed/simple;
	bh=tqmffhU++e2y4CW/WJTzvBLt8Ca4plE5fqX73LqMi1E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kpjKMq4M5MgD5VzZioqw1fkvyqKtgRf+jdfExx7QLQAGWRAuWyiwCsBYeberoks1rWle1Gq2qh5DDcLMShjE1ET+P3P6TPbUZSsK3rZ7LO4n/wwnkLPlmkl/BmpFbHaANHYjN4va/uoRBhZGhabPP1l+PWdE4dZrvZY887Yig8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ICfFRwww; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ICfFRwww"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-82cd98be655so2063538b3a.0
        for <linux-pm@vger.kernel.org>; Sat, 04 Apr 2026 20:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775360089; x=1775964889; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=rilvN/qEenlgBdA9ncCur3Wq4ZQc6ufWPDcrrCcWyBg=;
        b=ICfFRwwwe5MGqChTE8F4TfDguWH7RIcb4LlWQ6GXXSg6p/9r/Blp5sXlJsVk+H9IUH
         z5k1e8tyD0E2o08qEyJ/lricTxlZCIwiq0CSDLkBY9rKB8T7ooOJBValQsS1Io/bJVv1
         PLvLdVL7GJUeNZ8d/419fOZScqcac+H5AlRZ8yRBef++WpiO68Cfc1BEtf3cuYIsc+gy
         GKMhxrYTPnGZdd7CaH7o4O9/IYZEtlxMEscZMAI4zdw1xZE0WTSXkSY4+e3RwpratjTo
         VxmPmRg3pNOOBZivFQxIpm9NadfPL6TxnhVSQsGf/Kq5m9G3hSyMJrhGcxxLs3qUes7p
         EuAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775360089; x=1775964889;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rilvN/qEenlgBdA9ncCur3Wq4ZQc6ufWPDcrrCcWyBg=;
        b=qzeD5nMssary7LckYzY1BQz6QQka1BxKaxp6Jq8a1C59z8dbu/tTxyr/UeZ/dLuGbc
         i08EwlsOS1moYlvbA966yheHVj7EmR0b2Fy5X9eQVNEE/lnSG4XMKSKjIXH4UiTWJOun
         Wu4HBFW66CCeX5XWYmyg0o8njG8WkgqgiJA6xHDqHNBHa9cH7nO63Vu7JQHpzvqjX5tO
         IH1Qja3L2/hVQic9CjKjUCm1auXH9avG+940BecueaJtx+TdNNh4aktgbTs5dH/NReT3
         Jl1RrHR1KgCicDac2S1qpLE7rAXuXndOLi7NJhQ8Ev5MaW14xDUcIvJYM6UaHrf9g/F/
         s4hQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJy80tDQBDNa3wI3c72RCAauF9kzRaBv8OTAYs9HZ47+ykvl8DXfmav8LjjDnehFKbpG7ndmvasw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyrByZtIEaCq6Cb2db9oY3z4qKM+Ht2mEP0fVzDtZMEliWAu+tv
	zqWc8TAzUvfDuhE3qn3gShUPpV9QkBjT5YzsG2dd8xQq8hzitIL9W7yH
X-Gm-Gg: AeBDies3/NfGEcyhcD2hTmd+SQU+48YVmE+vGojzvmYzoomv+WHc3vpNUjVU23D2WI2
	tzty+5Ryl+VZedOh/xQZGzwaTtygjZl8PXrkKiZmwMV1h5olm0ypZzCXp3KXH+4zgYwGYNhOQg1
	t2siGU9QkMdqtpX0b36u5dqETuAHZMWUulKfGEtwZ3C24AQY4mh/pcqwUGg3Yy0A3zlSFQTk6zI
	KRu5KoGyZwKUayLwnUcOAGtii22DBV5kjHnE4qwOm9Zk/lwwfOz8ZOjy5FfSq3zulCFb68Nq8U/
	XmCsOTPM3alE7vlbC8EcAgK1KeM7y3CExyZGxn/3IcQXnuQtDxsL/7dewkcX3ogi1I5tn6Rg4Dj
	SfgSxRWh0aW93CTdXvseM0HEbMMnGkE0Fr1YtByzQyEPMO9Ey5IDYq6ymJO48SVKDyHzZGB4Emk
	THZO/KZPP8OOWh1oEGjO9mqXMXdSzc/3zZXPb2ixOh49SpYu0ARop3pHZ6N/0JEX49jSqnoeUf
X-Received: by 2002:a05:6a00:845:b0:829:8bb4:1034 with SMTP id d2e1a72fcca58-82d0db7d945mr7995317b3a.28.1775360088830;
        Sat, 04 Apr 2026 20:34:48 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9b5f1dbsm10197531b3a.27.2026.04.04.20.34.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Apr 2026 20:34:48 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <e5638cf8-88ee-4b61-b032-6cf324b7c642@roeck-us.net>
Date: Sat, 4 Apr 2026 20:34:46 -0700
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
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <CAJZ5v0g83UQKRcZ+u5EM13gwzktMXAxLqqcCoT8+CQLzOnChiw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/4/26 10:38, Rafael J. Wysocki wrote:
> On Sat, Apr 4, 2026 at 4:02 PM Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> On 4/4/26 05:58, Rafael J. Wysocki wrote:
>>> On Fri, Apr 3, 2026 at 4:20 PM Guenter Roeck <linux@roeck-us.net> wrote:
>>>>
>>>> On 4/3/26 05:52, Rafael J. Wysocki wrote:
>>>> .[ ... ]
>>>>> It appears to work for me, but I'm not sure if having multiple hwmon class
>>>>> devices with the same value in the name attribute is fine.
>>>>
>>>> Like this ?
>>>>
>>>> $ cd /sys/class/hwmon
>>>> $ grep . */name
>>>> hwmon0/name:r8169_0_c00:00
>>>> hwmon1/name:nvme
>>>> hwmon2/name:nvme
>>>> hwmon3/name:nct6687
>>>> hwmon4/name:k10temp
>>>> hwmon5/name:spd5118
>>>> hwmon6/name:spd5118
>>>> hwmon7/name:spd5118
>>>> hwmon8/name:spd5118
>>>> hwmon9/name:mt7921_phy0
>>>
>>> Yes.
>>>
>>>> Names such as "r8169_0_c00:00" and "mt7921_phy0" are actually overkill
>>>> since the "sensors" command makes it
>>>>
>>>> r8169_0_c00:00-mdio-0
>>>> Adapter: MDIO adapter
>>>> temp1:        +36.0°C  (high = +120.0°C)
>>>>
>>>> mt7921_phy0-pci-0d00
>>>> Adapter: PCI adapter
>>>> temp1:        +30.0°C
>>>>
>>>> essentially duplicating the device index.
>>>
>>> Well, with the patch posted by me, the output of sensors from a test
>>> system looks like this:
>>>
>>> acpitz-acpi-0
>>> Adapter: ACPI interface
>>> temp1:        +16.8°C
>>>
>>> pch_cannonlake-virtual-0
>>> Adapter: Virtual device
>>> temp1:        +33.0°C
>>>
>>> acpitz-acpi-0
>>> Adapter: ACPI interface
>>> temp1:        +27.8°C
>>>
>>> (some further data excluded), which is kind of confusing (note the
>>> duplicate acpitz-acpi-0 entries with different values of temp1).
>>>
>>
>> Yes, agreed, that is confusing. I would have expected the second one
>> to be identified as "acpitz-acpi-1". Do they both have the same parent ?
> 
> No, they don't.
> 
> The parent of each of them is a thermal zone device and both parents
> have the same "type" value.
> 
>>> That could be disambiguated by concatenating the thermal zone ID
>>> (possibly after a '_') to the name.  Or the "temp*" things for thermal
>>> zones of the same type could carry different numbers.
>>>
>>> A less attractive alternative would be to register a special virtual
>>> device serving as a parent for all hwmon interfaces registered
>>> automatically for thermal zones.
>>
>> If they all have the same parent, technically it should be a single
>> hwmon device with multiple sensors, as in:
>>
>> acpitz-acpi-0
>> Adapter: ACPI interface
>> temp1:        +16.8°C
>> temp2:        +27.8°C
> 
> So somebody tried to make it look like that by registering hwmon
> interfaces for all of the thermal zones of the same type under one of
> them, but that (quite obviously) doesn't work.

Not sure I understand why that doesn't work or why that is obvious,
but I'll take you by your word (I would agree that the current
_implementation_ looks problematic).

I looked into the source code of the "sensors" command. It indeed does
not index ACPI devices (nor virtual devices, for that matter) but
assumes that such devices are unique. My apologies for not realizing
this earlier.

So your only option is indeed to index the chip name if you want/need
more than one hwmon device with the same base name (here: acpitz)
instantiated from the thermal subsystem.

One comment to one of your earlier e-mails:

"However, it is more of a design issue IMV because putting temperature
  attributes for all of the (possibly unrelated) thermal zones of the
  same type under one hwmon interface is not particularly useful"

A single hardware monitoring device, by design, serves multiple
thermal zones. Anything else would not make sense for multi-channel
hardware monitoring chips. The hardware monitoring subsystem groups
sensors by chip, not by thermal zones.

Having said this: This discussion is not new. Certain subsystems
advocate for having one hardware monitoring device per sensor,
not per chip. One submitter went as far as telling me that I am
clueless. We don't need to repeat the exercise. I have my opinion,
you have yours, and all we can do is to agree to disagree.

Thanks,
Guenter

