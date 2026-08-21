Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CDDD3B05BC
	for <linux-pm@vger.kernel.org>; Fri, 21 Aug 2026 08:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787299915; cv=none; b=Tv2yEeZ0NN1o4+n112+HotpAl/Iami0Qnzvy6nJhXjZEh6sX9v6UZrW8mQiQZox2DDh9f+645GsggVFdCM+SYXhv1arfigfvbVRoa4c004rJCrSa4WjAiUnLJpxOBsVnDv2/gi9budEEz950g6gJqQdWt1IwQ3Q+GGc3ASCmh4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787299915; c=relaxed/simple;
	bh=SYh8JVjyrgiYGMhi3isk6b1wRA3skDP673AgZxWg3b8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ftAaspBSpigGz6xlJ1HwLuz6LIZKjR1Oz+99hViHL55pSgPucRcMgaefOv8vS1pAa41t6L/OPz4JOaPD4ppJLlTsjWQ1dweu4wMTm7CEFx/M35XEf0dQiTk+iPkQpLh7eXIStu9CreHFHeQoaAWPoOAsSEvvWbuggDYSF7XVF0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DngY1SOK; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DngY1SOK"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-cc11a905ba5so541619a12.2
        for <linux-pm@vger.kernel.org>; Fri, 21 Aug 2026 01:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787299913; x=1787904713; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=hgK4vPUxcbiUBUoyhR1t55G5/yt5ox/a4is866kaVjE=;
        b=DngY1SOK9yu7crPzhG0VC5Q5i+bxpDrZIKRT+2E/QrvdtqQo8aMY+07EOZ4WBvEs9z
         QXvWV5qjkndiSpsr+8IEb7LogdmroOMTT2ZKPixuDTWjDwKeYvA7VnheEveJvEcY2o0v
         h4m0qIzhDr7TNQ1nRuWbpVUSr/jMdzAhm+sZju0lsnFw+3+8UvGdGNCjQQsTK+DnPqkk
         rzzx9/BWx75aGvdyTyQtKB43hunD9+zuMzjInmU8zu1/UFi85icg6ZTPPfm3ZcmpfAfm
         gvZ4mNYi205PmZkVgdLynOCk0iWJjRI9xwa3qvm3cxub5hlL1W+izniL3srFCuA2d+Rl
         vl4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787299913; x=1787904713;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hgK4vPUxcbiUBUoyhR1t55G5/yt5ox/a4is866kaVjE=;
        b=eTP5Km0rAC7iKQWXsiqnVtjysDm/W56CzpoypDx/51e95T38AF/2RtTTFrsY2uEPBR
         Nwx9e9KG5ObmsxErN7y/GUYu1F0ITahrRmzjTa+bOmohH+cOmy4qtsDy65to/7ZJgnMQ
         QiqC38MrIMnA23/cugvzKMfX0FwzwyqicN4ulXl8R+6zlnqQhUUIR1fYLJm54b3cEXmF
         piOVoS3Rz+feXWaVXnDevo5w+sTZWcmF3PAL/roBJZUHuRLawk9JRtPgD1CYtl86HoQC
         zjy0IOX/SmPumt/A3+drXSN0xxlrTIFP5zoUDv94LQOdoO3Ic9P8zMP84slQOYryu871
         fiHw==
X-Forwarded-Encrypted: i=1; AHgh+RpdedGHGKCjWb81mFPj76hXEAfH7ZxpTbdeE5eDZgx7KhrsaI1psZxZlWn98DBdIT9CSqjyP/M37w==@vger.kernel.org
X-Gm-Message-State: AFuF++mhCWo2GIEERo8R8gB6CRiGoWRlnuzOKAq7a2a96o7vRy3keh+Y
	oMsoBQnKtv6R3uNMbu7fjZR6Lz1gPAtM/VayusVJXn2YjHGxjo1ijyuv
X-Gm-Gg: AR+sD10kQbQ23NH30kO8dmaG7ciFKJekEGS/RbHv4UdEHr0j7TR7IB/I7ZC28OsaG4J
	U46uVoEQf+KeLgev7PgJ4aA5xD+ZQmwSsCft1mOdLjh8OHWUpxTQfAagcuWHl4JbCZVBoyVyyi0
	cMoA5xU0uvW2kKcBS0H2mSRGX+8cMd3zrevBxXNtIt6DkKpR7FbBVx5NTEO3GkBa7HXQ4Ns2Rz2
	V/ln3bbgPZmvFEgFG+xtF0VIPPXlUguQD0lhSPtX+Ucv/z8B3Amp9y/u5SHI/Aci90mrQuQbMh6
	wtRZwQOGSXZTEs6osspcnkSnoNv2yAvI0Oo8SVUFwxC3ygJbIVz19vlyPtBADZpyyl9HxCtBkzO
	qTUeu0cuy06bt9pltmA2p09ow71hnmmkKTdnajSYJz5GzQadNzJkdFQs9tXC7rU4SUgljiDSioe
	QuISyNLdwqB4iR1WpNM/8miOaxOXFT5SafpgUsVCThf83W3V2UrEO3fOV3Cnuk4LDq7B6+58vXX
	/gkrR85oxGj
X-Received: by 2002:a17:90b:33c2:b0:38e:c232:9d3f with SMTP id 98e67ed59e1d1-395c3597c56mr7524714a91.5.1787299912888;
        Fri, 21 Aug 2026 01:11:52 -0700 (PDT)
Received: from localhost.localdomain ([152.58.217.163])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1416ae48761sm22040786c88.12.2026.08.21.01.11.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 01:11:52 -0700 (PDT)
From: Sreeshankar K <sreeshankar0910@gmail.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	andersson@kernel.org,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	rafael@kernel.org,
	viresh.kumar@linaro.org,
	konradybcio@kernel.org,
	tglx@kernel.org,
	ulfh@kernel.org
Cc: bmasney@redhat.com,
	radu@rendec.net,
	abel.vesa@oss.qualcomm.com,
	lpieralisi@kernel.org,
	quic_tdas@quicinc.com,
	danila@mainlining.org,
	davidwronek@gmail.com,
	mani@kernel.org,
	robimarko@gmail.com,
	linux@gurudas.dev,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Sreeshankar K <sreeshankar0910@gmail.com>
Subject: [PATCH v3 00/13] Add initial support for Qualcomm SM7250 SoC
Date: Fri, 21 Aug 2026 08:11:12 +0000
Message-ID: <20260821081125.4522-1-sreeshankar0910@gmail.com>
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
octa-core Kryo 475 CPU configuration (1x Prime Cortex-A77, 1x Gold Cortex-A77,
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
Link: https://lore.kernel.org/linux-arm-msm/20260817082457.64797-2-krzysztof.kozlowski@oss.qualcomm.com

[PATCH v2] Link: https://lore.kernel.org/linux-arm-msm/20260819152545.3934-1-sreeshankar0910@gmail.com

Changes in [PATCH v3]:
1. Updated the way of registering critical clocks.
2. Made some more clock critical.
	GCC_VIDEO_XO_CLK
	GCC_CAMERA_XO_CLK
	GCC_DISP_XO_CLK
	GCC_NPU_CFG_AHB_CLK
	GCC_CPUSS_AHB_CLK
	GCC_NPU_BWMON_CFG_AHB_CLK
These clocks are flagged as critical in gcc-lito.c

Sreeshankar K (13):
  dt-bindings: arm: qcom,ids: Add SoC ID for SM7250
  soc: qcom: socinfo: Add SM7250 SoC ID
  dt-bindings: clock: Add SM7250 global clock controller
  clk: qcom: Add Global Clock Controller (GCC) driver for SM7250
  dt-bindings: clock: qcom,rpmhcc: Document RPMHCC compatible for SM7250
  clk: qcom: rpmh: Add SM7250 rpmh clocks
  dt-bindings: power: qcom,rpmhpd: Document RPMh power domain for SM7250
  pmdomain: qcom: rpmhpd: Add RMPh power domains for SM7250
  dt-bindings: arm: cpus: Document Kryo 475 CPUs
  dt-bindings: firmware: qcom,scm: Document SM7250 SCM
  dt-bindings: interrupt-controller: qcom,pdc: Document SM7250 PDC
  dt-bindings: cpufreq: qcom-hw: Document SM7250 cpufreq hardware
  arm64: dts: qcom: Add SM7250 devicetree file

 .../devicetree/bindings/arm/cpus.yaml         |    1 +
 .../bindings/clock/qcom,rpmhcc.yaml           |    1 +
 .../bindings/clock/qcom,sm6375-gcc.yaml       |    4 +-
 .../bindings/cpufreq/cpufreq-qcom-hw.yaml     |    1 +
 .../bindings/firmware/qcom,scm.yaml           |    1 +
 .../interrupt-controller/qcom,pdc.yaml        |    1 +
 .../devicetree/bindings/power/qcom,rpmpd.yaml |    1 +
 arch/arm64/boot/dts/qcom/sm7250.dtsi          |  612 +++++
 drivers/clk/qcom/Kconfig                      |    9 +
 drivers/clk/qcom/Makefile                     |    1 +
 drivers/clk/qcom/clk-rpmh.c                   |   24 +
 drivers/clk/qcom/gcc-sm7250.c                 | 2269 +++++++++++++++++
 drivers/pmdomain/qcom/rpmhpd.c                |   19 +
 drivers/soc/qcom/socinfo.c                    |    1 +
 include/dt-bindings/arm/qcom,ids.h            |    1 +
 include/dt-bindings/clock/qcom,sm7250-gcc.h   |  163 ++
 16 files changed, 3108 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/boot/dts/qcom/sm7250.dtsi
 create mode 100644 drivers/clk/qcom/gcc-sm7250.c
 create mode 100644 include/dt-bindings/clock/qcom,sm7250-gcc.h

-- 
2.43.0

