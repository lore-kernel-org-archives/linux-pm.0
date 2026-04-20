Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05523A6F1A
	for <linux-pm@vger.kernel.org>; Mon, 20 Apr 2026 17:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776706811; cv=none; b=HtDcwQvd7GUDdG370eq5tj+CPlsx0XZmkXK1ShkHGBKSwvBY3E8LAzp1Etgxck0b/bl1NOGdsPwcZpmbr/SwcIBfPmrnO7anI48YpVGTXblTKNzE5t/o4wVTy3a/2evX372KV/UbwqfvbEPifobp71K24uOnWDKHWZ7TAtSXD6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776706811; c=relaxed/simple;
	bh=EdQP2Wruo5Doe8ztaHk+aq6I88bm/VqlU7qINEfTGPY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=cnYQhrlEW95NUwe/qcbz9TuRm/NfprYJ95aio0R2/8pj+BPvY7LMLJZpwGm3CIeKXD5V3dgzvP1S07qyNU7fj0yiwsbTq0jbHA+ubDFQEZ1AwTjVVosNL7mscp/tA1Y/hFrJ6riOCPGHoDql2A06rNi6gNM7CxkGAqigCTC6yLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yki/cRcw; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yki/cRcw"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-488ab2db91aso44121855e9.3
        for <linux-pm@vger.kernel.org>; Mon, 20 Apr 2026 10:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1776706806; x=1777311606; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lDJkImIgICmlNFiRXajnn8mAXyhcbIrPtW7+EmIu9WU=;
        b=yki/cRcwzKF+tHLij9xHWzWO5jz3kdFcUrzww76gfDFLWJ9HiARuvLWHaAoyN20xeU
         5en/0ADvO/z0VBpS/cVK2E6+ilvjBjqCnoBLU4jXYCskDfd0XmO60M7iGBTA87I2nuWb
         mZBrFBUkPqqie/c2zFGt0oHH/n5DMzBl8NyaoQpppHAaERQcXMpnkDLGAJbfvUIq2lpF
         dOIibhygKNq/VYqFnrS8p7btKwDBGuYRaP7HSIJgdwe36glu0FTsxCxPJIDXxM+9m7yy
         a28j7A4Mw/SsOMT0C1YXDt0rGb7YXPG2J3cVU2qKmZSycEdZzYMcH+8WabLwX8Aa3LQg
         eJeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776706806; x=1777311606;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lDJkImIgICmlNFiRXajnn8mAXyhcbIrPtW7+EmIu9WU=;
        b=nf2hd8QCGebbLLGvC+Ed2eblEVOy5bp7RIyDEv8bcBirX67NF2hTDjJGBdUeCv3dPE
         ZPV3HgCuldhVsQFCZKln4ILv2YW1+tY+dPGtRfvjJRsjQGZfRmmJGDBtsxPutNjwd59l
         6FhD7hlzM4Kbg2aAgHBWuRdfl3rEYUbo+PtezevsYYINFOWc5XavPzgH6p02MnUjx+cZ
         djdoHInLQK7Pt3+Ju6omhmuRt4R8uNoDjEKVRFGcpsc3ZRplaZ9vPNvOFfVv1u2RKEJH
         iT2AO5CiOSmdCoLmRdgVxhMedNAHNQAb/i92x7xUsLPbAvMP2YDi6tLd9V2as43/hVoZ
         FcGg==
X-Forwarded-Encrypted: i=1; AFNElJ8RQ+kS7xYta0tWDkrcpryXtEBxOSngeafXL1hftrqVE3vSQFTArw3dT9C/XZo/hFLXixBH1mntJg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzYZ6Hs5uvCJFJb71Vdr86GWTldlNKvL0szLqohXH1ymTt1O4je
	XgFo2A1DeToOxYBe3s6efxz/aKhSDfeF5EaJ5hGeId9VqwEpC30/eLNUkGLTtV21Nps=
X-Gm-Gg: AeBDiev2cPGvduGwew1XCp4agmrnT9CUISgyHze382E5Cj4SPp6jL5jIoafM6IN9o7k
	8UxxKPrm4QRoLqRscwWtDbY7CVLks8UOXnREy+7KC+3vjmf+4E1mcg0PPPb8to4ui/FuchufMBQ
	VQmB+DMOBsXivOdNgasHPXZ2la1Fs01VhwxyqNaOoXDJfpR95BuygxF8Q6m5UVjcXXDue0Ugpm9
	Rb+jh1QZBCrZQdUp6Q98TbU1qK8nAOH7F8ihfW7jD4Ol7OPWtXZlER7Ji1skEU/JhSI36l8UPUZ
	NaM4JenARB0Gu2erD+0t5pIW02mGU8OngdQI5n8Vfuo6Awe0Wv1KwSLcecZqmfnpGASBYf15ez6
	Ek5z9o7eMz3al3wMTUni01Ds9C0zz+03qrYSfApTLVxmRgjbBnTk5lJMPv2JRQ211J1SSx9lTw5
	QM3t7f4F0RICInAQf5juUlAbY9zi0NEan0VLtWWe6qRlOA3iBuoxGt0SxL0f+DNRNO/3NbmDpL3
	JYGoiULKA1s7Dsjbw==
X-Received: by 2002:a05:600c:1e28:b0:483:7903:c3b1 with SMTP id 5b1f17b1804b1-488fb77fbf3mr202675855e9.20.1776706805576;
        Mon, 20 Apr 2026 10:40:05 -0700 (PDT)
Received: from ta2.c.googlers.com (17.83.155.104.bc.googleusercontent.com. [104.155.83.17])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fb72d365sm144280285e9.1.2026.04.20.10.40.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 10:40:04 -0700 (PDT)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH v3 00/10] thermal: samsung: Add support for Google GS101
 TMU
Date: Mon, 20 Apr 2026 17:39:46 +0000
Message-Id: <20260420-acpm-tmu-v3-0-3dc8e93f0b26@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOJk5mkC/1WMwQ6CMBAFf4Xs2Zp2W1E8+R/GQy1baCKUtNhoC
 P9uITHicV7ezASRgqMI52KCQMlF5/sMcleAaXXfEHN1ZkCOJRdCMm2Gjo3dk+GRUFhOaOQd8n0
 IZN1rTV1vmVsXRx/eazmJZf1G1C+SBOPMWDqUdSWp4vbycL0Ofu9DA0sl4dasNiZmkzjqk1SWK
 1P+mfM8fwBnhRPK2wAAAA==
X-Change-ID: 20260113-acpm-tmu-27e21f0e2c3b
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, 
 Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, 
 Sylwester Nawrocki <s.nawrocki@samsung.com>, 
 Chanwoo Choi <cw00.choi@samsung.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Lee Jones <lee@kernel.org>
Cc: willmcvicker@google.com, jyescas@google.com, shin.son@samsung.com, 
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-hardening@vger.kernel.org, 
 linux-clk@vger.kernel.org, Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776706804; l=5994;
 i=tudor.ambarus@linaro.org; s=20241212; h=from:subject:message-id;
 bh=EdQP2Wruo5Doe8ztaHk+aq6I88bm/VqlU7qINEfTGPY=;
 b=RTb0XIdv247dsRhBC3h8MnErBTOzM84fAn+wrWqFb+Sk/42POLptqjS7s0rmp9lB+F9T83ayW
 E8wKEuoDdq4A9Awl1GFDy068zmsA/53CebiUKTVPyJCwlmCPSnbyq98
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

- firmware patches 2, 3, 4, 5, 6: required by the thermal driver
  (patch 7).
- bindings (patch 1): required for DTS validation.
- thermal driver patch 7: required by defconfig (patch 10) - logical
dependency. 

Given the thermal driver is a new addition, I suggest everything to go
through the Samsung SoC tree, with ACKs from the Thermal maintainers.
The MFD and clk maintainers are included because of the cleanup patches
(3 and 4). ACPM updated some structures that the mfd and clk client
drivers are using, so these patches shall naturally go via the Samsung
SoC tree.

If the Thermal maintainers prefer to take the bindings and the thermal
driver patches via their tree we'll need:
- an immutable branch containing the firmware patches (2, 3, 4, 5, 6)
  from the Samsung SoC tree to serve as a base for the thermal driver.
- an immutable branch containing the bindings and the thermal driver
  from the thermal tree to serve as a base for the dts and defconfig.

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
Tudor Ambarus (10):
      dt-bindings: thermal: Add Google GS101 TMU
      firmware: samsung: acpm: Consolidate transfer initialization helper
      firmware: samsung: acpm: Drop redundant _ops suffix in acpm_ops members
      firmware: samsung: acpm: Make acpm_ops const and access via pointer
      firmware: samsung: acpm: Add TMU protocol support
      firmware: samsung: acpm: Add devm_acpm_get_by_phandle helper
      thermal: samsung: Add Exynos ACPM TMU driver GS101
      MAINTAINERS: Add entry for Samsung Exynos ACPM thermal driver
      arm64: dts: exynos: gs101: Add thermal management unit
      arm64: defconfig: enable Exynos ACPM thermal support

 .../bindings/thermal/google,gs101-tmu-top.yaml     |  68 +++
 MAINTAINERS                                        |   8 +
 arch/arm64/boot/dts/exynos/google/gs101-tmu.dtsi   | 136 ++++++
 arch/arm64/boot/dts/exynos/google/gs101.dtsi       |  18 +
 arch/arm64/configs/defconfig                       |   1 +
 drivers/clk/samsung/clk-acpm.c                     |   8 +-
 drivers/firmware/samsung/Makefile                  |   1 +
 drivers/firmware/samsung/exynos-acpm-dvfs.c        |  17 +-
 drivers/firmware/samsung/exynos-acpm-pmic.c        |  20 +-
 drivers/firmware/samsung/exynos-acpm-tmu.c         | 240 +++++++++
 drivers/firmware/samsung/exynos-acpm-tmu.h         |  28 ++
 drivers/firmware/samsung/exynos-acpm.c             |  94 +++-
 drivers/firmware/samsung/exynos-acpm.h             |   2 +
 drivers/mfd/sec-acpm.c                             |   6 +-
 drivers/thermal/samsung/Kconfig                    |  17 +
 drivers/thermal/samsung/Makefile                   |   2 +
 drivers/thermal/samsung/acpm-tmu.c                 | 539 +++++++++++++++++++++
 .../linux/firmware/samsung/exynos-acpm-protocol.h  |  32 +-
 18 files changed, 1176 insertions(+), 61 deletions(-)
---
base-commit: c1f49dea2b8f335813d3b348fd39117fb8efb428
change-id: 20260113-acpm-tmu-27e21f0e2c3b

Best regards,
-- 
Tudor Ambarus <tudor.ambarus@linaro.org>

