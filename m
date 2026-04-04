Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC0E72550CD
	for <linux-pm@vger.kernel.org>; Sat,  4 Apr 2026 14:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775311339; cv=none; b=Ki1+by4eM7gwT/B3Asz1dYuSZQSginSzdA3XIxTS7jEjxmC87+AKnkCHoVmwZPlJUj9Dd5SAcfNdraUChBOPzR0MEEg8J3qcklncbWK4CmssoRaBZd6lOClkl8UCBkcox+kovJLieVI9RgDR988RBxMOi6K9Nfgc1pbOcfU1DJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775311339; c=relaxed/simple;
	bh=pui2CY/MHaerWoTe+/7bHBimXbcDMdDAeW59iYcu0PI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iokx+huSqciGMB6OpUMKtvF4GyeTY8cyI9Rbosijm3g9RaCK1j01+ZBJvHntN64tJp6frB6D7RlL4rKNbaN/f1GMNXZzfhykWNlFHLk1R8nLQ327fMaavXd0O2GyHW7a0TeJA5wgsujd4SEPc1t9fmDB5heNgdyjqgFnRsvrALY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CJUHvW5l; arc=none smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CJUHvW5l"
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-1274204434bso2955304c88.1
        for <linux-pm@vger.kernel.org>; Sat, 04 Apr 2026 07:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775311337; x=1775916137; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=migxXqV8IwRWUQ78ctplOv6exsVkYjSUqCPHFrApy2I=;
        b=CJUHvW5l1x6v2vRj4lmjIh8xDtYyBXn+fwcOuUAfWQYJ/tlfyjNQvK03PqP3Di9Lgx
         mDY0AuK5ctXan7uciMPCn+Uq8E/eINRtWp/v0meWUyXSIJCCUnEMmrov7OUxottqmPL3
         GnsMvvbjUblHgXuLJtS8cyrkWwZngfgCUfWScNCV6/LL2EI0DdluGP3gClbWv3Zs1mv0
         bknYKWeMwHB97vHtImzkQEL6iokX6VJNyVvVkzdkinu1S86xJCdL0NsA1CUo9wnVRY0d
         LzGWdUXQE+F3xfQAwrP1/BQ1h1lBehiWo6oBWZqXjIoC6lG5D7vKgSO7KM+xkv0wDMiF
         5uDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775311337; x=1775916137;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=migxXqV8IwRWUQ78ctplOv6exsVkYjSUqCPHFrApy2I=;
        b=E8pGg+8GgbCQ09bCElHgtSimJzevyx7+YxCUrXumRg6IJuYdInRDNQMTXs3/ewLh36
         xtNyfUXGj0TG4ZYSiO2T7gxsVovO34M2E4PjMesjAt3qBwcIAbJ/N6lKIduUITJLtaEI
         l+cNrWdJHpAZK31xNUIaaNxsDr3H+VMvch3AV7xCnaSi6q0JMu4MmYv2UPvYImfRyLD1
         GlDIjcPwbHtU7iEaIQ0XtBYyHOXDjxuBtY7v0kE8heKsUuZIDw0jczF7YQ2nciLkeb+4
         Eiwg9ZtotEvYZjiP8mktlVyUYTFY9jxLxzCj3exHN51Vm5LPOsI4Vjl6WI9I9m8p6yLd
         ZeAg==
X-Forwarded-Encrypted: i=1; AJvYcCWQALwVStHexkVIP0XX/6DCQwp4JJVJQTvjB3gK85bADT855fKkmmTha44aybi5QDuqhn4M0Qf6lQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxTGKpkb24Mb11Vx2fGz/9fnOnyug6T/13gS/mH0iSWt2vXtHvE
	nI/PpkPEYZJoXv0rnosGbzgERWIvo9nG83fDRceT5CukI/u23kIvqzij
X-Gm-Gg: AeBDies9eFQd1sjPUAnW1M33/cPfSPBBfZiXeisHn/M7Nc5KyDIOGhp6oZjXQyY4mJx
	pDifttGCWU5mnFB5Pqr4+UBR1f57I4Rr3ZiEp57NHUcARXtf9ZPNTk9M0QlEJHvBrF20fl4tPaC
	2s1y9/OfUci7k+smbYyQxhayucHOP1ShpUGccM4OF9UlomVN2oqkUZ7EhUpubnerhOCNYvkNY60
	Hjh+PaYx3ZHvIAd/bWHAhWAv7zqIXOTJwaDIA/tzqITC6m0BKtyGJeidOxySVH+6PwlVUmFThLr
	RoPbgvMXXKzItMwg6edj6G8Ng2JqUn0ObybqvJgPwxLwVH4QJAsw0MFSC4fxDz6T4NVIyolMpPT
	2U6uNV/IqJeOvs8akbh76kwA8pqR3UGQaFWMWJ9B7zMsrMMhE+nFswCZ/AP9zQqRZI32Dz+zVax
	iAeYBx5GGhFovasWXgdip+zcEg8yx1Q23urNmrBxxp2uxlbslLwY+3gcfwfw==
X-Received: by 2002:a05:7022:2219:b0:123:2de5:346e with SMTP id a92af1059eb24-12bfa9cddfbmr2636491c88.0.1775311336564;
        Sat, 04 Apr 2026 07:02:16 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12bedd4e623sm6965003c88.3.2026.04.04.07.02.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Apr 2026 07:02:15 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <ec16fc75-c5fa-4ff9-bc6b-91464e9c26cc@roeck-us.net>
Date: Sat, 4 Apr 2026 07:02:14 -0700
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
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <CAJZ5v0jZPXC5g3KY+trwmV=nXJu74y=0LaQTHaQ_MnqcfPVAGQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/4/26 05:58, Rafael J. Wysocki wrote:
> On Fri, Apr 3, 2026 at 4:20 PM Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> On 4/3/26 05:52, Rafael J. Wysocki wrote:
>> .[ ... ]
>>> It appears to work for me, but I'm not sure if having multiple hwmon class
>>> devices with the same value in the name attribute is fine.
>>
>> Like this ?
>>
>> $ cd /sys/class/hwmon
>> $ grep . */name
>> hwmon0/name:r8169_0_c00:00
>> hwmon1/name:nvme
>> hwmon2/name:nvme
>> hwmon3/name:nct6687
>> hwmon4/name:k10temp
>> hwmon5/name:spd5118
>> hwmon6/name:spd5118
>> hwmon7/name:spd5118
>> hwmon8/name:spd5118
>> hwmon9/name:mt7921_phy0
> 
> Yes.
> 
>> Names such as "r8169_0_c00:00" and "mt7921_phy0" are actually overkill
>> since the "sensors" command makes it
>>
>> r8169_0_c00:00-mdio-0
>> Adapter: MDIO adapter
>> temp1:        +36.0°C  (high = +120.0°C)
>>
>> mt7921_phy0-pci-0d00
>> Adapter: PCI adapter
>> temp1:        +30.0°C
>>
>> essentially duplicating the device index.
> 
> Well, with the patch posted by me, the output of sensors from a test
> system looks like this:
> 
> acpitz-acpi-0
> Adapter: ACPI interface
> temp1:        +16.8°C
> 
> pch_cannonlake-virtual-0
> Adapter: Virtual device
> temp1:        +33.0°C
> 
> acpitz-acpi-0
> Adapter: ACPI interface
> temp1:        +27.8°C
> 
> (some further data excluded), which is kind of confusing (note the
> duplicate acpitz-acpi-0 entries with different values of temp1).
> 

Yes, agreed, that is confusing. I would have expected the second one
to be identified as "acpitz-acpi-1". Do they both have the same parent ?

> That could be disambiguated by concatenating the thermal zone ID
> (possibly after a '_') to the name.  Or the "temp*" things for thermal
> zones of the same type could carry different numbers.
> 
> A less attractive alternative would be to register a special virtual
> device serving as a parent for all hwmon interfaces registered
> automatically for thermal zones.

If they all have the same parent, technically it should be a single
hwmon device with multiple sensors, as in:

acpitz-acpi-0
Adapter: ACPI interface
temp1:        +16.8°C
temp2:        +27.8°C

Guenter

