Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221AF1AE877
	for <linux-pm@vger.kernel.org>; Wed,  1 Apr 2026 11:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775041520; cv=none; b=ppsG1vIvLiksdmfufrkIKT6KHDCmm1kJzT8WoLgRYAa+Syyh7kxPAXH1EtmR4QzJ89PylXneQlD3lwTNDricylotS5kp9Wgm882N1D6mqsOgu2d4nQE74eEL0GdemIZeXRP5aBrfUgb2YhHJwht87KFnvr7QFBHEYEwsMTd0nvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775041520; c=relaxed/simple;
	bh=om1doAdG2PMAv9rQ6C/z/VNO3DmdhRZwcmQFk9Vnqy8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hHs+0xbN6YNvG3+atCXH7IhjhRqBUKyTD20iYIxW/Loru+xOocBNbCz8oTtTQdQbCzJwgXYsLBubEfHKSPTQfMeIxy+bJ9qLAIJ38jvmz8a0IeHtN/ZEmNJ+B15/UmV6oygWgh3TIZKGryWVeJPEjkHmGjFRwbHoDvTP5CQ1X7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MwxJJyLQ; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MwxJJyLQ"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-48558d6ef83so67566345e9.3
        for <linux-pm@vger.kernel.org>; Wed, 01 Apr 2026 04:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1775041517; x=1775646317; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HBGBJDQ/gRb2ZWiVOaSaUlUwjskXrH5SbODqYF4ayW4=;
        b=MwxJJyLQ7TkzsOQEuDMS3aQ5MCPLtNV05Zx7ZFJQJg1+cVgFzygzln6QmIjgLNv4Uk
         8eVxWSAMDMl447kLXj8sPezmkQkx5BokGxstHbLMHww10lotwivBq8E3oNWX9w6sxbw3
         kf+Y4RwtfwJavFB8EQHmaDANJ5vOT3AFd4Wpv89/nKIpFIiE21A5bgiCGAaOplgJX3U4
         3Y35VYdJORWmUdKA8c4ghTAPnXhQhdrJ34oX6lZYgsmL6muUHgcMP54kAP1FGUhlXNz7
         9+AC1ajqXHKG3CMEDJRoUh/kJkLj8twvztJHq0xqHCWI9kKmQRP66TxrtRfiO/Zaw7K+
         K7kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775041517; x=1775646317;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HBGBJDQ/gRb2ZWiVOaSaUlUwjskXrH5SbODqYF4ayW4=;
        b=r8uxIxRKnFgOzB2Hic45FP97MTzKcf0TQ6GASh6oIl9nCEF8O21TuYrfZ4YS+jQcPT
         av1EEUvnwQn17gL4TdbVdMEov0H4zXfto0ZcTlzjWluTnvI4weZvYBQwGG2ym76YhHXw
         hbRK5AGU1d9zEG/u3YWw1mXcIlylUEwdNqNa42gL/QIygec+8QW8gAP3cOUpywFW2CK8
         zNqi3+omNaokz1YmS5KDYv2Wj1B1INMMA54t8y3DDQcqEo6OQBdt3iNBx4g43ik2ECkc
         dfjM5PCMmLr34vJuGV/b+R0FhoeS4CBVMcURM5fVl+tZSRIlZsmstxfXFhURupZzyRRQ
         inhQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5tmnMqnRxD4kGi73kU/dcfO9onub05t963IMiTd8fNk8ILmr61OqeK8gOcGHnc4FFlrN+W59PfQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxcpsP4pacHxmOrj3TvYcgGx8Xq3h97IAPCFNPuGNeOgP5OEWck
	/HF++maV+n0ATFPb6nlPzbPmwafAaFr7Frz+owdDGoDhZhf8waI/DZDkQnAQH5dHeCo=
X-Gm-Gg: ATEYQzwq8lLeNdu4WvgbzPoQOqmPK8DvkS6+QJn6Hq/GI0IxzxJpxvskyINcKFMUf6f
	08g9uH4wFXoy4DWtdh9QznwPUN7QUaORxhCXQDQSzFWRzB0CZaW9QAoPimvNnQZNjFVsOCmINg4
	K9EXbwOkLl1w40tmnIGaNBAhyKfwNnyZseK2gVTULeiTalzMHOazV8qNrI3obZKEabXFAw6XZVz
	xRvH92t6zA3wC+kGedeKMskq/sRv7hK0DE/DN0Cj5LT7MsNDVivGQdTq9B5LwxRexbksr5WoBEs
	QKwnSodtuEqk0U3Fyt5CrxllpBkBe7/agkp8aNYUCKzO5XRTgOX1YzS6++jvotYJxTaov5K2oSP
	WdJ0lhiuLZDTzJ7ZPdHMOlH5v+hv1FLjoaL4sWINaWTuQvdkyzD4zN5WaDsu1zhK3PxItiSUvcs
	CRlPQxI+8xmuuDptCEHviKjvmUfc4f119M8Qw=
X-Received: by 2002:a05:600c:4594:b0:486:ffa3:55f with SMTP id 5b1f17b1804b1-488835d0f0cmr51363045e9.27.1775041517450;
        Wed, 01 Apr 2026 04:05:17 -0700 (PDT)
Received: from [192.168.0.167] ([109.76.235.19])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43cf90424fcsm30627349f8f.32.2026.04.01.04.05.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Apr 2026 04:05:16 -0700 (PDT)
Message-ID: <69b993ce-07b8-4071-ace3-9a33147670af@linaro.org>
Date: Wed, 1 Apr 2026 12:05:15 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/5] media: iris: scale MMCX power domain on SM8250
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Ulf Hansson <ulf.hansson@linaro.org>
Cc: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Taniya Das <quic_tdas@quicinc.com>,
 Jonathan Marek <jonathan@marek.ca>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Bryan O'Donoghue <bod@kernel.org>,
 Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Stanimir Varbanov <stanimir.varbanov@linaro.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, Hans Verkuil <hverkuil@kernel.org>,
 Stefan Schmidt <stefan.schmidt@linaro.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dikshita Agarwal <dikshita@qti.qualcomm.com>, linux-arm-msm@vger.kernel.org,
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-media@vger.kernel.org,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
References: <20260209-iris-venus-fix-sm8250-v5-0-0a22365d3585@oss.qualcomm.com>
 <20260209-iris-venus-fix-sm8250-v5-2-0a22365d3585@oss.qualcomm.com>
 <5e2635ac-35de-645b-b5e7-235923f844ce@oss.qualcomm.com>
 <x5gv6dxdum5klzfjyo7xjqull6o43okkmkn7avssg26epbvrz6@z2brpssbk7iv>
 <0b41ee7c-83fe-d604-b750-8a5a0bd62bf8@oss.qualcomm.com>
 <CAPDyKFrO3DzfG0aW4z4w87j_iWM=3dpvp=2Wgr4MX1Bin5-6ZA@mail.gmail.com>
 <6yfn6ux3gbin2dtopdxxv4okinspueryuey5vfdq633gsewc6r@ttp56brnpgvr>
 <CAPDyKFpm7ujNw51dVpPaHCwssjgYe1JVBEyrQ_1CsPbDJuW0Ww@mail.gmail.com>
 <4fiyjcqt5smotudsfzyqrevxxnx3sf5grbgfluzkndbp2od6pq@vlyikcvl3xkb>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Content-Language: en-US
In-Reply-To: <4fiyjcqt5smotudsfzyqrevxxnx3sf5grbgfluzkndbp2od6pq@vlyikcvl3xkb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01/04/2026 12:01, Dmitry Baryshkov wrote:
>> Right.
>>
>> Since it's my mistake, let me reconsider. If I rebase my branch and
>> share the necessary commit through an immutable branch that you can
>> pull in. Would that work for you?
> I think that question goes to Vikash, Dikshita, Bryan and linux-media
> maintainers.  Bryan, what is the plan for this patchset? Should Ulf
> rebase the branch? Or is this patchset delayed for some other reasons?

Yeah no it's grand, immutable tag works fine.

---
bod
