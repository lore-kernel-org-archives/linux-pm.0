Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3FA32DFA3A
	for <linux-pm@vger.kernel.org>; Fri, 16 Oct 2026 04:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792124840; cv=none; b=eQKFV67IBlYij1vpwiBg9XIxuTUBL4M1kVN6nWUA/xfA510FCtSIbHc01k1d3N+WG2X1XnZBd1Q0VO/SZhMKsC1y27oMQQWx1z0rWB2Bu0Wc0GAhqfKNSSu2kIt8zmgABRVhmwgKpCKzrtIR3o7B2xCVtLOLbBQD2yt0SqyRE8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792124840; c=relaxed/simple;
	bh=NPselX8jhTM98gzV932AP1M18hySEO6deIgAQViShos=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GWheFAhah0okFlyhrpQ0RHVljcC2zuAeHIiEPtZNqb0oiJIJ53LlMpBaKQon5/H7/JUxL3gxOgTcw0dguOI7zs+FiYqzr49HLsT9nDmPSP+EwmxbvOtB2/WkfWEJ2uZ7JN9h47xF/aat55qn/nV/zz5MnrTvJT/CN9RpOGIe8A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qr/PPGXy; arc=none smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qr/PPGXy"
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-1517bda04a0so4359996c88.0
        for <linux-pm@vger.kernel.org>; Thu, 15 Oct 2026 21:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792124836; x=1792729636; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=mntqcOgaEVA2dJqWvU6cdKK600RbvIE/Xn15gv5EFmo=;
        b=Qr/PPGXyGdsY4ei1n1QH9xOaY5j9sCBORfFnJp78jRw1Al9Be74YM8KSLX+Xq/HlF1
         J5XAiR545tYh2y7ZVTZeR+Zvqx5neJAdrX8kyrFcQno7HGrwTvRFLr0AgVE7M2LZYq2E
         0cZyCLN+gJ5mrvwqhPbtIIGthG/NYqAn2C8iEe5BZdLUd+9NUhXOSvS0AmdUygTTrvkL
         RhFbiPjJBY2IEQ9UWu1NKv9KmbwLu9Dm3Z2jSKLr3ZaEsIFvIUfhhPVX/Q8JmLWhCt1m
         svVWXuiNiC8sD2fLeftSnrM9htYxO0iLvc+OS1Io+JfMRBABJGEw1jbjdpini6oVocQF
         1Z8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792124836; x=1792729636;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mntqcOgaEVA2dJqWvU6cdKK600RbvIE/Xn15gv5EFmo=;
        b=pvIAuIWT6KwLNUj+iEvWr6guow4ClG6yccNtcpSiC6KgURt7w93T8LVbi6LT+Bhqhq
         uGjZ6UFDq39qIktDIZ6YBjLHuPrx1/n7ghraAX8z3vLiF9uYlYW2b8gL9KiOxYuo8GbR
         nLYRkdQclft4f+grs916ERkdEFlTMc2xiujiBR8re8aBJk5aBGO/I+uu/rpEfMvJ3+us
         mmlRHNhys1qvW+om/R94THt+saXX4gWSrZJnlKQ41tRpoxE46DDlEs2/2JmrVZ69JYUk
         lr6XAf9zGy3F3bH2FROovvXBV+YAik41mMOdaz9uWRS1dmFLI3wPHXbpxJU2zAPh7Cxh
         SLGg==
X-Forwarded-Encrypted: i=1; AKwUvBzCqyIVlPZq0wNRwCz8HXzpnXWJ3louWREL766C/RlODfRdi3mCJ2rzBUwlPdhzEILUGU3dSNNsrA==@vger.kernel.org
X-Gm-Message-State: AFq9FYInMyvlj737DX2LH/aBzQyEBgzj1QFu/e/a47QrAqFU+I44vAfv
	9X6GToHZq3p8dy9G1ME/1Pya2BS/y6dCKn4KvIOkkSuG6a8JJ5ghq5nU
X-Gm-Gg: AYBFou0235Q6s4egBRpBjYuR6Z2HndI/R6rAtu3NHmOy1QHcXwBTkDuDjmVG6/hQuj0
	q5i6ASYZovRO+Clp7T51T6SDFB/id1bnOUN3aNPCK/tm5KxDQhH+JfERAzxtCo4XUCkbEshpblA
	c5W/YhWiacnRAIIjH4tVAhXKwyeUbWOKtVcwC4oA0Lu3tELJlwG2EoGcHm8+j+Ebh1I2p4sbO4o
	9VnWISYgDL9PQvQ6RIUXg5HqXuK6tQlC0p9W0NTv6z1QmiPZJTBchfB+PT2cHh39x6RLHMvMRnX
	Abm2BakW0OvI/7TIVRZXBsSt4oBdD0Vhm65h7v3GOT12DO6GO343K5H88e98CKSXxz1PX4AGwxG
	o/lQ8dS67b4Y5tlTbFbCSiyDTg9v2o6iXMyIJshh1dCSyY2x+hfsJDUES8n8NkGpk/+VauSbAkh
	MSOG2n8PLibTFRVVcd7hY7fLkdUKf7R0aOLruimNHMS18hzDwEQ4QtSP915sEWerq1QDnZo+6OT
	uGgCyWqwfDUdk7AXxDWOlyvaBIgEG1yDH5g53UNwGFHrnZF5R14fKC5N3ME5MaL
X-Received: by 2002:a05:701b:4508:10b0:154:fa0b:6df1 with SMTP id a92af1059eb24-16a5e49d6c9mr25908560c88.37.1792124835685;
        Thu, 15 Oct 2026 21:27:15 -0700 (PDT)
Received: from localhost.localdomain ([152.58.201.32])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1831b75be5esm2644712c88.16.2026.10.15.21.27.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 21:27:15 -0700 (PDT)
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
	konradybcio@kernel.org
Cc: danila@mainlining.org,
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
Subject: [PATCH v11 0/5] Add initial support for Qualcomm SM7250 SoC
Date: Fri, 16 Oct 2026 04:24:27 +0000
Message-ID: <20261016042432.824-1-sreeshankar0910@gmail.com>
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

>-----------------------------------------------------------------------------<
Merged patches:
dt-bindings: arm: qcom,ids: Add SoC ID for SM7250
soc: qcom: socinfo: Add SM7250 SoC ID
dt-bindings: clock: qcom,rpmhcc: Document RPMHCC compatible
clk: qcom: rpmh: Add SM7250 rpmh clocks
dt-bindings: power: qcom,rpmhpd: Document RPMh power domain for SM7250
pmdomain: qcom: rpmhpd: Add RPMh power domains
dt-bindings: arm: cpus: Document Kryo 475 CPUs
dt-bindings: interrupt-controller: qcom,pdc: Document SM7250 PDC

Pending patches:
dt-bindings: clock: Add SM7250 global clock controller
clk: qcom: Add Global Clock Controller (GCC) driver for SM7250
dt-bindings: firmware: qcom,scm: Document SM7250 SCM
dt-bindings: cpufreq: qcom-hw: Document SM7250 cpufreq hardware
arm64: dts: qcom: Add SM7250 devicetree file
>------------------------------------------------------------------------------<

Changelog [v11]:
[PATCH v11 2/5] clk: qcom: Add Global Clock Controller (GCC) driver
> Drop hw_ctl clock branches
> Populate default values for GDSCs

Link [v10]: https://lore.kernel.org/linux-arm-msm/20261015051926.13752-1-sreeshankar0910@gmail.com/T/#t
Changelog [v10]:
[PATCH v10 2/6] clk: qcom: Add Global Clock Controller (GCC) driver
> Update .halt_check and .ops are per the review.

Link [v9]: https://lore.kernel.org/linux-arm-msm/20260901092447.3028-1-sreeshankar0910@gmail.com/T/#t
Changelog [v9]:
[PATCH v9 04/13]: clk: qcom: Add Global Clock Controller (GCC) driver for SM7250
> Make all clk_init_data instances const across the driver.

Link [v8]: https://lore.kernel.org/linux-arm-msm/20260901070717.20513-1-sreeshankar0910@gmail.com/T/#t
Changelog [v8]:
Same as v7. Resending the full patchset as v8 due to a transmission interruption during v7.

Link [v7]: https://lore.kernel.org/linux-arm-msm/20260901064357.20055-1-sreeshankar0910@gmail.com/T/#t
Changelog [v7]:
[PATCH v7 04/13]: clk: qcom: Add Global Clock Controller (GCC) driver for SM7250
> Fixed missing (struct device *dev) in gcc_sm7250_clk_regs_configure

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

Sreeshankar K (5):
  dt-bindings: clock: Add SM7250 global clock controller
  clk: qcom: Add Global Clock Controller (GCC) driver for SM7250
  dt-bindings: firmware: qcom,scm: Document SM7250 SCM
  dt-bindings: cpufreq: qcom-hw: Document SM7250 cpufreq hardware
  arm64: dts: qcom: Add SM7250 devicetree file

 .../bindings/clock/qcom,sm6375-gcc.yaml       |    4 +-
 .../bindings/cpufreq/cpufreq-qcom-hw.yaml     |    1 +
 .../bindings/firmware/qcom,scm.yaml           |    1 +
 arch/arm64/boot/dts/qcom/sm7250.dtsi          |  771 ++++++
 drivers/clk/qcom/Kconfig                      |   10 +
 drivers/clk/qcom/Makefile                     |    1 +
 drivers/clk/qcom/gcc-sm7250.c                 | 2286 +++++++++++++++++
 include/dt-bindings/clock/qcom,sm7250-gcc.h   |  163 ++
 8 files changed, 3236 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/boot/dts/qcom/sm7250.dtsi
 create mode 100644 drivers/clk/qcom/gcc-sm7250.c
 create mode 100644 include/dt-bindings/clock/qcom,sm7250-gcc.h

-- 
2.43.0

