Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=94.231.106.230
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794150554;
	b=oG6a8P3xVoQTB9vy5GhkH1PPe+gNW7ampwLsme+CPh30k1W8FEKhQ5jw0FFrkQgn9AZG
	 2Q/3aFMngjwP2ujdz25qp8GCbJwYCD4+OGikOepqWYRLNSOANS9U8D1w8yst6D0mU2KGX
	 X0LReYb0euIHZt0OQjRDgK6gko9a567AskPKnI3GLGYyFvkH/2GwEGz21PKuvnqsZTe4n
	 Yq5MmtwU0WUjIGoB95vAzMwiytFsUp69Lat0ro4DAkpEM0qROuEEEbOLbqp7mQGpvE3jg
	 DBNhM0qpqZf+KBr5bKt/HFmgnLm+P9h4jCQRY8tz98Wdwizs3OoaYccWqN8uORa6vrQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794150554;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=eZ9X5JmqE+6Ign1BGIGBRDm4FK8j/iFGtRIwdvBYSmM=;
	b=E6Eq3tzURkg7ub2WjPwezoLP5oY7F4E+y2xe0mhiyOoC09cdQuY0YDRZ4/DLpFuaR29E
	 rYx/qF7sUUJYKKyuZaT4Eb2EevRq+YW/DQ1CBP8p0tkM04klxIZBRFYdCiuvt0FUWKlpx
	 guSf/Tg0a48wDjCm37LHheDMNLpwvwtYNGiDFEiUAJgOL0NUDs3sOkI/M5tVKe8VR/SE6
	 LQJpM22dXXRgXCX71F0P5QEeZM2J9vTiT8H5lQFdtIf09xT+pyBiAWKSyH4nmUcbODoHL
	 /9ruQdZCItt16mQhItq+88xkiJeILTj6KXcmPaexwhejyYdsr5RzadHO3/XJ4CDzYfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=klattorp.se;
	spf=pass smtp.mailfrom=klattorp.se;
	dkim=pass header.d=klattorp.se header.i=@klattorp.se header.a=rsa-sha256 header.s=simplycom2 header.b="H/AEgOi2";
	arc=none smtp.remote-ip=94.231.106.230
Received: from smtp-out2.simply.com (smtp-out2.simply.com [94.231.106.230])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8F5606A31C;
	Sun,  8 Nov 2026 15:09:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6A8F5606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=klattorp.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=klattorp.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=klattorp.se header.i=@klattorp.se header.a=rsa-sha256 header.s=simplycom2 header.b=H/AEgOi2
Received: from [192.168.1.45] (81-228-203-110-no2102.tbcn.telia.com [81.228.203.110])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp.simply.com (Simply.com) with ESMTPSA id 4jMxCC3sQnz1DQsm;
	Sun,  8 Nov 2026 16:09:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=klattorp.se; s=simplycom2;
	t=1794150551;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eZ9X5JmqE+6Ign1BGIGBRDm4FK8j/iFGtRIwdvBYSmM=;
	b=H/AEgOi2KWQizzw0yVFETqJ1lKwW+9yut0Dl7MxqzsxKZLhOGQ4hiTV9J5Kma+DaaYTKJN
	WG+9aNwk/EkdGPTsq3S6p1UB8DYjhixFvKKPezVNgl8X1T0HYND6rHfvfMFSXjw5Ioez9x
	80mwl3SdjUIrIjkoL3+LcKKvDrFQBWZIZaLMsQujZYpBrwcmDiDM4mM+KnFf5ijSUgdmWx
	TswH9LIp406Bawt77doLrAvKZ0b+fwQjh8jZm4btcvFvcUMI+QYzW7nBNooJ6Cv+nPD6bK
	jNiONzV9CNn5MG7HDt1tcr2LyAYN4ZerGVyExsxrvewiIP+yAqU0Pl7z7vw1+w==
Message-ID: <3cd1da5d-8888-4127-b406-a1ed35454e77@klattorp.se>
Date: Sun, 8 Nov 2026 16:09:10 +0100
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
To: sre@kernel.org
Cc: linux-pm@vger.kernel.org, matheus@castello.eng.br, me@iskren.info,
 krzk@kernel.org, m.szyprowski@samsung.com, linux-kernel@vger.kernel.org,
 clamor95@gmail.com
References: <20261108144548.190622-1-huggek@klattorp.se>
Content-Language: en-US, sv-SE
From: Hugo Karlsson <huggek@klattorp.se>
In-Reply-To: <20261108144548.190622-1-huggek@klattorp.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Adding the other MAX17040 reviewers, LKML, and Svyatoslav as the
author of the commit in the Fixes: tag, whom I missed when sending.
Sorry for the noise.

//Hugo

On 08/11/2026 15:45, Hugo Karlsson wrote:
> Hi,
>
> I work on OpenFlight [1], an open-source golf launch monitor built on a
> Raspberry Pi 5 with a Geekworm X1202 UPS board. The board pairs a
> MAX1704x fuel gauge at I2C address 0x36 with a GPIO that is high while
> input power is present.
>
> With the gauge and a gpio-charger described in DT and linked by
> power-supplies, the battery still always reports status "Unknown", and
> capacity reads above 100 when the cell is full (103 here). Desktop
> battery indicators then show the wrong state, so we have been shipping
> a patched taskbar plugin to work around it.
>
> Patch 1 passes the device fwnode to the power supply core. Without it,
> power-supplies is never parsed, so the supplier status lookup added in
> commit f4b782af61ae never finds a supplier.
>
> Patch 2 covers suppliers that only report "online", such as a
> gpio-charger without a charge-status GPIO: the status is derived from
> power_supply_am_i_supplied(), and the battery now sends a change event
> when its supplier changes.
>
> Patch 3 clamps the reported capacity to 100.
>
> The series is based on for-next. I tested it on a Raspberry Pi 5 with an
> X1202, on rpi-6.18.y (6.18.50), where max17040_battery.c only differs
> in the style of the i2c_device_id table:
>
>    stock driver:          status Unknown, capacity 103
>    on mains at 100 %:     Full, capacity 100
>    unplugged:             Discharging
>    plugged in at 98 %:    Charging
>
> The battery's uevent follows the charger's within 1 ms.
>
> Related changes for the same boards, for context:
>    - Raspberry Pi overlay that links the gauge to the charger [2]
>    - Raspberry Pi OS taskbar battery plugin reading capacity [3]
>
> The patches and changelogs were written with Claude Code
> (claude-opus-5-5) from my description of the problem. I reviewed them
> and did the hardware testing above.
>
> [1] https://github.com/open-flight/openflight
> [2] https://github.com/raspberrypi/linux/pull/7744
> [3] https://github.com/raspberrypi-ui/pplug-batt/pull/17
>
> Thanks,
> Hugo
>
> Hugo Karlsson (3):
>    power: supply: max17040: pass the device fwnode to the power supply
>      core
>    power: supply: max17040: derive status from an online supplier
>    power: supply: max17040: clamp the reported capacity to 100 %
>
>   drivers/power/supply/max17040_battery.c | 28 +++++++++++++++++++++++--
>   1 file changed, 26 insertions(+), 2 deletions(-)
>
