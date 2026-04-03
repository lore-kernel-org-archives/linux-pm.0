Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25BF23C554E
	for <linux-pm@vger.kernel.org>; Fri,  3 Apr 2026 14:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775226010; cv=none; b=ctnR9jpnPmoCPIxG4BRVkX5QgI2UQmA3ZDkV92cco7IhcNN5wBWlk1xo2f5DVjyrrppmVTbEWJz/Gz2cFOcvJ3PzeoBw45COiZor8A2mmtbTleItOpI//MVGSeEVDTBnZ+234rMOAkXK1x0h2BUIIcW4HiopFVgwEW9gYpopodE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775226010; c=relaxed/simple;
	bh=q6aLYQi/GSYkWx4zjUOFY+Apoci2erR8dsFPJ01NFzw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RL9mzyktHlbNdd2nEf9x0TE/GbAFzzQJBZpOcLB2rM2hQ8kVTIeL6i32Yxnd7U78QDiE0Sp0nOQ+QCegqewFtL5ipZdwzS+wtlgzWoQyAA94cJgivPGNlC3LsSdojs3xB1+uMnspRDQOy4fqn6IacZJQuBr8B0MOJZRbGailCJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TA9pXmfg; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TA9pXmfg"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-2c156c4a9efso2319333eec.1
        for <linux-pm@vger.kernel.org>; Fri, 03 Apr 2026 07:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775226008; x=1775830808; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=a5qbe4blEcePCtVOcOKZ0vHUGNI9pEoCsfXF5ttISwc=;
        b=TA9pXmfgFPoFWJYsIWo83SffdVKcQ3FWeRTvEkKBBG6LrRS+EoDObRtJz1MG8WE4qN
         4wHeU7LrNGkmfCT8FIHCceywMMdj6/LgDCSEm8MIB3ctrYCxtNP1guJ9iY2lXPp+pOzq
         BDQBhlwwJi5SB3FF5ShbOyILBSeb79zi+q1/8xraqGRM0mQuSOpkz4hzK9esUo+lBud0
         fGbjkxpD7uz124eWy9FjuXJelsJq6RsdXgZLngt/VsNUOU+Me/xvwJGes3xr6pbczCoQ
         83j2bbcwqewST7NGXs7v+kTEHJb2n3Y9SbgGxsdN2kkADqgy9FTNUh7XSRtCx/DkDAit
         jaGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775226008; x=1775830808;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a5qbe4blEcePCtVOcOKZ0vHUGNI9pEoCsfXF5ttISwc=;
        b=F46aez0Nrcz2AW0bFhWnh4GmYDSV7mdbIh4zVnEEAaWILSb0sDuqnaIQsX4a2K1/8X
         rKwrCtNS43dPikuD331Nx10HalbCnTBo/g51MUnqWKuK0MGQl3rI972kmYLjJn48/bsP
         mQykPPPGTwUkz4245M44p7r5dEgO/9TtSLR/0v7P55+eZtNksUqkANselnBMJiAkb1n/
         j4fHtQ8ZZuNxlMjqzQ2W2YNkNRsrPbNJgFv7jqkrcJpj3XK2cHuZE+043npJaQzrLIou
         5/Hix/MilsC/uW44r6+ENFTUvD5Wp719rOLBVvIPG1pZNvLZ3QLfFL8KSrxFZ1R8+IWR
         eFBA==
X-Forwarded-Encrypted: i=1; AJvYcCUOQ6P/IVCaOHeTyOz/DRoz0UIWlkt9mYlcoAn3v2NIfLz+zL+n5ItimpB3TJbeVNtWH9CwbIBYTw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyF05NQNSYYFTCReOf2RCkYiUAGWDArFrAyDCCeQrL6XkBmGWO2
	F45nd00bISr1OqEyJkaUa4bRZpVZXhK4Lz1NbxI00HOuhizaQvVCDwNn
X-Gm-Gg: AeBDieupiPfxh24+aBg81ZW7xwTUVxqTUqIBW2sNsQY84G2SLdKvyijDwtMkX5KV92d
	aF9vq9KWYlpYnybobbFVrxjpfp82ILYHA9HAus47kSSBv2Q5BMucUB7GijYqho43KcAVIpvvap5
	FjuPaDDAxUQ1dnIsejRR9avCQHD6udfqYLIa0h7lDxeHyV+mQmQAx55qL9gT1arrD3Jd15EI9zD
	bymry0kZXpJFqjacvs9bxv8kA6zTaqG+gtDUQEQjOVIxsZUjaLnhZ0pUlzrdWvmf8tVMKjxowFL
	H/sbFc0sQjBe66x5h7EKYu5xwMBzK8/iEUdL8q0Ci7yAeIqS3LG+bIdZKjnU2P+3XOAN8b4vrUu
	MgtkcqwMMLBbHcYqYvxWc+cEYnx/VHqZHdwnT8GAlCQPWut8P77pBhEY/k00+KGD4dtd1po18jB
	kgRu3BtuOMsTPVhTzNYob1Dxr44eODWZtHqqKME/ZJV5hP2U1JO2eAolQqIKXxSoGQlJ4lIlzU
X-Received: by 2002:a05:7300:6d05:b0:2ba:a60a:15e6 with SMTP id 5a478bee46e88-2cbfb994665mr1743272eec.16.1775226008020;
        Fri, 03 Apr 2026 07:20:08 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ca7cf1271asm6588907eec.26.2026.04.03.07.20.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Apr 2026 07:20:07 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <ebdbe040-d673-47b9-a6c9-f0fefc0b771b@roeck-us.net>
Date: Fri, 3 Apr 2026 07:20:05 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v1] thermal: core: fix blocking in unregistering
 zone
To: "Rafael J. Wysocki" <rafael@kernel.org>, Jiajia Liu <liujiajia@kylinos.cn>
Cc: Daniel Lezcano <daniel.lezcano@kernel.org>,
 Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Armin Wolf <w_armin@gmx.de>, linux-hwmon@vger.kernel.org
References: <20260402022742.17738-1-liujiajia@kylinos.cn>
 <2432224.ElGaqSPkdT@rafael.j.wysocki>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <2432224.ElGaqSPkdT@rafael.j.wysocki>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/3/26 05:52, Rafael J. Wysocki wrote:
.[ ... ]
> It appears to work for me, but I'm not sure if having multiple hwmon class
> devices with the same value in the name attribute is fine.

Like this ?

$ cd /sys/class/hwmon
$ grep . */name
hwmon0/name:r8169_0_c00:00
hwmon1/name:nvme
hwmon2/name:nvme
hwmon3/name:nct6687
hwmon4/name:k10temp
hwmon5/name:spd5118
hwmon6/name:spd5118
hwmon7/name:spd5118
hwmon8/name:spd5118
hwmon9/name:mt7921_phy0

Names such as "r8169_0_c00:00" and "mt7921_phy0" are actually overkill
since the "sensors" command makes it

r8169_0_c00:00-mdio-0
Adapter: MDIO adapter
temp1:        +36.0°C  (high = +120.0°C)

mt7921_phy0-pci-0d00
Adapter: PCI adapter
temp1:        +30.0°C

essentially duplicating the device index.

Thanks,
Guenter

