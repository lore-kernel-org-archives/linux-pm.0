Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C9B47CC71
	for <linux-pm@vger.kernel.org>; Mon, 12 Oct 2026 20:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791838666; cv=pass; b=FoYnX5TYoWA/i660EQFEgR5u6eSiOGGfr4/RexpVyjAT7GJLf0ui1JOyWHsBs5yuzblH1QzCEcM2jiBjmIUtd1oWENkaPmVsNv+HELvW1dMgMaTqFX+pgcEOO2imdK/ziBTI5cnpQvJa4OhEnf0v9jCquU2LkZDoC2ZXFSVN7Hw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791838666; c=relaxed/simple;
	bh=qfhNpMKikTUE4GXuTXMhSz598q5HToAtxwd6kVZHfsk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gzYMI9TA2DWz6WrXJgNnpltaST7nik7aWqfyJ6rn7bzhtrXuvrM9CE7SEW0mxwDS1SuDRr1NZS25tQKc55yDb6jpti+DyOD/YlONZHxHLPR4acIZ/4gPvoCn8fr7pLl6DNzaYZtgRCmfv5qMqrA6Xc90mCrej1Z7Uc999MUM4E4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bbz16QiI; arc=pass smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bbz16QiI"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-3a1f628b1d1so16473731fa.0
        for <linux-pm@vger.kernel.org>; Mon, 12 Oct 2026 13:57:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791838663; cv=none;
        d=google.com; s=arc-20260327;
        b=Sj+Nxxqa9Ip1FWtWcVjQlLi8oexDG7CbhTj1wHNq9+WIIwqimG5GtNtviJIMYMvkmQ
         YQXljTpfgYTkKafcT5QL2gpfLjZNcDoCmoI5GWmZjuSAxIvDMiP0qBc//g2BxNDMuEJX
         fz8fqaRYW8ucH7odjp/rjVWUeq0+09jKCd5YG1z722K6BhYjCOyB6TRh0UZ+VZQRODWG
         L9+EKH1B92d/DS2Hp+Po31pye68Y1hLq/XkWSk5AqjtHhb4o4rBXZqbuCJE7VnZOGwuF
         AefPJaaR2muYrhPf+REJ96Gfy73E2npmCCSTQRCi9+PVrd6BhZyuR3mzeOe8lwjLP2Ud
         /thg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=jLix4JrWc+gaL1YtlKdXsZNF8UYItzc7REKQDH8C5y4=;
        fh=JGpUsIwGgiZRseWjbgZCGMG0Tzdagb9Q5fUy0wSvhyo=;
        b=jU+ST3Bls+czNy56cbtU3VmWZoVAEV4JxsxCVFzvZeTqKyZ+YRsbKd7NS89eYBt9NY
         2e5k4R6fYagh+bGZ3sdONbe2gFLDZsOT3Q9l/FyL8uZfxoEy3ixTormnw7NkzCU5Ruxj
         y42sIxC9dPXUijKJlLBo23eOVt0Wtw6LCe/orhtDcT4YTuX20NF1DKps6urNj5rC+CLc
         W9v+lteEnxXH3z83FAmYM2KPKWXymJI6ISq8k0tlbeXVAXj+2smCRyb4CZSjFcuFbpHw
         WkHw0cxOGC+QQddmQiazMdq6SMvqe+1z+8+J70x3vFhD81G8i83Hcdzxg/CYGN+4Y9HJ
         kK5A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791838663; x=1792443463; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jLix4JrWc+gaL1YtlKdXsZNF8UYItzc7REKQDH8C5y4=;
        b=Bbz16QiI9Ar3XCnJJS2neAbkOd1tzEK8qJMur6Va/i2SojzGri0Z/wTNMwdO0kbDDm
         JONh0CLLZJhp3l7V3dbmAhiPsSh+TfkDsuDw+tWbXGb6okvORkv5ccMQYwwTdefC1Uh5
         B8T85pvKrT3DTCkeFmw0HKAF/Kx7mqsXEw6o6nrT0XmTo+Ds/8PrDYvFI0oWA2p+l9oz
         LNtY+KPUlRTFSEbzn5dxe0YBvA5bvpRVdA3S3Mtx5k51shqQmRg4+SWmcjDJ+oZtB7cC
         E791JiFSd+XewQgw2D69Ugr1dCsZBKTw3XQMGT8rRj/PHtE18OABbAAzf6TCElUeDSyj
         Hc6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791838663; x=1792443463;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=jLix4JrWc+gaL1YtlKdXsZNF8UYItzc7REKQDH8C5y4=;
        b=Xvt4p2qgzAfNx3XzIB+gMIMDxAACF/0fpSUx5D3evR3qUJdbdCqwbRFbfkQU4R7VBi
         pRLUtmmlXTgz/GToJ5quU3eyYNibI9PEQZhYhNTUT8IpTNMn91ayOKyxdZyXRWhDwfZB
         8gKpBfQr6YkVqru4nh3e//5MHeaGG8vUw+Y6dEnZSSXfDUZlease4CNCv+h5olQj4fC6
         FPEYWcMvuchWnatpQkepmNMMOPzFDniaM3p8/KiRv7rQ63Q2B2eE3fyc1n9drjqcX5io
         Ras5ZwcoiZ9rtXbzzBGKRy7oVrKiuxqIJvvNJBl95GHAvERBcsV5Xg6BMLs85iSZF6vR
         +QuQ==
X-Forwarded-Encrypted: i=1; AKwUvBxeHV8jAkpHWZOofUInUWEVtqfe8RW817ieMsw5BKKWU2342OD11ojFbnhkQx/SkAJcJFlvMObcdg==@vger.kernel.org
X-Gm-Message-State: AFq9FYI1NtYIT7FDWJ/cmsqxP8CFwt2qIO7VKuAi4bfVaZCRXreGESAh
	0SCoBGJSFTEnMSafjUB2OwK7BhLMku2co4we+ek2KeVx1P+Ji/HvI/kAcAmidoAY1ASd6zcWOsN
	NQt8vmCvPkYesucB6EuKjTwr1s5Tph0E=
X-Gm-Gg: AYBFou3A/3G11VjdPgUWLm/Lrt5mCUq0yNSGIOAxxsBSl3pEiZG70Zvw5A8v+c36XLP
	XdUOhZ60f97LvSCgZuTWLjjvqBGbKgRQ8z5fbb6pVvAU07SvzVgErXh+hzh86hW6sgmKCmK6yHc
	NdH7QZDHFTWmUhfbhrDuLCIvbIptDCQKrHt2RfNAA3IRXyA/dqF0y9U5eE445y/PfDdcvNS3C32
	tgHQth1afKhefYlpb7G4JRRCIIRo6QPwMg9fdWjPx0ggsLBk8gZjixISidP8Kxc3o2oKPxha1ro
	ee+pOnJJVYlVzPsb9K07Zf4hGkOLXrOvBr2DO3st7RTHy+0xGid5Sn+pzQ==
X-Received: by 2002:a05:6512:12cf:b0:5bc:d0fd:8c13 with SMTP id
 2adb3069b0e04-5bcde6c99b0mr3562593e87.30.1791838662732; Mon, 12 Oct 2026
 13:57:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261009-sdm660-icc-sync-state-v1-1-77b8d2501cb2@gmail.com> <0ee83fd8-dcc2-4666-a864-de52fdef1c7f@oss.qualcomm.com>
In-Reply-To: <0ee83fd8-dcc2-4666-a864-de52fdef1c7f@oss.qualcomm.com>
From: Fabricio Akio <fabricioakio@gmail.com>
Date: Mon, 12 Oct 2026 17:57:05 -0300
X-Gm-Features: AclHuK9R2roF5QsBv8_V9u4Vazf51mZ_EeLjSM2qy9Ih7_PcYXeb3AMjJuQTvEI
Message-ID: <CANxzQdH196iquX=kKFm450W63E6=v9H1N-=OQygr64z90a_11Q@mail.gmail.com>
Subject: Re: [PATCH] interconnect: qcom: sdm660: Enable keep_alive and sync_state
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Georgi Djakov <djakov@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Marijn Suijten <marijn.suijten@somainline.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Alexey Minnekhanov <alexeymin@postmarketos.org>, Dmitry Baryshkov <lumag@kernel.org>, 
	Martin Botka <martin.botka@somainline.org>, linux-arm-msm@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> None should be necessary on 660, except on bus_0 / RPM_CNOC_PERIPH_CLK,
> which is not associated with any interconnect master on this platform
> (so it will actually get disabled through clock cleanup!)

I tested removing the keep_alives on a Moto X4 (SDM630), on the
sdm660-mainline 7.2 tree with this patch:

  keep_alive on    result
  ---------------  ------------------------------------
  none             resets during boot
  all but bimc     resets during boot
  all but mnoc     boots, powers off in the first suspend
  bimc and mnoc    boots, 10/10 suspends
  all five         boots, 2/2 suspends

So on payton those two seem required, and the other three not.

I also checked bus_0: it isn't disabled here, its active-only clock is
CLK_IS_CRITICAL at 19.2 MHz since your commit e1cd74b6dccb ("clk: qcom:
smd-rpm: Set XO rate and CLK_IS_CRITICAL on PCNoC"), and the RPM votes
logged on the device show it held at 19.2 MHz while the CPUs run.

Would a v2 with keep_alive on bimc and mnoc only look right to you?
