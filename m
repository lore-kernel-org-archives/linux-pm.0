Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795619460;
	b=5CC0h6NLXXfjagjEx94tngMXoAg0LtjxPVHYfxC5gMtFQOHjM3C3hsAOXErc74+riH5K
	 Aj5X829bmCYca8u9ZpWXKpXEVbCmGY+MLTwFxHvfhScQGvW0uD2ZQnbUhTl4udFU3suAP
	 /blZ5Dgzb9xx4BLWmjluc2/R9sZhHb4rBIu+YZZ3uNaMvpgePCHmHJvNWJeqgMKO6N3NF
	 uYzHRgwocvo/SkXGPdmpU1SLWY9Ukxo8t05XBQ3cFbNLlKcWCiTmD9sMVCuV+3jloHSQH
	 DIuA9hBJu/Y0QOdcKwlLjeWXC909KmVN/XujdPEVnP+Sgagx0ZTemaNLGFtm4XIytSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795619460;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=JwlPeECvQEEIvvkRP2SoNRScUU29bdxsw2mOvi0iroI=;
	b=h/B/sfSDdurpj3pFFkYF+X5qiwuPQ8ocvLLG/r5q5ejO5q13U4BZQ4bFxqaOmdxyb1Bn
	 bd2b6Xdze56sBoGlGEKAyZScTJug9jJqMNR90DqD1h04/ucBuZqXz42S2YfX/cE9rd/QZ
	 j8F0RxlumGOXGCYLlyAohTMB2L0YEy+pxsXnA+cqCUSNDEgvlJA4RiAGN7XmogRpcwFxv
	 emX+xgRotSy/piJ1nKn5Xunh77Kh3VkrHiW+UiT+uvlCwr3RxMKSjNNDaru2jXXdHUvDj
	 GfW4atNRbwX873VgSGYgrk4XJjIYyqPUlU9ZmEyI0za9uuSrkcouneqMYhf1Ma/NvPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b="pvgO/YEk";
	arc=none smtp.remote-ip=209.85.221.45
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF8A606A31E
	for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 15:10:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0CF8A606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=pvgO/YEk
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-4a68190a2a7so4844283f8f.1
        for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 07:10:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1795619458; x=1796224258; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JwlPeECvQEEIvvkRP2SoNRScUU29bdxsw2mOvi0iroI=;
        b=pvgO/YEkUdlTI28zuYZC8bFmQ0ov6Ytr8mgLvhlmdjJrFmun/YQy/s9ogNGEO3ScvE
         y1yjxZFDIf0mZkflbv+NqwdMv1WaH5epqxsxN5igi76syFebxcbfpJOqB75BGxQKCSvw
         ebLE1FXNu/ZtoIfutYBQOfokYl5xTtUhRQj+b8VJ7pNfWSwNv6xM6cOaIKoqFF6y7Sqx
         MyuaLImm4IKg2FypDwXdX7El2lpChRMrsRTrDNzAqJwkVhnE+2rm8VWe8XNLMHWzVGzB
         q3z9B5LxWMyh1VERl22N8/nBkejYHSL96cRVXEz2ncfq2mugX733q6F4Uuvwkf9LoyfJ
         e9CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795619458; x=1796224258;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JwlPeECvQEEIvvkRP2SoNRScUU29bdxsw2mOvi0iroI=;
        b=Pc2OAbe3gn49pkv+B1CJSUtuDeCzfCmI3Ze8DeWNQy7N1S9nn9HJYF6jSEa0P0ACJD
         pmXObJvMn0TWp9oseCpwc/LQcGUM3mnIaLKHh447xY+i4IXGTd/KV7pjA/vVen8cOgFO
         Rpf6ZE2zBBRgGTGVkGk902hVrvWetCFEEWKDoj0nftY5vs9+vDanL2xoHYD3jj8875oj
         kxpGyGvm+zFeejQO9LBW/2RLu+xwBGuCz0GPnDxyzWLnHYChrRmXOMXs7GLt/5xu068w
         ZUJkxP7t1Y1o9SPL94xRSfjI/z2RAdqhZltOSIk5hTaocTejZsecLChqh2FoB+r/Sm6q
         Xc5g==
X-Forwarded-Encrypted: i=1; AL+hErEOWioArCkUjuc1Jgu3mL0eL5T9Hr5NRSRnooQ/YJ3DGzxAEo5Y8eD5tEKwtmLF5V25OZoMle+rgw==@vger.kernel.org
X-Gm-Message-State: APuU4Z89GNU5mzwONjk9U5SuHG5x+nicfM3FWNvhzfJCg9rBZoE64wLR
	Q3IZp9gx6Yz1/Ym6xrTk9HMA0fPy+JA12ZO4ADfYdOaqvPO2Q5UA6pZ+6f+OgRcBvuc=
X-Gm-Gg: AZFdTZctPorVt9myEff6mL2x6WVszZQ0ScDE2AzUuz8Es5IGsI33Zw2a+1v+rPOS/uV
	4uFv41ddWnbbglmcfYSoxEbDjEoTMiN5so33UjkU+3llPrvj8GFUd8OW7c8zrSo1FpQ0FE1cpSy
	bTV/F1o8cGPvTC6o+CJBLFmMzkm39EYpudbcVN/WaNzJrjEzkEQ5AGuYiHAIT61gxj6LF+yXqxy
	DrQcCBVDL3SlzrIbMDIHHWZjfoNGc07xwDA5y0UmHosOHi+1RMfC2PA/D+x6X4TeWTKyKHz+n6l
	PhTUq1PxzOoQ1x8N4PYAb8XLKcEOBaWOg1wyZv/Vye697HOxhRgvOJOaVYnFIBYaElNnezs27AB
	R6Dc1or6FNsyGnuednuimYEfIKdxetJ88sqQssm6kxgNg1dHxtKAuG5h6QrzRMR3RY2YO0MJLkq
	VAz/ajpcVh4/MGnyLO9uBoj5zCDHZW5MPwk7W4WrdBQP24QOS6RxNl3Wjj4Pq19wym5llLRFTHQ
	938TrryIyP3sVqDhX0J9cb68sv9fiim2upOJyhcYrnNhU9X0maLZsGvtpyyFIapscYRX/JxE83i
	CExLyNgFJxVNtLdqKZYZq0gA1yclhfVOceyXnvo=
X-Received: by 2002:a05:6000:470e:b0:4aa:323a:d7b7 with SMTP id ffacd0b85a97d-4abb16e310bmr35276861f8f.23.1795619458249;
        Wed, 25 Nov 2026 07:10:58 -0800 (PST)
Received: from [10.11.12.111] ([79.115.63.240])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6b110d56sm33656875f8f.40.2026.11.25.07.10.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Nov 2026 07:10:57 -0800 (PST)
Message-ID: <2b369a93-d20b-4df7-b667-1775117e9470@linaro.org>
Date: Wed, 25 Nov 2026 17:10:53 +0200
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
To: Christian Loehle <christian.loehle@arm.com>, bzolnier@gmail.com
Cc: krzk@kernel.org, rafael@kernel.org, daniel.lezcano@kernel.org,
 lukasz.luba@arm.com, linux-kernel@vger.kernel.org,
 linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org
References: <20261124132756.1306906-1-christian.loehle@arm.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20261124132756.1306906-1-christian.loehle@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Christian,

I tested and I confirm the CPU throttling.

The patch is looking good. I have a design question please.

On 11/24/26 3:27 PM, Christian Loehle wrote:
> acpm_tmu_set_trips() supplies two thresholds, but the ACPM command writes
> all eight slots, zero-filling the rest. On GS101, slot 7 limits CPU clocks
> independently of its interrupt mask. Setting it to 0 C limits all three
> clusters to about 200 MHz while cpufreq reports the requested frequencies.
> This was found through trial and error while tracking EAS regressions.
> 
> Program slot 7 from the lowest active critical trip. Cache the low/high

Do you think we shall program slot 7 from the hot trip rather than from
the critical one? If we keep the hardware throttle and linux shutdown at
the same temperature, the throttle only matters if linux fails to shut down.

As you already noticed, downstream programms slot 7 from the zone's last trip,
which is the hot trip (115 C), there's no critical trip defined in the zones.
I can't tell why downstream misses a critical trip and why the hot one is
in slot 7. But I guess it doesn't matter too much because in upstream,
the critical trip doesn't need a threshold slot of its own (we use the
low/high window in slots 0 and 1), so I think we could use the hot trip for
slot 7, even if there are critical trips defined.

> window and update the critical limit from set_trip_temp(), because the
> thermal core skips set_trips() when that window is unchanged.
> 
> Suggested-by: Tudor Ambarus <tudor.ambarus@linaro.org>

thank you, but it's not needed, let's drop it, I commented only on the
implementation.

In case you're going to send a v3. I guess Daniel prefers the subject line
as "thermal/drivers/samsung/acpm-tmu:".

Cheers,
ta
