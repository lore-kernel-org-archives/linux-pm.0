Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793005046;
	b=ICfQchMZpU4ZQnS4Ddim7kbT39k8SL2nJGc8IZsLdsz+vpXlpfFf7UD/OQMJTY0mwJvv
	 R2mpMU1nlHS9p3dhzfnj2SC86PdrLXtt4zplNjEIGbEL2BB1hqpNuQqsgXSpmQm5O7ylY
	 ZMphC8I1wjbcf23LxUL8Oz0LIVU10B+91iUt9oPgurK5oPzD7xUpcKt5tXspdiugkMDhF
	 2SqibTbq7bIN27tGHzRM3FVtC8lEFS+9Pno0WuovgdFyrfWSsw3yAds33rtWn3JqG+r71
	 Hi29+NXr30xG+rqhHDcuTva658PXdjjvuI8y1CX3t+SA0Rg7sDafYRNpFjxV3Q0Kl1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793005046;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=bI1K7WpjHruW52kJjg4X/MW1X2UQCXM+sxLT9XP/nlQ=;
	b=dF1YbtX3hO07nkH2SspFNY0ZsZnaLBh22nuRlXYseGovPF0izUTZLcH3w4AI7UGtdlYz
	 VBMBbFKZalDbPYd1Wfpa0VeR+d0YQDq4mVmNMuh9Z9XggD6/qZ6+ZQyYqE97H/GqostTQ
	 B+yeS2f7gX1mnW0+I3KkKaQgCobRSS8+oKNLXTdWi0qM6x3f2eTIPSNARaK58RKWkKQtn
	 apKHbTUzktqEiZOsvuwF1fdh67aJGvp3/DNQ4XK2CQCiGkOnqEKjsUZwB0AUiy5O/hpSj
	 Eavwlu4pMIJ3CsgXOqfd3K5XC73Ai0IaqBBI55sSyRcmPsRbKXgAkYnXdUKuJ7auT7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=baylibre.com;
	spf=pass smtp.mailfrom=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=nBILM34N;
	arc=none smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9AA2606A31D
	for <linux-pm@vger.kernel.org>; Mon, 26 Oct 2026 08:57:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D9AA2606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=nBILM34N
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4a20bde60a0so22288605e9.3
        for <linux-pm@vger.kernel.org>; Mon, 26 Oct 2026 01:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1793005043; x=1793609843; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bI1K7WpjHruW52kJjg4X/MW1X2UQCXM+sxLT9XP/nlQ=;
        b=nBILM34N+DQmcQaiOwhhjAIBvLE1X8GiwMvy8mC6GThNPWRS1nnLAFrtY3hnyPSVNE
         Iw1wUC/FrAKhdk2E9Rv+/IZ3Uc/lKsrmo5Mo8o81Pcp3wYgTBWsY/iK1KyOY8+ku68Gr
         tlMyY4cGuHGGSdUUxuJ7RZ3eZanC3KZDVNtmShz+O6nzvpD7y+1eqGYHNXl0RPRK9FO5
         U1h5UehATB6b4SpLQbkpIAIfNmrGn2Y81XswDvMZerQClesyMtP3EptTEVYYe/0a2oLo
         PM/pYmxmaKVN2IGHCumdecvCMaF1hsrQQpghaWKBGPX5Aozb9IqHi1j1Ihl8WKCh6LDx
         cEiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793005043; x=1793609843;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :references:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bI1K7WpjHruW52kJjg4X/MW1X2UQCXM+sxLT9XP/nlQ=;
        b=lgszTB0+79jKjOAmEr/DgxZ92Vg/n8UbJgP1OX4vi5Tpdb1QqCl5unV1mEbMZ01I8F
         063wORKWtD6If17iKq7/6Hh7HBb93IYvCh4j5rJu58yp9ZImF9hgDC1j8waBJP7xK2z7
         Z/+gM8yGWrHCqqCt8CU5n1QoYnc8qEhAv7jmVrfZqkt1h3WKbLWpqg0UnQMcuWoQ7Nmu
         hWo+oAyFXURZz0iynQBIuUU1wvX8w5/VZl7vNrUshU3aYhrfCplOPJEnL0y6+8oic++c
         99kLTp23FJAr91lXC4v44wrhybxjTW3VgELVUimvKkxa1TZi8hysIAhnxvjLtw+HfYuq
         2sKA==
X-Forwarded-Encrypted: i=1; AKwUvBw3M7nr6hR0xZMG8R8kDCceNn4RUxYWvzaEdRGqvy8kx/ymJeZUwrajQMq18yZ7gey/9NGi+T5XzQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYIhwq3KtonrFIT0qOS9VwHU+SWXs1WqFj0QF8PvrM1zhiJAg2Sg
	u5PCrosraj7Jmw//eNANYUDRD5vDawgEtOV/xeDyuQeayPKoP64sKdGaKSo45a0237o=
X-Gm-Gg: AYBFou1jWv+z1h0YoQx5p8g1dZ9LiBMlJXmEioOPQpmGVSpolbPruRY1L6/oGCc9QKF
	MdDXKkgx+o60ptxRVN2xKl8+wowF2sWRJU54EnFbcmH0wFWotFPKnaS92D95b1f+q/K+Yv5x3w5
	QecgcX0qb70v9GAkoWM+hz7kBtOyK/DTIUUdUTVSRZp7OhP+aeNv4NrBgi+WWVIq0kjx4X/UCgF
	isvuLzdbIiVbffmslrt/MpSUh5QBAEbPasi5Ow1fmTYpKUs+cT1FJndwoMIuzXAVgaMwXufjLjw
	pse1It8raOB/gfNrFj09kFEdQR4e1yQQvbzsZIQtIRpsn5iNHGHrF/LEj566DNz2RumC5YPrCZC
	ENwkCvvpfsyGozuHZLLbNZ/zPq1wuWzRj3lEUiVEbOpDICKbOk1+684EqPxzmg9BxRvpHRFG6l4
	W1NKn8Jt7x1dlGPf/TkDu3am3L93q2krugFXRzvE+67o8E7acbkerMj5dl97uAeQDSskqTSdDyA
	TvgJ5FHz5Ml8EkhNYyFRKhMnuH8mrFSBn8MVGe11EcqaqOnOcX0ErMKOPiX9ica0+Bmz+TrpIo=
X-Received: by 2002:a05:600c:3b25:b0:4a2:1a:a128 with SMTP id 5b1f17b1804b1-4a35ac9f1ecmr118305925e9.19.1793005043279;
        Mon, 26 Oct 2026 01:57:23 -0700 (PDT)
Received: from localhost (82-67-6-57.subs.proxad.net. [82.67.6.57])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a35a59d998sm187484365e9.15.2026.10.26.01.57.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 01:57:22 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Viresh Kumar <viresh.kumar@linaro.org>,
 christian.koever-draxl@student.uibk.ac.at
Cc: neil.armstrong@linaro.org, sboyd@kernel.org, bmasney+clk@redhat.com,
 khilman@baylibre.com, martin.blumenstingl@googlemail.com,
 rafael@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, linux-kernel@vger.kernel.org,
 linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, Christian Stefan =?utf-8?B?S8O2dsOpci1EcmF4?=
 =?utf-8?B?bA==?=
 <ckoever@outlook.de>
Subject: Re: [PATCH 4/4] cpufreq: add an Amlogic speed-bin driver
In-Reply-To: <at7lXEqds7ukoR2V@vireshk-B250M-D3H>
References: <20261025192219.209137-1-christian.koever-draxl@student.uibk.ac.at>
 <20261025192219.209137-5-christian.koever-draxl@student.uibk.ac.at>
 <at7lXEqds7ukoR2V@vireshk-B250M-D3H>
Date: Mon, 26 Oct 2026 09:57:22 +0100
Message-ID: <1jbj8gkff1.fsf@starbuckisacylon.baylibre.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On lun. 26 oct. 2026 at 11:00, Viresh Kumar <viresh.kumar@linaro.org> wrote:

> On 25-10-26, 20:22, christian.koever-draxl@student.uibk.ac.at wrote:
>> From: Christian Stefan K=C3=B6v=C3=A9r-Draxl <ckoever@outlook.de>
>>=20
>> Every S4 speed bin runs the same CPU frequencies but needs its own
>> voltage curve, and the bin can only be read through the secure monitor.
>>=20
>> Read the bin from the firmware, select the matching
>> "opp-microvolt-speed<bin>" property for all CPUs, then register
>> cpufreq-dt. Bins outside the known range fall back to bin 0, which
>> has the highest voltages. Like sun50i-cpufreq-nvmem, the driver binds
>> on the SoC compatible and needs no node of its own, and S4 is added to
>> the cpufreq-dt-platdev blocklist so cpufreq-dt is only created after
>> the bin has been applied.
>>=20
>> Signed-off-by: Christian Stefan K=C3=B6v=C3=A9r-Draxl <ckoever@outlook.d=
e>
>> ---
>>  MAINTAINERS                          |   1 +
>>  drivers/cpufreq/Kconfig.arm          |  14 ++
>>  drivers/cpufreq/Makefile             |   1 +
>>  drivers/cpufreq/amlogic-cpufreq.c    | 184 +++++++++++++++++++++++++++
>>  drivers/cpufreq/cpufreq-dt-platdev.c |   2 +
>>  5 files changed, 202 insertions(+)
>>  create mode 100644 drivers/cpufreq/amlogic-cpufreq.c
>
> Is it safe to apply just this one ? I can take this via the PM tree then.

I would advise to wait a little for Amlogic to chime in.

Patch 2 is something I already rejected back when S4 support was
initially introduced. I suppose AI just unearthed it and did not bother
to mention it.

Amlogic was supposed to migrate to SCMI at that point, and possibly
handle CPU frequency scaling through the secure fw entirely.

They did on later SoCs, I don't know where their FW stands on the S4.

>
> --=20
> viresh

--=20
Jerome
