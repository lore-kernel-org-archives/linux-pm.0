Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795003613;
	b=a2GeE3MkYkNNDXmT4/+R80e0Kk+/gRlMqUiMqIrjNgZXk+m89RMBXwzfiy8aeZ7hqiTa
	 Ck8sfUEcnTcHiSffnO2zcb+djsdvhnRDB0KbqQcRH2SvWJ8xqLLIcCyPE85IcvcH45LA0
	 082FWTEW4nB3LkFS4Th3gxTfC8Ez2L2q/dT7nOXCt5bim8TSWl3G5A3YquTiCM4NpJfZD
	 ZSGupcE/rJQaGQW8JTw/bJwA+Gd6sjh8MHc4w9qnFB4G0kmnu49AWV+JLkNH62JiBFaaY
	 ngfXYmJ4+nJsEnR/FZ0XTEEams2gz9sCFf6F9orutqCyAkatOOk2gjftWi/JwZZTMCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795003613;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:From:To:Cc:References:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=x8TBlHiLxfZKxBfM5S1Kv9DsVFJwwHw4bapMNTFW3cw=;
	b=TmNXTfnXL0dcK5/XyFNc3kWHNfO36lGecceFytujwOiY67MYD1y7hd0fjKB/N1AzmOuq
	 2uKDc7d3b3FAuXCgiXlxIQjkr1w2OW/+7QBlXs2Dr7UWAuFi/JaEvEVG4uHJjX1ZE2QI0
	 EXMSOwelKE6x818SZfn52cPST92Vpmy3rFoIyKpNIV9O7lngr0FhlDhJqMJNlUrEqH2qE
	 Jl0hqc4PbvQbk2fo09lyWf1TD6vP1YISzeJNbuPk3wCnUbxh4k/29J+NEadQkYDOOM7og
	 7Il3LUT+lhSoOIzXATXogv+CpT53A1OKfGsvqEyu5hBZfAQbRmdRF4fKxGHGPlBT9kw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=kHfVc9JC;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C4CC606A333;
	Wed, 18 Nov 2026 12:06:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2C4CC606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=kHfVc9JC
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A57DF1596;
	Wed, 18 Nov 2026 04:06:49 -0800 (PST)
Received: from [10.0.130.226] (e127648.arm.com [10.0.130.226])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8ADF23F632;
	Wed, 18 Nov 2026 04:06:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1795003612; bh=Beuqlbaer5+8H8ptgr354z6QOfqcZDfnqmKGpJmZOxE=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=kHfVc9JCvkTel5iRe4pA9xN/dDjox06VeOcGvY792EM3akEY4lLvj5Fp1SAQeiafb
	 A/MZo29i9OWRft8xRM4Lf7pmDGhpJWp62X+808OfxZasWRgaS4xvhwY10CFjLEKxbo
	 cbsesCkzTWMEYOa9Ubn5f8vaVPc0aNDEzNVvU31g=
Message-ID: <b2b0ddc6-964f-4d8d-86d4-a0bc24d9022e@arm.com>
Date: Wed, 18 Nov 2026 12:06:47 +0000
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
Subject: Re: [PATCH] thermal: samsung: acpm-tmu: Fix spurious CPU throttling
From: Christian Loehle <christian.loehle@arm.com>
To: Tudor Ambarus <tudor.ambarus@linaro.org>, bzolnier@gmail.com
Cc: krzk@kernel.org, rafael@kernel.org, daniel.lezcano@kernel.org,
 lukasz.luba@arm.com, linux-kernel@vger.kernel.org,
 linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org,
 Juan Yescas <jyescas@google.com>
References: <20261117083442.830549-1-christian.loehle@arm.com>
 <3ea5d94b-6913-4534-816a-3935c689225b@linaro.org>
 <56a7a762-7667-4186-973c-ca0fcb399ecc@arm.com>
Content-Language: en-US
In-Reply-To: <56a7a762-7667-4186-973c-ca0fcb399ecc@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/17/26 16:41, Christian Loehle wrote:
> On 11/17/26 15:37, Tudor Ambarus wrote:
>> Hi, Christian,
>>
>> Thanks for the patch!
>>
>> On 11/17/26 10:34 AM, Christian Loehle wrote:
>>> acpm_tmu_set_trips() supplies two thresholds, but the ACPM command
>>> writes all eight slots, zero-filling the rest. On GS101, slot 7
>>> controls autonomous CPU throttling even when its interrupt is masked.
>>> Programming it to 0 C limits all three CPU clusters to about 200 MHz
>>> on Pixel 6, while cpufreq continues to report the requested
>>> frequencies.
>>
>> Could you share how you discovered this? I don't have access to the
>> ACPM firmware sources, and the downstream driver doesn't state it
>> either.
> 
> Neither do I, I discovered this randomly through running regression tests
> on Energy-Aware Scheduling on the Pixel6 and acpm-tmu (7.4-rc1) causes a
> massive energy regression (+~1000%) for the same workloads.
> The reason is this DVFS throttling.
> 
>>
>> How did you measure the actual CPU frequency, given that cpufreq
>> keeps reporting the requested one?
> 
> PMU counters CPU_CYCLES
> 
>>
>> Do you know whether slots 2-6 have any side effects as well?
> 
> I hadn't discovered any.
> 
>>
>> Also note that Daniel has already queued a set of acpm-tmu fixes in
>> thermal/linux-next, so this patch will need to be reworked on top of
>> them.
> 
> will rebase then!
> 
>>
>>>
>>> Program slot 7 from the zone's critical trip before enabling the
>>> sensor and preserve it when updating the low/high interrupt window.
>>> Cache the three temperatures so a writable critical trip can update
>>> the hardware without changing that window.
>>
>> I think this can be handled with a smaller change: look up the
>> critical trip in .set_trips() itself. The zone lock is held there, so
>> for_each_thermal_trip() can be used. That avoids caching
>> low/high/critical, the .set_trip_temp() callback and the probe changes.
> 
> Ah yep you're right, will fix and resend.
> Thanks!

Okay, maybe I'm missing something but AFAICS we have to do the set_trip_temp
because thermal core looks only at min/max and may skip set_trips() in case
these are unchanged, missing a critical update.
So the minimal I see working is making 'critical' (again, this is my
interpretation of the value, if you want it named anything else, just shoot)
non-writable by failing it's set_trip_temp()?
Or is there another way?
