Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794929834;
	b=jhfYdDBsF4YmJbYCpUanuh+FvEtXnk+s/+y+jfvggmWEiA+M/OTWY2S7p5a+TqHmssBv
	 7NkzYygymx2zSWh8WEExHGEZsPuljFwvriY1ixAl55iYK7uHp5eImt5ovn8Tj3nrJHoTH
	 kmOEcFJZjzfOaOy24XDVpteWrKZDa5JcydnNlUUruhHH6VcRS99lwXCV++vuyN4D9CYSf
	 EOyTXb4H0bozCPkLMs16H1Qfy5Stbhsc+SG8aiZlhs8dv9YXkENDUvtfnf5FkEZlEVNXL
	 BUCDYwMZM16urX0HGILJ73cB6H4eUMPNzUEmR0prTmta+vIzyWy5N3eOxdIvk+/H5eA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794929834;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=LKdLJQzk+hjbpuBIp8LKIvBrdSbWJhDuwBNnuQ3+E9Y=;
	b=yJSNFZFOilKVlDeQYW0pHWGcgIr4Pwj6amIxA1Iq1RfHD2P89qzxLu8ivp8ewVb7mDUF
	 r07wrNUR6LgJrc1rbJa6vxUY5fg4Sq3DOmpnZ3jM1eTGgWqcoe+tFEnOYHbfPTsBfDTC2
	 x341/nf+XGjB15sbNQgjrgT3ivgOGUNnrtK4D5xXv5oK8/G0q4AED9h2pgHQZYG3Zt1yk
	 SA7K3n4Esi22LZ0belL+xHU7RmYaRS2dtCjOlQfJzQkgNfB1gJAG7CRf3F9KpXoKpn8Z7
	 /gsh8IWuxHtaJExlD8NAzoroWxr0FLYkhf3qiVlMa5yhcE1OBbQBG0xI26qlyikJrFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b="Cl3+cJ/R";
	arc=none smtp.remote-ip=209.85.218.42
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA742606A31C
	for <linux-pm@vger.kernel.org>; Tue, 17 Nov 2026 15:37:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AA742606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Cl3+cJ/R
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c50933bdf4bso246120266b.1
        for <linux-pm@vger.kernel.org>; Tue, 17 Nov 2026 07:37:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1794929832; x=1795534632; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LKdLJQzk+hjbpuBIp8LKIvBrdSbWJhDuwBNnuQ3+E9Y=;
        b=Cl3+cJ/RdMLwMsHTsFXKq3E92HfrGSiunfW9rpYSxRvClZF0G/Umr9IzPAULUNCy/P
         +xNS6v7g1ViZQ6BwbJgfN/cqwz6fr7Nrrox4B/wEr94+/VoFCmFBuC0EwBNHU1GmDBJz
         MXeiPUk2PvMwrxaGNhclltfsKmhl+u55Ew35Pp3RfaeYesKgGmqZICzb5YkQPCdnaQlo
         GSv5o8x6IElafkcKY7tfj2BvG61ba8brJaaatvP1Q866auavXqRxt1CTfwhDTAd+v0Gc
         +nUTIsxAfZsBcBWm1x1httoFkvGdEomHcqcPOzWdlmI/KeaP7qn4yRwCv23Fgdu64YRz
         9wFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794929832; x=1795534632;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LKdLJQzk+hjbpuBIp8LKIvBrdSbWJhDuwBNnuQ3+E9Y=;
        b=y2vWA0Qy5XwWVpguexdtpOnVaf3ZS80FRT8YniXfIHDAdW7bB/RCPmns28s63PXrr7
         VyDoMxMiFq70vkgthAz7xG9O8YrUrpagoxSGoE/14KHJRQ9m50wRZrRYhGiw+BtyOVVm
         GSESscYEF4NT03D3ElnHscKyJ0d9kQwE/I3ZZb7aLmuZOq6OFGCaqB9+Q/i9D6rklRPl
         w8gjuOlhowtbNyeIZpgJ+avlTY76xNwO6CILmgMqpN5tdjzBsA98JPzXLrk6PZ8fo9y7
         hq3ahZP25e50rK5QNhgO5B6VfPtLu2Pcol5Xl5ubtBmDEE+gAPmPw3haMGeNHGvQJ4iS
         RhQg==
X-Forwarded-Encrypted: i=1; AL+hErEomiVs/um2AHewCAqAKykk+XnzPNSvm94qNXuutRPWTz0P9DAQ03gxODQh0wnM8/SzCkFumkUcmg==@vger.kernel.org
X-Gm-Message-State: APuU4Z977wBhgmtnkrvVdguX+gEufQtqG8m3qbFOVYXDfFQ4N8mIhcKu
	daZqhfyZbXf7QMr3REZuRPtF0xbieIZIlBUZq5Et7WWiwfETPpD6lgK41udMs6e90o0=
X-Gm-Gg: AYBFou0mx+E1OwxImTR/K5jEQDCrrZZ2bgSdTTrhn4w5u1sR93n36bjQbXi5ZMCn7EN
	kHfAaiZ8JogxBPJRWAueKgMWtgaKldlvtKau6CTZWEZu00I4rANWH67JK46MdBGnVYfO9/QMD3T
	WXSNk54j4nTbVvB0suQttGnfhkQ2ZawzNczHEeJildbR37MEoRAeE0XwbRcR/bn8ahCO1fvX7q0
	+Qfr3FFLyEoF1ElBUjvh276s74AngyZuCmaa2lgZl5X2CUCpokNNzPQ41I/VLbB+FUCdXwf0uRb
	Q5IKTL6/hCdz1LX8DR2zd39yXKbpr/2UlGKi/JgP6lTEkAL8l1CO3Wzo/VRmxAQnKUlRCbFtZiT
	sl/yj2m5uDEHXJjbYVjpjbsfCDGPJihTUp0YdkHaMJYV2TxP7bhFYd1eazTm6OZKGeHNMm6h/6i
	BvvzFRsEvhlYsHqP9FrDHLQXaaRx/HoIbqvjMoCQuHWj8k3GTAAMm8Nm8s6BO+c4Dyy8rcaNHS8
	eLkKfivuNRiC2WzWwUI+VHO6vG8P2oBl45FUpD0RgZCYxXl1EogvosDSmxJSz7sU9iT0wy1wQnK
	E7aNYe3iJf8OA21bIakbU/V2KpdRzzc2u8jSxqp3/Rae7xWlm5WiukSuGfGf
X-Received: by 2002:a17:907:18c3:b0:c2a:ac35:95fb with SMTP id a640c23a62f3a-c50f3781084mr288834466b.24.1794929831875;
        Tue, 17 Nov 2026 07:37:11 -0800 (PST)
Received: from [192.168.0.252] ([82.76.204.26])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4a32155283bsm6407600f8f.37.2026.11.17.07.37.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Nov 2026 07:37:11 -0800 (PST)
Message-ID: <3ea5d94b-6913-4534-816a-3935c689225b@linaro.org>
Date: Tue, 17 Nov 2026 17:37:09 +0200
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
To: Christian Loehle <christian.loehle@arm.com>, bzolnier@gmail.com
Cc: krzk@kernel.org, rafael@kernel.org, daniel.lezcano@kernel.org,
 lukasz.luba@arm.com, linux-kernel@vger.kernel.org,
 linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org,
 Juan Yescas <jyescas@google.com>
References: <20261117083442.830549-1-christian.loehle@arm.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20261117083442.830549-1-christian.loehle@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Christian,

Thanks for the patch!

On 11/17/26 10:34 AM, Christian Loehle wrote:
> acpm_tmu_set_trips() supplies two thresholds, but the ACPM command
> writes all eight slots, zero-filling the rest. On GS101, slot 7
> controls autonomous CPU throttling even when its interrupt is masked.
> Programming it to 0 C limits all three CPU clusters to about 200 MHz
> on Pixel 6, while cpufreq continues to report the requested
> frequencies.

Could you share how you discovered this? I don't have access to the
ACPM firmware sources, and the downstream driver doesn't state it
either.

How did you measure the actual CPU frequency, given that cpufreq
keeps reporting the requested one?

Do you know whether slots 2-6 have any side effects as well?

Also note that Daniel has already queued a set of acpm-tmu fixes in
thermal/linux-next, so this patch will need to be reworked on top of
them.

> 
> Program slot 7 from the zone's critical trip before enabling the
> sensor and preserve it when updating the low/high interrupt window.
> Cache the three temperatures so a writable critical trip can update
> the hardware without changing that window.

I think this can be handled with a smaller change: look up the
critical trip in .set_trips() itself. The zone lock is held there, so
for_each_thermal_trip() can be used. That avoids caching
low/high/critical, the .set_trip_temp() callback and the probe changes.


Cheers,
ta
