Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795088468;
	b=vYmeyQn6gGvarQsvnee+N2PPG3PGGngFATZ6eTjOLm68Rrd9UDgRtH7lnSWOUkbK+9dF
	 xAWpFbl3PjwD+Ba/QUhiE9aCMqiavLWtSPfJZ6T5pDZXi+wvZX8BKPkjq3jPR1cRr0pvt
	 8WNBHuLwwfCQ38vJohqRu+e8qbS2m32fb28gsSzIlb3j3GrEtD7kzhkttwTHpXdCsLo2w
	 uFsxzJye0kras8tNJoqYOyeGCrJGiggdeRuEe5Sb7gQDpnw4ACqJc+vIzYTyiTRh1R16X
	 mPIc04T8Qkk+ocmZMQ17h0JRDPPZycEB3y8W/5RBfDUdUL/U95N5xFXSVo5pq6AeY8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795088468;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=Zn05LQ3W1lpoYmiGEPENrsqSnlYIcvQviJvLZUlNcNs=;
	b=HwiOeoqh5j8YoLJ183tllGS9xSCzRmaZYS73aO3Q82IuEwgiUtyet+lnTx5amU/F6RJZ
	 N1uib7QhhX0B1q2a3EtSvwqqh9UXMs5HZBvMV4DvAA4Y72pea6Hh8k90v/V0OQ4pi1PpS
	 Aa75TxUmLa6DQZJs9c88yNiDcs6mSaBnT56LiYATvs9fcVOwxsayZgC3Qk8sv0GH7HyrG
	 qoo7uvTvQDvnTj7dfZazEYrPq0KMHq6ToxeBcLq4eJtSQiSURMCPoEuKywYXx7wiXkppW
	 3dmEcqY5psc4uRSY6JAVag+rLtn7MfYtCN1CuFffPwstk0iB1SXH2hvEbzxr/CiIuxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b="hLfVGe/6";
	arc=none smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58864606A320
	for <linux-pm@vger.kernel.org>; Thu, 19 Nov 2026 11:41:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 58864606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=hLfVGe/6
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4bb666304fdso7072865e9.0
        for <linux-pm@vger.kernel.org>; Thu, 19 Nov 2026 03:41:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1795088467; x=1795693267; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Zn05LQ3W1lpoYmiGEPENrsqSnlYIcvQviJvLZUlNcNs=;
        b=hLfVGe/6VVOPTA8v7FKdWRuQuRmWxsjr6S6y5jTg5if7Lzf0tQNN4TaXAQody43hTg
         wJQ4s9BffXGconioSgn0+0huHsdHw8oEFKYEr/6f+Ca5F6S8ix1HbHWCvhH8T/P0iLq8
         vxFIxLEdW2ZUIMsIfdbOSJhTy9GLmCs6UIxIOJliplJ7PWpk7Da2VbChe+7+h6OOEFQ9
         L7xKm89Mr4c6+lEJ5x6wmHxyKbxBM7vI0oiNqm9oqIZ8dBdUg30TDvoDDxhq3ekk1H4A
         mPDKNMP5bo9+Jz3OHygXjk1wRO43yxyCiu6xP0dUdeN6SmfkpGoAdTYd8f77OLQl3mYb
         CgxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795088467; x=1795693267;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Zn05LQ3W1lpoYmiGEPENrsqSnlYIcvQviJvLZUlNcNs=;
        b=M0d90/9J4kqnZlGDvKCGrtS85QE9J+4lkY1yLa626BLopc6ffCm95LMn+2Achs/6ej
         Sl01Lm3S26YGYB1bs5hsy04W7XGG8uUAN4DFdEGHg0uZSJb9Ia0dXPgwqTDs1M9+2dU9
         PNVbEQ0fsG8wYFAFyeZYOaEDzLMZGOitqfseG1KsHAPcY7lEEyBlguovLw/kaAcdmOlN
         OymZEZJQgsvrfOl/E14z3Gebm6NB4HHeShOT+PBDJXFYrmbgYqmQiVC8gVDcKuglZcJS
         e4ZgemsUHpoVFVKhzoIuPUnVOXdCx/dOtmtogQ2Mu/mbC1h08wBZNrQ2zh4+6YapSflm
         SHHw==
X-Forwarded-Encrypted: i=1; AL+hErH4c4PJfy55VR474GT3BSh5S1H9jWsaKVzSB7guRIhxy3AX6xbHnOdseEMvtbNx6e9TznA4ZGwpsQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z9qmu8Wqfw5XHPnLpVHTZBs1gOJ/UFEO/ZY6sWzCEX2fM8FggOt
	NV/uOYmqrM7wAQ89EJfUYVW8vQlnVoajRaUF7UooPABjqA7IJxcwnYo9baQ2dXCUW9g=
X-Gm-Gg: AYBFou2F/pugjhXNHJ3Py+Aj2zbE7BN9/3azks3z1nwYAntiqHPxyTbgUfIzpxXIFuH
	Q6o4nCH6Qym/3cfLGzYayMGmmfGxPo21ETVI5nN0l9QcPeAxUvWDGbQeW+ZrFEPuOyKt0L0ZsJW
	7ekWblKvxtCmOMQ36RCfaA8IMcWztpUn6+YP66E6dsBfEsapMDTX4qhxjMdftKP5LqPBRJQlsTl
	8USSjSGd8rA0vG4XYl8YFc5zCI2wAixVN47IeCE2UUxHuYVQ5PTEH6IHBnaTLgF7jbzh19WkWqg
	OKobLKT+lArVedYpBsnNqpWyAqlQv7jVI2nbcSoqgNbRiYOXXMjMwDyD5ddfzvLrsh5oWlxnDVg
	xgMRgj52Fi6fMQCcTXpsLntas4wWkvxHIZpcq7ib8xolFLBchTshGRiD1yqJfLBfusSOwmHpbb1
	/3Rxn2wtAyDnCSks7IMex48jK8KTAPm253opor2HVfjqM47BmE5LfR7Q1KDl8oiyWbABN7ve7JH
	z8razeshCjEiRX0h/mQxBhiqdACEhD6xvjDD2Jljp3WfwtASu7o3mXu7TV1Tbm+dJRPq60tU6ml
	ZNL+tgrqnbIz6oPK+BZxx9wiYd5sIJOtBHJKVg9d
X-Received: by 2002:a05:600c:12cb:b0:4a2:1104:7ca7 with SMTP id 5b1f17b1804b1-4bb861576bemr14665855e9.11.1795088466528;
        Thu, 19 Nov 2026 03:41:06 -0800 (PST)
Received: from [192.168.0.252] ([79.115.63.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4a654a8c406sm9943663f8f.14.2026.11.19.03.41.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Nov 2026 03:41:06 -0800 (PST)
Message-ID: <fa1f0750-ac4e-4bf9-b549-2bb9a17cbb0a@linaro.org>
Date: Thu, 19 Nov 2026 13:41:04 +0200
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
Subject: Re: [PATCH v2 0/3] thermal: samsung: acpm-tmu: Add Exynos850 support
To: Alexey Klimov <alexey.klimov@linaro.org>,
 Daniel Lezcano <daniel.lezcano@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
 Krzysztof Kozlowski <krzk@kernel.org>
Cc: Mateusz Majewski <m.majewski2@samsung.com>,
 Thomas Turner <tturner@lineageos.org>,
 Peter Griffin <peter.griffin@linaro.org>, linux-pm@vger.kernel.org,
 linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261118-acpm-tmu-e850-support-v2-0-19848c0d97e5@linaro.org>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20261118-acpm-tmu-e850-support-v2-0-19848c0d97e5@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Alexey!

Thanks for the series!

On 11/18/26 3:51 PM, Alexey Klimov wrote:
> This series adds support for the Thermal Management Unit found on
> the Samsung Exynos850 SoC to the existing acpm-tmu driver.

Exynos850 almost doubles acpm-tmu.c, and most of the new code is
register-level handling that has nothing in common with GS101.
I'd like to split the driver now, while we add the second SoC,
rather than later. The layout could be:

  drivers/thermal/samsung/
    acpm-tmu.h            internal header: acpm_tmu_priv, acpm_tmu_sensor,
                          SoC driver data / callbacks
    acpm-tmu.c            probe, PM, thermal zone ops, threaded IRQ, OF match
                          table, locking and sensor disable/enable around
                          threshold updates
    acpm-tmu-gs101.c      ACPM IPC callbacks, sensor groups, regmap config
    acpm-tmu-exynos850.c  MMIO init and trimming, threshold and interrupt
                          registers

  obj-$(CONFIG_EXYNOS_ACPM_THERMAL)  += exynos-acpm-tmu.o
  exynos-acpm-tmu-y                  += acpm-tmu.o acpm-tmu-gs101.o \
                                        acpm-tmu-exynos850.o

See drivers/thermal/qcom/tsens* for a similar layout.

Also, please note Christian's fix for GS101 threshold 7 [1], you'll likely
need to rebase your set on his v2 as it's a fix and shall come first.

[1] https://lore.kernel.org/all/20261117083442.830549-1-christian.loehle@arm.com/

Cheers,
ta
