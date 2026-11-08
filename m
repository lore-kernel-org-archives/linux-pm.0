Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=94.231.106.230
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794152680;
	b=2oj/0VXyYVpUYHScmxXyuRyXilNXjv6VWESeWsNMpQTfXjcTYjBCSK+/2vEjBjnW2PUg
	 WNq1s10DPH2hqQ8uycKSevqiRy4TEkvSbCXC0YLwCTHbcVVKfhepLQIKVsSceOQThelQW
	 RCnVVHFu1mAykE/dQTFYQ0QeA/N8MtBY4y19odhIYVch3X/yRg0jjS52FNUiBgTZcC2W2
	 ofqap26Xba7INeIKP4Hq0lCRu95aFNKzlQmKPre8jSXZsr3D1gYelNnMNHwF63HfWqMmB
	 W1dzB02NgzyQAwEQHI37ZGWMi+fIWdnLK1YfTUkzEG5Tc4oG25QzBb11kdu0Z+uycsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794152680;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=CGTrufR5u551vPqeL8Q+XJZMetV7BiZ7/CTz+720Qbo=;
	b=rgVrotX2olIHg41Nu95EvnxWbq/LA+r6l8grE3LIelpvEkuTzPMTtBcqK4L+IhVABkzx
	 ea+1D/pI89yXUjCoiDziMQFzc38uHj4I2ZsAx14MJBPLgZ7QAfoFNB0oRDnZaxXmMH34I
	 a3LWSI5C0wZnSUws1gc0N/t4KHEJmRKkYg0wLiPF/vPuWoJSw80dPvbCL076kiBahxRFt
	 yLS5OY5StPZ4lCNaZLOmwsChT8B6d8BT1V5fMERB5Rt4RXVJvvcU/SEuDCGHB9J2MwOBJ
	 xYeP7wehD++OOPniPQYLWjYW1IK3P2zi7Bh1hoKeHn/F27yVMIEVJWF9axoP7MKZ1SQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=klattorp.se;
	spf=pass smtp.mailfrom=klattorp.se;
	dkim=pass header.d=klattorp.se header.i=@klattorp.se header.a=rsa-sha256 header.s=simplycom2 header.b="Hy/UKf5T";
	arc=none smtp.remote-ip=94.231.106.230
Received: from smtp-out2.simply.com (smtp-out2.simply.com [94.231.106.230])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81E1606A31C;
	Sun,  8 Nov 2026 15:44:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C81E1606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=klattorp.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=klattorp.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=klattorp.se header.i=@klattorp.se header.a=rsa-sha256 header.s=simplycom2 header.b=Hy/UKf5T
Received: from [192.168.1.45] (81-228-203-110-no2102.tbcn.telia.com [81.228.203.110])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp.simply.com (Simply.com) with ESMTPSA id 4jMy053fw9z1DDhC;
	Sun,  8 Nov 2026 16:44:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=klattorp.se; s=simplycom2;
	t=1794152677;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CGTrufR5u551vPqeL8Q+XJZMetV7BiZ7/CTz+720Qbo=;
	b=Hy/UKf5TEHjR1thBp6W0sZpBTN8gOvj5uTz88jJ9YmEsYhZpHcJw7QiZTs/QFvOwhCXL8X
	qmfOlnwXNCxSP2zY3Znm/tZpDL0RgDM54cBgYl7Q+DvBPGxjAVtFWEMVpNTSvscPC6t9fg
	F8iqwW40lIqgwZy5M7lYzmG9vItLetbq6btzWhYCaZzOpYIvifElEfv3qa63EXGYGyYgXn
	kJ7PAzNm3wFmV41rFpbDTnV4V0cvAQzjJzkhvzPKop4ntNOc1TYAfohmoUV5pcNw/Lxm+N
	YhTSOUjY0pepMqTkxy7xSdnxp9ykxT6cw3PQAX67sfRAd//19RJNPhCA7TMuhQ==
Message-ID: <ce39c36e-cb6e-4239-b14d-528eab9b132d@klattorp.se>
Date: Sun, 8 Nov 2026 16:44:36 +0100
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] power: supply: max17040: report charging status from
 a gpio-charger
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: sre@kernel.org, linux-pm@vger.kernel.org, matheus@castello.eng.br,
 me@iskren.info, krzk@kernel.org, m.szyprowski@samsung.com,
 linux-kernel@vger.kernel.org
References: <20261108144548.190622-1-huggek@klattorp.se>
 <3cd1da5d-8888-4127-b406-a1ed35454e77@klattorp.se>
 <CAPVz0n0KjpfuNNG=r-Zgf6gNX68UnvUARQm4KUS5FNGH439F0w@mail.gmail.com>
Content-Language: en-US, sv-SE
From: Hugo Karlsson <huggek@klattorp.se>
In-Reply-To: <CAPVz0n0KjpfuNNG=r-Zgf6gNX68UnvUARQm4KUS5FNGH439F0w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Thanks, I've resent the series with LKML: 
https://lore.kernel.org/lkml/20261108154241.198160-1-huggek@klattorp.se/

//Hugo, completely new on the sending side of mailing lists

On 08/11/2026 16:20, Svyatoslav Ryhel wrote:
> нд, 8 лист. 2026 р. о 17:09 Hugo Karlsson <huggek@klattorp.se> пише:
>> Adding the other MAX17040 reviewers, LKML, and Svyatoslav as the
>> author of the commit in the Fixes: tag, whom I missed when sending.
>> Sorry for the noise.
>>
> I do not see your patches on https://lore.kernel.org/lkml/
>
>> //Hugo
>>
>> On 08/11/2026 15:45, Hugo Karlsson wrote:
>>> Hi,
>>>
>>> I work on OpenFlight [1], an open-source golf launch monitor built on a
>>> Raspberry Pi 5 with a Geekworm X1202 UPS board. The board pairs a
>>> MAX1704x fuel gauge at I2C address 0x36 with a GPIO that is high while
>>> input power is present.
>>>
>>> With the gauge and a gpio-charger described in DT and linked by
>>> power-supplies, the battery still always reports status "Unknown", and
>>> capacity reads above 100 when the cell is full (103 here). Desktop
>>> battery indicators then show the wrong state, so we have been shipping
>>> a patched taskbar plugin to work around it.
>>>
>>> Patch 1 passes the device fwnode to the power supply core. Without it,
>>> power-supplies is never parsed, so the supplier status lookup added in
>>> commit f4b782af61ae never finds a supplier.
>>>
>>> Patch 2 covers suppliers that only report "online", such as a
>>> gpio-charger without a charge-status GPIO: the status is derived from
>>> power_supply_am_i_supplied(), and the battery now sends a change event
>>> when its supplier changes.
>>>
>>> Patch 3 clamps the reported capacity to 100.
>>>
>>> The series is based on for-next. I tested it on a Raspberry Pi 5 with an
>>> X1202, on rpi-6.18.y (6.18.50), where max17040_battery.c only differs
>>> in the style of the i2c_device_id table:
>>>
>>>     stock driver:          status Unknown, capacity 103
>>>     on mains at 100 %:     Full, capacity 100
>>>     unplugged:             Discharging
>>>     plugged in at 98 %:    Charging
>>>
>>> The battery's uevent follows the charger's within 1 ms.
>>>
>>> Related changes for the same boards, for context:
>>>     - Raspberry Pi overlay that links the gauge to the charger [2]
>>>     - Raspberry Pi OS taskbar battery plugin reading capacity [3]
>>>
>>> The patches and changelogs were written with Claude Code
>>> (claude-opus-5-5) from my description of the problem. I reviewed them
>>> and did the hardware testing above.
>>>
>>> [1] https://github.com/open-flight/openflight
>>> [2] https://github.com/raspberrypi/linux/pull/7744
>>> [3] https://github.com/raspberrypi-ui/pplug-batt/pull/17
>>>
>>> Thanks,
>>> Hugo
>>>
>>> Hugo Karlsson (3):
>>>     power: supply: max17040: pass the device fwnode to the power supply
>>>       core
>>>     power: supply: max17040: derive status from an online supplier
>>>     power: supply: max17040: clamp the reported capacity to 100 %
>>>
>>>    drivers/power/supply/max17040_battery.c | 28 +++++++++++++++++++++++--
>>>    1 file changed, 26 insertions(+), 2 deletions(-)
>>>
