Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793019482;
	b=jceYnnOAVM1SCYKwoYeJ/iyhGGJYLL5b0ljx2QNl3s/MvdMWOJ/LUnyoyVJ7SiDnJ8Fg
	 MT2WoCfbThFlwRHcoSyDUJARFMtIHQo55wXKq57/LtR1TL9yBnygZZpFHX5NJB8xkV21a
	 Gq/yO6vZfArjjBE8aEQsniIWzmtdjuHuCU4OUTr24dz0z8lq/WefAl/Ug18/r1Uny9Buz
	 MuCGpzP1adv7K63HdF25OVdQIQ8ZuKCYN2Y4Lm7x/x8MtGV5YAj2ts3kvztOSpgTcBWId
	 3/2iS/6Iv2fNMG8N+mZC8zPHVXkrXIH05AWdXDU7AiR4KrIhRN1LPMKgZT1ekV4Kz2Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793019482;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=t6GH884chvgzD9Ofd9SmMJ/+b4uyUbpGX7r6FVPRzJk=;
	b=MNQgb+lO/Q1yYKQgyeUBQDzyfuHoGzKq6azWBq1ja3NYAMDbi9xmAtsu5GJj7x+uUqJ1
	 FeKL0Gxz+h4VNNFOCpWOLk8YpSiNP3mkoW5jJsSeoYwSa81dj2qzdBgbBbG+qniiu+Nv1
	 3q5MJFMVjyPgoCFWJ4yvvIxZJ/9G2G9vTWtapcgv4F1b3vhJjTN6O6xW2eb0UHOlch0vA
	 2YI0NHHZlv+JAA78YAEIyIbCnvIiX2bCW8ft1Mues0bwtBA/bRLh8okHkuDtHAj9UMShf
	 oo/S5fkYVsTeatDjEofguBoQIUEgRE1q9T+0iE/3vTIXhQD0YbpPSsjr3PNx7AFk5DQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=VqO1lUQC;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.54
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80D7606A328
	for <linux-pm@vger.kernel.org>; Mon, 26 Oct 2026 12:58:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C80D7606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=VqO1lUQC
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c3f04e0e65fso431807466b.2
        for <linux-pm@vger.kernel.org>; Mon, 26 Oct 2026 05:58:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793019480; cv=none;
        d=google.com; s=arc-20260327;
        b=Wv+CqHajuWoibmk/waau37RKT7+VAF3gDxVZ/zQ/FG/p9GDbtoPuoX6Z021M9Qpwxk
         9bP9qnEWUggWbzFyzzAy27bUd1L4iI3K+iUgJksJZZ/xsBwitsmT12nuNTe9g386dJiS
         boM+aXq8PQsm09y04RWlqX3nPQmo1n+Q9PQav1eBvfWCtIixypGL/HnU91dslB2S6dAF
         t6y9xbmoUwfhSw0R7oHPv24H7JWlF1irtao+ztOSn6SGtelb63bUspMxtSzdd9ayJ7Hu
         IOXiBwfG5bKU9IcCw+xjCIhVJcx9UOcMfaSgzQsq+mSkbZdvqITahFK5clnPPOtpoxmM
         kb/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=t6GH884chvgzD9Ofd9SmMJ/+b4uyUbpGX7r6FVPRzJk=;
        fh=AsXGWo7fTLMDEBUNbh6lQXqExmZ5BvYIex2ydQ4krI8=;
        b=QClVmnYZ+25v+YX6GITYzeC/b3hyT1GMB2LX9Jg9P+ZXwi1IrNMDrkrn1ks0ZXnOee
         rxao+HgwLpVHh9VzBZmmwKPu7c9tSocelbAGOQeYQmirWc40JygVRdPGc7nWTGYegY65
         iO5h0u+qGrYhkjbwg8qh+daEUhBD5t1zcOVewx2JAneFaSR3Vf6X2KFGN+uMx9rlTlTx
         IHam7FqH91uhdrlxjb/dYKom6DPYANQdEUtIQf5jV8pM+Dw88KbGen9iPuOpELOFwkwE
         0h33ZTDTF+S3n2nU1wZAa6PyB4+PFoIG4B1rzLFNOb5hR433SY0lV310FYXhNNuU5Mkg
         z2jw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793019480; x=1793624280; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=t6GH884chvgzD9Ofd9SmMJ/+b4uyUbpGX7r6FVPRzJk=;
        b=VqO1lUQC4/ZB86Bob7PuaqandeKM0dkfftYDf5kB1TzT/vAYMZe3lWFJmSvZDNQ2p9
         sDs/pmOD9xySol00LCkT1+BYr+oRmPmkkXNiLVRP6PmngB72HdMm5g/SZzk+u05QZrCu
         dwTKE/BsTEwIbISZ1/SonNGe9z5faC+s6z1Jaw//IB41QqG1RqiHUDmeu26WlXOt7fbL
         m5pscN98Aazfrf2wgOXYqTbTd3iEaeou3IvdOMut0xwuS7UcIdRKxvYt+4f2c8tojo9g
         8aPAA+x+JKtNX97Dq/ubP+/3fbU7CMAUbo4Ix4cYJ0fz/o9rvSxc3VtFQJlOuo3W+3ok
         8StQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793019480; x=1793624280;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=t6GH884chvgzD9Ofd9SmMJ/+b4uyUbpGX7r6FVPRzJk=;
        b=qUxEkjGdi45yVLHnVtbTWz0ubynkbnIhkBiz9TG8iVaxTFHdWNok5MNjRMntEeFRbf
         y3cT7otsYVP0UGZLTd8etjNUbUdGZz79Riw9PZOvIRG7IA88nfo9XvyXxurMZvq/vZtk
         NgAde/kwhCv8owYUE9e1u9PXjU1QEdoICKmiyU5r8mFORMj47uyir2prcoJaDNULWETM
         qJvyWpi70PbEQZgABCQtHkJPYTSqAOh1NHufZq6S/cCugQfYZbBhnRsnEvztab1pYYDW
         elmM8q9usQnID5FcB2Dp82deTLYpP+lQgO21LHK750/4yx5A/uCxMSC57ARXxodsszbg
         bkkA==
X-Forwarded-Encrypted: i=1; AKwUvByq08XPI8mPTkm/YRBw7uQBVB6N9hzieVV9JTTCAEO5Od3fWDEafkQrj+m1uqTn3VnIQrxzA4LZhA==@vger.kernel.org
X-Gm-Message-State: AFq9FYJS+pAUAXejiZm/ucd/HUPVt1KfRoyJkecv7xPmpJTVsC1ggaEH
	GCug4pwEiRinoHQL77nRWf9oHl/H2/LK+kwi7k8sJvomn0o99oALTO6I2Qna8yl5kgrR05f36G/
	Q5J7z/LGhXEo4r7GeOkRK8hOg/JfYSds=
X-Gm-Gg: AYBFou2QR4fHej3HdBU6+h/+SLIsaajQnyEDnfVJXJ83kKcKAPYoNsvEpc84VcBnjkD
	zP6Z4b7RvwfhAuR9lVH5NHGNMjvpqRaNYg4lN1j/P58EgrNH8R76g8/BQOx2sAB34/UCp3Nx8x7
	V49iYaW9XmqYGr8aJQTUGuNMD0XB+aHXnBLsqiZRNkESuGBjjO0i1Ok+qGY24+gDaQ9YU0OF4YL
	C8oAZxT7zQ+yMTOhuEINfP9R3J7w/ho7Wk1xtQyqB9D+aECjeQSqyy6OC2IwfHy3Jj2Ml0g8538
	LJgdBtyTHc69hAPaQbWjiuYa7slwOI1NjhvEM94q9LXPR+KkmaenCBBjD/b8faeaqp/rk7rWWiO
	J90ZbAU6jrfmyeNo+u5nr+857sjeorbQQyNNEAXY1r1bFg+jJvLOMfYMvt5CUqeuElqrmH4Ivug
	U/cSoZkkJBwNuOlvCRTjLzzadsJs8=
X-Received: by 2002:a17:907:6e86:b0:c3f:c878:7c1d with SMTP id
 a640c23a62f3a-c46bddb3308mr817681666b.9.1793019479919; Mon, 26 Oct 2026
 05:57:59 -0700 (PDT)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261016042432.824-1-sreeshankar0910@gmail.com>
In-Reply-To: <20261016042432.824-1-sreeshankar0910@gmail.com>
From: Sreeshankar K <sreeshankar0910@gmail.com>
Date: Mon, 26 Oct 2026 18:27:48 +0530
X-Gm-Features: AclHuK-qVOdu5LbOqp6_F0580cdJ42kSYQZoFTTe2Es-FxZ1SlI0qmd8PhmgExM
Message-ID: <CAA-+ukL=H6W84__TtD2C5oxbRr7jgsDqOj=2KN4rMtJ6wBgc=g@mail.gmail.com>
Subject: Re: [PATCH v11 0/5] Add initial support for Qualcomm SM7250 SoC
To: andersson@kernel.org, sboyd@kernel.org, bmasney+clk@redhat.com, 
	jbrunet+clk@baylibre.com, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, rafael@kernel.org, viresh.kumar@linaro.org, 
	konradybcio@kernel.org
Cc: danila@mainlining.org, davidwronek@gmail.com, mani@kernel.org, 
	robimarko@gmail.com, linux@gurudas.dev, linux-arm-msm@vger.kernel.org, 
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 16 Oct 2026 at 09:57, Sreeshankar K <sreeshankar0910@gmail.com> wrote:
>
> This patchset introduces foundational upstream support for the Qualcomm SM7250
> SoC (internally codenamed Lito).
>
> SM7250 is an ARMv8.2-A platform manufactured on a 7nm process, featuring an
> octa-core Kryo 475 CPU configuration (1x Prime Cortex-A76, 1x Gold Cortex-A76,
> and 6x Silver Cortex-A55) and Adreno 620 GPU.
>
> This patchset is organized as follows:
> > Document relevant device tree bindings (SoC ID, Kryo 475 CPUs, SCM, PDC,
> RPMh clocks/power domains, GCC and cpufreq hardware).
> > Add driver support for SM7250 in socinfo, rpmh-clk, rpmhpd, and GCC.
> > Add the base SoC DTSI (sm7250.dtsi) defining the cpus, PSCI,
> interrupt controllers, clock providers, power domains, and reserved memory.
>
> >-----------------------------------------------------------------------------<
> Merged patches:
> dt-bindings: arm: qcom,ids: Add SoC ID for SM7250
> soc: qcom: socinfo: Add SM7250 SoC ID
> dt-bindings: clock: qcom,rpmhcc: Document RPMHCC compatible
> clk: qcom: rpmh: Add SM7250 rpmh clocks
> dt-bindings: power: qcom,rpmhpd: Document RPMh power domain for SM7250
> pmdomain: qcom: rpmhpd: Add RPMh power domains
> dt-bindings: arm: cpus: Document Kryo 475 CPUs
> dt-bindings: interrupt-controller: qcom,pdc: Document SM7250 PDC
>
> Pending patches:
> dt-bindings: clock: Add SM7250 global clock controller
> clk: qcom: Add Global Clock Controller (GCC) driver for SM7250
> dt-bindings: firmware: qcom,scm: Document SM7250 SCM
> dt-bindings: cpufreq: qcom-hw: Document SM7250 cpufreq hardware
> arm64: dts: qcom: Add SM7250 devicetree file
> >------------------------------------------------------------------------------<
>
> Changelog [v11]:
> [PATCH v11 2/5] clk: qcom: Add Global Clock Controller (GCC) driver
> > Drop hw_ctl clock branches
> > Populate default values for GDSCs
>
> Link [v10]: https://lore.kernel.org/linux-arm-msm/20261015051926.13752-1-sreeshankar0910@gmail.com/T/#t
> Changelog [v10]:
> [PATCH v10 2/6] clk: qcom: Add Global Clock Controller (GCC) driver
> > Update .halt_check and .ops are per the review.
>
> Link [v9]: https://lore.kernel.org/linux-arm-msm/20260901092447.3028-1-sreeshankar0910@gmail.com/T/#t
> Changelog [v9]:
> [PATCH v9 04/13]: clk: qcom: Add Global Clock Controller (GCC) driver for SM7250
> > Make all clk_init_data instances const across the driver.
>
> Link [v8]: https://lore.kernel.org/linux-arm-msm/20260901070717.20513-1-sreeshankar0910@gmail.com/T/#t
> Changelog [v8]:
> Same as v7. Resending the full patchset as v8 due to a transmission interruption during v7.
>
> Link [v7]: https://lore.kernel.org/linux-arm-msm/20260901064357.20055-1-sreeshankar0910@gmail.com/T/#t
> Changelog [v7]:
> [PATCH v7 04/13]: clk: qcom: Add Global Clock Controller (GCC) driver for SM7250
> > Fixed missing (struct device *dev) in gcc_sm7250_clk_regs_configure
>
> Link [v6]: https://lore.kernel.org/linux-arm-msm/20260824150156.1310-1-sreeshankar0910@gmail.com/T/#t
> Changelog [v6]:
> [PATCH v6 04/13]: clk: qcom: Add Global Clock Controller (GCC) driver for SM7250
> > Make all clk_init_data instances const across the driver.
>
> Link [v5]: https://lore.kernel.org/linux-arm-msm/20260824130437.2771-1-sreeshankar0910@gmail.com/T/#t
> Changelog [v5]:
> [PATCH v5 13/13]: arm64: dts: qcom: Add SM7250 devicetree file
> > Reformat multi-entry phandle lists (domain-idle-states) to '<&a>, <&b>'.
> > Reformat multi-entry tuples and string lists (qcom,pdc-ranges, qcom,tcs-config, reg-names)
>   to one item per line.
> > Enable QUPv3 wrapper globally by dropping 'status = "disabled"'.
> > Move compatible property to first.
> > Remove clock-frequency property for timer.
>
> Link [v4]: https://lore.kernel.org/linux-arm-msm/20260821154030.2514-1-sreeshankar0910@gmail.com/T/#t
> Changelog [v4]:
> [PATCH v4 04/13] clk: qcom: Add Global Clock Controller (GCC) driver for SM7250
> > Update .fw_name with .index
> [PATCH v4 13/13] arm64: dts: qcom: Add SM7250 devicetree file
> > Added missing capacity-dmips-mhz and dynamic-power-coefficient for cpu@300
> > Added power-domains for cpus and apps_rsc
>
> Link [v3]: https://lore.kernel.org/linux-arm-msm/20260821081125.4522-1-sreeshankar0910@gmail.com/T/#t
> Changelog [v3]:
> [PATCH v3 04/13] clk: qcom: Add Global Clock Controller (GCC) driver for SM7250
> > Updated the way of registering critical clocks.
> > Made some more clock critical.
>         GCC_VIDEO_XO_CLK
>         GCC_CAMERA_XO_CLK
>         GCC_DISP_XO_CLK
>         GCC_NPU_CFG_AHB_CLK
>         GCC_CPUSS_AHB_CLK
>         GCC_NPU_BWMON_CFG_AHB_CLK
>   These clocks are flagged as critical in gcc-lito.c
>
> Link [v2]: https://lore.kernel.org/linux-arm-msm/20260819152545.3934-1-sreeshankar0910@gmail.com/T/#t
> Changelog [v2]:
> [PATCH v2 12/13] dt-bindings: cpufreq: qcom-hw: Document SM7250 cpufreq hardware
> [PATCH v2 13/13] arm64: dts: qcom: Add SM7250 devicetree file
> > Added SM7250 cpufreq hardware
>
> Link [v1]: https://lore.kernel.org/linux-arm-msm/20260818080754.4362-1-sreeshankar0910@gmail.com/T/#t
>
> Sreeshankar K (5):
>   dt-bindings: clock: Add SM7250 global clock controller
>   clk: qcom: Add Global Clock Controller (GCC) driver for SM7250
>   dt-bindings: firmware: qcom,scm: Document SM7250 SCM
>   dt-bindings: cpufreq: qcom-hw: Document SM7250 cpufreq hardware
>   arm64: dts: qcom: Add SM7250 devicetree file
>
>  .../bindings/clock/qcom,sm6375-gcc.yaml       |    4 +-
>  .../bindings/cpufreq/cpufreq-qcom-hw.yaml     |    1 +
>  .../bindings/firmware/qcom,scm.yaml           |    1 +
>  arch/arm64/boot/dts/qcom/sm7250.dtsi          |  771 ++++++
>  drivers/clk/qcom/Kconfig                      |   10 +
>  drivers/clk/qcom/Makefile                     |    1 +
>  drivers/clk/qcom/gcc-sm7250.c                 | 2286 +++++++++++++++++
>  include/dt-bindings/clock/qcom,sm7250-gcc.h   |  163 ++
>  8 files changed, 3236 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm64/boot/dts/qcom/sm7250.dtsi
>  create mode 100644 drivers/clk/qcom/gcc-sm7250.c
>  create mode 100644 include/dt-bindings/clock/qcom,sm7250-gcc.h
>
> --
> 2.43.0
>

Hi everyone,

A friendly ping on this patchset. Please let me know if there are any
remaining concerns or if anything needs to be updated.

Thanks,
Sreeshankar K
