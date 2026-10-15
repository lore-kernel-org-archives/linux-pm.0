Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394A53D969E
	for <linux-pm@vger.kernel.org>; Thu, 15 Oct 2026 05:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792041611; cv=none; b=au/ukCcacKj14RPV1OWrZy2Wiwco9EBqDIkRc7K5N3Y7+HIc/oQuhUqBFo9JJszqmerdMv15MekeQZ/GWciZ3gLiB2dkwobsE2CqW47+QvYvFqds4dvw6EEZY6HTNw+WYfMvqqHII0FZYC1zdQxBrO9gqU6a34OT63PPmDUuxXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792041611; c=relaxed/simple;
	bh=OQC25c1LEHFGfoH5Bm7niHLmtv+mEFBRonN2Ynsoado=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YYj5dEWeL0LRlUfgrqZSqzLCwVBIHA+xpVy8MGfApShfToY+hkH6Qx6HxbX+NKwOoVeuYYMfGp6wxdQ9WnjtBheLrvxK7H1e16BCNdYjvSQIdtbMQakJXN6IU7r+fSDjtV7M/8UOQfkIHY7mgVmHXISLiPMB/hJrP2EIGByCQQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WmrP26JT; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WmrP26JT"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-353804b591eso8598040eec.0
        for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2026 22:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792041609; x=1792646409; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ImTb0dV81wJLFRF03G06WWKr03Mr9OjsAdwghtSU7AI=;
        b=WmrP26JTIzB5r5T0bpYE7mFkJxi24XospsG96pmGqmTPrKKq0xChvT91knM9Ln0Mu7
         OVh/xwiSiCLRWyPqBOt3K6qWeonAwJw0TOS/stinGWNOkb4kQYv4u3LoprDgerPR2F6E
         mz+oVu8yJRW4xOoHo7D+s51pXhmJjFc/KkDeGWNaFyH26rWKo9IpM6EzVCdz6Sf+EBcF
         ZZKJT7+IipwxIYwbbUZlofKDvuRRS9YU0LmVJ3N3dERsaRT9tTb7ccoTE/DPZVEj0x+I
         70vnBL/QnAypjljdyaW/2q4Z6JcBPaN9uGKzaCzGBUrYQmN31f5VqiDHTlRDYSNwBqK/
         a5TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792041609; x=1792646409;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ImTb0dV81wJLFRF03G06WWKr03Mr9OjsAdwghtSU7AI=;
        b=EcX2+vza96B1HFniAyWPJ/J4TJr7UCWezFoQNTzd8rIcbfuJPc+s9VnmnqRhUfYgHJ
         Vt96Jex3bh9qrdKgSr+MuK4it6ghFbRPU1hL49yflMqV20hbANqU+XOYkmIROSJGyZta
         gTHkKQM/kjgFmzeu8b+B8JN3oF9SFDLoLHfFh5EcNCm9S7FP0dkLOwBGx8is4dAQr+9W
         ZrO6NbcqTavkMdtY5W4m1m04hBesUsbRbJN+ztV5wYfJt4U0YkJoDkKS5Pkb8gpLaDdN
         q+XX8rQlmYhOAClTwJ37ZRW+JgyCR4LSaZBDpmDhiGXb4cWma1ySgSH6jZWeScNjFS6w
         uOsA==
X-Forwarded-Encrypted: i=1; AKwUvBy0PoIVaSDKhwyO7pkpPYtbyYpW2DUD+novtJHjJUGXDsK05C1rRMnJ6pn9e4lg0oGrTNVH6/lqdA==@vger.kernel.org
X-Gm-Message-State: AFq9FYK2YsNO52Dy7HgxjtDMTHl6YRCdC767exJtvU4/hcuKc/G7Ogpe
	MqtzUPXw0Da4vko8oPmKr/lphdMe5bG1QWGXLSfZmQ+i2V24XcRXtPTe
X-Gm-Gg: AYBFou25PMStFsbOZONg31x9Th3FdX0e7Pl9QdikoVSqY1/Bhx/3Re7wNgOdnmwqQU4
	90JuuG+KKyzpLJespP1h6eQPpS82mkC6Ng/4qSTJJ22h64E4FG6jgqeIVPKhtUyGUYdhbcy6Fct
	2V+skgk6jM2bnWEwBCvw/XIbmtnujbFP51uY5nYK1qwG0XCURodd7eF/q5Ry/pW+dKtd6gDkRLp
	509n9NKBMqFzvuLCpuwy95U4hLyHMU4P9EzpssNbKm4M5J7Pr81eetJbuDUpM1Oov+wGG84bskE
	QJAC4r/ROoCt0+QM9tNWICjFv2/OHtQbVUdTj0mFxfhbBhbQeZdOI01j4kGxMke/XTf447wbo3S
	FIPcokCPY6BOt5vPC0Up4wwExwjyR3BpIPtmQfBqiOuWnDoK2w4GAChMAO/J5qyCRHemc3UWxxC
	h4D/dwpD37BMq/L30XOVVOcWBgGJSWZ+phX6DOJjSN8D769356YktAj1NgsVYghWNbOQwykFiHT
	NNSLanYvT891jGkx1fnd37xNeRedzDB1+HHucjqWkqqCqo/BKew8dk=
X-Received: by 2002:a05:693c:638e:20b0:351:7bdb:6eb1 with SMTP id 5a478bee46e88-3537e03ce72mr24074028eec.11.1792041609063;
        Wed, 14 Oct 2026 22:20:09 -0700 (PDT)
Received: from localhost.localdomain ([152.59.223.102])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-35de709d928sm12923112eec.25.2026.10.14.22.20.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 22:20:08 -0700 (PDT)
From: Sreeshankar K <sreeshankar0910@gmail.com>
To: andersson@kernel.org,
	sboyd@kernel.org,
	bmasney+clk@redhat.com,
	jbrunet+clk@baylibre.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	rafael@kernel.org,
	viresh.kumar@linaro.org,
	konradybcio@kernel.org,
	tglx@kernel.org
Cc: radu@rendec.net,
	danila@mainlining.org,
	davidwronek@gmail.com,
	mani@kernel.org,
	robimarko@gmail.com,
	linux@gurudas.dev,
	linux-arm-msm@vger.kernel.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Sreeshankar K <sreeshankar0910@gmail.com>
Subject: Add initial support for Qualcomm SM7250 SoC
Date: Thu, 15 Oct 2026 05:19:20 +0000
Message-ID: <20261015051926.13752-1-sreeshankar0910@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset introduces foundational upstream support for the Qualcomm SM7250
SoC (internally codenamed Lito).

SM7250 is an ARMv8.2-A platform manufactured on a 7nm process, featuring an
octa-core Kryo 475 CPU configuration (1x Prime Cortex-A76, 1x Gold Cortex-A76,
and 6x Silver Cortex-A55) and Adreno 620 GPU.

This patchset is organized as follows:
> Document relevant device tree bindings (SoC ID, Kryo 475 CPUs, SCM, PDC,
RPMh clocks/power domains, GCC and cpufreq hardware).
> Add driver support for SM7250 in socinfo, rpmh-clk, rpmhpd, and GCC.
> Add the base SoC DTSI (sm7250.dtsi) defining the cpus, PSCI,
interrupt controllers, clock providers, power domains, and reserved memory.

Changelog [v10]:
[PATCH v10 2/6] clk: qcom: Add Global Clock Controller (GCC) driver
> Update .halt_check and .ops are per the review.
  Link: https://lore.kernel.org/linux-arm-msm/1ea96c7d-102a-4261-a70e-ca0813490a02@oss.qualcomm.com

Link [v9]: https://lore.kernel.org/linux-arm-msm/20260901092447.3028-1-sreeshankar0910@gmail.com/T/#t
Changelog [v9]:
> [PATCH v9 04/13]: clk: qcom: Add Global Clock Controller (GCC) driver for SM7250
  Make all clk_init_data instances const across the driver.

Link [v8]: https://lore.kernel.org/linux-arm-msm/20260901070717.20513-1-sreeshankar0910@gmail.com/T/#t
Changelog [v8]:
Same as v7. Resending the full patchset as v8 due to a transmission interruption during v7.

Link [v7]: https://lore.kernel.org/linux-arm-msm/20260901064357.20055-1-sreeshankar0910@gmail.com/T/#t
Changelog [v7]:
[PATCH v7 04/13]: clk: qcom: Add Global Clock Controller (GCC) driver for SM7250
> Fixed missing (struct device *dev) in gcc_sm7250_clk_regs_configure
  Link: https://lore.kernel.org/linux-arm-msm/apYNXZ9TJEC6rVVf@baldur

Link [v6]: https://lore.kernel.org/linux-arm-msm/20260824150156.1310-1-sreeshankar0910@gmail.com/T/#t
Changelog [v6]:
[PATCH v6 04/13]: clk: qcom: Add Global Clock Controller (GCC) driver for SM7250
> Make all clk_init_data instances const across the driver.

Link [v5]: https://lore.kernel.org/linux-arm-msm/20260824130437.2771-1-sreeshankar0910@gmail.com/T/#t
Changelog [v5]:
[PATCH v5 13/13]: arm64: dts: qcom: Add SM7250 devicetree file
> Reformat multi-entry phandle lists (domain-idle-states) to '<&a>, <&b>'.
> Reformat multi-entry tuples and string lists (qcom,pdc-ranges, qcom,tcs-config, reg-names)
  to one item per line.
> Enable QUPv3 wrapper globally by dropping 'status = "disabled"'.
> Move compatible property to first.
> Remove clock-frequency property for timer.

Link [v4]: https://lore.kernel.org/linux-arm-msm/20260821154030.2514-1-sreeshankar0910@gmail.com/T/#t
Changelog [v4]:
[PATCH v4 04/13] clk: qcom: Add Global Clock Controller (GCC) driver for SM7250
> Update .fw_name with .index
[PATCH v4 13/13] arm64: dts: qcom: Add SM7250 devicetree file
> Added missing capacity-dmips-mhz and dynamic-power-coefficient for cpu@300
> Added power-domains for cpus and apps_rsc

Link [v3]: https://lore.kernel.org/linux-arm-msm/20260821081125.4522-1-sreeshankar0910@gmail.com/T/#t
Changelog [v3]:
[PATCH v3 04/13] clk: qcom: Add Global Clock Controller (GCC) driver for SM7250
> Updated the way of registering critical clocks.
> Made some more clock critical.
        GCC_VIDEO_XO_CLK
        GCC_CAMERA_XO_CLK
        GCC_DISP_XO_CLK
        GCC_NPU_CFG_AHB_CLK
        GCC_CPUSS_AHB_CLK
        GCC_NPU_BWMON_CFG_AHB_CLK
  These clocks are flagged as critical in gcc-lito.c

Link [v2]: https://lore.kernel.org/linux-arm-msm/20260819152545.3934-1-sreeshankar0910@gmail.com/T/#t
Changelog [v2]:
[PATCH v2 12/13] dt-bindings: cpufreq: qcom-hw: Document SM7250 cpufreq hardware
[PATCH v2 13/13] arm64: dts: qcom: Add SM7250 devicetree file
> Added SM7250 cpufreq hardware

Link [v1]: https://lore.kernel.org/linux-arm-msm/20260818080754.4362-1-sreeshankar0910@gmail.com/T/#t

Sreeshankar K (6):
  dt-bindings: clock: Add SM7250 global clock controller
  clk: qcom: Add Global Clock Controller (GCC) driver for SM7250
  dt-bindings: firmware: qcom,scm: Document SM7250 SCM
  dt-bindings: interrupt-controller: qcom,pdc: Document SM7250 PDC
  dt-bindings: cpufreq: qcom-hw: Document SM7250 cpufreq hardware
  arm64: dts: qcom: Add SM7250 devicetree file

 .../bindings/clock/qcom,sm6375-gcc.yaml       |    4 +-
 .../bindings/cpufreq/cpufreq-qcom-hw.yaml     |    1 +
 .../bindings/firmware/qcom,scm.yaml           |    1 +
 .../interrupt-controller/qcom,pdc.yaml        |    1 +
 arch/arm64/boot/dts/qcom/sm7250.dtsi          |  771 ++++++
 drivers/clk/qcom/Kconfig                      |    9 +
 drivers/clk/qcom/Makefile                     |    1 +
 drivers/clk/qcom/gcc-sm7250.c                 | 2358 +++++++++++++++++
 include/dt-bindings/clock/qcom,sm7250-gcc.h   |  167 ++
 9 files changed, 3312 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/boot/dts/qcom/sm7250.dtsi
 create mode 100644 drivers/clk/qcom/gcc-sm7250.c
 create mode 100644 include/dt-bindings/clock/qcom,sm7250-gcc.h

-- 
2.43.0

