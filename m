Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B441D3B895F
	for <linux-pm@vger.kernel.org>; Tue, 10 Mar 2026 02:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773111389; cv=none; b=SohXDdjaLLLPLMYzkVYYogBQIpzSvEQ0VlGLb9MeoEGljw+HCxfHaL0xcQK9Rl9U2HzBAplECgKsjVHldcWgPT9TgqLK6Q+YyQumiLr7a1celTkp2CsdW7Di+x4vSNL7X5hyPkx7U3FFLRtoJoyRbvksdkYE8L4UhM09K2dTOy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773111389; c=relaxed/simple;
	bh=xOlmWHElZ0RirDwGPesTb+6FfflbyfzMF26FQgLD2eo=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Ee5KfKQKmshWY68BYYVwuX27Cfqe8Y8zfejZxXlfyhqNAQ6zsDJxHhMrsfiXNYFh+ZQGZHIHzrbECTVBem+49zxVe2Ss/mmgV2k6NW8+p+5jEjgpd1bbE4v1PUmz9pH8I6er9jPKysQjHLTNHiN3ee9AikiYCKFkVtAHZ2h8qIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=v+8Mo90A; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v+8Mo90A"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4853f2826f7so13716615e9.1
        for <linux-pm@vger.kernel.org>; Mon, 09 Mar 2026 19:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1773111385; x=1773716185; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IPeNaI7yJ6rN7QDAg6cmHZUEk/n4Ga/qldWclJyzUAo=;
        b=v+8Mo90AU8QuIIbTN38TdolQQV7OdXys2Nt9KOY0xdwM2RCIm7mAL/Ot0nwZ2G0qhn
         879DZzTwgV8ZB3ejEqajk/J7P1zCk6HOvYm4jMXPIOySnfqsLLAzl7qIkFu0rUo7yNrd
         hf0AR4AQvr7nYlSupQ45odasBDBGT//VCnsSg0a0jRRkLSpyCHfivvPNGyzfSxROJUe7
         CKrchZq4JLj+I/kJzSMz26gAm9NstbA2W607JKLoXIqTtY/dUmM7mtQ9vgdSIUuXcW68
         +s5tqWfgOUnOiMx7wW5o+ZDaQHvzjtUdA7y3E+tXNLWIkJRCLZQytq91rlAkyOJxYBZK
         ulJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773111385; x=1773716185;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IPeNaI7yJ6rN7QDAg6cmHZUEk/n4Ga/qldWclJyzUAo=;
        b=NImi3wfbCn91wQ3qhvedaXy2LLCjb8zBrrOjVQg2WEJo6UOGlu7i77kWrYRT9d+N+Z
         vC9UqcDXtukZlzdBJ2+WjdSNmAqaRxZt/RPVumYOsUmJSZNwmH7YVPI4G+s/ERE34HKD
         FP6WhrHsvgqHMW1+rtt3kv1n4huLtXHh/v/q+MoV1NbtXe7lhxan64lyimYC0DvqB0yx
         P3vBjnggx5sZDie839Hc1Y2X3rf/MaNxD3K+3V2LAOQLxpsc5JzCu56dNtcMUFCajxTZ
         Ap9v914WYNwkQDSMIAsp0ByULyN3NqSwSzALHKoQCtQ738/wmuHiSf7xI8LknvRMXppE
         giKw==
X-Forwarded-Encrypted: i=1; AJvYcCW7cI7LRv6KSs76HiSsyKiodkIbBDJaajRPDwNqQt6fhFjCZHFxwkpv2pgErm0wyD1L//VBvMUMNw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyzHRrdsdXApUcA08nfxKs19wlpFw0D0ae1ratP74YvIXAHqOuI
	v/vdF8r0EyDXJZRj1OyBZfQR4acjzS31NPz5+oj0t5e5aAuX3JsRUNycz/glokdGdTo=
X-Gm-Gg: ATEYQzxFnmdYRMWfnu3gWoEtvn+VDEVotENJU92v7YqJ8ugtcNwNYNvSh2alhQYfRlG
	QBisLLeJGMmuy9U+Tf/8cjdeCKcGOZvkph6C8t6nVhEqw4KzKGVo2Qs9e+ocMZG0jBzl4jenvpv
	26miQ+arX3oVeqT/EEOLn/UjbT2BjhJIM6+39rJT9rkN3bzpq5M0Oi1VYbQkBqFA4RV6pl8tKnj
	bbwlSr593eM7dN8dCM5uQDnJqOpdrlc8LXrLFXpPGSMkEZC09gA5qF26/mDr1fjVyIttm0awwg5
	nqO5TBjQD+25VVqaaxNqtCUTu19r+6qULgzbdeckkVeFti5jbhzgBhRLVQJVHXZYmpYMIzWU3XI
	Zlks4xECpCZn0fKYvKCgGKibJrvdrzONI29Q8VSk8VvunX4EhXksLk7oTeYG1OeT3FLtHxn/a+5
	HkfzER2iO4mUjYU/EDBfnwygsu26KgIsLB9OD+HJSxT2YJ1IU8bFMkcTnAAi2T/bLbq96eccE9R
	OEikZIFRys7JVy9
X-Received: by 2002:a05:600c:a0d:b0:485:1878:7b8c with SMTP id 5b1f17b1804b1-4852695b6fcmr215782145e9.18.1773111384919;
        Mon, 09 Mar 2026 19:56:24 -0700 (PDT)
Received: from localhost ([2a02:c7c:5e34:8000:7b62:c11f:db20:9ab])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48541b8d4easm38369165e9.15.2026.03.09.19.56.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Mar 2026 19:56:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 10 Mar 2026 02:56:23 +0000
Message-Id: <DGYRJ0FUBJIB.3HUS30VW280A4@linaro.org>
Cc: <linux-samsung-soc@vger.kernel.org>, <linux-pm@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>, "Bartlomiej Zolnierkiewicz"
 <bzolnier@gmail.com>, "Krzysztof Kozlowski" <krzk@kernel.org>, "Rafael J.
 Wysocki" <rafael@kernel.org>, "Daniel Lezcano" <daniel.lezcano@linaro.org>,
 "Zhang Rui" <rui.zhang@intel.com>, "Lukasz Luba" <lukasz.luba@arm.com>,
 "Rob Herring" <robh@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>,
 "Alim Akhtar" <alim.akhtar@samsung.com>, "Sam Protsenko"
 <semen.protsenko@linaro.org>, "Anand Moon" <linux.amoon@gmail.com>, "Marek
 Szyprowski" <m.szyprowski@samsung.com>
Subject: Re: [PATCH v4 0/7] Add initial Exynos850 support to the thermal
 driver
From: "Alexey Klimov" <alexey.klimov@linaro.org>
To: "Mateusz Majewski" <m.majewski2@samsung.com>
X-Mailer: aerc 0.20.0
References: <CGME20260303090219eucas1p1711b5b0f0e8ae56bc421ad8f6e5bf365@eucas1p1.samsung.com> <20260303090211.673143-1-m.majewski2@samsung.com>
In-Reply-To: <20260303090211.673143-1-m.majewski2@samsung.com>

Hello Mateusz,

Sorry for delayed response too.

On Tue Mar 3, 2026 at 9:02 AM GMT, Mateusz Majewski wrote:
> Hello and sorry for missing your mail, thankfully Marek pointed it out
> to me.
>
>> I applied the whole series locally, it applies fine on 6.19 but I didn't
>> check linux-next; and tested it on Exynos850 E850-96 board with the
>> following DT node:
>>=20
>> tmuctrl_0: tmu@10070000 {
>>     compatible =3D "samsung,exynos850-tmu";
>>     reg =3D <0x10070000 0x800>;
>>     interrupts =3D <GIC_SPI 226 IRQ_TYPE_LEVEL_HIGH>;
>>     clocks =3D <&cmu_peri CLK_GOUT_BUSIF_TMU_PCLK>;
>>     clock-names =3D "tmu_apbif";
>>     #thermal-sensor-cells =3D <0>;
>> };
>>=20
>> and thermal zones as you mentioned way back. It works just fine.
>> Temp goes up to 48 C with a loaded CPUs and settles at 36-37C when idle.
>>=20
>> So for the whole series:
>> Tested-by: Alexey Klimov <alexey.klimov@linaro.org>
>
> Thank you!
>
>> However, do you have plans to update it or re-submit?
>> Or any other plans working on it?
>
> Honestly not sure. If any other patches are merged that conflict with
> this series, I definitely can resolve the commits (for now it applies
> just fine to next-20260227, though I haven't compiled the result yet).
> Correct me if I am wrong, but I don't recall anything to be done in this
> series otherwise. If there is interest in this series, I can retest this
> on the other boards and re-submit this later this week.

So, I bumped into the same issue you described in your other email.
Other sensors seems to be not initialised and always return some weird
temp (minus 29 or smth like that). Only first sensors works.

I initially started to look at this after enabling idle states on E850-96
(they work with only some un-upstreamable change). Having at least one
sensor is better than nothing.

I am looking at enabling ACPM thermal thingy but so far I see similar
issue that temp of all sensors is reported as 10 C regardless via ACPM.

Having said that I am not going to oppose this series moving forward if
you wish.

Thank you.

Best regards,
Alexey
