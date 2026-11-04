Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793810808;
	b=NvxCfeeFvaa6CoVr2JLqkhjznlkxwI5EDuuqpl6LgRE7UqvKU3sRGs00pnn4qXMYep5a
	 BsTcm9qZA3uSsHvLYm8LODs55dJ8V14W9avaf15/E9aTR43my0/qn5UhUmKAhnXxXjobP
	 e2yO5aclZdM67UYKOdoikGHEFWSQKgDyzr3aU13GNG776T3afk7TSiWyE4I5I3hiDpva+
	 IJtDLvrGaPWO0cA8Ol28HBJ94HB3q4HkQVOyqJY4CGYSPF7xczqmHZr1jieXBH48WrJbz
	 jHCf7MBNjzSwmKNbvFAbgo4JKSEF9z/hEfzSqCCyeZZ0Kp30xM78N7QufztlUHTlc8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793810808;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=gamzM6thtPz+m4PXUApFbSIz2cimDoEpil3OMLpoqEk=;
	b=DcuS/CoEhykV3fyMdk6q03puMVCRMvKT4RumX5DAnS8aNYRvpVCkFXPRbbclBINfHCwX
	 uS88u+FwU7Gn8rJHaCoJaTu2MplsIN/1THXmY309VZfhluWhzcC1KkVcFPjFuu/tpr/Nt
	 TyCRlSjKURt/9SNKY7xOR74csuYGIZlSdcIAMgobsIl8uIayR65o6Dr6YE92i/p7/9jjj
	 QtrcjUPVbDl/07a3WF0Um+u+0fBC/dK2MPDsPgycTyIaRNaO10y1l089gO7TQuS485KY7
	 dBbRdWdRSMeKn26YSPRBoeJy/OzkxzYsE8EdnQEK/JdV+jpvJ75TR3YXx7smS1b5y+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EIM2vPn9;
	arc=none smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90844606EEA7
	for <linux-pm@vger.kernel.org>; Wed,  4 Nov 2026 16:46:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 90844606EEA7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EIM2vPn9
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-35829219da8so2206088eec.0
        for <linux-pm@vger.kernel.org>; Wed, 04 Nov 2026 08:46:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793810807; x=1794415607; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=gamzM6thtPz+m4PXUApFbSIz2cimDoEpil3OMLpoqEk=;
        b=EIM2vPn9V19hECqpmeNKGLmsjl/DLoI547pHa9lF1xGjzNZV50WRaydjBdEygzouvT
         J2Z40PhMpTfmci8H1vSKxPsZcIK70VPANKG/VuJbH8GUMlI6B3hO2U0I1WXidwh/VeWw
         eflwUyNqr1hmixLgFeSSuF2g9CwpsMApVrxdsi6wZlZ5p/YCmbWkMp1mgfR/tS+zKaho
         aV9A65UqCCsFdcj5HcdltB77b4JWlXhVdOKHivMEOb6bnaQoPD8acO+zutNmoGxPNMzn
         wtZ7/E1LiZoeBMovCDdqhUeKfCEDin/7SLM9fkxuEDIysyOGygqqp6ppHjyCnsCHiwLa
         hDAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793810807; x=1794415607;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=gamzM6thtPz+m4PXUApFbSIz2cimDoEpil3OMLpoqEk=;
        b=Y0ezO5HNQczTzf5Dhq+C42Js7TP9ihdGuQR2SlaVfz7vDmVN/uDQRVX1KGE4CcdHLJ
         ruDFYaoePESYTEkDBmBQfyPh2lZI6tPlUfNeoubC92qfeLkvlZ2bUjXHPayk7JfN5P2u
         Z9hIwlXfmwKuZ9q7Fx0nrMTCpW757vvbYhmYG50FaFyKLvkNn8fSTU2VStCdCjbBfgg9
         FwEBIGX89Ny2dJ3TgZqCyvYEZtcGV+hvlOuVR7n8n72siCFNc8rdQaZtRT6DhCkWayFY
         t6RCLiJTKfPiLosNbI8C8O/7fdZBUm6h+xkXov4kn8WWcFLjZJIKVxlPv7ToRQbCa7oz
         nIqQ==
X-Forwarded-Encrypted: i=1; AKwUvBwnkob5GIVcBVgfs0K6CteqCT7/0eY3CH/1xl6Eo3edFJgsvravqbtFCHOmY8NqW6pmO97GuR7RCg==@vger.kernel.org
X-Gm-Message-State: APuU4Z+rQ6t/xC1NQbFqSEhgI1Oma2WclGYE11n5+5NWUaozFOPyZTwG
	F8297wOUOFpyEm+LVkPgIPTBIfsE2Y2gst7XnyPjxsv/mg+BM3GUITyl
X-Gm-Gg: AYBFou01cp6YeqUG7AZW3V0O4lKEbRa+D2RL4aCwk5+7YRV9pvAxJYMkr5rounDLhrZ
	5qm6d5JYUEAmIoBqV0wnuK3S0yFM2mUoiOh/qnw1MyDv9mB8NJsaB3TT1ayHGLQWJnIp1fYw3pu
	VBOMlfy7lJb7DxFOZTazdwVEaotsJBrVk8Zg8TXqG02JirefWNrVbhIBuzStx33LEzz/JjAsLIL
	jxLpDPKwxumanTmtTzKGpJLDIaiWqtiQADmRgnPrgtnJH2JfnoKgVuLitoYywAjtrXJWRV28Hhg
	nJnkFQNn9duid9x1dXxK3Ce2P1QIKxIJzZRohzFucdSlA1JOrJUplWH51Lgcn4YDaANHd69uTP+
	ZVp7QHgNo3o3jCuSQrwww3uTXeEdmZoLOTvmJgcjudS8H+k/bEVU6wSk8kABep00E+XUjV2pf1I
	r2asWjxltvnecSV0CS+CGp/EXLJvfCYQViJMM12P+vPWH8kJfPMmE/FhpPZL332GDidia9XgP6R
	iyYuaOZd+pOzxJyseM1lSeDIZZ7nbDWuou70EIa2f+xUGeIVYF06PakvuUHqxfiTnpRAImmfNRP
	A0vjaBtpMIGu4BaN+OdrLllBMjbWXigmV96Yg+0Du9R7drUHoCQnKAb5tqKbvX8xgXI0EOuZw7n
	fxTv2Tu8=
X-Received: by 2002:a05:7022:ea8a:b0:159:f192:5290 with SMTP id a92af1059eb24-1b24f4bbb6fmr26685c88.13.1793810807054;
        Wed, 04 Nov 2026 08:46:47 -0800 (PST)
Received: from Sobhana.localdomain ([157.51.207.207])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b245c57430sm10839666c88.18.2026.11.04.08.46.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 08:46:46 -0800 (PST)
From: Sreeshankar K <sreeshankar0910@gmail.com>
Subject: [PATCH v13 0/8] Add initial support for Qualcomm SM7250 SoC
Date: Wed, 04 Nov 2026 16:46:32 +0000
Message-Id: <20261104-master-v13-0-355b65c6f764@gmail.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGhh62oC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDI11FJSSM
 xLz0lN1M1OAAkpGBkZmhoYGJrq5icUlqUW6liYpyQZmpmnmxqYmSkDFBUWpaZkVYJOiY2trAa7
 qdUdZAAAA
To: Bjorn Andersson <andersson@kernel.org>, Abel Vesa <abelvesa@kernel.org>, 
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Taniya Das <taniya.das@oss.qualcomm.com>, Amit Kucheria <amitk@kernel.org>, 
 Thara Gopinath <thara.gopinath@gmail.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Konrad Dybcio <konradybcio@kernel.org>, 
 Robert Marko <robimarko@gmail.com>, Guru Das Srinagesh <linux@gurudas.dev>, 
 Viresh Kumar <viresh.kumar@linaro.org>, 
 Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, Sreeshankar K <sreeshankar0910@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793810796; l=7848;
 i=sreeshankar0910@gmail.com; s=20261029; h=from:subject:message-id;
 bh=uPzqsnBTSTy5j8CzURIR/JxJhIk24GZEHjkBYenwv7M=;
 b=j47drGptocIm5nmgMwnduUwrjp77y/xGZ8CsPAov6BfHh5+B0PsqUlETbwVa6Ya2s/RXCGBbf
 jPokhHoLf5JBwfEi+3JY0rCVnzwcnHPo05/DmJ6VI/0WiDgrLjjet3b
X-Developer-Key: i=sreeshankar0910@gmail.com; a=ed25519;
 pk=CGSHduvtn2hwLCNRXRc9s/fh6X8PH/zNdp08zC8hOuQ=

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
thermal/drivers/qcom/lmh: Switch to match data for SoC CPU-to-node mappings
dt-bindings: thermal: lmh: Document SM7250 LMh
thermal/qcom/lmh: Add support for Qualcomm SM7250
dt-bindings: firmware: qcom,scm: Document SM7250 SCM
dt-bindings: cpufreq: qcom-hw: Document SM7250 cpufreq hardware
arm64: dts: qcom: Add SM7250 devicetree file
>------------------------------------------------------------------------------<

Changelog [v13]:
Fixed various issue found from Sashiko's review, Link: https://sashiko.dev/#/patchset/20261104-master-v12-0-57fbe9eef978%40gmail.com
[PATCH v13 3/8] thermal/drivers/qcom/lmh: Switch to match data for SoC CPU-to-node mappings
> Switch to match data mapping instead of hardcoded 4-4 cpu configuration.
[PATCH v13 5/8] thermal/qcom/lmh: Add support for Qualcomm SM7250
> Add 6-2 cpu configuration LMh support for SM7250 SoC.
[PATCH v13 8/8] arm64: dts: qcom: Add SM7250 devicetree file
> Place the nodes in acesending order.

Link [v12]: https://lore.kernel.org/linux-arm-msm/20261104-master-v12-0-57fbe9eef978@gmail.com/T/#t
Changelog [v12]:
[PATCH v12 1/6] dt-bindings: clock: Add SM7250 global clock controller
> Move dt-binding definition to qcom,gcc-sm8250.yaml. The device tree
schema of SM7250 matches with SM8250 for clock-controller node.
[PATCH v12 5/6] dt-bindings: thermal: lmh: Document SM7250 LMh
> Add LMh compatible.
[PATCH v12 6/6] arm64: dts: qcom: Add SM7250 devicetree file
> Remove cluster wise sorting of cpus.
> Add LMh node.

Link [RESEND v11]: https://lore.kernel.org/linux-arm-msm/20261029-master-v11-0-2c29e382162c@gmail.com/T/#t
Link [v11]: https://lore.kernel.org/linux-arm-msm/20261016042432.824-1-sreeshankar0910@gmail.com/T/#t
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

Signed-off-by: Sreeshankar K <sreeshankar0910@gmail.com>
---
Sreeshankar K (8):
      dt-bindings: clock: Add SM7250 global clock controller
      clk: qcom: Add Global Clock Controller (GCC) driver for SM7250
      thermal/drivers/qcom/lmh: Switch to match data for SoC CPU-to-node mappings
      dt-bindings: thermal: lmh: Document SM7250 LMh
      thermal/qcom/lmh: Add support for Qualcomm SM7250
      dt-bindings: firmware: qcom,scm: Document SM7250 SCM
      dt-bindings: cpufreq: qcom-hw: Document SM7250 cpufreq hardware
      arm64: dts: qcom: Add SM7250 devicetree file

 .../devicetree/bindings/clock/qcom,gcc-sm8250.yaml |   13 +-
 .../bindings/cpufreq/cpufreq-qcom-hw.yaml          |    2 +
 .../devicetree/bindings/firmware/qcom,scm.yaml     |    1 +
 .../devicetree/bindings/thermal/qcom-lmh.yaml      |    1 +
 arch/arm64/boot/dts/qcom/sm7250.dtsi               |  803 +++++++
 drivers/clk/qcom/Kconfig                           |   10 +
 drivers/clk/qcom/Makefile                          |    1 +
 drivers/clk/qcom/gcc-sm7250.c                      | 2278 ++++++++++++++++++++
 drivers/thermal/qcom/lmh.c                         |   84 +-
 include/dt-bindings/clock/qcom,gcc-sm7250.h        |  163 ++
 10 files changed, 3332 insertions(+), 24 deletions(-)
---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20261104-master-94dc065f7354

Best regards,
-- 
Sreeshankar K <sreeshankar0910@gmail.com>

