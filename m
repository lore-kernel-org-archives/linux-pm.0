Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB99147799B
	for <linux-pm@vger.kernel.org>; Tue,  1 Sep 2026 09:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788254715; cv=none; b=WCLABlty+PnsBt5g+APXpkh2rn7hz61dVWprh5GBHi5bSgsV1LYTIKWBPMXfRkftvNXwodjsJoQprZWSyxXNMUE6rPnB2ThLr0LjbXDTNR9GdxA7gtDDdQHPKHTdmF9jtpqL8lHs5FIFJWutJ5tRGd0biFpOZZi40yvb5yb34bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788254715; c=relaxed/simple;
	bh=REU9wsPaGJNSTwmn511u8FyP6qTye5YD87sITI9m9ZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b6YM7gXANJG+xo26ZGQc9PLczxHF6dz392PtX62DOhplVRQRNIEJ4hRp6pDs6UzOoBKIwTzc3Uh7w1YH4wNj44ypsn6Ow+TljeL8+kF+oH98ZIPudNx1Fyvm2PunFgMUcrG+wZrB/jYbkGq0X58CY6Ltj77aCk0JrYzDhFfI7QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e8ZPY+wJ; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e8ZPY+wJ"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-cc1c3c90074so3898270a12.2
        for <linux-pm@vger.kernel.org>; Tue, 01 Sep 2026 02:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788254712; x=1788859512; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=z60FD1fUHm9+bC0HRYA7KQCUR9Tk0sZxFZNLgaVknjk=;
        b=e8ZPY+wJzu1SRJP5X72gehxlvrce2e53sW86p8Ph+67FMqMfUnTymMQed/5lGAILSb
         t6rFkJQIRg5nhoiUjV9dYYlgjZ8tPv2NS7QwubcCGIkgdw1QhFqtFE0mmGmV/wNP7NoZ
         vnJNwoJekJT8LnHsqH0hgyvughwpCLrC9nsBs+xVENF7SnIb3NUMZaLzrQ3rQyV/rgPU
         X3oh35k5RaZ6ie0udJIbY1d88HV3/dSIZswuTi1CVd79mRkDDfNkLTrt4MNdENQrgOld
         1LCwh6bvvtgnZtu3F40eoKPsU4pvXfuiaxqPAeresBY756B8a4kUgP3TBQ1/UsoJXkT0
         wGYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788254712; x=1788859512;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=z60FD1fUHm9+bC0HRYA7KQCUR9Tk0sZxFZNLgaVknjk=;
        b=PFATIuhILwRNR0J6pK1umgwBDqht01yYNJfATESdGS+lRsJraKUhf1g1Bpt9jxJVOI
         Wx/doGw1AVIVy/VrX1k5zfUD3EdyuLwPI3xrjc6FISXtdUebWcwh5B8E7cpA+AC6K0E6
         fwIy7PRozenoH08Xs0vh895NoRrOaE/oLJnKceLb+l/NkhqJphZ7lqeYPGpNsV5jnzUv
         e9ne7vd1At/RYhx/1z16A5HgjGhcan1g1ccGen2Sm5vwGaEcRqjSB+Ts1NFabSqUdip8
         wqmW9HINs/MGYH9yj7tIfhhN4Vz55xyetjR+unGa07yGCDR0Rn2H3n/vwoxzvYqBUtB+
         MsKw==
X-Forwarded-Encrypted: i=1; AKwUvBx0XArrjzxtIroxOHyK1ongd+18Y/o0AQhERD+qTZ+yIZm1tFKdCy3G/5XsswWgraX8uFmtqwjr6g==@vger.kernel.org
X-Gm-Message-State: AFuF++lBpH610hO4TG36g6kvTp1hKG+IRTheLoF+cHNJZjgT0nvqXxUH
	bA7oL1IW5cI8HeJvoUUiBQcbz9SjTvEjczCysyQw7513rLz02ko7ynW3
X-Gm-Gg: AYBFou2e9jfILZVsf6BVpU7tuV//3Bu3FI6LmPtVRfHNuikZbpHTsQp/0OuqF2lRyRf
	uN5/bU04ERNrgBGVfCTDBxGZQFmIKDHfLItHkwrQoAZ6/hXsJJcT37D8nPOd0mshleppcnGcpKZ
	8j5LI8j1tdkLWgDuQ//FXfV6fKe1s9h5Mm1TDIc/OE77hlaM8lfyEU+V1adgs5E9tyd1EsaXAkh
	T4qOMhGiAtZB0DHI7bbF5n3KWQZdVuViWHLQZhT2kQ/DOdLv4lu3410xaj+B4aGmtvxyrDQbl/B
	NvOnkt+7+quglJB5dJtfDXXtnacsv3y5ZYsFAIOLm0RNeHZC5GP+8mAN3XskYZgNUNZk83DWrA1
	hImUgzf9daV4ZNLtxyL4UwLrve8vmgRJFSRP+SmZ0d225uoTWnMqZj7Od/VEwukrv1rMI2zwL20
	yRnm63rbaAxXrLO/xe3iKE3yENxLfgFJR2RvELmFVIW+zKGquXjyh8Zge0Mx/SmOoUHeDnbDCHR
	jWGC4poctOr5ZXaS9/wAoA=
X-Received: by 2002:a17:90b:2f0f:b0:380:540:d499 with SMTP id 98e67ed59e1d1-396d0ed0023mr51208197a91.6.1788254712068;
        Tue, 01 Sep 2026 02:25:12 -0700 (PDT)
Received: from localhost.localdomain ([157.51.207.128])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-32b28ab0571sm30004560eec.4.2026.09.01.02.25.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 02:25:11 -0700 (PDT)
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
	tglx@kernel.org,
	ulfh@kernel.org
Cc: radu@rendec.net,
	abel.vesa@oss.qualcomm.com,
	taniya.das@oss.qualcomm.com,
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
Subject: [PATCH v9 00/12] Add initial support for Qualcomm SM7250 SoC
Date: Tue,  1 Sep 2026 09:24:35 +0000
Message-ID: <20260901092447.3028-1-sreeshankar0910@gmail.com>
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

Dependencies:
This patchset depends on the following patch:
> [PATCH] dt-bindings: clock: qcom,sm6375-gcc: Merge SM7150 into SM6375
  Link: https://lore.kernel.org/linux-arm-msm/20260817082457.64797-2-krzysztof.kozlowski@oss.qualcomm.com/T/#t

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
Drop applied patches
1) [09/13] dt-bindings: arm: cpus: Document Kryo 475 CPUs (commit: 1c8fe8863780705aba77893fade65f728e82b67a)
   Link: https://lore.kernel.org/linux-arm-msm/178822856275.1835959.3848131517961346933.b4-ty@kernel.org

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

Sreeshankar K (12):
  dt-bindings: arm: qcom,ids: Add SoC ID for SM7250
  soc: qcom: socinfo: Add SM7250 SoC ID
  dt-bindings: clock: Add SM7250 global clock controller
  clk: qcom: Add Global Clock Controller (GCC) driver for SM7250
  dt-bindings: clock: qcom,rpmhcc: Document RPMHCC compatible for SM7250
  clk: qcom: rpmh: Add SM7250 rpmh clocks
  dt-bindings: power: qcom,rpmhpd: Document RPMh power domain for SM7250
  pmdomain: qcom: rpmhpd: Add RPMh power domains for SM7250
  dt-bindings: firmware: qcom,scm: Document SM7250 SCM
  dt-bindings: interrupt-controller: qcom,pdc: Document SM7250 PDC
  dt-bindings: cpufreq: qcom-hw: Document SM7250 cpufreq hardware
  arm64: dts: qcom: Add SM7250 devicetree file

 .../bindings/clock/qcom,rpmhcc.yaml           |    1 +
 .../bindings/clock/qcom,sm6375-gcc.yaml       |    4 +-
 .../bindings/cpufreq/cpufreq-qcom-hw.yaml     |    1 +
 .../bindings/firmware/qcom,scm.yaml           |    1 +
 .../interrupt-controller/qcom,pdc.yaml        |    1 +
 .../devicetree/bindings/power/qcom,rpmpd.yaml |    1 +
 arch/arm64/boot/dts/qcom/sm7250.dtsi          |  771 ++++++
 drivers/clk/qcom/Kconfig                      |    9 +
 drivers/clk/qcom/Makefile                     |    1 +
 drivers/clk/qcom/clk-rpmh.c                   |   24 +
 drivers/clk/qcom/gcc-sm7250.c                 | 2275 +++++++++++++++++
 drivers/pmdomain/qcom/rpmhpd.c                |   19 +
 drivers/soc/qcom/socinfo.c                    |    1 +
 include/dt-bindings/arm/qcom,ids.h            |    1 +
 include/dt-bindings/clock/qcom,sm7250-gcc.h   |  163 ++
 15 files changed, 3272 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/boot/dts/qcom/sm7250.dtsi
 create mode 100644 drivers/clk/qcom/gcc-sm7250.c
 create mode 100644 include/dt-bindings/clock/qcom,sm7250-gcc.h

-- 
2.43.0

