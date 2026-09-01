Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0867535A3BF
	for <linux-pm@vger.kernel.org>; Tue,  1 Sep 2026 06:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788244171; cv=pass; b=IUfDbQ1arnn/Zo4Zfk6GyiqiqUz2SsqGywKp45FVAqnC9sGqqsjOhsdce39Amo08LuZsaAeqaxvN17wHJ9aBK0lYkrTCEbl069NTUrDDL9nNsY993eB7jsdLs5yvQ/ar0VPeRp+xVZzc28GUNsAM2A8T4OQmVTsKE5hnl7cQqMw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788244171; c=relaxed/simple;
	bh=K4gZl2mOhHoZykPR7kAcqsDmqgMqQEWtRL2LJIdoA/Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qJ0ES1Vnx46C1fD8EhpTYW//4NLXkTxI+o/Dd0zGgqhdHW8wDGSYW3z+xeqBp2nHLBWqpYEckD7kQ9GgCTzCTwaNUnxKFJCxiKII+1Umbe2r175u/c2FwO94O6ntEIrgJYo2zOGEuYG2i5GymXfVp5ME/dZauXm7rswCyXCvcGw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fo2YkDhp; arc=pass smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fo2YkDhp"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c255c58156bso781065166b.3
        for <linux-pm@vger.kernel.org>; Mon, 31 Aug 2026 23:29:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788244168; cv=none;
        d=google.com; s=arc-20260327;
        b=qAgO3ir5AWhcfWCZzhINVxpF6aa2CwUzhohb6Zq6CsfVuGF7kgpLgaRri2W0DxmrMa
         CkeTlQH4B7y9JGxNh6rKqFvoqnjZLzMD7ymvHwAAiKOboLVZf98I47D6K6oSKEIfDdx/
         1YvVufJVCH7JZFYa+O1Kzvba6Nmu9Z3aLtsId1kDzf6BEfG5RV8OCyyad8P1QaA2CVv/
         0YknR96qpy71iuoSLSuq2y9c1Ipgl4pAi5NaP8+SxFtRBU/DPj4XkUGUblJsfhPjrHEo
         Mz8yWUN1ydlb4+i1bfh1Fdiy0j8U2Ix8Bxc41UJToDHNomdDVS9q9xMrW1kTE0PB3h0b
         Q+rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=bEEZ7fL9N/fBrtWdluD5mbU6vgaXF6Tfc86ggJbNVK8=;
        fh=sVU6z2DWukOMI27qP5uDpyUet12/IyBU14fWV4n+xkE=;
        b=F3gxMIwel+ERHiwRFNkw9+OWE5vmZiKy0thIHobuCwDz6wG7doTZfpOpa5h3E5urfj
         TqMlaW36IQ8ooLJqSJqkbNq/5plHd094XMIkD0IwxRQwydU/1STF5n0GG4xi6M2s96mC
         HobGVprD4OXR8Hr8kSwsmm7SqlfyhrIzVTdn9flpgbEOArhjarnLwrPAsUZeHCwvSn/f
         LZmMFdSbYQmVUcy+OdqqPKTYTPaNCPXdKhER1apNW3HzrgoEVqVMpHmRe1X1KGjD6U8X
         lTVokc9b1cn4MSw/X1/kWUUubKgFyB/gIQnE94M0WkbwDLMzFfHOZVBbF1xclo4x9qLf
         HrTg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788244168; x=1788848968; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bEEZ7fL9N/fBrtWdluD5mbU6vgaXF6Tfc86ggJbNVK8=;
        b=fo2YkDhpZfxnKAqDT/bIy7kMg93snOkQDUV43O92bP0KQucf0Osu7oMJS8xxDHP0po
         l8n8P2OyJog9TnxTt81NEDyUHmfJNfcliJBUagjOMFxSzHS3ThrxqxkwvtQ0TnNrAgnK
         jggJtVqkFrof6Xxl7LcbB+3MTbyUUS+MvE/9L7xCgHNzENOW8FXaiQ8ZNwoIW1Xif7IR
         3kPnIImwhJ/gHGDpA4Zqess+K0herU91/6dvhXk/OY23YasMNDhMTcxgjMZUoX8J5nY2
         C+j05AhCZlMRPXoSS8kJTXsPrZKcKRw3WVRFRCvJIigMc6G1p0LMLFegwLrQPkaHlXrY
         ewgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788244168; x=1788848968;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=bEEZ7fL9N/fBrtWdluD5mbU6vgaXF6Tfc86ggJbNVK8=;
        b=dQzn4DeteVWnjg2zf5ddKXfDav4xHjybc583tPvI4jLlv80SG4gjYCH/tS4sIn5T1H
         5KYbRz7zCAu4dfFhHcV7efJjNcLMnTtZ53RU/KADdCvYnCLPQqND4pAvKQKp4mG9eVBz
         htFFCziuEf+CW5nJTQ868srNokyiYWOFTeWekl9Yf817iBkM8MGtBRLhe8J8iuT7j2Rj
         jEORrusk+RXCMo2cfNehKM7tPbV1Wcl57y/UQWwIel3KUmprxS0b6VI433lkhzbNcYsz
         71H9mI19yZ7/FR13OSMboDYCjZJVOY0gmMRC589rLKWD91DbBTHqr24YNVamY9rcE076
         lR1w==
X-Forwarded-Encrypted: i=1; AHgh+RoTUWeAZzLCU2jbHZTygzaGkZ4Z0YGS0nCplQrGiXxFAWJfg4+dA2G/6aNiSwNHuA6e7yo4MbAW9w==@vger.kernel.org
X-Gm-Message-State: AFuF++k61kSuay5CvaKvmTtX9STQ9mrA3CpDR55BZzKug3B3Ub8c+6+e
	RORLQmqfhdIzI769XZ1mPpmQEJgzEKoTTqmDoP8zl2PA+GhXhwa0ymgK1gqimT6VQq15P1xbEPE
	uLTDaMfOugLCVh3Gs9LUgfV9knH+9GnE=
X-Gm-Gg: AR+sD12BBnXFcMDGbVagV9SK9Y6mcwwBrUNUXubsudDaVQB5VEO8ipQe/ncSIclO4b4
	2vw6DxkzwdZbWiyNdMLjKfFbyXt9HxxCtSpl1+vR5ECs4t71/X86f9Veegh9zzmDrRvFQ6QvoPs
	odOsZki1J7Ki3gTljAlL8dXo1IFaSF6LmbJ9P8Tj6yFsNY9SEmyR2YDfOPEEDDZl7v2VBAq1QLi
	n7+yHJH1Lnta8s+6USjuAlHWfWkjZlYzI87cvB5bld7uERkHtiTdZjHVrWZwOFWyj+FAq1qg9MZ
	VHrmHxi/ah8kPyGkUDOtLJGjtwImevTTq9rukSMqAsk/+XvlkyhLn7r2YJpMpLxF+5KXkE/r+ec
	Arw==
X-Received: by 2002:a17:907:7b84:b0:c21:72b:dec0 with SMTP id
 a640c23a62f3a-c2556c61d62mr1936956666b.5.1788244168036; Mon, 31 Aug 2026
 23:29:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260824150156.1310-1-sreeshankar0910@gmail.com> <178822856275.1835959.3848131517961346933.b4-ty@kernel.org>
In-Reply-To: <178822856275.1835959.3848131517961346933.b4-ty@kernel.org>
From: Sreeshankar K <sreeshankar0910@gmail.com>
Date: Tue, 1 Sep 2026 11:59:21 +0530
X-Gm-Features: AcwNN1UlOPMwx9DB7E6Z2-eTZ4gj_ZRRlYulJwE9lf5s7b-4tAwIra4YOS7pijs
Message-ID: <CAA-+ukLy9CoENCEnQ0hHGzzHTw3d-aZZfT3H2o7x8_cmo9dkJA@mail.gmail.com>
Subject: Re: (subset) [PATCH v6 00/13] Add initial support for Qualcomm SM7250 SoC
To: Bjorn Andersson <andersson@kernel.org>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	mturquette@baylibre.com, sboyd@kernel.org, rafael@kernel.org, 
	viresh.kumar@linaro.org, konradybcio@kernel.org, tglx@kernel.org, 
	ulfh@kernel.org, bmasney@redhat.com, radu@rendec.net, 
	abel.vesa@oss.qualcomm.com, lpieralisi@kernel.org, 
	taniya.das@oss.qualcomm.com, danila@mainlining.org, davidwronek@gmail.com, 
	mani@kernel.org, robimarko@gmail.com, linux@gurudas.dev, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 1 Sept 2026 at 07:39, Bjorn Andersson <andersson@kernel.org> wrote:
>
>
> On Mon, 24 Aug 2026 15:01:43 +0000, Sreeshankar K wrote:
> > This patchset introduces foundational upstream support for the Qualcomm SM7250
> > SoC (internally codenamed Lito).
> >
> > SM7250 is an ARMv8.2-A platform manufactured on a 7nm process, featuring an
> > octa-core Kryo 475 CPU configuration (1x Prime Cortex-A76, 1x Gold Cortex-A76,
> > and 6x Silver Cortex-A55) and Adreno 620 GPU.
> >
> > [...]
>
> Applied, thanks!
>
> [09/13] dt-bindings: arm: cpus: Document Kryo 475 CPUs
>         commit: 1c8fe8863780705aba77893fade65f728e82b67a
>
> Best regards,
> --
> Bjorn Andersson <andersson@kernel.org>

Thanks,
Sreeshankar K
