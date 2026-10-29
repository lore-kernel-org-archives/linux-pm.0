Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793257405;
	b=5ht8g5B2A5dk0190/QyYb6d3IUnP9K27gYErxtSaBB7kDFyy5NwxEicXKpiVln9NIXjP
	 7WQ8C3BgrTdYay6tDBBO0drBcrZ8ZVjtE24opTwLnB5QAsEMRbJ+hp6WxXkCMXG1qyJtJ
	 2DENRSm+21NYenMbmJw6rKigkhn/p9y6ICVhfoPXECRGyo1wm7PiPfCjjFLWRA/44pSvj
	 kB+R2FICkGnnFfeB36Z8dZE5cikBtp3rH6HuE/K53c/upfzmABh4fUDUvUj6HW2+r98jG
	 wM9hFH/nddyLFLBpksfV4wAupZ0+9t4GUJKc3nBAQEG+s2GDrtA8A7YaTqn1MWp5YMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793257405;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=3b6vdH2+jz8Vj41dc+Mlr3MP2syrLhugxkFarVQVfaw=;
	b=N0F7DaEBi3Xz0MjgkacMKbvbg0vVxZOFNkviKSwbO4tg5C2FYFw5ojp2cj54oQzH98NR
	 E/Ztxxk4i1RY07w4LDKSF7ZcvlKCEl3IpAhNb6lQCb0cbOhR/6HeUFdp+grgzotZ+TfyW
	 pbopREMY7mZtGuUJO8MlBA32LFALVRoEV5Rn2c154EY/6m7f/0wweZyfr6B80KFbVJeWZ
	 2iDosBB5ST3roqH69tsilGnw4tyhpvKw0RgVsMzU9PymqvAzcQ49j/WwkdXp0qoCS8s8c
	 176jKpwnXS84DvYFXwrWDRmS5nzNBRxKVgtPFG2TE12W5pntzEz1VqmpZKXp5/LwiEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DqD7hgyn;
	arc=none smtp.remote-ip=74.125.82.180
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961AE606A323
	for <linux-pm@vger.kernel.org>; Thu, 29 Oct 2026 07:03:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 961AE606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DqD7hgyn
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-36a0f27c9f4so2756012eec.1
        for <linux-pm@vger.kernel.org>; Thu, 29 Oct 2026 00:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793257404; x=1793862204; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=3b6vdH2+jz8Vj41dc+Mlr3MP2syrLhugxkFarVQVfaw=;
        b=DqD7hgynyTM/03cNIhthLnim5lUHOcm9EuUdqKU8mQK0rsVXiPVYBfTtn92MGF/000
         LfIoDIH9EqWpxO654xPBZfGrMyhMH1Jdj7iCaqLmHFG/S2yQUnkBJyMPM4LSI90/W2EG
         kMSecfaLX2HyrM8N3q0BqRd5MyRb2QmQ+ThDwV3yFQ+ipZbFgwb52atj0K6Jo5a5FUsV
         h56LvxLm0cYG+lz+U42qKhp+nZEqUJzxrGMXQyR7tMC++SrUedHLcIaIli9PqYrecTuj
         avbDojozjUEReS6doZPuw9gDZQQ4v78dm953vTJKN1eJnim5EQ3l4b8OlQclbU4u08Cr
         ZD2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793257404; x=1793862204;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=3b6vdH2+jz8Vj41dc+Mlr3MP2syrLhugxkFarVQVfaw=;
        b=vAInxggGAAaGt8QatNuWe6MllPxOJyKkpYNYjtVGqcasJKaX81MfZMgs5OMFwx4gd9
         jDozEF7ixzHWm1iwVROoo0+C6rXizcgqbpf6fI62kT1z+7aft5juleljMmh85Vv85ixW
         4LKPWR0lQH0eHGvcaHsGfRpjsHVUvqI+tA0A9Jp2AXUFu6SSNDGiR9L5QnVgvGg7f2Sg
         Www5bViVCBF2XGgqjYkkYuzNCrKgU73RNajPJ0J1b6wImV0ANXtpvT2fdBoQ/R5n7d21
         QBETkEbx/SGjPNyu6tQ8d+g58iDo4LvXBXoa4tumsUmLWjyYL0Ol01c2TEelIZlWYaMu
         Rwjw==
X-Forwarded-Encrypted: i=1; AKwUvBwISTFwoHEQ2Llqrfi9WYmOXh1lqH7YgGqM9xsTUWvLOW4Qc43xpcPuxFgig0hx9bwpsXZ8SyKkqg==@vger.kernel.org
X-Gm-Message-State: AFq9FYIelCLvGuAA0aiACjv7RJjtQh+SX6YoyNuJ9q1UUYaUaONAiH7t
	nH85J63HL7+3Em1BXneVJksebNC92IOC6Lk1bo+8OZbgFJ8eO8hFyWcU
X-Gm-Gg: AYBFou0Bdqmdxy4nDt5/drwThfJ8tHIM3ORv2F5FoTTXg+CK/qEpYr69hvzLVcsgUK1
	vgOAISxRkGG+dMgqPTa9q8n53QNkzzjykRIsdoxQxvPQmBZ+Y/wjQ1NYuwjGh8nCWeSNlDC2Kw0
	6J5ck99WtJ2aT6v52SYHSSuIvAmqnyH/P4sMmRKLfkz9TIpxnCBLdskmOiFTC9CzNPn5nVb03/3
	S2gbCQpSeLkfofHMUjxhzMSCkBw/En3ra8hwLtrTdjjQ8+AVrvdIo6z6zi2Nim+zoxNy3GcD/96
	TR0VSPu/OD+pFq7YcU8lCpj9ODhKkFJq8ke02PNyF7Kr5Kc5pAe3/wTHPFeKMexyQDnro+DrAFJ
	M7baW4nuxUNAKBea5OYAaBtsQ0oeoW7jpU5497BjSB3+3HqH145+Tj//YB/vth59ZJtMwb9/tSp
	O5v3BqHlneRXbIfhWJjOKOUGhTQXqVA138fDhIygaQBKjtdnMofTExQZUnFsrl6PTrHIyw6C69Y
	fqcpo6u3Fk/JdrkB/J9kX5RT5dDb3jyVg4XfLyGKmG6jwSCcO18FObV/qT1CfJtImPjkuaEYL7O
	sebKFyXGTCiwYxc5jnr3KAOrOjnTnN0FX6Zs58pcV3E4mZJEemWbAff6eAu2tRnP0K4d2wLpgyI
	y8Mb3RLQ=
X-Received: by 2002:a05:693c:42d3:b0:36a:2383:eb51 with SMTP id 5a478bee46e88-36a2383ec49mr5494275eec.26.1793257403363;
        Thu, 29 Oct 2026 00:03:23 -0700 (PDT)
Received: from Sobhana.localdomain ([152.58.200.233])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a2398fa4csm16955443eec.24.2026.10.29.00.03.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 00:03:22 -0700 (PDT)
From: Sreeshankar K <sreeshankar0910@gmail.com>
Subject: [PATCH RESEND v11 0/5] Add initial support for Qualcomm SM7250 SoC
Date: Thu, 29 Oct 2026 07:02:57 +0000
Message-Id: <20261029-master-v11-0-2c29e382162c@gmail.com>
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
X-B4-Tracking: v=1; b=H4sIAKHv4moC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDA11FJSSM
 xLz0lN1M1OAAkpGBkZmhgZGlrq5icUlqUW6iQbGFuZmFhaWBiZmSkDFBUWpaZkVYJOilYJcg13
 9XJRia2sBw02Md2EAAAA=
To: Bjorn Andersson <andersson@kernel.org>, Stephen Boyd <sboyd@kernel.org>, 
 Brian Masney <bmasney+clk@redhat.com>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
 Danila Tikhonov <danila@mainlining.org>, 
 David Wronek <davidwronek@gmail.com>, Abel Vesa <abelvesa@kernel.org>, 
 Robert Marko <robimarko@gmail.com>, Guru Das Srinagesh <linux@gurudas.dev>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, 
 Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, Sreeshankar K <sreeshankar0910@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793257394; l=6160;
 i=sreeshankar0910@gmail.com; s=20261029; h=from:subject:message-id;
 bh=pMaV3p1wY/hJ19yVZNVUSH6boZE8iznCu8d5b6Dyemw=;
 b=LwPehCJnihIRvMueFhLEqIdojCA/JwtVKPuYsUDw522On0R9tTY1rSkXbTjqDNPHDjGf1RiWG
 uPX3Hqn5vvjCxMd4yqS4Xi2FRAh/SYDQ16/HLu8FoVDnd8Q38+YLd+P
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
dt-bindings: firmware: qcom,scm: Document SM7250 SCM
dt-bindings: cpufreq: qcom-hw: Document SM7250 cpufreq hardware
arm64: dts: qcom: Add SM7250 devicetree file
>------------------------------------------------------------------------------<

Previous v11: https://lore.kernel.org/linux-arm-msm/20261016042432.824-1-sreeshankar0910@gmail.com/T/#t
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
Sreeshankar K (5):
      dt-bindings: clock: Add SM7250 global clock controller
      clk: qcom: Add Global Clock Controller (GCC) driver for SM7250
      dt-bindings: firmware: qcom,scm: Document SM7250 SCM
      dt-bindings: cpufreq: qcom-hw: Document SM7250 cpufreq hardware
      arm64: dts: qcom: Add SM7250 devicetree file

 .../devicetree/bindings/clock/qcom,sm6375-gcc.yaml |    4 +-
 .../bindings/cpufreq/cpufreq-qcom-hw.yaml          |    1 +
 .../devicetree/bindings/firmware/qcom,scm.yaml     |    1 +
 arch/arm64/boot/dts/qcom/sm7250.dtsi               |  771 +++++++
 drivers/clk/qcom/Kconfig                           |   10 +
 drivers/clk/qcom/Makefile                          |    1 +
 drivers/clk/qcom/gcc-sm7250.c                      | 2286 ++++++++++++++++++++
 include/dt-bindings/clock/qcom,sm7250-gcc.h        |  163 ++
 8 files changed, 3236 insertions(+), 1 deletion(-)
---
base-commit: f5491c67aeee4a68dd2b218e2f4c5baa7786c566
change-id: 20261029-master-a03876889046

Best regards,
-- 
Sreeshankar K <sreeshankar0910@gmail.com>

