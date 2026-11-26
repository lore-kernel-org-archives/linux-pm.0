Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795691039;
	b=P1vmAWgLnQcYD9r/0ZPD9869lXH+i/t3xbwTSWI7HzksYs1swpS3NMhD4rNcSv2j6W7z
	 2lKzoFIj2o0ktz1OrQvQv06kOo2mP+FRnJFH46iY8vG6DTQQyqwi6tC2sojLPY5CfL4fZ
	 ZpQX+4do+mbgH8LbZWH9Gu+lxjzyCc4GTfyF1Gn4LlhxvaYAftxR+d2qNH4Pn3o/dVqnK
	 HsK5ipeS79ai3MxHS1w4s44G33umqv2R6OpkYwjHxobQPdVozscmCWxEjk1LWcytw2470
	 jgMElqWL+IYBJ4bNDxdsZF6nniUK1RCzO/2amzOPzMNO3NOkAbMLpzN2yb17WYKUq4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795691039;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=wbMl1PZXioIhutwHjgEf/QKIJdTG6ISgm88fxtlS6O8=;
	b=IfJhu5x1/g7qgzC6BsGFQPyRcf6d9lZaPritM9QJYQ9stY49hOPxW9nlvAVTt2mmLFZ3
	 ntly3mP0WfIgHErOZRnM+y/t3C38VR6zf1M+j0xKT2NY3gODueQ9aS+LeqUDCT3sFUTNw
	 c+wKg188kVkAIKiHOulNZKeqlfoOg/5LcjkA7O8G+ZJKxMERkI0k+88apf0MHrpbYQ5Bu
	 q6kkL5pHzbHuFCJ7vgyFqQwCwQTeU2nod74p5O++5HhTaGfBKAKU92MRslGbw6DPEJmLb
	 FB5arKog4FOOrOjyS6D3U7ilNiVGP3Fwvpt21+Tx0n8FHizfiVUznxlvk0KuQfN03QQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=L4jYK993;
	arc=none smtp.remote-ip=209.85.221.47
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA370606A321
	for <linux-pm@vger.kernel.org>; Thu, 26 Nov 2026 11:03:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DA370606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=L4jYK993
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-49465892f7bso4993915f8f.1
        for <linux-pm@vger.kernel.org>; Thu, 26 Nov 2026 03:03:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1795691037; x=1796295837; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wbMl1PZXioIhutwHjgEf/QKIJdTG6ISgm88fxtlS6O8=;
        b=L4jYK993lz2ish9adws/NpZ/TcP6lz8393v5p8wEDlb0hJqFvDYDz7zq51tf/uRk/Z
         hfnSVjRNre5BdqiQXjFeSQ10XnmSqg03I81bLLP4eXRqz9wM3b2CH8ObMgWLiql3sdLK
         uxLWOf9gxnWeIGon1rxiZznEZHE3KDIfPThlK8Hs5dbviLVZJUPm8WA4RmVuVBiriZ0F
         x8V27cRrr9VYVEagZa5EBhBJrwIUCrDbjuDjP4+th4aBcjfzma6wVLaRJMd7Vm6zSpg5
         yz85qvgYT/SJ0GW9BzQgXBhOEiOFh2LuQJicjN0CDKkM3MdGsBdilkzeBiJWmOvWfZBQ
         0inQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795691037; x=1796295837;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wbMl1PZXioIhutwHjgEf/QKIJdTG6ISgm88fxtlS6O8=;
        b=lLOhYqLc3za8MvOhLqAmW8b+W3Na7KRMlJvcueQ5epMkdYZCtXIOvgB1EXmwzBbZU0
         bfe5ZKdCQjebHu3flDLeNZ9Jn5LiYwYGFofD70bBtOAfF5PX+4aPqEqHxgiIQGhjT7/f
         hhX0qwNW0yjEZh/1aeATeaQ8afyVn9bl5WjrZ3FCoTm13EamCMRt6ttVPwgBIyuhp6oV
         MdGA9982ucE4nAELYoQyJFyClsCcri2BvXN1c33MdFOTlT0RYRyAMaTM7i36qpSSotUB
         MzUksIa+Tc315OPsPBHsAXsBvfO67QPXswr6swrlt1pl9KYYd2tMcX2uyAAUCCS5vnTA
         AfQw==
X-Forwarded-Encrypted: i=1; AL+hErEKKryC/yOR04RVzBU+7hp9Iu+LbVH4x6IMgQdFdZsdocWkGe4+IitJzyflaDIXq+f1JqBbcW90YQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z8/LYnDTXLN5Jh5E4SAEjA/De4IkEnn6S0HCdqlDXSKyZEPglV6
	wHwGlT+SUQ1vzuNQzaakVm01Ui9iGAHblCbMqAJVEaON0UZGst0Il0oLyVEuQtFN9qg=
X-Gm-Gg: AZFdTZeZdEEobYxh6VM6BZAl7M7NaTFxEnRNPsyN0k4brXaNpPSfPkYHw+Mpm/PM9b/
	PbmoYE8DglUdr88n2efcM22TQc05Aa9UKpGR/kUjKIzmFfj8BKqZDOW09pOT/PwhbGEVyFJSSIq
	vv8mcXqreET2CYzBVAvywtoVSNIpj3jOKY8n0JP4VPwhYgLEBDkAOgkXkqAPNOCQokDf6wh3KeN
	ix51tzTsPbw+v7en0/B6PgT/19NQRRYta/MWsHOjjvwn8uFPEY9SvZwj/TKeNbySYRWIvfc7NMG
	McwJcaD//7SlUF2RbdHbAWvRAmIQ4F8amRNmhz0xl/wekRb6WqH86mN6suJ0ww8Dv9iZTdqaAsK
	BcN9NpDTsAAEi9EPkYscJaoyTxNzyMRyjUFz+Ap4iBa5niKpo6VKWfukucZEVAHpX37g7CCR87K
	wEdpOwV1MZGuAObknV1g+7EhBLfYCCNO3ULUhSFK91pxdh1nGpaKY4uZSC1/lqArNHxbEZxxM4p
	jQ5S/g/ZBVCHHWlo/C3eyeWSisObDgmfwga11TErmHIbHVGCpnfihCjSDBUBvuUw2McN0o690gt
	Ba45x5ysYcIpR/VPrWzqouPGM3p6izIS2pdsBcofwI2W/BpQ5gBUYZgNgE+v
X-Received: by 2002:a05:600c:848d:b0:4bb:694e:496c with SMTP id 5b1f17b1804b1-4bb88810b39mr439443445e9.22.1795691037195;
        Thu, 26 Nov 2026 03:03:57 -0800 (PST)
Received: from [10.11.12.111] ([79.115.63.240])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6a68048esm41934052f8f.29.2026.11.26.03.03.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Nov 2026 03:03:56 -0800 (PST)
Message-ID: <1e474131-3013-44eb-b675-db532d9733ec@linaro.org>
Date: Thu, 26 Nov 2026 13:03:46 +0200
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
Subject: Re: [PATCHv3] thermal/drivers/samsung/acpm-tmu: Fix spurious CPU
 throttling
To: Christian Loehle <christian.loehle@arm.com>,
 Alexey Klimov <alexey.klimov@linaro.org>
Cc: bzolnier@gmail.com, krzk@kernel.org, rafael@kernel.org,
 daniel.lezcano@kernel.org, lukasz.luba@arm.com,
 linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
 linux-pm@vger.kernel.org
References: <20261125173959.2198116-1-christian.loehle@arm.com>
 <CANgGJDp02H7-wLv6DoaPMeiy4UvDUC2nvSR=+mngEZ+Z4Hqgog@mail.gmail.com>
 <2162b02c-642a-446c-973e-ca80607da294@arm.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <2162b02c-642a-446c-973e-ca80607da294@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/26/26 12:50 PM, Christian Loehle wrote:

>>> Program slot 7 from the lowest active hot trip so hardware throttling can
>>> precede the critical trip's system shutdown. Cache the low/high window and
>>> update the hot limit from set_trip_temp(), because the thermal core skips
>>> set_trips() when that window is unchanged.
>>
>> FWIW, Exynos850 control register for TMU has bits to enabled/disable
>> such behaviour (and it probably works).
>> Maybe gs101 also has it.
>> But it seems that cpufreq scaling feature itself is explicitly enabled.
> 
> Thanks for the hint Alexey!
> THERM_TRIP_EN is bit12 on Exynos850, clearing that on gs101 still stays on 200MHz
> for me. The downstream driver doesn't define it either.
> Clearing bit16, i.e. 0x09003 instead of 0x19003 does indeed remove the throttling
> even with all zeroes in slot7.
> I would probably still go with $SUBJECT, as I'd say the risk of this having unwanted

I prefer current patch. On GS101 the TMU control registers are owned by the
ACPM firmware, which may rewrite CONTROL (e.g. on init, tz_control or resume),
and clearing the bit would also drop the hardware throttling as a backstop,
which downstream keeps enabled.

Cheers,
ta
