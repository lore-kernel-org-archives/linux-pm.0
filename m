Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.218.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1794536860;
	b=XaIxJrJrr0RKumfbFmDGPQ89kpLRDbNypbsU/bj+mf/IQwtK9JpHsHX1d+mdEzyur0YI
	 mLpcrQM/bCED5adN5L5U6suhqI/IAe5xKSdN4slFevZ1lqkWTwPzaR0iGOKRaK/rgEa50
	 RV252FgD942VHQbjLTrhda+RO8gvY0s5OUZzh6HAojj2pX7Ve5CeMJJP42CSmuxrvFDEN
	 8A6AmR9I3KIHPdMrPPZ0qFkDZEvUX/q5r3LM2lgOvBEjSNk0FhqtTg3RzDBPB2kUTRuma
	 QVDzkGbGzmA22hlfiQhKRXdQKPQyyoJajUpyfBZq1tKzROoQukw5y9mfjkizv3de6EA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794536860;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=mhmgHqxT9q9D0dhD6vPj0pvXXso4EsLhMvW2R188fnU=;
	b=36AOpe5pTv+dpnWRaKEavLb959ioCMp+1kCMqm2Q/DvP6WL/C4va7U+iVx5e/8C7SacD
	 OnwKglY7LXrSIWkuWV0RXiMn78r4bQTy3RgW2ctFRU5ylgpmHDiB1XqWFoWEcbQFDoODd
	 qtKMw7ubkBv+Lfx66yzC6qQwuVJ38QTQbNcRc2jjBLrUM5C7uBv+JDWUYk9qWI7bUETIV
	 /NlDfHCfJi8la7SPRRwYBARuBEXQBR9z/VRaG7Osf+dm3aGl+BXxjBeRw5BPaakfwliF3
	 S8IBrg0+k42mK2r8DLy/r5428MFsrGIMmAmAXs4suI4QNMrFpmvxDuzcw59ZW2dS8nw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wi9X0uD2;
	arc=fail smtp.remote-ip=209.85.218.54
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5AD606A31C
	for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 02:27:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DB5AD606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wi9X0uD2
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c4d427836e9so64353766b.1
        for <linux-pm@vger.kernel.org>; Thu, 12 Nov 2026 18:27:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794536858; cv=none;
        d=google.com; s=arc-20260327;
        b=EUmo0NRHHbyAvrK942kiF1HtbwxWkG8OJ56OH9UviU59dhPwPkaWfdGtclWHrt2mEq
         v0M4vCqDe4PBGhBmCPo7/HEx9wMJi67FQCBMprec5R2Igk1mupPt0gs+ZZqPUJLYoOBl
         ZSTm5K/d3uFqzIRYWuaYyKSjtiCKmOa6RzGTRZdmevDqgZIuT7PsX5HgVQNWWT4AMkjy
         vaf/dwq0LkKEe56lgA9wKSTPq8UAoaop2kxhQiGMjjdbcYGalrc5jWRA12MHH/GUJFTb
         YvQCYtszCUNHJoosK+sKSPPRgOw7kkCRAqevSp/B5QP9XZBpBSdcQhIK5bKeUK9bUWR3
         sVkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=mhmgHqxT9q9D0dhD6vPj0pvXXso4EsLhMvW2R188fnU=;
        fh=ZWwT21gf0BFd1+1vaNZl3UcOhcqcjGSRTsH0P9vic1Q=;
        b=Ua8L2UQqGA6S+VDM7RbMR5ASi6GpzX0mY/+PUzbCrG5GpECfU3VAKx1OhuD8ECT2Gx
         7QSGpL9gWuMs6Ux5pw0KHvnMrFbnhTgpzpnkWactA99dvk2U9RqQJVHCGA+hM1NTklwF
         OFj/zJ0WAjyacDAGRNo3esAGwnTlV2wWq+gkFTTuJBygx3IZdn++ZiBzomSJFqNVXOj0
         vVE96bjqlaLR9BGr9YP0X+oJlrQVZljB9aHPXYWNntEkTKi4BYoNpeGc/n7uiOZ0NGAb
         aFl0lmN7dqgk+xw34BhG8hWGnZjWYQAvilo65V0m81zpZA6jNxXShC/JKQVWJwcQb8Ne
         DTog==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794536858; x=1795141658; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mhmgHqxT9q9D0dhD6vPj0pvXXso4EsLhMvW2R188fnU=;
        b=wi9X0uD23pyD1hwud2ZUTYw9RLw7zgv2HRQixNQf4/ghFgY7jliAhsEY3WdB5s8p+l
         5LniB4F4Cn/5YKoegW1i7RA91FP86bwpiHaCVfnZHvXRUMgzaL8qf+0w/PoXnwsA1TDW
         bHUK/q2+fSmCNCH3V4JwSCOGLLE8SocrEKSjFZzlihMEuShMuitJ8BRBCp7GJ1fEbbLg
         Piv2YNNY6UyEwojmjTB7RqDOtTGPPDQNrVjiyEbpNKw3iFkqSXn3sLLivRYfnwg90SaZ
         Bg2f0gcsIaEZUYt4FEF8riYyvgneE234ST27Me1UjA6kDF9eiKZOG0RqO18Kx6y776nv
         O6tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794536858; x=1795141658;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=mhmgHqxT9q9D0dhD6vPj0pvXXso4EsLhMvW2R188fnU=;
        b=iks09TkzWmOEvUJ7oNwFkkKo5+lFMNB5ByFv69D8LTSoNIrJAvYjM14iQcVRkg9MuA
         P3+bc0bEsf/X5/q7GZX15MBgW3Uq2WXc3M+G7FKfDR/QtIviOWoe/bvd8gGtwUFKxadG
         r2rTE7Y95fbJAtb0crJGRblGDbhCfNAbqn3kTOPXK7q4s1azivKofLMGlBEtibrQqNxW
         Tz8XPBdK0ZgT8TElbipaBRKc7Nx7OONPijenpzODYVIABUc1akBNqCzhXPyLWC+zYWRl
         UKYmU9zoNItgajjlrunS8yX9a7KO8AtjcSKcb/pJsD6nV2W+tcx0/Bxo3d1h2Omkc3NF
         07Dw==
X-Forwarded-Encrypted: i=1; AL+hErFMc7p886snS9CS1bvaXIML9hKxvUFg69H27ObJ+Go0Gto07vqM6qwYN0Y33ZP/KiA7ump8auf2Pg==@vger.kernel.org
X-Gm-Message-State: APuU4Z92VDZHQQ3GzTv+3b52DoAptDQxe6Av2DbRRdPoeeV02e2tzg5q
	b8PnUV2yomu0b4/tZreAPXpuGZLISvQcKbXflMIbnfwmIgQv36nwNRWoZXteojsfhj6bQY19eJv
	JsnZwCFZ7g0z6LWjdCS2zW6r3XqdbvlY=
X-Gm-Gg: AYBFou1RZNxRZp1v84fAm5GGaptWl8p3EsLv5nFujhqTQvF/ZhiH3oTZN6LbCmTuJnU
	HUmYojT/V0/TzjYUr89mc1G/GveNI11kW0qEPGpKTyFBjEd1z4sO4VcqfPRttAxGXRq2JYe6Zta
	fuB508v/pDb+MEEU8EaG6PzImLw00cnYCGbnMJyivnCnVI9zuyCfBt2PRPRfQLLnkZ5tmNuMZ0C
	EQpBNWDChyTreDmyYlo+IdQKgqUTsjbHVGEsr02eye/jaVAEc41G8hgh16/uluGyiRy/cV3+RzF
	fadyFlhhdYXbbKS6Qp0gLiS1la74kuUlbQf5/7/GnAGRZeTKRFlT/Ap3edo716R8z/K+MefFnH6
	IeDsG0HY2gsUtTlf3KJODgeoh0S9NpXD7K1X9eceCcy/JDqrQfTuc0C8IRI8ixTB4VM64
X-Received: by 2002:a17:907:3f18:b0:c4d:212a:192a with SMTP id
 a640c23a62f3a-c509642889emr75412566b.48.1794536858155; Thu, 12 Nov 2026
 18:27:38 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261106-sm7250-v14-0-7d167e993f9c@gmail.com>
In-Reply-To: <20261106-sm7250-v14-0-7d167e993f9c@gmail.com>
From: Sreeshankar K <sreeshankar0910@gmail.com>
Date: Fri, 13 Nov 2026 07:57:23 +0530
X-Gm-Features: AclHuK-5Jx0NaJBBJK_E2yE52SkSKOFAgAmYCFNDkDQigjVyP_umucpReQmSj6s
Message-ID: <CAA-+uk+=kkeeH-stjS_8=Kgw-m7rxxXoVR2S7UW-TP0gxEktEQ@mail.gmail.com>
Subject: Re: [PATCH v14 0/8] Add initial support for Qualcomm SM7250 SoC
To: Bjorn Andersson <andersson@kernel.org>, Abel Vesa <abelvesa@kernel.org>, 
	Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
	Jerome Brunet <jbrunet+clk@baylibre.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Taniya Das <taniya.das@oss.qualcomm.com>, Sreeshankar K <sreeshankar0910@gmail.com>, 
	Amit Kucheria <amitk@kernel.org>, Thara Gopinath <thara.gopinath@gmail.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
	Konrad Dybcio <konradybcio@kernel.org>, Robert Marko <robimarko@gmail.com>, 
	Guru Das Srinagesh <linux@gurudas.dev>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, 
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 6 Nov 2026 at 20:45, Sreeshankar K <sreeshankar0910@gmail.com> wrote:
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
> thermal/qcom/lmh: Switch to match data for SoC CPU-to-node mappings
> dt-bindings: thermal: lmh: Document SM7250 LMh
> thermal/qcom/lmh: Add support for Qualcomm SM7250
> dt-bindings: firmware: qcom,scm: Document SM7250 SCM
> dt-bindings: cpufreq: qcom-hw: Document SM7250 cpufreq hardware
> arm64: dts: qcom: Add SM7250 devicetree file
> >------------------------------------------------------------------------------<
>
> Changelog [v14]:
> Fixed various issue found from Sashiko's review, Link: https://sashiko.dev/#/patchset/20261104-master-v13-0-355b65c6f764%40gmail.com
>
> Link [v13]: https://lore.kernel.org/linux-arm-msm/20261104-master-v13-0-355b65c6f764@gmail.com/t/#t
> Changelog [v13]:
> Fixed various issue found from Sashiko's review, Link: https://sashiko.dev/#/patchset/20261104-master-v12-0-57fbe9eef978%40gmail.com
> [PATCH v13 3/8] thermal/qcom/lmh: Switch to match data for SoC CPU-to-node mappings
> > Switch to match data mapping instead of hardcoded 4-4 cpu configuration.
> [PATCH v13 5/8] thermal/qcom/lmh: Add support for Qualcomm SM7250
> > Add 6-2 cpu configuration LMh support for SM7250 SoC.
> [PATCH v13 8/8] arm64: dts: qcom: Add SM7250 devicetree file
> > Place the nodes in acesending order.
>
> Link [v12]: https://lore.kernel.org/linux-arm-msm/20261104-master-v12-0-57fbe9eef978@gmail.com/T/#t
> Changelog [v12]:
> [PATCH v12 1/6] dt-bindings: clock: Add SM7250 global clock controller
> > Move dt-binding definition to qcom,gcc-sm8250.yaml. The device tree
> schema of SM7250 matches with SM8250 for clock-controller node.
> [PATCH v12 5/6] dt-bindings: thermal: lmh: Document SM7250 LMh
> > Add LMh compatible.
> [PATCH v12 6/6] arm64: dts: qcom: Add SM7250 devicetree file
> > Remove cluster wise sorting of cpus.
> > Add LMh node.
>
> Link [RESEND v11]: https://lore.kernel.org/linux-arm-msm/20261029-master-v11-0-2c29e382162c@gmail.com/T/#t
> Link [v11]: https://lore.kernel.org/linux-arm-msm/20261016042432.824-1-sreeshankar0910@gmail.com/T/#t
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
> ---
> Sreeshankar K (8):
>       dt-bindings: clock: Add SM7250 global clock controller
>       clk: qcom: Add Global Clock Controller (GCC) driver for SM7250
>       thermal/qcom/lmh: Switch to match data for SoC CPU-to-node mappings
>       dt-bindings: thermal: lmh: Document SM7250 LMh
>       thermal/qcom/lmh: Add support for Qualcomm SM7250
>       dt-bindings: firmware: qcom,scm: Document SM7250 SCM
>       dt-bindings: cpufreq: qcom-hw: Document SM7250 cpufreq hardware
>       arm64: dts: qcom: Add SM7250 devicetree file
>
>  .../devicetree/bindings/clock/qcom,gcc-sm8250.yaml |   13 +-
>  .../bindings/cpufreq/cpufreq-qcom-hw.yaml          |    2 +
>  .../devicetree/bindings/firmware/qcom,scm.yaml     |    1 +
>  .../devicetree/bindings/thermal/qcom-lmh.yaml      |    1 +
>  arch/arm64/boot/dts/qcom/sm7250.dtsi               |  803 +++++++
>  drivers/clk/qcom/Kconfig                           |   10 +
>  drivers/clk/qcom/Makefile                          |    1 +
>  drivers/clk/qcom/gcc-sm7250.c                      | 2278 ++++++++++++++++++++
>  drivers/thermal/qcom/lmh.c                         |   84 +-
>  include/dt-bindings/clock/qcom,gcc-sm7250.h        |  163 ++
>  10 files changed, 3332 insertions(+), 24 deletions(-)
> ---
> base-commit: f66469d9905b39d2c260a15d7d6db450f4db67c1
> change-id: 20261106-sm7250-e9ced14be130
>
> Best regards,
> --
> Sreeshankar K <sreeshankar0910@gmail.com>
>


Hi everyone,

A friendly ping on this patchset. Please let me know if there are any
remaining concerns or if anything needs to be updated.

Thanks,
Sreeshankar K
