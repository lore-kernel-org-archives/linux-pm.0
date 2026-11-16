Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794807238;
	b=t8fJSOdKRZbFsYscHK4LYdmna/LtRFaCavliZcCixMGNOs8vqgwWoFb1hZunukXDxhdH
	 P1+UUwCHmc7JcjvJXRFZRcqHuaX4pv+k5DhNBaNzZQKe+1QGU4SrJjKFfzvt8tuwVBOTU
	 +zavP3nst/Xs9+8O8S0xq2jH7Apg6DsHPM4cUaLqkchhTtje1Nr9a+NMOHfIArVty1EV8
	 umY6TPKYoIce1AUko7dZZsauNj0sNjIc2Firf0sjUgcz36F+rjb5Wwfw0JoWGHPcjwujR
	 lUabwzsF+PwavCj13JAdcY5xg6wlxj1zWX8WYfRaQCLZopTiZZmqJ/e5W0ejhraO3iA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794807238;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=0w/f/nIRvQ41Y5kXOY9lL+2GFsd+GjYZ0Mpuv3lgWjs=;
	b=li4G8AY+/CI19Id4wW68Dw0mfQKNO8Pn1LWrM/E1GawnvqvpIowkZtaG+qjwzTLlxCh6
	 G3R4FJhum9k1f5saPiSgrh6YmJS9lY3rPHYiEk58mhX9hnXxZwXGzJDYGfsoIQXbwuOrq
	 Z3G0cHxu5N2gJTt+xufmTBg1yLVFaIMz4ju9DVyTESBkPWHbgdE/1e8bAFai5mKTKM8AU
	 13AyuPRV+bw0nz4OlHWZeFPnNIAT2tVapT0Vv7kAEYlR0P77nlT7umjtH9OtV0IrnKETe
	 G+B5Ezzf7xFP0tAw7miahmypYayk0uCFQ5EciJbAVbiEWH9pjJTa31W2q6NlXxAe8NQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vwJ1KqKL;
	arc=none smtp.remote-ip=74.125.82.46
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A63606A32C
	for <linux-pm@vger.kernel.org>; Mon, 16 Nov 2026 05:33:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 59A63606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vwJ1KqKL
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-1b3b4944a0eso1158499c88.0
        for <linux-pm@vger.kernel.org>; Sun, 15 Nov 2026 21:33:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794807237; x=1795412037; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=0w/f/nIRvQ41Y5kXOY9lL+2GFsd+GjYZ0Mpuv3lgWjs=;
        b=vwJ1KqKLo2XIV441DN9PpIWRfPJaoX9A0drWHA+3bQDRQxXKPa+zWdT5VPD/4m1uNP
         lSY4desoNuPSzNMazMVv2cNxT8i4E66H4lR4BP2jm9fDcVNeXKQVgeYUlW6WDrYSSJPB
         i6xJ7r6WEyj+X0kzTTW4S8Cc7LJUvl/O7lJrU+x3lfiGVNKPAo6gJyiB+2Y+W5Pg6q7h
         KptRYlAyZUtxsO0C5ZebFVUVxjC+12K8W1pdeKgP/EyS30L97pZnDzQsjjB7f+FIjRLS
         A5m2EUDsc0XpVWtBvT6n0CUTptwq0NXvMuIFb7Iq6MLb8Pk9imci6b1G7Li6IqYNITYi
         K9fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794807237; x=1795412037;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=0w/f/nIRvQ41Y5kXOY9lL+2GFsd+GjYZ0Mpuv3lgWjs=;
        b=p2Y4XqTt6wV4scX4+h7pO4z864IqFIwLO0fu5z1zd7XddGNLsg1tSx9GJfsX6gYrKa
         iDmdep7yA2rsVGrDMRwkmKTkndEqwEPlxJcUEFQ9QB9fb8fvy+2+sQ0vMIBeCRFxIO/m
         +q8Ubtl7sBeQYfj7AFZTQntbN8FgpQzmbhV/em7ALlj/a2d7Giul6hLhXvf8wL6G2JrX
         dSEjrwGCBFYuYpPki2vul065mkNrVPGxfu+JjdwBRaQ7fKUitdXHjaAcawTZUoBQEVTh
         N5/t19vFL/iQbmy5ci0cI0V4Arc+EQhf6IMnJCPqruJaQGpTnOWn0KfopGMbOqa/6GQ3
         +5Iw==
X-Forwarded-Encrypted: i=1; AL+hErFnrhli9LEzYbsPtDiS4K594VwM/LiMD20sUXfsY8/6e5Lf+3ou+8cHtDg4st+ilY3xFbJeFnGBXQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z9WDHP/iMhCw3ih78IRyIcTwySbtX+d53NnzU0rbEoYZBLYsHVO
	DfigYv/smkQgUN3uchsyVsgR/B/4pnbvkZPN25XTDj3fkx5vcEcvv+TP
X-Gm-Gg: AYBFou0EG59So3bqAb4U1yS2WBzdyT99gxRbIeclmDLDDJJ+fYptRHU4x7qTILWvuq6
	EkLZtxwNcRrIMm9mmHtobbF/IxPsHfj+Fs9if9quCxdfPcrhPkDLl22fsEdkFBxtGmey+ksGCly
	Od0Sy/hDtQugGNUu9mCyS3O4HHcxOzEgWMwmj0lxRdGN+w55mf62RtrMQOAYq3nzw6LmCAC+36h
	dAymSHhkw+yagj2Ih3bxVV0yQuUT+jH1IeIVv7qT4Kb15eoD/vnJU2yarrlam6io7LIsByVOoVE
	YyuAH6sQeNhqEg+td5zH+twtKQyqAtxBz4HkIlZbJT/+iM/r3wQ3bJnaXBgtQPCqUWUUly9baaz
	8NjT+HK9CgCnqTVSJk2VsxukDOfRTM6Btw1L9N91e0xHKC7yJZmF1+OLQ3XADrXuoi4qvAvT2dq
	vk2loIQr1c7UvEhOYTdtDjiLrhwSYjAS2DBJSI1+dxuvfokh6mEFfwtPsCQrTwFb7zo1n4kNZyc
	TFM6BZQQPxdrB3quBlw+PScZRTsXpxVeeVIX4hGHySok3DJvPTv2mDSB8BVL7iJUiVB1LY+8F/D
	wq5SQRweQKLpgTMtlzN9rDdBIbEbkFL72mis3dyV/NmI/EoaQlSg1gqICOzhu0oUDhhZpN952/Z
	yEbG9
X-Received: by 2002:a05:701b:2050:10b0:18d:5ef2:1644 with SMTP id a92af1059eb24-1b5031247b2mr9638120c88.30.1794807237116;
        Sun, 15 Nov 2026 21:33:57 -0800 (PST)
Received: from Sobhana.localdomain ([157.51.206.8])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5031468b7sm33463380c88.5.2026.11.15.21.33.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2026 21:33:56 -0800 (PST)
From: Sreeshankar K <sreeshankar0910@gmail.com>
Subject: [PATCH v15 0/8] Add initial support for Qualcomm SM7250 SoC
Date: Mon, 16 Nov 2026 05:33:44 +0000
Message-Id: <20261116-sm7250-v15-0-6acbb232fef8@gmail.com>
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
X-B4-Tracking: v=1; b=H4sIALiV+moC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDE11FJSSM
 xLz0lN1M1OAAkpGBkZmhoaGZrrFueZGpga6BkYmScamBonmSWmGSkDFBUWpaZkVYJOiY2trAYg
 gNg1ZAAAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794807228; l=8347;
 i=sreeshankar0910@gmail.com; s=20261029; h=from:subject:message-id;
 bh=7sFNnBSgl0y/IKnMm2OQoutXPcOL7acB8zm5ok13LaE=;
 b=vz/YVSoqEGCVg/OHnT2rf5hNS0amPModqoJeSgyHHgLcsLkzSIr5QY607mugyMKPPruaTV6rg
 XHknS7t+e/BCrw9RWwSxUarDlJCzEGfdp9JvI1mGC0U7vsUe9VxaJ1r
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
thermal/qcom/lmh: Switch to match data for SoC CPU-to-node mappings
dt-bindings: thermal: lmh: Document SM7250 LMh
thermal/qcom/lmh: Add support for Qualcomm SM7250
dt-bindings: firmware: qcom,scm: Document SM7250 SCM
dt-bindings: cpufreq: qcom-hw: Document SM7250 cpufreq hardware
arm64: dts: qcom: Add SM7250 devicetree file
>------------------------------------------------------------------------------<

Changelog [v15]:
[PATCH v15 3/8] thermal/qcom/lmh: Switch to match data for SoC CPU-to-node mappings
> Update the patch to fix apply conflicts with Linux 7.4-rc3

Link [v14]: https://lore.kernel.org/linux-arm-msm/20261106-sm7250-v14-0-7d167e993f9c@gmail.com/t/#t
Changelog [v14]:
Fixed various issue found from Sashiko's review, Link: https://sashiko.dev/#/patchset/20261104-master-v13-0-355b65c6f764%40gmail.com

Link [v13]: https://lore.kernel.org/linux-arm-msm/20261104-master-v13-0-355b65c6f764@gmail.com/t/#t
Changelog [v13]:
Fixed various issue found from Sashiko's review, Link: https://sashiko.dev/#/patchset/20261104-master-v12-0-57fbe9eef978%40gmail.com
[PATCH v13 3/8] thermal/qcom/lmh: Switch to match data for SoC CPU-to-node mappings
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
      thermal/qcom/lmh: Switch to match data for SoC CPU-to-node mappings
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
 drivers/thermal/qcom/lmh.c                         |   74 +-
 include/dt-bindings/clock/qcom,gcc-sm7250.h        |  163 ++
 10 files changed, 3327 insertions(+), 19 deletions(-)
---
base-commit: aebb7274476403040d582c61478df8f4a7bf9cd3
change-id: 20261116-sm7250-024b350a7bf1

Best regards,
-- 
Sreeshankar K <sreeshankar0910@gmail.com>

