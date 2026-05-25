Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52051F192E
	for <linux-pm@vger.kernel.org>; Mon, 25 May 2026 12:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779713432; cv=none; b=Hc8SifwiRiAZHXN3Q7KEf8nILdrlGF0dmiOKtm/JcKmkf4wBvLelenTpQRcNUkBX2upsRujg1hMdTuqTg6nJf0nqeVrvo85IGLjaGHxXXvatbpQpmAQz6WdHrTsCSVzfN7ClY6/hoM3Vs0Ef7Zl2ObVzFtPzGERDPoCgqNsZDZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779713432; c=relaxed/simple;
	bh=jeBXtuHojBHH2gQPeCSwY8bPjROTXlTPK5x5EdFyeUM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=l/N3E0ZSiU2bnMR5vV6YNUOq8tEtVG1pJ/mYk4368bL8hczbr4f/hLh534qqpUapz3R03o1hVgisnKp9D3fimntydKDXhPnk4O6YYZqzOtQqoFdNcHCCy+aGG7LpFcigsNpR2bTlup1YaNSgLpIOboZwHuAgcvSmBzQ6FUQrhQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=d5Cd53rb; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d5Cd53rb"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-49050bfe053so22989855e9.3
        for <linux-pm@vger.kernel.org>; Mon, 25 May 2026 05:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1779713429; x=1780318229; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EifUxRKI8q3aR99rwm5sIdonRFjEYR9jP8wSE6moOVo=;
        b=d5Cd53rbjwckJ2gclfqJN77+2ewpxy3t3Y5K4KkxX1BUetCErx//cGlp34qL4rhJ+R
         7625FvURqxfo5mmobByY3kJ+XBeAhwlwBpmKglf3fS6es/I8QMrVjPiXrtcX3rxuvcIb
         l8tIRNvzOuEO+wLLDxrJK8hZGf01khSyofBQObzuYiNn3yh/691/yP6nBAa7+OI0LnMY
         WmL9uRnUv4pr6yQaaHXDJ/rx0amp6C+DFTb6x2zgWvV7cOpwkxKTzOwqvNPl4zv9EZIe
         Io19LM284li1jPFs1c47+riwKOgaRIX/+Fvoy4hmkivaIwV9clrPolK4XyRFjqXWy9bg
         BpNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779713429; x=1780318229;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EifUxRKI8q3aR99rwm5sIdonRFjEYR9jP8wSE6moOVo=;
        b=L+WKLBVDkkx69pOW+HCGWjx3ULTekYO2eQaJtlG+o7Bmdn0sadV6bmR6YXKIjwTP3n
         ecRWr1lCFO4qg0hR5nQTaFV1+0h3kCLF8uqKHBfTYjxUmp2d5iGxYGAP2B0KAyBKZmg1
         6+Q/zo5ex7FKuCx35ulNo3YXsv1DdETS+X3aWNA3k3kIEjM2YDDpr0iTv3pvYaN35lmp
         kBAKqd/ktfITZkzdy2fXOFbjxB4fIDq14iQJQmMwbqUU9LRqAafVq3rI402fxVfPEFGP
         6+d1n+SWMsQxC5LmKGI0xEgm3mIBTgFzI9KMilqGqDy8+hbC4l16ZV+I7kzqLOKBeKAa
         GeHg==
X-Forwarded-Encrypted: i=1; AFNElJ+0JZn+qKfof6Kk/Dkfu+FHQLo9GkAZuW7AAbn1xB6d5i4ndGMJdL1vmn5bDj7wokV2R2/zFdKbVA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzUIpI9O6lDX5OChvAih89s9cGT9uL9ZhyCUVpIBKp2RU9KlZId
	wngPV9hqeue5qWnbIBxcmAHa0ornw8I0gjM04XVZ6k0/BLhzahhkgn9sP7Qx54pNWVM=
X-Gm-Gg: Acq92OGS0/spC6ayf6bTdsgom6RhyHfuw+jQecyb5vQirzizTTVojTdjF3Ct1dE8I3n
	S1d2F7HPMNhzWGoOLJfaq/RVdRYyOZv0vzC/MkVgeG9xfe69Iv6EFA23X46rFLp81WbcJ+UXTdu
	voA1s9ZHrXp+/IdRU2cr1ZvfqgABVswXyNv2iywvKfXYReNbamAVAFdQfqS1KElOalDbQ/6NLnb
	gP4DUunvhP/sAuuBs8q7ejaDCsZkb0MZVJGhQPG/tju8XYCC65/GEjCI8tVgZb9awXJo4434byS
	uwbatl10MNrlDW2+RUPBcUq3eRYiZr+n39mHJGEQEYyPUJmpD9olnj7ciOy8A8eBpGQbdTPtoUC
	R1OuDoh3TLVL0nA7mHzOReO9vh3bTuOw3PfMxfuHAkKPodHwr+rLDo/2pdTU/kooZ68z+VpqRYU
	IgXnfwv3Cg6xqcKSbxQvFMvJHYnVIWGDeXy+x0pg3XBMeq3xDG6rB2/vTn/CLIcdKDkasBTqNaR
	UEcV14=
X-Received: by 2002:a05:600c:8217:b0:490:5215:e9a4 with SMTP id 5b1f17b1804b1-4905215ebd3mr153873335e9.6.1779713429114;
        Mon, 25 May 2026 05:50:29 -0700 (PDT)
Received: from ta2.c.googlers.com (231.141.38.34.bc.googleusercontent.com. [34.38.141.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490454cfcaesm241824825e9.4.2026.05.25.05.50.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 05:50:28 -0700 (PDT)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH v5 0/5] thermal: samsung: Add support for Google GS101 TMU
Date: Mon, 25 May 2026 12:50:20 +0000
Message-Id: <20260525-acpm-tmu-v5-0-85fde739752e@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIxFFGoC/2XQQW7CMBAF0Ksgr+tqPOMEm1XvUbFInDFYKklwg
 kWFcvcaCsKI5R/5fcn/IiaOgSexWV1E5BSmMPQ5VB8r4fZNv2MZupwFAtagFMnGjQc5H04S14z
 KA6OjVuTnY2Qfzreq723O+zDNQ/y9NSd1vT5K9LMkKQnSea7qzhJb8F8/oW/i8DnEnbi2JCylL
 SRmyYCNIe1Bu/pN0lNqhEJSltQ5w5Y8tPgudSmLLyedpWkr602lTU36RS7/I0Q+nvKM832JZfk
 D/qyo+mQBAAA=
X-Change-ID: 20260113-acpm-tmu-27e21f0e2c3b
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: jyescas@google.com, linux-kernel@vger.kernel.org, 
 linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-hardening@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779713428; l=5139;
 i=tudor.ambarus@linaro.org; s=20241212; h=from:subject:message-id;
 bh=jeBXtuHojBHH2gQPeCSwY8bPjROTXlTPK5x5EdFyeUM=;
 b=TVGX+uxLJueTSFZqqQKinjfGd20qo8y4BOHNCkP4+kA/IzL+waxIxvvbLI1auGMTaKxO1tP6Z
 NZvzyueB1qCBcCWePft569+A34hs4Q662s+eW32N7kRc1eZD8k8i40L
X-Developer-Key: i=tudor.ambarus@linaro.org; a=ed25519;
 pk=uQzE0NXo3dIjeowMTOPCpIiPHEz12IA/MbyzrZVh9WI=

Add support for the Thermal Management Unit (TMU) on the Google GS101
SoC.

The GS101 TMU implementation utilizes a hybrid architecture where
management is shared between the kernel and the Alive Clock and
Power Manager (ACPM) firmware. This hybrid ACPM TMU architecture is 
also present on other Samsung Exynos SoCs (e.g., AutoV920, Exynos850).

Dependencies
============
The set depends on the ACPM TMU firmware helper driver that was queued
via the Samsung SoC tree:
git://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git, branch
next/drivers.

The bindings, driver and MAINTAINERS patches can go either via the
thermal tree, and then we'll need an immutable tag from the Samsung SoC
maintainer that will contain the firmware helper driver, or they can go
directly via the Samsung SoC tree with ACKs from the thermal
maintainers.

The dts and defconfig patches are expected to go via the Samsung SoC
tree, after the bindings and driver are queued.

Architecture Overview
=====================

The hardware supports two parallel control paths. For this
implementation, responsibilities are split as follows:

1. Kernel Responsibility:
- maintain direct memory-mapped access to the interrupt pending
  (INTPEND) registers to identify thermal events.
- map physical hardware interrupts to logical thermal zones.
- coordinate functional operations through the ACPM IPC protocol.

2. Firmware Responsibility (ACPM):
- handle sensor initialization.
- manage thermal thresholds configuration.
- perform temperature acquisition and expose data via IPC.

Sensor Mapping (One-to-Many)
============================

The SoC contains multiple physical temperature sensors, but the ACPM
firmware abstracts these into logical groups (Clusters) for reporting:

- ACPM Sensor 0 (Big Cluster): Aggregates physical sensors 0, 6, 7, 8, 9.
- ACPM Sensor 1 (Mid Cluster): Aggregates physical sensors 4, 5.
- ACPM Sensor 2 (Little Cluster): Aggregates physical sensors 1, 2.

The driver maps physical interrupt bits back to these logical parents.
When an interrupt fires, the driver checks the bitmask in the INTPEND
registers and updates the corresponding logical thermal zone.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
Changes in v5:
- no changes, rebase on top of krzk/for-next branch.
- Link to v4: https://lore.kernel.org/r/20260423-acpm-tmu-v4-0-8b59f8548634@linaro.org

Changes in v4: address sashiko review:
- thermal driver: avoid mixing mutex cleanup helpers with goto statements
- firmware, tmu:
  - remove __packed from union acpm_tmu_msg.
  - return ERR_PTR(-ENODEV) for devm_acpm_get_by_phandle when
    CONFIG_EXYNOS_ACPM_PROTOCOL is disabled. 
- Link to v3: https://lore.kernel.org/r/20260420-acpm-tmu-v3-0-3dc8e93f0b26@linaro.org

Changes in v3:
- thermal driver: use .set_trips() instead of .set_trip_point()
- new cleaning/prerequisite patches for firmware/acpm:
  - firmware: samsung: acpm: Make acpm_ops const and access via pointer
  - firmware: samsung: acpm: Drop redundant _ops suffix in acpm_ops members
  - firmware: samsung: acpm: Consolidate transfer initialization helper
- firmware: acpm: TMU helpers - check return value from the firmware
- overall change: emphasize that the ACPM TMU hibrid approach applies to
  other Samsung SoCs as well (Exynos850, AutoV920).
- dts: drop active trip points, update trip point values
- collect R-b tags
- Link to v2: https://lore.kernel.org/r/20260119-acpm-tmu-v2-0-e02a834f04c6@linaro.org

Changes in v2:
- architecture: switch from a syscon/MFD approach to a thermal-sensor
  node with a phandle to the ACPM interface
- bindings: address Krzysztof's feedback, drop redundencies,
  interrupts description.
- firmware: introduce devm_acpm_get_by_phandle() to standardize IPC
  handle acquisition.
- thermal driver: drop compatible's data and use the static data from
  the driver directly.
- defconfig, make EXYNOS_ACPM_THERMAL a module
- Link to v1: https://lore.kernel.org/r/20260114-acpm-tmu-v1-0-cfe56d93e90f@linaro.org

---
Tudor Ambarus (5):
      dt-bindings: thermal: Add Google GS101 TMU
      thermal: samsung: Add Exynos ACPM TMU driver GS101
      MAINTAINERS: Add entry for Samsung Exynos ACPM thermal driver
      arm64: dts: exynos: gs101: Add thermal management unit
      arm64: defconfig: enable Exynos ACPM thermal support

 .../bindings/thermal/google,gs101-tmu-top.yaml     |  68 +++
 MAINTAINERS                                        |   8 +
 arch/arm64/boot/dts/exynos/google/gs101-tmu.dtsi   | 136 +++++
 arch/arm64/boot/dts/exynos/google/gs101.dtsi       |  18 +
 arch/arm64/configs/defconfig                       |   1 +
 drivers/thermal/samsung/Kconfig                    |  17 +
 drivers/thermal/samsung/Makefile                   |   2 +
 drivers/thermal/samsung/acpm-tmu.c                 | 547 +++++++++++++++++++++
 8 files changed, 797 insertions(+)
---
base-commit: 0d177c93e6fda86a96642e51131e1db173277957
change-id: 20260113-acpm-tmu-27e21f0e2c3b

Best regards,
-- 
Tudor Ambarus <tudor.ambarus@linaro.org>

