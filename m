Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C89BF201113
	for <linux-pm@vger.kernel.org>; Sun, 21 Jun 2026 13:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782048769; cv=none; b=cqwAAGJyOUYNUFshDW/CAyrjjGlokyoXuy5OZqgQyELF+YWs1h25ntSh6nFs3tH0p1lZng4/LxKlwVtV4JEp0TQoqxeRavBTUNNEM9iL+3sF4OSHjM5rhrV6yxS7LG2Cl5MRBlsajzu6mnwuESl/88aBhe50SIfMjsn5KOphPXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782048769; c=relaxed/simple;
	bh=bmpEv7zfbPfF+uUXBjGarKYDsIp+jU6IJzmySaHtp1s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eckHAOFs1q5GyQCXsjUyOmhwceCuziecvIAgVuWbB0JHtcoVXKmitv5d/MPQ+8mTAFAyRR6kvmnf3y9UzX8X3T+P27KhGVjXik8m1w9dT4UXCYCFoalECnfojeTTAvNz3Pxdb0wUUlXD2RFciTPwfg71PjMRSookdX3XYVPfHkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U7hJwIA+; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U7hJwIA+"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-490b9318997so23936925e9.2
        for <linux-pm@vger.kernel.org>; Sun, 21 Jun 2026 06:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782048766; x=1782653566; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pIUZAKR1TIZbz1tlwg21diURa8ijNKXwIp01TVZOLCI=;
        b=U7hJwIA+Tv/cWdVBwcbIg9baSUgTSpltZlnBnpPDyXMZnyDASYZc/wqmGHILJ8jcJs
         CUNfqXNsp56otajgm/vGpAuM4b2Rqc62GIaHHvkf7wcsaF6ddZxEhZoYj/xKBVk8PRYF
         dwFBf0Dj1SrJsJ2b/vgauZjIWmFHX86mhqMT9S3rvL/e9r5SARXj84cdus41LSQx92Os
         hGWGV6J9B4hsuvbCnbHcFkUr3tXRBPdmvB/pePUp9iPO8WZXvoNWo/4c9mxY1F/V++B+
         huKpffbDKYSy+sQMX80N+2b/vXlZYa3OPnnI0MfP/i8X0IbnfhsqN4gN/XrDQPSXWqSU
         wMKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782048766; x=1782653566;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pIUZAKR1TIZbz1tlwg21diURa8ijNKXwIp01TVZOLCI=;
        b=bHCfZmodOEz1kTN7gVm3U/Kt56ga5zO/GQYSVob6w1w+Z4sl8D41bsN/tLaoeDCD9m
         R9z/iMcy9YfY5l2p0qPkE7P8ooZMM3NOH7DMtadWB8t24lLsY5ODdcKG7eY2BFFFuNF6
         g0V0sB2LSg08GQp87EHFec7SWZykzPLialPCeKLVG0+5fbT/gejStP0eBogXX+L3fCyS
         WXw1N8fvZoOBGNzgGBATkUUUfpN9faPpV+WwiPj0+a1zztIdoQjnG7ZIEQRZ1OIaQlNS
         Nkb7Fg8yYKNM5Gy3/ascYy80z8Hz5fvOddk7gcGMA8bcJgB4b7Wt9tFYL/t8eyfRvNYw
         Jnjw==
X-Gm-Message-State: AOJu0YwXr0A/IsdEedANrKOGxpxbklcqtwA8PcW2WZK2OaeNrUWNa2Ta
	hUsFnYMrsCIEMMalGF7pxDFmA5X0zxCHTp0uz/zEXg+ukJ6eMnf5VXSQcXXysQ==
X-Gm-Gg: AfdE7cmOZWBrMw2v1KIaRHkCva4wv5QTUTIgZ7+8w6OEaZR2Wn1Fm3Yi3A/TnI4J/cp
	XPHtthIax6dpsWb7IJ6tKrD30DaNuFuoXjuF5JpwzAoW3Jgb2qEyVN08fDvM+CANm2euvOmokjm
	cfVIwn3glImB1Tik+98wC7UFSXkHOc/hTYr9oHJR0/Vv+8dfrx/+mLQu7/wUcs6N+RI1mfzGti6
	c1fyHIGFooGRTznrTNPm8uj3z+62WU3nlMMM2Hq2hBEAmSm/2rRpKKp/DsD2scUI+wb6uwMruGJ
	syWa2TNL2bWWD+1bZEy5+8Y0oYi1Li5DEpUStNH8Zo3WpcXmoeT3roQ+zjcQmp8ASok/UvIIqLd
	O26Uf7oVjP5hWnnOPOyADjuuZRwCVhbAcDjkhUZA8lvdfXvlEpPQ2ymR3ZoO2lfWzQ4h1a/VxZW
	6aSz92XHwx/zwoS3HYS1qzYWRAvKNoEvLESQuZkKY6jVl++opO4s0P2FuMbKrWUCU30uqRfxV7/
	Kt1pwyd0jUTBCIexQZLY9gLjA==
X-Received: by 2002:a05:600d:6451:20b0:492:3fb1:e9b8 with SMTP id 5b1f17b1804b1-4923fb1f003mr130057065e9.12.1782048765798;
        Sun, 21 Jun 2026 06:32:45 -0700 (PDT)
Received: from [10.77.100.5] (ipservice-092-209-213-109.092.209.pools.vodafone-ip.de. [92.209.213.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4666712cceesm16955817f8f.35.2026.06.21.06.32.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Jun 2026 06:32:45 -0700 (PDT)
Message-ID: <19647fe8-c520-4160-bf74-d398c6b642b4@gmail.com>
Date: Sun, 21 Jun 2026 15:32:45 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] power: supply: surface_{battery,charger}: Consistently
 define ssam_device_ids using named initializers
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig_=28The_Capable_Hub=29?=
 <u.kleine-koenig@baylibre.com>, Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <bc8eff03b2f36c82af5a75fc7114c277228921db.1781526433.git.u.kleine-koenig@baylibre.com>
Content-Language: en-US
From: Maximilian Luz <luzmaximilian@gmail.com>
In-Reply-To: <bc8eff03b2f36c82af5a75fc7114c277228921db.1781526433.git.u.kleine-koenig@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 15.06.2026 um 14:51 schrieb Uwe Kleine-König (The Capable Hub):
> The .driver_data member of the the two struct ssam_device_id arrays were
> initialized by list expressions. This isn't easily readable if you don't
> work with the Surface System Aggregator core regularily. Using named
> initializers is more explicit and thus easier to parse and also more
> robust to changes of the struct definition. This robustness is relevant
> for a planned change to struct ssam_device_id replacing .driver_data
> by an anonymous union.
> 
> While touching these arrays, also drop the comma after the list
> terminators.
> 
> This change doesn't introduce changes to the compiled ssam_device_id
> arrays.
> 
> Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
> ---
> Hello,
> 
> the mentioned change to ssam_device_id is similar to
> https://lore.kernel.org/all/cover.1779878004.git.u.kleine-koenig@baylibre.com/.
> 
> That allows to get rid of the casts in these two drivers and thus
> benefits a bit more of the (admittedly weak) type safety of C.

As in the prior patch: I assume that will be a separate change or am I missing something in this patch?

> But IMHO the improved readability alone also justifies this change.
> 
> Best regards
> Uwe

Looks good to me.

Reviewed-by: Maximilian Luz <luzmaximilian@gmail.com>

> 
>   drivers/power/supply/surface_battery.c | 11 ++++++++---
>   drivers/power/supply/surface_charger.c |  7 +++++--
>   2 files changed, 13 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/power/supply/surface_battery.c b/drivers/power/supply/surface_battery.c
> index c759add4df49..1273b6082311 100644
> --- a/drivers/power/supply/surface_battery.c
> +++ b/drivers/power/supply/surface_battery.c
> @@ -852,9 +852,14 @@ static const struct spwr_psy_properties spwr_psy_props_bat2_sb3 = {
>   };
>   
>   static const struct ssam_device_id surface_battery_match[] = {
> -	{ SSAM_SDEV(BAT, SAM, 0x01, 0x00), (unsigned long)&spwr_psy_props_bat1     },
> -	{ SSAM_SDEV(BAT, KIP, 0x01, 0x00), (unsigned long)&spwr_psy_props_bat2_sb3 },
> -	{ },
> +	{
> +		SSAM_SDEV(BAT, SAM, 0x01, 0x00),
> +		.driver_data = (unsigned long)&spwr_psy_props_bat1,
> +	}, {
> +		SSAM_SDEV(BAT, KIP, 0x01, 0x00),
> +		.driver_data = (unsigned long)&spwr_psy_props_bat2_sb3,
> +	},
> +	{ }
>   };
>   MODULE_DEVICE_TABLE(ssam, surface_battery_match);
>   
> diff --git a/drivers/power/supply/surface_charger.c b/drivers/power/supply/surface_charger.c
> index 90b823848c99..d4bba6b41794 100644
> --- a/drivers/power/supply/surface_charger.c
> +++ b/drivers/power/supply/surface_charger.c
> @@ -260,8 +260,11 @@ static const struct spwr_psy_properties spwr_psy_props_adp1 = {
>   };
>   
>   static const struct ssam_device_id surface_ac_match[] = {
> -	{ SSAM_SDEV(BAT, SAM, 0x01, 0x01), (unsigned long)&spwr_psy_props_adp1 },
> -	{ },
> +	{
> +		SSAM_SDEV(BAT, SAM, 0x01, 0x01),
> +		.driver_data = (unsigned long)&spwr_psy_props_adp1,
> +	},
> +	{ }
>   };
>   MODULE_DEVICE_TABLE(ssam, surface_ac_match);
>   
> 
> base-commit: c425609d6ac4012c8bbf01ec2e10e801b1923a7b

