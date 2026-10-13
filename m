Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2B050EC18
	for <linux-pm@vger.kernel.org>; Tue, 13 Oct 2026 14:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791901586; cv=none; b=CBiCE+p70B7dhsKYdqKiLbkAJ/aTyu7dkwcssgU1LWm11GrGPhdGLmGOGBwLgv6c38Aju1Goz0bDQTSsI8XsHUgSu5Bk1m5oI0we+IFiMUnRu0kYd3+I3Axg6TsNWO20R0OZtEsE7qHsVkHX91T9Mtz2ePcmOC6VFo22zOdDt8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791901586; c=relaxed/simple;
	bh=lILx3/OsQnm7ge2d80wnY5ipSw+J/tdkglI/qWUb9Ik=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rMixd8NepHN048KRvv0CYdQxaB/q2Z0w3IM4aO4M36t9AlAJrUrVdwQx5b/j89QsPuJ3ZSK5mzmbXrulLFM0FEE2IF45YQYudFuQCFl1PuU5mhs1j4wETQGweO5+AChdmCYgi0h/iIdIWo/KZmUZO4r4CTbrkjVetUglj1hoCo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RjJy65u8; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RjJy65u8"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-49fbb2acc90so26239335e9.2
        for <linux-pm@vger.kernel.org>; Tue, 13 Oct 2026 07:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1791901583; x=1792506383; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8u3fvZrweliySkFwW59HgfNZQsRs65Go4IHgDTz0m34=;
        b=RjJy65u8k6bmAeL5Ps5WJn5wUIHxRykGnC2W+i+0gAZya82/LDaX+uVb5A9LooVggV
         oOtuqc528N8QQhveMr4Xl3pCajwjFaQoAYjHFgOzIv+AqBax7wipiRIT/Y77qzuLrH/9
         kobHrwPrrG1H7orp8h9kSB7qT9Xy37Nn1dMHr8jOkkM0sx4sRoFwAJcJV8l9IlgAsH8I
         tN88ePvS8DReMHoljV0f5Fdp3u13i8VAcmYcvmsmcXq/isHf5vkXfjaSrDqvXGIy7ppU
         8k7gdvE0Hpv9SzWGWcSczMt7OJTpl7rqSzCKfsKAz6VGEXiFw50vx0HAaSNhkamSX1Tv
         FL9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791901583; x=1792506383;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8u3fvZrweliySkFwW59HgfNZQsRs65Go4IHgDTz0m34=;
        b=R0Lrs54R9abXrdvQW/U7Vmn4MCpptLN0kqdvvxw4Pj/ICIOi0+JZDMDG+urGeYnese
         EdCbi5sHKHcxJRpVCykfJqqDTTm41Z89J6MCiALqj739GLFYWBzQdgPoLijvgJsDaRNa
         kl82Vv2cMfArPjjgSmOeFFybZc7Lu0jYPgmsURrslbKqAF+b4q3MRWS89uoMCCBs74cE
         9l9WJCOXROSHG6PhjAHup+K+xwDTDWXTdLxMzQtki5wZMvrhJWhvtkdZz6JEu69z9TPk
         3++kcsh4pfgi9U1fq+pOl2MeMRghpaKIXkSM1bJ+mTs2ZkYU+SkngCGE1LPVPm/KfQsb
         8UGg==
X-Forwarded-Encrypted: i=1; AKwUvBxKR9j09daUquuvod5jbPtmLuNXE8mFlqdsEew0zdvFg1ukb9+KnOfFdieOlWprCdGriOWl/2zilw==@vger.kernel.org
X-Gm-Message-State: AFq9FYJF9WsBYrEaLLAGg2mBDIMmtwAz1fdNWSf/AwPLokd61XxboGfb
	k+VqCAYIC9B7nfJoiwkKGjVpOIZu0eQV2HHuCTKeEbAf/sophe37acHYIJoJqAFHSq0=
X-Gm-Gg: AYBFou0ZYE6M6LM44sfyU8wwBPTdKwXgFy+UiV9UShF9RNeRN1f/LhW+zABEzqrfRtv
	hcgBG1ZDCWVQnVvyTDaBVfQmsSDQdvkBnLVbhLcipvaPR7xdCIUwKcL5YHMEroUv2t3WEZyXIaY
	YXBG9a4gwlE7C0AtLRysKxHawJeQ9QTTdCnWxe2VYuodHbRnGl2frK3OadglUaEyho4NmXzTVb6
	zdSzUhh94QpQlgxIkLx4JmV5fcVxJUhb68GA3RBfWriGa/IDMLe2G7uWRlteMjxMzBrS/lIETSR
	gIREc7t7tbAP7ngANfbxInUQZ/S0KPnkm1WqkSqxvIu3OsqH6lIEGMeliBkM7l3swNorykJl+AZ
	/wIwZekBVJTPMh/ELrmH/p9xJtg2QR/23j5dNyOcxBR2iIX+BJNooomM+ybEjDe4Tf3ERgMnRLI
	4QQojxsrMc1QUFWA8T4Ws+wVCsJh+VXCn8KRStOuCfrVVxg+y2r+agwe1+SlFfxp2dsX+/i6k0W
	0ewuN/G6b/OASZ+yLQ=
X-Received: by 2002:a05:600c:6994:b0:49c:dada:30b7 with SMTP id 5b1f17b1804b1-4a18e446f3bmr249827115e9.2.1791901580664;
        Tue, 13 Oct 2026 07:26:20 -0700 (PDT)
Received: from [10.11.12.111] ([79.115.63.240])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0bc50e0sm7109928f8f.49.2026.10.13.07.26.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Oct 2026 07:26:20 -0700 (PDT)
Message-ID: <fe159792-c58a-46a9-950b-6c21d2172601@linaro.org>
Date: Tue, 13 Oct 2026 17:26:16 +0300
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 0/5] thermal: samsung: Add support for Google GS101 TMU
To: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
 Krzysztof Kozlowski <krzk@kernel.org>, Kees Cook <kees@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Peter Griffin <peter.griffin@linaro.org>,
 =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: jyescas@google.com, linux-kernel@vger.kernel.org,
 linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-hardening@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
References: <20260603-acpm-tmu-v8-0-0f1810a356e6@linaro.org>
 <8142519a-0062-4f0f-b978-980e049f99c1@oss.qualcomm.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <8142519a-0062-4f0f-b978-980e049f99c1@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/13/26 4:33 PM, Daniel Lezcano wrote:
> Hi Tudor,

Hi!

> 
> I noticed I picked up your series without notifying you
> 
> However, I did not pay attention but picked also the dts files.
> 
> Shall I drop them ? (AFAICS there is one comment) and let you handle them separately ?
> 

Yes, please. dts and defconfig patches shall go via the Samsung SoC tree.

About the driver itself, I was about to send a v9, where I addressed
some issues sashiko spotted. Do you prefer to drop everything and wait
for my v9? Otherwise I can do incremental patches.

Thanks,
ta

