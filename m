Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A02D46D559
	for <linux-pm@vger.kernel.org>; Tue,  1 Sep 2026 16:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788279732; cv=pass; b=MccvYxs5mLaHZ42rxKryy66UNpuXlTj/JmCzE0xZZTCM2/AkWLZn3nqoYaw1C6LPx5rI7n0eAXdi7SroUTnKpU1DpzPVxi+oIU2ld65jFKwkp0Np6ABQC6aC3O/r/unoysztOp9TDSUYEF5aBArJyDN58fmZqYIiZjFAIvGEfvY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788279732; c=relaxed/simple;
	bh=Zh9Qo22DVdgyIWE9/JgEgDmjV2v+axogH4c+ynR+9BY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=brf66rXj26MkXFr7lkuHcI4Ht4v5pvPuIiRAwWW1rvpbRddS9AgYaRxbq6rX7i2H6k2WMR2xXO8ACOBcQQi58BoN1M7ojFyyXruuHQt4cOf7KrqZn6f0+o21p1EbmxrxSRg3eQrJCiGrGIyuJgnWhH6Sg4aBf1d46IPiwjdsv9E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rVrFmLqc; arc=pass smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rVrFmLqc"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c250c6a6a9aso786660066b.1
        for <linux-pm@vger.kernel.org>; Tue, 01 Sep 2026 09:22:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788279729; cv=none;
        d=google.com; s=arc-20260327;
        b=IlsmbZllKOkROD0vJfJC0oiXkQftTIbnVgizidO0UX32V5nPKPh6iz8f22Lrqyg2kL
         PEogKYwmGkIJyqVHZkuY0/8wGUWPPNYn7dcPt8osH3o25qBlap9b7pCLOzfEwK5BJjr5
         gsdkLbay6aNqB5fg7Jnr3znt3n+EsQeeAFy+WYeJohjyHEVOw29JyflfZYsRxyQTvmiu
         cI+L9ySjbJBMlZKaYX1nj9aFS/Xjs3RZYNEBdEV/0hWTsPMGep5H2EZ5ff1QfaqJK2YQ
         Ex+it5vDJHmm8ONMd1EB44aW9svJRszM380qSrkSTqtAfRMfKp5GL0wXZ1QcQJmcdWn5
         m4Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tDsSPiNh2VRclC95pMtLDgKaEvcqJRxEZ4xEtdWkdQg=;
        fh=09CUwaGzotyE/1zmo8Z3mp/Yz6YagbgouHQBtIPRg0E=;
        b=Izc8uxx2jnZsdPrQzHEp8jvu4qUaIhDAcEDwW6XFJWeNMEzsHHQKStyY8KuS2U+W3q
         Nuaqk29uPcA+3FxwjukbEoqARgF6BqDedkMjk+kJKu3ZLJQNYYQWFc4aTdtJUow5Z9Fa
         wze4CV99bcM3ZpL4e2DsTzRXtBYlkbBLPIsQuFR3s2jvyFz/WsGlYSrkbGLJmbOLfFvf
         S3SYUD2WaP1aM0cbrAr59ZmJpEbXKxpJO17UXADZXset+BjpRWnfOyA9lRKogFBwsoWK
         srxA8wF2ip6diZZqiTQu3uXnT3sESbu+U+o+hbA2RsVL4Hr/MVcTbsBF96ik1/UGdvS5
         AYPQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788279729; x=1788884529; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tDsSPiNh2VRclC95pMtLDgKaEvcqJRxEZ4xEtdWkdQg=;
        b=rVrFmLqcP/25rlRoRXtjiedV7T4N4hODM2cU6Ep1ojhMUJDRoEyu/7YGgTeF6sfrfw
         2ihIUl6g6LSTR59t2HrqEEeBpT/JdkSyWio265iHlpmFu3UPy8Lt4X4VjxsO3w24ZrTY
         2w8AMtpbh8k/PGr1huQsXYbENZtS29q/7dQ8FWqheoyWfYrChkGWMGWGJj2gSAdwhKiF
         TjfJ8/1VtG50+CBNY9umIUarJqMywld3MHG0ECsWY70eYtgcp4jDHg+lZUVglRPjO6aJ
         ktlbJ1SVHw9TdZkIm06pDrhx+m05zs2LGDURPL76lXdUDXSSEen1n9wAoa/ap71VPymu
         eIlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788279729; x=1788884529;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tDsSPiNh2VRclC95pMtLDgKaEvcqJRxEZ4xEtdWkdQg=;
        b=CWN6GSSHyYCdiSragAO3RgxD82g17Tp2n4tYNIhjGCb4JTSZtS6NcBcTnwr//R3A+s
         +76rYcobOQXD/1M9YdFtRk/aLzVvH4mKJNahl3OGFOnrfb7tHdaW5rUNkT3jjkHWG99w
         oDeq+IvB6DogZB3hySLJRBylY0qKN9glxJoz8KuoECK4la/ozTEvnaILcL1iRLjEGesq
         INSutnN5a2jMueTTBTKKRnCO2xBTHDavjuwNeEkj9EJGlh7kKWOkRK9t2IhcrK8wKv38
         zN0a4ZEBDgLw7srRrE05XYO1M1PYkS3Lr84i0syHnQeHcEnXdDXV5c4hO0BX0UY4WN9S
         unCA==
X-Forwarded-Encrypted: i=1; AHgh+RopTsGuykPPaZHfCS6Tv8b8FWR2jYmufN8VhlNRisym5uv+ytEEgrXmSK6w9uD/2Zfu7qPan15s4g==@vger.kernel.org
X-Gm-Message-State: AFuF++mNWze1SPQErrzVDKpnpiBGvlyETsba1M7SMOi53b5Eo5dNpvHt
	JOjj3T0Bk8jV4eX5JuBVwuNgzJ5IUciMDExjITnQYi6AYuDO6MPpff0QlLhcILpyl1yHQwsN8PL
	9yEr1pX2/Rt8d3x3XJBJRXG5pQduMI5c=
X-Gm-Gg: AR+sD13gtukayVCweaqs+rKwDejHMi65iWYuydnwxVLrOGIKuwLOmyzxp6+mfa13sNQ
	BqzRM9fRuPWDp7oyFKpVjBjchz3wghwaSTDtDHap+J2xBIpDOsEGYcnh54tuFzLK5T3D5HXhDIk
	1ZrbFjL2CGDYtc426fp8+zSEHnmhRLK9RUGCvJux0m6FDsoIwAqWu+nx8gQ5CbGEwPTIz7Xmb44
	07WFzOiju+SOXz2gF6QW/bpWC968vpFXURVWFJnc7s05bvW/kf5YlI1aFme8CkUELRJ5P8d+VdV
	CdJ1qnFj+0mP3cXSzsJxuPGzxQtoA4ZkXl1Aw3WsIZ32ISyoIyS77vjXbtJRUBomadJw8dH1nOZ
	bbFSh4LdGp3Ot1oqQGv/WtOdZhQwMV9IGZ+g=
X-Received: by 2002:a17:906:c108:b0:c25:c979:e76a with SMTP id
 a640c23a62f3a-c25c979e7fdmr216147466b.22.1788279729382; Tue, 01 Sep 2026
 09:22:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260901092447.3028-1-sreeshankar0910@gmail.com> <CAPx+jO8XfaAJzjrO1uL5=0hadRLGtZsvVz7c-9P-+NBFwa-2Kg@mail.gmail.com>
In-Reply-To: <CAPx+jO8XfaAJzjrO1uL5=0hadRLGtZsvVz7c-9P-+NBFwa-2Kg@mail.gmail.com>
From: Sreeshankar K <sreeshankar0910@gmail.com>
Date: Tue, 1 Sep 2026 21:51:57 +0530
X-Gm-Features: AcwNN1UgmlzLO2QtgDmTIhpoG6ElFAFHl1rN8oIvI-bmMKMW8f6_U29Z1lRdz4I
Message-ID: <CAA-+ukLdb_98Fx8PCNesvg_-4BmCcU3jxy8QTL1-a46MCJu2ZQ@mail.gmail.com>
Subject: Re: [PATCH v9 00/12] Add initial support for Qualcomm SM7250 SoC
To: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Cc: andersson@kernel.org, sboyd@kernel.org, bmasney+clk@redhat.com, 
	jbrunet+clk@baylibre.com, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, rafael@kernel.org, viresh.kumar@linaro.org, 
	konradybcio@kernel.org, tglx@kernel.org, ulfh@kernel.org, radu@rendec.net, 
	abel.vesa@oss.qualcomm.com, taniya.das@oss.qualcomm.com, 
	danila@mainlining.org, davidwronek@gmail.com, mani@kernel.org, 
	robimarko@gmail.com, linux@gurudas.dev, linux-arm-msm@vger.kernel.org, 
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 1 Sept 2026 at 21:16, Ulf Hansson <ulf.hansson@oss.qualcomm.com> wr=
ote:
>
> On Tue, Sep 1, 2026 at 11:25=E2=80=AFAM Sreeshankar K <sreeshankar0910@gm=
ail.com> wrote:
> >
> > This patchset introduces foundational upstream support for the Qualcomm=
 SM7250
> > SoC (internally codenamed Lito).
> >
> > SM7250 is an ARMv8.2-A platform manufactured on a 7nm process, featurin=
g an
> > octa-core Kryo 475 CPU configuration (1x Prime Cortex-A76, 1x Gold Cort=
ex-A76,
> > and 6x Silver Cortex-A55) and Adreno 620 GPU.
> >
> > This patchset is organized as follows:
> > > Document relevant device tree bindings (SoC ID, Kryo 475 CPUs, SCM, P=
DC,
> > RPMh clocks/power domains, GCC and cpufreq hardware).
> > > Add driver support for SM7250 in socinfo, rpmh-clk, rpmhpd, and GCC.
> > > Add the base SoC DTSI (sm7250.dtsi) defining the cpus, PSCI,
> > interrupt controllers, clock providers, power domains, and reserved mem=
ory.
> >
> > Dependencies:
> > This patchset depends on the following patch:
> > > [PATCH] dt-bindings: clock: qcom,sm6375-gcc: Merge SM7150 into SM6375
> >   Link: https://lore.kernel.org/linux-arm-msm/20260817082457.64797-2-kr=
zysztof.kozlowski@oss.qualcomm.com/T/#t
> >
> > Changelog [v9]:
> > > [PATCH v9 04/13]: clk: qcom: Add Global Clock Controller (GCC) driver=
 for SM7250
> >   Make all clk_init_data instances const across the driver.
> >
>
> [...]
>
> Patch 7 and 8 applied for next, thanks!
>
> Kind regards
> Uffe

Thanks,
Sreeshankar K
