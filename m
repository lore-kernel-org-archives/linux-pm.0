Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B10F3F23CF
	for <linux-pm@vger.kernel.org>; Tue,  2 Jun 2026 17:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780419655; cv=none; b=KGu6WMXpvFffYY15SNbCeTAvIoYerUfzyWbyoVHF5TqVj4p8Ft2kRgS75C7qIg2kcYm8ydGYWyQpSt3Xx75+Zur5KeollOPsFDXNYh+GQDkLAfGwTokVi+k609E4+T7zeG8Gehr7L7sFLiSHMFPmc/Z/pUP4qq8arYdXb4Ko2YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780419655; c=relaxed/simple;
	bh=dzlXq7jykuFHnwxkXRA0IhnPhgOSS7lnT318/jWXEm8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=lsnCBddw+ElN8w97cgqAKem0q2J4kbqCt4BpiIJgBW/2F2LVUevhOftJEfPxieIYCL7eI/nyGjEOGke6Zd1LLyAgMFYc5o++Lh1RDF6dGJVGSwWdyPi8m+TMQ0gBlwF5zg6GSRXG07W98mQ2KBMLld4ucPidZ2oF8uKKI9/tD+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rvmVcsmC; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rvmVcsmC"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-490388fd0dbso116925155e9.0
        for <linux-pm@vger.kernel.org>; Tue, 02 Jun 2026 10:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1780419651; x=1781024451; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mi7kVezCcDvg8qXbli6L/hgVp0yagoLhCnZtW1BhRxA=;
        b=rvmVcsmCB8X7IeWUwkmKqwpTUkwoYCMIbbf5yDWR5hmnx64zyKjHBEn6o6X31C9lsp
         +KPMytHY9keRXImttcMNyi+Edl0ID8P+6VHnhVm5LkhjFg6BBrNVPQ0qgsJ2BHCvEflt
         vAyw6ySUMg1otJuFBz2oIKvoz0cHVDJpfS9KgJgQTOrFyf45vpU3eNXAnqzD3m6r32wo
         ce86azNJ6lXwuCuLgP00cRzEgGasZbagekIng1wXzZ5fwWcKROJ33NotKVghZSimRgPt
         ZkosB+6CnXCPfD3Z6V8L7w7ex6y1/OaY9+1pSr9U5e5GbFfkieSPwDC+4kjKYCYZY+Gx
         gHVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780419651; x=1781024451;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mi7kVezCcDvg8qXbli6L/hgVp0yagoLhCnZtW1BhRxA=;
        b=WD8P1H2QxwJnZnQbqj6z1fq5QdhTolvNArKzlLen/6D6e3LIT4LBIwwryRYG9hrZDX
         eC6M8VwpnUkg2Th6JaZ2NQUuIOfmK25EJbea6lFVPAXH9cMdr8MSXCflQSrNUah50WIQ
         EWwACA/F1S3NERtuyOdD145pkSMw+PaH1Fj1DLUdD+F36/Nu+6GD42xHMydC2aqDqTbw
         oGnMQm4QEdvmZabSNBtMXh9qUoQIIS+qiDE9WIz+Ci3TcmbAIClE4M/RRF1/NZCcGS72
         S3SIl032ZpRGyKP6k/e6z+3XFM9Xmb/8uvGeoNZcyl6UIf5OeWSqPqHhrP8Q8k3VsOke
         zr8Q==
X-Forwarded-Encrypted: i=1; AFNElJ/nYi45DOkH8ukVn8UBGI4K/1hocVdZoSFBwySeM0gLRI+bDsMarrmxk6CcCYBMy9ckLgx2+yLuyA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxd7Fn7RNuM1T8w4FGuIutPPfh8IjKYNJIvk8itoCIK4LdqfAdr
	HekYbF7OOD0tQ0+qO+5EuqbTKI/ixnuU1nYV7V88RpmDb1ZkEjvImci4jnPecXfF4VE=
X-Gm-Gg: Acq92OGngarcKzW3iUq9ZMDuHo/9VKAoX6AZAfyI8J3EDta8vKMwW01jgtoQUvms2OY
	q9QLWGuBvsHeNkHUYmvuW+hioEDcUlcZsMCnUxSaIpnZTPSSM82VsLdr3YrTyoFFma5VOXpXnYH
	NMLRIa3LOI6gef1h3J3e0hn3Ah3U3ItVZq3jb4M+Qhq0X07T5ShD8oPjQ96xc3iZ1omgn/0Pr1Z
	t2YSHLDc3pYigFfUJo+6UYsX2bXKLKZ8efyEnFoPgpZn5rcjDaBitv7lKfBW65u82SFlWMU0XnT
	PtRkBN4re1BJeylOBigkON2TR41bajaUBTgzQeeIFbmYCLTDcbOtd5qeL4jVc43WUOfpXthzCMK
	3F5kUmz7M3IeN1aBfUegK7qzG3P2s8XgH0o277H1dMIQlhFoZlNWws64ecYyXX1iRo7TS+utAhs
	dGP41TRXR7/0YoKX2J3WYxliHl8Jnjtl368bn/hTgE0ajtOrcYLRyB82lyZoLrFm/Uo1tZmSPqG
	DHJBxFdZnpDH28=
X-Received: by 2002:a05:600c:348c:b0:490:45bb:8dd9 with SMTP id 5b1f17b1804b1-490b506a773mr11009225e9.8.1780419651420;
        Tue, 02 Jun 2026 10:00:51 -0700 (PDT)
Received: from ta2.c.googlers.com (213.53.77.34.bc.googleusercontent.com. [34.77.53.213])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f360bd6sm541156f8f.36.2026.06.02.10.00.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 10:00:51 -0700 (PDT)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH v7 0/5] thermal: samsung: Add support for Google GS101 TMU
Date: Tue, 02 Jun 2026 17:00:46 +0000
Message-Id: <20260602-acpm-tmu-v7-0-8047dd54b0e9@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAD4MH2oC/2XRTW7DIBAF4KtErEuFB4afrHqPqgsbDwlSY6fYQ
 a0i3704bWUqLx+a70kz3NlEKdLEjoc7S5TjFMehBPN0YP7cDifisS+ZgQAtmkby1l8vfL7cOBi
 CJggCLztWxq+JQvx8VL2+lXyO0zymr0dzbtbXvxK1leSGC+4Doe6dJCfCy3sc2jQ+j+nE1pYMt
 XSVhCJJQGulCkJ5vZNykwpEJWWRsveWnAyig71UtaxWzqpI26ELFpXVUu0kbhIBK4mrxNCTkc4
 g0E7qWtpK6iI71RtPaNCp7p9cfg6f6ONWvm7+vf6yfAOuTbdp2AEAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780419650; l=7436;
 i=tudor.ambarus@linaro.org; s=20241212; h=from:subject:message-id;
 bh=dzlXq7jykuFHnwxkXRA0IhnPhgOSS7lnT318/jWXEm8=;
 b=jA88N4eUnchzna0+uTR/HgEIhnZJyvLI13NhkkttLP+TWN7PpfbM1Q+SVISL46WzVFp0Qc8m1
 p+gpzAm1/qmAKGfuIcbvh/kXQsjvpWkTIeNgdZn1d2LQq3msY/pzW8S
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
https://lore.kernel.org/r/20260531115713.19388-2-krzk@kernel.org/T/#u

The bindings, driver and MAINTAINERS are expected to go via the thermal
tree. The dts and defconfig patches are expected to go via the Samsung
SoC tree, after the bindings and driver are queued.

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
Changes in v7, addressed Sashiko's driver review:
- add a rollback mechanism in `acpm_tmu_control` to prevent leaving hardware in
  a dirty state when we fail to enable a sensor midway during probe or
  resume.
- prevent calling `ops->read_temp` on a disabled sensor if a concurrent disable
  occurs (e.g. suspend).
- don't mix mutex guards with goto as per cleanup guidelines
- fix irq clear order in `acpm_tmu_thread_fn`. Avoid clearing a new interrupt
  that occurs during `thermal_zone_device_update` (which can cause missed
  over-temperature events).
- initialize hardware thresholds at boot and prevent boot-time spurious
  interrupts (which previously triggered because sensors were enabled before
  thresholds were set).
- ensure clocks are disabled when removing the driver, even if an autosuspend
  is pending (which would otherwise get cancelled by `pm_runtime_disable()`,
  leaking the clock).
- add rollback in `acpm_tmu_suspend` on failure. If system suspend fails at
  `ops->suspend`, re-enable the TMU sensors so they don't remain disabled.
- Link to v6: https://lore.kernel.org/r/20260528-acpm-tmu-v6-0-b4d7ce57594b@linaro.org

Changes in v6:
- defconfig: reword commit message (Krzysztof).
- bindings: make samsung,acpm-ipc a required property (Krzysztof,
  sashiko)
- address sashiko's review feedback on the driver:
  - ensure that the loop continues to disable the rest of the sensors
    on the teardown path in `acpm_tmu_control`.
  - avoid leaving the hardware in an active state during remove by
    s/pm_runtime_put_autosuspend(dev)/pm_runtime_put_sync(dev) in
    `acpm_tmu_control`.
  - initialize `acpm_temp` in `acpm_tmu_get_temp` to mitigate the risk
    of exposing stack memory.
  - fix race condition in `acpm_tmu_update_thresholds`. Guard 
    `was_enabled = sensor->enabled;` with the mutex held.
  - prevent keeping the sensor disabled on a threshold setting error
    scenario.
  - allow the IRQ subsystem to correctly detect an interrupt storm by
    returning IRQ_NONE.
  - devres ordering in probe, eliminate a UAF by moving the IRQ request
    after registering the zones.
- self review on Kconfig:
  - add `depends on HAS_IOMEM`, due to `devm_platform_ioremap_resource`
  - add `default ARCH_EXYNOS`, based on Krzysztof's patch from:
    Link: https://lore.kernel.org/linux-samsung-soc/b20c560f-4bc3-4686-9c91-36d93f1535b2@oss.qualcomm.com/T/#t
- Link to v5: https://lore.kernel.org/r/20260525-acpm-tmu-v5-0-85fde739752e@linaro.org

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

 .../bindings/thermal/google,gs101-tmu-top.yaml     |  69 +++
 MAINTAINERS                                        |   8 +
 arch/arm64/boot/dts/exynos/google/gs101-tmu.dtsi   | 136 +++++
 arch/arm64/boot/dts/exynos/google/gs101.dtsi       |  18 +
 arch/arm64/configs/defconfig                       |   1 +
 drivers/thermal/samsung/Kconfig                    |  19 +
 drivers/thermal/samsung/Makefile                   |   2 +
 drivers/thermal/samsung/acpm-tmu.c                 | 618 +++++++++++++++++++++
 8 files changed, 871 insertions(+)
---
base-commit: a1c3227fc1a1cd83cd7fceb93406da4e37fe06eb
change-id: 20260113-acpm-tmu-27e21f0e2c3b

Best regards,
-- 
Tudor Ambarus <tudor.ambarus@linaro.org>

