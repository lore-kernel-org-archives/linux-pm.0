Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795627686;
	b=3XKWv39qNW3x2hZIRU9bMvgocF41xRhAtaHvPIHjmwGFbixoWybQyFdQxHbYbjUS4KKV
	 /ZLa7HQhjF7yotUuqk3w6s1j7J8i0avwJgIpl5VZ9bZVTxfNnnHRRkEF/6Xj6WaNCPzzY
	 oeay9Jc4aVf/emZjGKJwdV+inp1xI7fRL6kn3wiUsr/cIDFjb9tAlsUIlA/zHAVzeYjYT
	 fArOVJVS1KRpgG8UTm6qos5UtQxYJuasYo3kqdHG+/ip48b+fYqgGyzyxVJTdOzbhR8bd
	 L8uMV0Hl5R3VirEBZuaz5GTZqxnNlI2ZAX1evvveHVr1XR9ihYxrAfjJEyrE7hTtTkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795627686;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=VVkUIIQqS3MHyMZep+1422xStdzEt776xX6915io3O0=;
	b=p0/oo6Pa3No/NkhYXcghRNs7Tcti9ZChWTsEP0RHF+vTmHP3Wr9JARESDpwW0/8+5vTL
	 bZu9VyM753RheVX7/5Wo2ma4cnrbmyX0LdgCmPXfL9VV3ySWwFkAUzU42ouspST5vtB6w
	 rgY52Hlcx22QFzzfpzTlbsYhcw66h4P7BUo5XzPnxs82/KQhB800LEbwQbjXqOqWX8y8f
	 /DSK7amiNo2ZgnrL1S05DaciE45AVln/4kOfokD/ag864esZev43YGVKu+xTZJ/RkNmk1
	 Ta86veChD76edgKjhmEiNDY3+UKJJrkWZbKzM+v56LukmunZmLQq9IpF24Dqi90FIJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=MnR2e2GM;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84B51606A327;
	Wed, 25 Nov 2026 17:28:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 84B51606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=MnR2e2GM
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 99AD8339;
	Wed, 25 Nov 2026 09:28:02 -0800 (PST)
Received: from [10.57.72.178] (unknown [10.57.72.178])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C14863F86F;
	Wed, 25 Nov 2026 09:28:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1795627685; bh=4+YY4HcJ7LW9Jg+pxZvWjeqMKGEA1WZOWsfSTDcENK4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=MnR2e2GMIAu5C3Aque31T/xkApvRyHV7vZPrHLfwv12arzyFc8p+faBH2+HlNOn08
	 Fh3gQBlQG9f92YFgd+0iBOfgH4E+nyPJDEE8qaFpn3HMFow1pZ7wIO2xiUOcCSTp62
	 RIeyZaGa6bXDL1zjfqJzjQrqONyRa4pf0VEuZDUE=
Message-ID: <7785bfed-3c70-49be-92bb-3e35d12df467@arm.com>
Date: Wed, 25 Nov 2026 17:28:01 +0000
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
Subject: Re: [PATCHv2] thermal: samsung: acpm-tmu: Fix spurious CPU throttling
To: Tudor Ambarus <tudor.ambarus@linaro.org>, bzolnier@gmail.com
Cc: krzk@kernel.org, rafael@kernel.org, daniel.lezcano@kernel.org,
 lukasz.luba@arm.com, linux-kernel@vger.kernel.org,
 linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org
References: <20261124132756.1306906-1-christian.loehle@arm.com>
 <2b369a93-d20b-4df7-b667-1775117e9470@linaro.org>
From: Christian Loehle <christian.loehle@arm.com>
Content-Language: en-US
In-Reply-To: <2b369a93-d20b-4df7-b667-1775117e9470@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/25/26 15:10, Tudor Ambarus wrote:
> Hi, Christian,
> 
> I tested and I confirm the CPU throttling.
> 
> The patch is looking good. I have a design question please.
> 
> On 11/24/26 3:27 PM, Christian Loehle wrote:
>> acpm_tmu_set_trips() supplies two thresholds, but the ACPM command writes
>> all eight slots, zero-filling the rest. On GS101, slot 7 limits CPU clocks
>> independently of its interrupt mask. Setting it to 0 C limits all three
>> clusters to about 200 MHz while cpufreq reports the requested frequencies.
>> This was found through trial and error while tracking EAS regressions.
>>
>> Program slot 7 from the lowest active critical trip. Cache the low/high
> Do you think we shall program slot 7 from the hot trip rather than from
> the critical one? If we keep the hardware throttle and linux shutdown at
> the same temperature, the throttle only matters if linux fails to shut down.
> 
> As you already noticed, downstream programms slot 7 from the zone's last trip,
> which is the hot trip (115 C), there's no critical trip defined in the zones.
> I can't tell why downstream misses a critical trip and why the hot one is
> in slot 7. But I guess it doesn't matter too much because in upstream,
> the critical trip doesn't need a threshold slot of its own (we use the
> low/high window in slots 0 and 1), so I think we could use the hot trip for
> slot 7, even if there are critical trips defined.

Yup that makes sense, and if I had actually looked at the downstream before
v1 I probably would've come up with the same thing, the actual policy of
115C vs 105C I'm indifferent to, so will update.
Thanks!

> 
>> window and update the critical limit from set_trip_temp(), because the
>> thermal core skips set_trips() when that window is unchanged.
>>
>> Suggested-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> thank you, but it's not needed, let's drop it, I commented only on the
> implementation.
> 
> In case you're going to send a v3. I guess Daniel prefers the subject line
> as "thermal/drivers/samsung/acpm-tmu:".

Ack

> 
> Cheers,
> ta
> 

