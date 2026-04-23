Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6EF363C7A
	for <linux-pm@vger.kernel.org>; Thu, 23 Apr 2026 15:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776957783; cv=none; b=A4EMx8hdaFGDnTGnp05xwUS2PJBOAybEP9evWrmCkyuSv0kMyWWGCqZBAcec0zLhjNxwgl/BjWGA3fajdIJAXREhBaKSJtFJtwIiynY7hfR4JQtvyypdLO57YOnn5hEvxVR4/ROFsxWY2dik2ZdS1DZt/6cRZLJsA2xSm9fTPOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776957783; c=relaxed/simple;
	bh=lpprnZaM4doz39ONqYJs/k6i7enQK0i0cxznHQUKOJg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=XNn17YPD0Q+zKpufYKf/+ovK23d7SPFI0CWp+fdgrMlK+mvFePr+/4EdFZy7Kkl6AJk2nijziBGybIM89lQJL/D4G0XVCoFRoFmnEKUk/xlIw4kEj8fGgzv71bIicqfZYxQfp3UFdvpanC6LfptgMvzLLc374PnpGqWu6IKgE/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gHqeSt5R; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gHqeSt5R"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-488a14c31eeso54446455e9.0
        for <linux-pm@vger.kernel.org>; Thu, 23 Apr 2026 08:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1776957779; x=1777562579; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5VT18PIbrnPxIsVNhyJEZQwrWnfiHx8ppNoASHNMvek=;
        b=gHqeSt5Rv12YOY/husQjh1JE+mA+5ATUybur8Dj8XlW8zxbxFVNYv77uJL/jNcfbDK
         8ywUjPFGODlxbtKMhaJt1rkxmDuC/NmaADH9mGjCnTaFUoMJj41RwW9sWNvY0K79OQPm
         2dp9z+lanIXUVOoyGIW6N2AwugLIv/Uo2s0zfsoNQdJAZNTOGtrXO6S+Dkz+2KFqDetk
         aJclE0fUpcZ3ED6KlnVxvXZqlFVKldvqmaUr18gM+wTHAqxfnesle3l7kKzoVHSSVkaT
         yIE6oPOV55j7OvCOQ6ewuL4lCA6c3nfP8ZM6t0S9CjQAiaDWMQ3hm2/3auxgF+CACLNt
         yqDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776957779; x=1777562579;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5VT18PIbrnPxIsVNhyJEZQwrWnfiHx8ppNoASHNMvek=;
        b=InTb/nAL7QRbpwdP8w6QktK2ab1egc4eo66rr6Wab2NmZ/mV1wXmYqXlfgqh2zM/N+
         z9vCxAuqfNrglJB1MR2qmwnFzfGgm+Xb1p1Ip4409e1rOMXF0kw+IE/JPSHM0SAEUXt5
         R6uE96tszcK4yK034orF3BgxF5BwTfuyY0I4nEMp00K4rqrI8jy060kPVJ1pWMs9RPVi
         rod5AdwhypKXmFfx+ZyDVwDoZdp4p32xvAuTVJNL3LXefQPTl4fTIkAecZZHgJEDQNFt
         jFZoptZElbM2V+gLrJJF94+8Czd+FzzwCW9ABYIMDOHb4rbZisb5HVh1FlM4wCMr/9Yu
         Byrg==
X-Forwarded-Encrypted: i=1; AFNElJ+LhnGnSAb269fOmNYMNQapxBLuYgbwR4qIokU4j7rKQg5R1T6eBJZ++c+PYNj1Xvba6ZybOovfHQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxYBTE3q/yosXqZVIn/+LZZYN922gIaa2mrKwqRE1d8D0l8Yzry
	OEQpJg8V/p/9jC40QuBSySvIjMTJYTm71VFlbqy8NVksHwLSXn0uuJ4ynkxFJltsTFI=
X-Gm-Gg: AeBDiesnMOKFg6lA5nE68GMQN/IOBx9RDs0YPJ/Y2hA4xQzGTUOYyWdc4wsdvrymuFJ
	txzwtWChlB0qMWRjzCITCwWl17hhJ8Qd8ZyvBmM1wiZZFHjPeLN29194HE6jFHZo4AO0ge756cd
	LVHnJNSQivxRueUIuWv6yCWRmW4aSa1gI+9od7jrMrh5qxjNWtDMlzDtNRUV58vcLgH3bpOByav
	KIjJ5ul2KXSFnSIbjphNF+P3kTMbuMoybuIulVqYMUY6fleVDiredPzccaRZtb1HTucUBJVx58K
	3+ohBsuRRurs7YkXb7HgnqpQZ9+R5zmAyBC4a/J4kxvI1IaUbBlty+iCWGSk+gdZmTfB9uNRxVt
	67WIPcRgMezDTlwRabslI4ol1Tg+E5qrIRblgA1SiDVyvGVH1FHWpkEdK7UYqObKSNLJFYcMj8J
	FQo4z8gFYPC4NUkFh7t+JCbE4nLUMavXzMwWZ1TCogDzI1qbGVktudoQla6VJ3zyh8rIpLlCBLE
	c/TRU+q8IByA5FoWA==
X-Received: by 2002:a05:600c:8b38:b0:485:39b2:a47c with SMTP id 5b1f17b1804b1-488fb796fa0mr377986255e9.25.1776957779158;
        Thu, 23 Apr 2026 08:22:59 -0700 (PDT)
Received: from ta2.c.googlers.com (17.83.155.104.bc.googleusercontent.com. [104.155.83.17])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4891f98728dsm90550755e9.23.2026.04.23.08.22.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 08:22:58 -0700 (PDT)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH v4 00/11] thermal: samsung: Add support for Google GS101
 TMU
Date: Thu, 23 Apr 2026 15:22:48 +0000
Message-Id: <20260423-acpm-tmu-v4-0-8b59f8548634@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEg56mkC/2WQQW7DIBBFr2KxLhUMtgte9R5VFhgPMWptHHCsV
 FHu3omTyq66/CPeQ/9fWcYUMLOmuLKES8ghjhTKl4K53o5H5KGjzEBALaRU3Lpp4PNw5vCGIL1
 AcKpl9HxK6MNlVX0cKPchzzF9r+ZF3q+/knKTLJIL7jxWdWcUGuHfv8JoU3yN6cjulgX2pNmRQ
 CQKsFqVXpSu/keqjSxB7EhFpOqcRqO8aOEveXtUSXg60xjzo8+2RVM8hc8l1so829yHz8gTTjH
 NmVsE3dbYVZWWDZUnZ2szcheHIczkwFoLZUBLo+jL2w/PLW9BhwEAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776957778; l=6958;
 i=tudor.ambarus@linaro.org; s=20241212; h=from:subject:message-id;
 bh=lpprnZaM4doz39ONqYJs/k6i7enQK0i0cxznHQUKOJg=;
 b=u2MruZol6JukWD3V+mQ6lyGJ1Wg/VepW1XKXanfRVkKvfn/qKxrSKuwok9k9I9eg4HUMWqa5D
 CF1VKrFZ3JjAVY+6pBBgEUmLaPNY6hoabfozPpXr158zOyoCw6q9s0i
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
- context dependency on the ACPM fixes sent at:
  Link: https://lore.kernel.org/linux-samsung-soc/20260423-acpm-fixes-sashiko-reports-v1-0-2217b790925e@linaro.org/T/#t
- cleanup and prep firmware patches 2, 3, 4, 5, 6, 7: required by the
  thermal driver (patch 8).
- bindings (patch 1): required for DTS validation.
- thermal driver patch 8: required by defconfig (patch 11) - logical
dependency. 

Given the thermal driver is a new addition, I suggest everything to go
through the Samsung SoC tree, with ACKs from the Thermal maintainers.
The MFD and clk maintainers are included because of the cleanup patches
(4 and 5). ACPM updated some structures that the mfd and clk client
drivers are using, so these patches shall naturally go via the Samsung
SoC tree.

If the Thermal maintainers prefer to take the bindings and the thermal
driver patches via their tree we'll need:
- an immutable branch containing the firmware patches from the Samsung
  SoC tree to serve as a base for the thermal driver.
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
Tudor Ambarus (11):
      dt-bindings: thermal: Add Google GS101 TMU
      firmware: samsung: acpm: Consolidate transfer initialization helper
      firmware: samsung: acpm: Annotate rx_data->cmd with __counted_by_ptr
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
 arch/arm64/boot/dts/exynos/google/gs101-tmu.dtsi   | 136 +++++
 arch/arm64/boot/dts/exynos/google/gs101.dtsi       |  18 +
 arch/arm64/configs/defconfig                       |   1 +
 drivers/clk/samsung/clk-acpm.c                     |   8 +-
 drivers/firmware/samsung/Makefile                  |   1 +
 drivers/firmware/samsung/exynos-acpm-dvfs.c        |  20 +-
 drivers/firmware/samsung/exynos-acpm-pmic.c        |  20 +-
 drivers/firmware/samsung/exynos-acpm-tmu.c         | 240 +++++++++
 drivers/firmware/samsung/exynos-acpm-tmu.h         |  28 ++
 drivers/firmware/samsung/exynos-acpm.c             | 113 +++--
 drivers/firmware/samsung/exynos-acpm.h             |   2 +
 drivers/mfd/sec-acpm.c                             |   6 +-
 drivers/thermal/samsung/Kconfig                    |  17 +
 drivers/thermal/samsung/Makefile                   |   2 +
 drivers/thermal/samsung/acpm-tmu.c                 | 547 +++++++++++++++++++++
 .../linux/firmware/samsung/exynos-acpm-protocol.h  |  32 +-
 18 files changed, 1195 insertions(+), 72 deletions(-)
---
base-commit: 2e68039281932e6dc37718a1ea7cbb8e2cda42e6
change-id: 20260113-acpm-tmu-27e21f0e2c3b
prerequisite-change-id: 20260423-acpm-fixes-sashiko-reports-ae28b6ed5581:v1
prerequisite-patch-id: 18d89d0e2bc0efe2cb366746ac4db36f4682f061
prerequisite-patch-id: eb4f90add371877a1930c442c5464c4da7242889
prerequisite-patch-id: 021cd1ee6d2b93f554dd5098cd1158977294dc41
prerequisite-patch-id: b5da16b5c6d6731ea519ed68302fd52ce57c7ffa

Best regards,
-- 
Tudor Ambarus <tudor.ambarus@linaro.org>

