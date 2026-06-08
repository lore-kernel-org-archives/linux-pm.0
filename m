Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16903E5592
	for <linux-pm@vger.kernel.org>; Mon,  8 Jun 2026 19:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780946436; cv=none; b=p24sasPDeR2kfnQmRDo0EjDo+VqDOY+JNTD56P7Mt5Y0o7to9iaWB6dcwBXVqpJbKr/A/CJCthf+YMR3G1h+6rJmViqShrY/GCL1uljGqL1gAzU0WnR8IlkEVPEvDb/D8Qx0zRbppubsYJ6f75UZq9S//XAOvc9YbgboV/s2vTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780946436; c=relaxed/simple;
	bh=2u+Xfn/gA/Zlxvjk6kd3ZW1dS/a8SzaktNKuePrs584=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=thn5qLQwmdbu2MscGRHyppWtka7GU4lUjhfqS25E69pqcy5Nrxg177SPETfQvNZCY9nsU25hbR2k1HHxnb4Wd+rO3RoCgFO3P6cBJmz1eV2zZ0myJe13Q/ygBQyCns65HO9M1FlhE06FLnqthJsJFcto/UCVHc0DDKqKE7U4hYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PJGirDtL; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PJGirDtL"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-7dca5a81be2so44096037b3.2
        for <linux-pm@vger.kernel.org>; Mon, 08 Jun 2026 12:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780946434; x=1781551234; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=u+95oXBG47L0iPpZbqlYy2FEeWBxLE+pydioXJNH4nA=;
        b=PJGirDtLFtWMNqLr8GvXBwe6cYluaQevmCBbmzrKus9mDY8It9szVAByixXnN2LyrF
         CbDZ6ZgGO78Bjb9uDxDXjfYcKT5DE4+XyJrCnUt8QDEHSHh5Uipn3816y9PG8XPcULKs
         ASJKz/k/liIW60BzmEdESFjYJHO5Rg8s1X7RXdUGnksD1/DWKWRFxdoWbGrqt6OHjbwl
         vb23A6bCy/fOS9eyp1Y+KehbiaairgJADfpE+AwJ5dPnsxrGIEvlnnRP/oX2WNecghlE
         i/t+KUvxpfQn8jOW7QW/e7uqEjHQjUHpmqppICI0j/yElgyj4McWoAbVNyFUdgVndp75
         LAtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780946434; x=1781551234;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u+95oXBG47L0iPpZbqlYy2FEeWBxLE+pydioXJNH4nA=;
        b=m+r8Xutq68lKCj4olifyA7I8b+JBBAzGwYbXbi08KQA4HokqDBjXQoaaCeRv/ah4YI
         6lcwJKs6ZpDzek5KhXRC1cQX7QSXrmbOQZwnJhy4NPUBXaBxULUQjXvrQOHM4GaFe9Zt
         5n5Lzs3H2yUovUZDm6RK8gSL0v4z1OjggTSjY6btSX+mXGfTOB/GrC+HhnjXsLT4w7t2
         dEekBAfgN9h1ukHJxfdNoZyVZXAeiY5vCxA+aE6CZw3X5pIYng4Yp8AdRR32w1Qg6Hdx
         o8vd/XY5RjPzwHVLi3wfWybPnYHyqjHcM5I10GCVpibHw/ba62ONAFjczJIpESBEwpu9
         REsA==
X-Forwarded-Encrypted: i=1; AFNElJ/R/P0Vqj/TK97d3JUPjLzmHK0IhpxzPt7XzL51twf5vFcPp4mbxFzsrOvr1z9bny0wBpteE3Uj8w==@vger.kernel.org
X-Gm-Message-State: AOJu0YwLEEQm1mMkoXw3LCUJ2fvRck3HB98+aodk7oQCBazLKoLPGBst
	NWBLyo9GUqISjbUBMnF0Rf/TvpW5Z2pYt7g2TNpTKy2FfbHE8aXAe4E1se+qiNpHIQ==
X-Gm-Gg: Acq92OH5uF63IoVX3pzTa4ZWdKOqk4OSB2TNMBWyoMgOuQ3vqLTuN9Jopp4n7j9uifO
	cA/26QUH7seKEavKI/gBBKa6IGJjoHZ1RGE3GHmOX6nytE4HdRqnkbdGKCx6b5rRDrFKB9OduZS
	ZFSWfh4ndxFNVKC9MFWYb0xzIIq8rQR/PsqTwszYV0T8WOtFwyQi7n9kBPGtNZfCqb4Hm9ACvTG
	dnaFWMti6clXK3fbjZc8839K/KV82ueJVgd/FlRPTDXHjFQE4SxiAW1wnhnnmnJtMR+qOb9L4e/
	TyE1nEI29syqCBkoO/8TMDQzYpkDh1AdImUm9WozwmFc8ePumJ1Vcuriy/VrzMALSDlnDINMYn8
	FwBj0tt1qyU3zVPTX/YSontm8CvJ2Nh5kLrY5PUKkVSEbOkBE/vXFn0DPA17MWNJrXU8jaFF5YE
	jM1pk2JJ3aTwNfViK12kjx1KL78u7OhXsQGpruAMNQ0TmwUKkYY/ffrXCaIzFqDgVmiq9VERmT6
	9sKNnX4d0adJBMZHQiVGQafsbJNfuGDg91SjoN1TGdIKgJKUgtT
X-Received: by 2002:a05:690c:7088:b0:7bd:6043:7ea5 with SMTP id 00721157ae682-7ed0b48d978mr158107477b3.19.1780946432975;
        Mon, 08 Jun 2026 12:20:32 -0700 (PDT)
Received: from ?IPV6:2600:1700:4570:89a0:2e8a:3aa8:ce92:765c? ([2600:1700:4570:89a0:2e8a:3aa8:ce92:765c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7ef81dcc565sm25010477b3.49.2026.06.08.12.20.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jun 2026 12:20:32 -0700 (PDT)
Message-ID: <6ea3d71f-ec81-44b7-a0f7-d10adcb4c834@google.com>
Date: Mon, 8 Jun 2026 12:20:25 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Amit Sunil Dhamne <amitsd@google.com>
Subject: Re: [PATCH v3 0/2] Add support for Battery Status AMS
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Badhri Jagan Sridharan <badhri@google.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Hans de Goede <hansg@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>,
 Purism Kernel Team <kernel@puri.sm>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
 Tudor Ambarus <tudor.ambarus@linaro.org>,
 Peter Griffin <peter.griffin@linaro.org>, RD Babiera <rdbabiera@google.com>,
 Kyle Tso <kyletso@google.com>
References: <20260602-batt-status-v3-0-a7c1c271f3b0@google.com>
 <aiG1aJY7VURSJOZ2@venus>
Content-Language: en-US
In-Reply-To: <aiG1aJY7VURSJOZ2@venus>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Sebastian,

On 6/4/26 10:36 AM, Sebastian Reichel wrote:
> Hi,
>
> On Tue, Jun 02, 2026 at 10:47:05PM +0000, Amit Sunil Dhamne via B4 Relay wrote:
>> PD 3.1 v1.8 Spec necessitates a response to Get_Battery_Status request
>> from the port partner (see "6.13.2 Applicability of Data Message").
>> This patchset adds support to get all the battery type power supplies
>> and query them to report the telemetry required to build a Battery
>> Status Message. Right now, this submission assumes all the battery type
>> power supplies that exist in the system are fixed (meaning cannot be hot
>> swapped).
>>
>> Previously, I had sent a patch series [1]. However there were some
>> concerns. Broadly:
>>   * No client drivers
>>   * Duplicating dt properties
>> To address the above issues, we now have Fuel Gauge and Charger drivers.
>> Also, I have rectified my approach to fetch information about batteries
>> from the power supply core.
>>
>> While, the original patch series [1] added support for Battery Caps as
>> well, this patch series only adds support for Battery Status. Therefore,
>> I am sending it as a new series while incorporating relevant feedback.
>>
>> [1] https://lore.kernel.org/all/20250507-batt_ops-v2-0-8d06130bffe6@google.com/
>>
>> Patches in series:
>> [A] "power: supply: Add helpers to get and put arrays of power supply handles"
>> [B] "usb: typec: tcpm: Add support for Battery Status response message"
>>
>> Technical dependency of patches:
>> [B] depends on [A] due to usage of `power_supply_get_battery_all` &
>> `power_supply_put_battery_all` APIs.
>>
>> Signed-off-by: Amit Sunil Dhamne <amitsd@google.com>
>> ---
> I think you want to filter on batteries that are
> POWER_SUPPLY_SCOPE_SYSTEM? Otherwise this would also give you
> battery devices for something like a cordless mouse.

Thanks for pointing that out. Which one would you prefer?:

1. Bake this into the power_supply_get_battery_all() implementation by
either passing the scope as an argument or directly implementing the
filtering on POWER_SUPPLY_SCOPE_SYSTEM without the argument.

2. power_supply_get_battery_all() returns all battery type power
supplies but tcpm filters them. Note that tcpm still keeps all
references to all batteries because of the review comments in [2].


[2]
https://lore.kernel.org/all/4e4a63a4-9d07-4b77-a8dc-ba19c9a803f7@kernel.org/

> You mention that this is assuming batteries to be always present,
> but handle POWER_SUPPLY_PROP_PRESENT. So basically a battery, which
> has POWER_SUPPLY_PROP_PRESENT=0 would violate the PD spec as Fixed
> Batteries are not supposed to have this unset?

Just to clarify, I meant fixed and not "always present". The spec
defines fixed battery as:

"A Battery that is not easily removed or replaced by an end user e.g.,
requires a special tool to access or is soldered in."

Theoretically, you could still have a phone with the fixed battery
removed and the system powered by USB.

So, while this is more relevant to hot-swappable battery case (, which
is defined by the spec as: "A Battery that is easily accessible for a
user to remove or change for another Battery.") it wouldn't be totally
off the mark to add that check here.

So while I lean on having the check present, I am okay either way.


> Not sure if this is fixable, but you implicitly rely on the battery
> driver to be probed before TCPM reaches this.


Given the power supply architecture, the probe order is deterministic: a
power supplier driver (e.g., the TCPC) must probe before the supplied
devices (charger, fuel-gauge). Because of this, TCPM will naturally be
up and running before the fuel gauge during early boot.

Holding off TCPM interactions to wait for downstream devices to probe
isn't a viable option. TCPM operates under strict USB-PD timing
constraints. Stalling the state machine to wait for a fuel gauge could
violate these timings and cause the PD contract to fail entirely.
Furthermore, a fuel gauge is not required to establish a valid PD
contract; Battery Status and Battery Cap messages are purely telemetry.

The current approach handles this cleanly:
(1) If a request comes in during early boot before the battery is
available, we safely send an unsupported message.
(2) The port partner will continue to retry for battery status/caps
irrespective of the reply.
(3) Once the system is fully booted and the fuel gauge has probed, the
telemetry is reported correctly.

We initially considered a DT-property based approach so TCPM would know
the exact number of batteries (and their reference phandles) at probe
time, but we moved away from that to avoid duplicating DT properties
(based on feedback in [1]). The current implementation safely
prioritizes critical power negotiation over optional telemetry while
still fulfilling the PD requirements in the steady state.


Thanks,

Amit


> Greetings,
>
> -- Sebastian
