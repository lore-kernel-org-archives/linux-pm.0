Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD3C22FE0A
	for <linux-pm@vger.kernel.org>; Wed, 11 Mar 2026 02:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773196299; cv=none; b=b0MhBNJ8i6uHFcdo3crbFHvPneILRD77QhgLJT52v1EXvEtolRFIjrPKDQbbQRsR1utSC2NlwsRpxeOTB9UWXCBCeaI2fyRz4effPdi1a/zsRAyMq5WBYcBv+8vm3oA5kyjDfFYEb0uyDseS6minZ4n4TsPRoUaGhyot6Az+QUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773196299; c=relaxed/simple;
	bh=Z03M98zWigFP+44qUkERvggDlIvToobmoebeK/UHstM=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WXf2rkWQuOxVCop2np4imW9dIezwC48kAVg+kHV3zBSjbJlEV5dj2E3mbvJ0qaOWuGW9ENWwkIdfkuwZjwl7T7x2WAleFiBZFheQPQzNSr3DetTwRf8GONyvG1pVD6X5tF6A///Kp60ivOUMVY0f7ufLyXmxkEdGu0Z1FLimgR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mdmMt3LB; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mdmMt3LB"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-8cb38e86cf2so1409724185a.1
        for <linux-pm@vger.kernel.org>; Tue, 10 Mar 2026 19:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773196296; x=1773801096; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RYASA5o0ARek5BWoJ2TGPTOQANHoirb3AbtC/R8tQuA=;
        b=mdmMt3LBunPA/MJJTZlNIXogCk95vnBkSpC1MeDsk2Gtb3dcrPiOjE7LyhWC0u4VYA
         OdCI3i+G3QjclEPWhLHl/a0M6O01BXDyfz+ogybhweuB/dWJDWwFBmkMnCQ1UIAdLMny
         wVGTD29n99ueGHDXsLh3m7Eo/U756kPPlpE3xgidbqW/EAip9Wa+o1V9tG+AteMfJxfh
         MUCdLLP5Ay+m+uXwny9cO039rXNzRGAHtrap1RJdLZ7jPRUm90PR/0i0IU9RJv7QF99n
         GrAHU6zzJO2lZjsQKvZdtEDcosXsuHT++77k8sCq36R/3WtG1Z2zn845stYL6ezeYcqP
         xYjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773196296; x=1773801096;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RYASA5o0ARek5BWoJ2TGPTOQANHoirb3AbtC/R8tQuA=;
        b=b4UmfSG16az5shQDS9ti5gbO0IWhDFPAteexMdAUG3qV5NBWf/FrCUIp+tb5P2hWDl
         hj9xfXx8HW7MkwdJvbkXKACTMz5oahEU+QME3p5EZ45Ru3w1HyKGh7aWvHon+jUZOpIj
         R9xPuulZVe8XZib2hP1rqrZI5l/O+eyiOZVAQ1mwN9WcRES69ca/vBZ+MZ4XOB05by+M
         wKf3SaqTiqGE4H8Vogh6Rxc3KCsG0Re99WpdmEYbLwnmv6GZtQs60sal1ksUdUB7So/w
         RXDkpDEwnqS0jjBL796LTpi11nlvsdW2Y8GQ40RDXdRmFUmxqPntjb1oJTv1SB/ItS0R
         fgVw==
X-Forwarded-Encrypted: i=1; AJvYcCV5mcS2YIaDSz9WfvKgrO9IwV66J+3VaQ4fXwLM6jvobRkVqT5R5JodkmO+uEwmIdl8M1EjhPO8kA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxAgH50kwVj+7LEcIXMYqg9fBwkq4QEW/i4oEEkSFS2hu1Qd7zi
	eu51P5IV6Cm7FeCIxveWM3tkeY/yFM4Pap90HoB7i4NsYE4Dc0OQ0syC
X-Gm-Gg: ATEYQzzchPT8CrI632J+GcI0GvbXiEroYP1EYBFa+Vqisu0x4nHBm749kw7b5p+qaUI
	egXnv4NDO4xbklsf74D/8xanQVeW2l5fam32BtRBsyCU7VboIwPlfd7SYRnvkmOe2shUdMTDyMH
	oOT2NzK3Mj91SkMaDuBSFP9ouwRq2DwTNAL4N7tF02bU+7Q6ziEIAtZnaqLzjJBmUcSiVPsMHlg
	oPuJdutbreud4GL0KYn50n27c7yXucmbbIQrkQCUmQTV8zwvIBOHsrzH7aZxsYLRH69Rj7yT1XA
	lKwuF0dvpn/IYI14x+pUlAu9mqjrkfYkMYb262j4nMorLuSqH4uxff2/i/Bfr75/xyBIttGw2pm
	VdKvRs1SrZsa/vJD8Fsc188bV1NiNYNeEGmaxD+h+qgWZ0O4xGJDPtfWpxqiWLQR3pGZQGH4qAX
	z/YDNfWEqoMIP5QF7Tp8noPJXFYA==
X-Received: by 2002:a05:620a:4153:b0:8ca:305b:748e with SMTP id af79cd13be357-8cda1a5595fmr128197685a.57.1773196296096;
        Tue, 10 Mar 2026 19:31:36 -0700 (PDT)
Received: from localhost ([184.144.58.243])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cda2166a79sm45713885a.49.2026.03.10.19.31.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 19:31:35 -0700 (PDT)
Date: Tue, 10 Mar 2026 22:32:07 -0400
From: Richard Acayan <mailingradian@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Amit Kucheria <amitk@kernel.org>,
	Thara Gopinath <thara.gopinath@gmail.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v3 3/3] arm64: dts: qcom: sdm670: add thermal zones and
 thermal devices
Message-ID: <abDUJ4ymu-Pv7qnD@rdacayan>
References: <20260310002037.1863-1-mailingradian@gmail.com>
 <20260310002037.1863-4-mailingradian@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260310002037.1863-4-mailingradian@gmail.com>

On Mon, Mar 09, 2026 at 08:20:37PM -0400, Richard Acayan wrote:
> Add thermal zones to safeguard from overheating to high temperatures,
> along with the thermal sensors (TSENS) and CPU frequency limits (LMh).
> The temperatures are very high, but should still be safeguard for
> devices that do not specify their own thermal zones.
> 
> Signed-off-by: Richard Acayan <mailingradian@gmail.com>
> ---
(snip)
> @@ -2289,5 +2322,372 @@ cpufreq_hw: cpufreq@17d43000 {
>  
>  			#freq-domain-cells = <1>;
>  		};
> +
> +		lmh_cluster1: lmh@17d70800 {
> +			compatible = "qcom,sdm670-lmh", "qcom,sdm845-lmh";
> +			reg = <0 0x17d70800 0 0x400>;
> +			interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
> +			cpus = <&cpu6>;

This is not supported.

> +			qcom,lmh-temp-arm-millicelsius = <65000>;
> +			qcom,lmh-temp-low-millicelsius = <94500>;
> +			qcom,lmh-temp-high-millicelsius = <95000>;
> +			interrupt-controller;
> +			#interrupt-cells = <1>;
> +		};
> +
> +		lmh_cluster0: lmh@17d78800 {
> +			compatible = "qcom,sdm670-lmh", "qcom,sdm845-lmh";
> +			reg = <0 0x17d78800 0 0x400>;
> +			interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
> +			cpus = <&cpu0>;
> +			qcom,lmh-temp-arm-millicelsius = <65000>;
> +			qcom,lmh-temp-low-millicelsius = <94500>;
> +			qcom,lmh-temp-high-millicelsius = <95000>;
> +			interrupt-controller;
> +			#interrupt-cells = <1>;
> +		};
