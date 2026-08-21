Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D7C638BF67
	for <linux-pm@vger.kernel.org>; Fri, 21 Aug 2026 15:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787326857; cv=none; b=m29lJJVNYbcb58xk+T+2eP2UhBJHe1YVK0Sewj56cfC8H11crS3UMl/ljEZ/OmABkMVQKtGfwQBJvHtx5BBVA5WtkMymzVIs6ECLFexL7MgKLqjwomyh0lYn2nhlkG/M16y7ETf+0BhKfDQ7h4CWjCLXFPDU2IioGYK3OZu5Sts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787326857; c=relaxed/simple;
	bh=EBIEK0ctGOLIdYheYSYQ42aVp8zZOSvUXK4M6hrlV7Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tJnouXhiJtpCIdZ8+/l283HSWV3eAXfD2lwbpCYnmF2KZzLbF79npihlUmUARduY+wX3HcG16n4bU7Lkn9LNdo5EkYHqrqC2QI5tAfMrXezy2w56tlFp+sz9l7i0wZjie7SK2QVAypX3LDwV31XiWZdLuqUfIPyMjHiPrjJ7OvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HVobMYnT; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HVobMYnT"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-38e58034d05so898581a91.2
        for <linux-pm@vger.kernel.org>; Fri, 21 Aug 2026 08:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787326853; x=1787931653; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=NLDe0BKAQgmPczIiGwzPyNkfTByg7ztvmyU32QDSeyo=;
        b=HVobMYnTCwDn4VkLjP7zZl7PNvI/+35PNl7vsWxe5fcAD4RyXEn0Q6KeCJT/Yldwx8
         lWnZU8Pbj4NUAi76M6Pg8i+2vgxeJh1/a1bIDxInpVhJ9d++F+6hb8Wb/8BjXudqCAPP
         El/2JNbjwXOY9aYKq72kJUnEvJfUyhJ23m8pe/4Tjm7XY1W5qZc+qX+iaTexN7UcTbl4
         cJl/HaZyQ3STEi5S/AvGeo9biFl80Wq6+Z2TXog2FpfGZ48ABcep+jpsbHh3Ua+FJmbk
         Xpu4+gzKgyFUg0wUpNIoxZnT92/m8Y3sRIvjTTQxhA5tfAG5isGMxOZBuVI1K03Gdjl2
         oOBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787326853; x=1787931653;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NLDe0BKAQgmPczIiGwzPyNkfTByg7ztvmyU32QDSeyo=;
        b=hX4bXljT8QD37y9U1G4NQn+BQ3RqsVbdsgOdPs5iHE4yOMVxygcPBO6WTdEE7wf/qw
         9m4r/t/4mxV6yXL3mndFHRDpWu58xO6ZsoxpDEVpWFJk5lYa4lJVfK9blwWd1tjRqPXC
         BnEI6uTVzOHhp0njaIEV4OaB7M261OAP10J4EglqW18WQUKmGvXfaUsOygeXyWcE0qSI
         0zrxxVfMjqZMpzibcGFEoDwcvFpk2bB24OZCQbHiKO/vaq55fCSYlqw98wEDZKHVu5sV
         nd0R099EyrPFprAcObbi6AAywZYBUkJ92LmcEwYrGZrmYk1MceI+LotGaPxJ3HLpVvMG
         xA3Q==
X-Forwarded-Encrypted: i=1; AHgh+Rrenrh7tke8DWoGh9gxFrWYdSLqDoNle8qUGRqw1siW7k/rHXE3IZMAo/+Feowg3OGe4FS9yZYbnA==@vger.kernel.org
X-Gm-Message-State: AFuF++kkwmE4rCX6npjTnYkYAyVnKPuXvvz2+mcT8kgPpihHPUx3YRTr
	tPHF4+/7IItNdiG1LchGYVjuu0e5yJJueAZXDz0iB1JehiuXeSjXdhvv
X-Gm-Gg: AR+sD13vMB5VlYuek+SxdLUGl4mfmC68Fc2xcjYuQWKMQZuT/JvKklavnAuBS1hnkTk
	UYXJNIosb0WPPJVnUY4hgqizb27c9hddNsO1xSRC/NqsVKvPei+Cx+T/+jKbkY2WXM4qN6yHlKO
	PoN4SxvuRBZzw1ZkKevGjKBfeH0zvmsGQEN8W4BarZIUw9N4GAES+u0x3iY7l3jXlS1HzGvtJeU
	LUxyCiSXATaQkXrX3kDNEeSCM+kfHIDKU0hi2LhD8PipT3Euah0osJDy4iZ4At6Q5AarHhabYD3
	fPUMt00YH/27aUevZ1QJ2s0UWZwcuFdCbGKf2Cl/Am4Gp3tbB3aP8zkM4RlEBj5J8bEMIlRFzFl
	k18aRYN+3ovCRJXBOncqf2Ll9NtCFOhi9EGk+r8TU6W7vWxtagHkKsrrb8JLvtevG06MIwx15Tg
	KjgJqfZzIOKZuxZYV17WdbdAeubHCil1u6UpT0CrrApH8mkN77zLTu/USOifhYZCjq7K8VMhZUg
	yigguT4c0N3
X-Received: by 2002:a17:90b:3902:b0:395:bbfe:fc6f with SMTP id 98e67ed59e1d1-395c333710emr12421375a91.3.1787326853054;
        Fri, 21 Aug 2026 08:40:53 -0700 (PDT)
Received: from localhost.localdomain ([152.58.217.163])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1416ae5f1ffsm42903185c88.13.2026.08.21.08.40.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 08:40:52 -0700 (PDT)
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
Subject: [PATCH v4 00/13] Add initial support for Qualcomm SM7250 SoC
Date: Fri, 21 Aug 2026 15:40:17 +0000
Message-ID: <20260821154030.2514-1-sreeshankar0910@gmail.com>
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

[PATCH v3] Link: https://lore.kernel.org/linux-arm-msm/20260821081125.4522-1-sreeshankar0910@gmail.com

Changes in [PATCH v4]:
[PATCH v4 04/13] clk: qcom: Add Global Clock Controller (GCC) driver for SM7250
> Update .fw_name with .index
[PATCH v4 13/13] arm64: dts: qcom: Add SM7250 devicetree file
> Added missing capacity-dmips-mhz and dynamic-power-coefficient for cpu@300
> Added power-domains for cpus and apps_rsc

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
 arch/arm64/boot/dts/qcom/sm7250.dtsi          |  756 ++++++
 drivers/clk/qcom/Kconfig                      |    9 +
 drivers/clk/qcom/Makefile                     |    1 +
 drivers/clk/qcom/clk-rpmh.c                   |   24 +
 drivers/clk/qcom/gcc-sm7250.c                 | 2274 +++++++++++++++++
 drivers/pmdomain/qcom/rpmhpd.c                |   19 +
 drivers/soc/qcom/socinfo.c                    |    1 +
 include/dt-bindings/arm/qcom,ids.h            |    1 +
 include/dt-bindings/clock/qcom,sm7250-gcc.h   |  163 ++
 16 files changed, 3257 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/boot/dts/qcom/sm7250.dtsi
 create mode 100644 drivers/clk/qcom/gcc-sm7250.c
 create mode 100644 include/dt-bindings/clock/qcom,sm7250-gcc.h

-- 
2.43.0

