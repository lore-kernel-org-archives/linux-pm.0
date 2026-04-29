Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D59B9377EBC
	for <linux-pm@vger.kernel.org>; Wed, 29 Apr 2026 15:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777476059; cv=none; b=CqWieoShmaZJwH6RvEB1QZeq2hwWk9QA344PS+rD6hVK6L5iN7iM6ojXYDhZ3fx6ngOa5DDZmHw7xauWpVKOyQsLDcAoxp83r4MZmSWU4LzC5fuv5cSkkReUfrv3JWeqbR6zoWhV69sIGvgG2O88FBZspYgJoVn0Vxb3HnqG+iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777476059; c=relaxed/simple;
	bh=G01D3imQ7+o35Ef3KRuQfIV17JN9Pd0G6yv1+UrifFE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JVQEYuMYTJ3GRauDHdXgUhBi77756Tn+LB48q44UslhOqF+mZFapRBq0oSe8jlPcIEZ+o1swXtbuqXJWVj8jbiM8dN7OboqCCvLYgMh9FP3rY1TrK65AKVXEHLWN5JxAt4PRG+aOUmFiCs7JdNb7vC71GxuyVz0bQo91L5rvFK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lzsNQwSE; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lzsNQwSE"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-48984d29fe3so153889725e9.0
        for <linux-pm@vger.kernel.org>; Wed, 29 Apr 2026 08:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1777476056; x=1778080856; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S1mflq2JmCovYJyevIlYYXkXeU9o+ZpGv13YTJw53l4=;
        b=lzsNQwSEhng+nLmcAb+SX5pYjDtxV1pJcPLQSsS05vnrhXcquTsxitaPN2BdI9LMl7
         r+nftcDlD6HWNI491c5hHBNXY0CC3W48sTY52d5ib4zxvhBaQsEZA//z5p5IHjD3D+/s
         8NDlhjYuchKHpTpk2AR0KMWrCRV3TIY5QbxkkTkeGxhDotq3aWTuKAzawknPHXxs3YxV
         rXvJ+A+xGdSR2afXoF96Wbgezi7L3HsQFdy+1L9UHraG5I/1z1sgUeSgjSRvAzPQ2R67
         pTc1CgB5YjBThxB9OJJa0RV0wmoiu3xApBCUyNydZQCA7SBfeT+irEHpeB5//9rFibiR
         iNTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777476056; x=1778080856;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S1mflq2JmCovYJyevIlYYXkXeU9o+ZpGv13YTJw53l4=;
        b=BG5Ay4KxpwD+YcVA3qsHprHRnNL6qRwWTTN8UZ6ZzuM5KBqDyKCNXkrtEUEf27NUej
         jCkyCjvyaAJYdQiaIXEiU2bysqtuZDRoGhYFsurCFJBWVIi5jdG5yBzYSYEDKzvQaD1h
         hTWefooxD9CvEsF473ujMd11gGHrZ4NVvDa+3pYIb6dgRkBSeGtaYO1n2ZY80DXB3l3H
         j50lxzGmENt+05tkmAnO+KxyjUb+ZpqMFUlRyLv2STVP/eDX5Lw6+83VpnQOE7SsihuO
         eg+mHTSWNiEuxuXGJI+UCYVjCplthErc73Yminx2stJUoarkF7x1wKEioOjJm6ZHVxsK
         y4bA==
X-Forwarded-Encrypted: i=1; AFNElJ/YHns220O/+X9dts1VnapD4fwLEcD+m1sb1iqsbkNDiM52o7PPs41OisUCOMh6KdJR4oJgBd66GQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyLn+p8ELrYySRpsnRXBXJwHEp0yGLa+qrZ+JQ17gRAMg5RKo4V
	lPgo9nLmZKun7bJFQiCa6kUOetq9mp+in79Phfq9+s4DP9wQBJLtb7zr2YV15E3BaU8=
X-Gm-Gg: AeBDieuUrb7Tkmazu5dtwjqeyzgpG+fvHwm2ONB49dNl53sKZHhKbEOvu1ZPLczQLv6
	wMtUes7+h8OOLDyssQRKRYbocBxM7GJ9RH6SQdrmITVK7PvPrHDpagNmwX0Gu85OVi4aUHjsUkl
	Eb7NqY1Isj/EbTufrtqJpHgWFv+DI/ol2x6Xtg0FLNGQLf0si6AVEizT+x+N0FV019v6b4ooqfr
	V76XkQdW98wp3dfCAazVxEajU8HXnj8sDH5BpnSrDKTLkRxxPqvNqSJYa55OsE/stc+/3tsYfql
	f6K0RBvTqic/kfGwOgGJKap4Iqk4L4cxXOaX/gGFILVcrRnIPYJyQklJwzKGjQFEFL6CAXm43fk
	AuCIcrN6KBg794RsyKdiYMNLE8qDkflhzYPqBWyOdZzVlqthHhrG9/BSAGCgnZdfZQHNC6kYneS
	Wt8ZJCLgKJehcTeuBZJRce5E2Iiv5Nj6VuPezCMBXYGq8=
X-Received: by 2002:a05:600c:4745:b0:488:9bf8:7f17 with SMTP id 5b1f17b1804b1-48a77b054d8mr122018735e9.14.1777476056171;
        Wed, 29 Apr 2026 08:20:56 -0700 (PDT)
Received: from [10.11.12.108] ([79.115.63.228])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-447b76e5afesm5634461f8f.30.2026.04.29.08.20.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Apr 2026 08:20:55 -0700 (PDT)
Message-ID: <001a226f-606a-41fe-a684-c208d8898e17@linaro.org>
Date: Wed, 29 Apr 2026 18:20:52 +0300
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/11] thermal: samsung: Add support for Google GS101
 TMU
To: Krzysztof Kozlowski <krzk@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>,
 Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Kees Cook <kees@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Peter Griffin <peter.griffin@linaro.org>,
 =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
 Daniel Lezcano <daniel.lezcano@kernel.org>,
 Sylwester Nawrocki <s.nawrocki@samsung.com>,
 Chanwoo Choi <cw00.choi@samsung.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Lee Jones <lee@kernel.org>
Cc: willmcvicker@google.com, jyescas@google.com, shin.son@samsung.com,
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-hardening@vger.kernel.org,
 linux-clk@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
References: <20260423-acpm-tmu-v4-0-8b59f8548634@linaro.org>
 <41ebf31c-89ca-497e-b206-ece332d0260e@kernel.org>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <41ebf31c-89ca-497e-b206-ece332d0260e@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Krzysztof,

On 4/28/26 12:24 PM, Krzysztof Kozlowski wrote:
>> Dependencies
>> ============
>> - context dependency on the ACPM fixes sent at:
>>   Link: https://lore.kernel.org/linux-samsung-soc/20260423-acpm-fixes-sashiko-reports-v1-0-2217b790925e@linaro.org/T/#t
>> - cleanup and prep firmware patches 2, 3, 4, 5, 6, 7: required by the
>>   thermal driver (patch 8).
> Well, cleanup in one driver cannot be a dependency for other driver.
> 
>> - bindings (patch 1): required for DTS validation.
>> - thermal driver patch 8: required by defconfig (patch 11) - logical
>> dependency. 
> Most of the patches should be taken before, which would leave you only
> final new firmware interface as dependency. Creating such unnecessary
> dependencies is not helping.
> 
> And the patchset even grew and will conflict with other firmware work,
> so I will deal with firmware bits and I can provide them via stable tag
> to thermal for the last patch.

Sounds good, thank you!

I'll send the firmware cleanup and preparatory patches in their own patch
set after the firmware fixes get in.

Then I will resend the thermal driver once all the firmware patches are
sorted out and a stable tag is provided.

In the meantime the thermal maintainers can still check the thermal driver
proposal.

Cheers,
ta
