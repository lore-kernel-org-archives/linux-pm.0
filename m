Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0083320FA81
	for <linux-pm@vger.kernel.org>; Sun, 14 Jun 2026 07:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781421257; cv=none; b=JgNxFtywXZie2ZrSL7P4XkNUjOji5Lk8WmqARyI1km4V9mDdM7kE2Gd73l/OzbFtMmqkhrmZw+X+O5M1WqKJgraDk/bEifmqmj1r6OSo1PxYsNBkLAUzIHo6b4IHkWDBEXQTPYID/o714OTb3IDg5HkUkNfQDY0L+ew1xA3NXe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781421257; c=relaxed/simple;
	bh=pqecBGrwwJDacJr4gnG5bJ16wt0S3FihsDoxp+tVCRg=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qAg/QVU7pDggq3NZulObFJxANVluhHhy+Bjivcfqn3ZJtMtNd/zXvt8LPV+yIhCjYDYw0bs20bT9FwabUuTpgTfuB8mnVwX3wK4hALswE/ZnS+IcZRxPLDeJwbbXX9QzjsZFHXjWsg22KXgCeCCIGywtxyYJISnUdahtTx8SM3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jmy+zG6z; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jmy+zG6z"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-45ef56d9b67so1893415f8f.2
        for <linux-pm@vger.kernel.org>; Sun, 14 Jun 2026 00:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781421254; x=1782026054; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=t6JKdGL8Xe2lq+/BiQDSaNE1rM0cDe8Om7VyrIfgze4=;
        b=jmy+zG6zkXQrurOmVxcicTLc2TdOaYTpTND4xZri6xjQZnXEmNMTddwKsSvrUk/JuW
         dCeeEOzOiqEYXfVw5wy5keeFYC8a/M7WEzRaGOiMgwtNjn+V+G5L+aa+iajOaUnUCgyW
         sGIYbjdFB1yEp4ZlyI4NXwFQOJI73ahklG/pasb5F/l1DY1x5vIKEa8MOG2YA7qB1MZ5
         DN6TMGBEaBF7D2eSrPrPi3KRRvUjQ7TmVXH0yG/77TNnmDfWt+GaxqL41vuuOxTphy+U
         mbXKc4StnuSita/M/L4Q94J9DoqxG6mWXoJXS5ZFOR9vWuY/3wHEyLtoVJSMabsYGmUb
         7y2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781421254; x=1782026054;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t6JKdGL8Xe2lq+/BiQDSaNE1rM0cDe8Om7VyrIfgze4=;
        b=ZE172eKSTw0HbrPVtSsx1EOaB0GRQ7h0Xcy5/mcI66PQjl73v/Y5s+CiCLk13kyRLb
         MLRVtJ5il2tNChDsWipHSvuk+sVU5q21ug2MNOP/r5tBayG81YXkLsW1Lbt03r1jPtGY
         3RpuTBmXHpdhU30UurNYTOGnbmOC//+juXjkMbjQlahSTipHifh2o9D52gfFCGVW2tK2
         K92jVn7qLxSkzZyKiLbJO8dFK0Hbidp9YN77hzMBN6UELsUbQsvRPuf9MlsvplJcJ8e0
         xBbeXzrg519W6NImXt9DxuUTWhaH52ArYAvCNBNfWm77macmQgSDOu7cj3MZshet72bn
         pqRw==
X-Gm-Message-State: AOJu0Yyw3QJqsMrQbgmB0YTnDV71D92tpwda11BDPZo2P0h4TTXfN9hA
	Oi/2HAt33M6hKFlk1Im355yqs2zv45Um+Go9H1apLlSMSQgp5pfIom/U
X-Gm-Gg: Acq92OGD/jyDgljg/vkqlpX5VMOPLZ/Z6v9Tekle4DQAoGWecHEPQdoHWTqJ5+ZV4J4
	xWFOQ/3yxdmLglo5ATxthsuFb9LCRfjhsPtLlOqbHYJpcvZzi55d0ajyp/OQnveuSc+/3uc6yAX
	LdplqFOUxy6cuXL4TH4RVeAmLs6nlXS+jt1zv1xNLm/TTs7r6/YIiP1FYNAYhvegbkLlXKxnydH
	0Mb74H99668w056d7bzKJJ4z5LtI4ntn3EPx0O8JEsQV5YB1Q0kAOr3k0CtBARV/ImFfvCMZt/2
	QYvEZgFfbr5OUhSnswye+uhUbmKVXpMjl4o3mmJ3RFFmk+Dkv14Dq7wLo4rnxQ9NMOrOXXh+eil
	O8aeHdRSBxStMRyHbErqNYiVK4HdtwQS5of94EoCthEWtEHQpRZG4FZa11meW8oNczillXEkwo+
	TWtOH0gVjI6Wht7HD77MCREyuPC3WhzSiuZ6I/FsAMClxWIKYDVanHllQqkEZHXcUY
X-Received: by 2002:a05:6000:420e:b0:43c:f66e:f24 with SMTP id ffacd0b85a97d-4607ebf8195mr6941469f8f.35.1781421254134;
        Sun, 14 Jun 2026 00:14:14 -0700 (PDT)
Received: from Ansuel-XPS. (93-34-88-103.ip49.fastwebnet.it. [93.34.88.103])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f2d933esm20866652f8f.33.2026.06.14.00.14.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2026 00:14:13 -0700 (PDT)
Message-ID: <6a2e54c5.56f33bf0.2d579f.295c@mx.google.com>
X-Google-Original-Message-ID: <ai5UwygS775FPbdx@Ansuel-XPS.>
Date: Sun, 14 Jun 2026 09:14:11 +0200
From: Christian Marangi <ansuelsmth@gmail.com>
To: "Wayen.Yan" <win847@gmail.com>
Cc: linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>, linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] thermal/drivers/airoha: Fix low trip clamp using wrong
 variable
References: <6a2df296.6b2684af.263065.8200@mx.google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6a2df296.6b2684af.263065.8200@mx.google.com>

On Sun, Jun 14, 2026 at 08:14:11AM +0800, Wayen.Yan wrote:
> In airoha_thermal_set_trips(), the low trip validation incorrectly
> clamps 'high' instead of 'low':
> 
>   low = clamp_t(int, high, RAW_TO_TEMP(priv, 0), ...);
> 
> This causes TEMPOFFSETL to receive the clamped high-temperature value
> instead of the requested low-temperature value, making the low-temperature
> alert threshold identical to the high-temperature threshold. As a result,
> low-temperature interrupts can never fire independently.
> 
> Fix by replacing 'high' with 'low' in the clamp expression, matching
> the symmetric pattern used for the high trip on line 264.
> 
> Fixes: 42de37f40e1b ("thermal/drivers: Add support for Airoha EN7581 thermal sensor")
> Signed-off-by: Wayen <win847@gmail.com>
> ---
>  drivers/thermal/airoha_thermal.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/airoha_thermal.c b/drivers/thermal/airoha_thermal.c
> index b9fd6bfc88..439aa011b7 100644
> --- a/drivers/thermal/airoha_thermal.c
> +++ b/drivers/thermal/airoha_thermal.c
> @@ -273,7 +273,7 @@ static int airoha_thermal_set_trips(struct thermal_zone_device *tz, int low,
>  
>  	if (low != -INT_MAX) {
>  		/* Validate low and clamp it to a supported value */
> -		low = clamp_t(int, high, RAW_TO_TEMP(priv, 0),
> +		low = clamp_t(int, low, RAW_TO_TEMP(priv, 0),
>  			      RAW_TO_TEMP(priv, FIELD_MAX(EN7581_DOUT_TADC_MASK)));
>  
>  		/* We offset the low temp of 1°C to trigger correct event */
> -- 
> 2.51.0
> 
> 

Hi I already submitted the same patch in the AN7583 series. Can you review
that patch so maybe we can try to push fix for this?

-- 
	Ansuel
