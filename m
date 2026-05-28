Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8807B3E316C
	for <linux-pm@vger.kernel.org>; Thu, 28 May 2026 11:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779968186; cv=none; b=IXjL4FsVSaXukRimYcMMzKXZ2JVUb6n6+bc3+2p4gyHwmKzx8YZN5kHYrcVHGGQqhJic7AGW0XDs2ZX9/CzACMN+s8i3kE39qoc/8BWt486LFWVKk8/q6ZSD4dFIhjevVnAQjONUtfr8X2TUvkBzhJeCqo+2NNvqZ0ScA5A70hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779968186; c=relaxed/simple;
	bh=fg7EB7vCgH/aDoFQebtSPxlUJ04hl+rFx5FdoRGOgAo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=eORl39+aow3hwJB1I3IEmci/3p0bVv1pi9a1ugWFBto1zj85L+DbasktlhCRnKD1+RB+6Evah5X+9D+qnGv4UsgSZbzd081DjYS/QQ1AswqvSuk1XV5gF0Pp5tEDHUEft0fZoZyJwfwVUW9flrqsWyZlH77sbixuXuiUVzWpmiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pbety+MG; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pbety+MG"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-490686877a1so30438645e9.0
        for <linux-pm@vger.kernel.org>; Thu, 28 May 2026 04:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1779968181; x=1780572981; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sTljh5Yor4x9Y98TqyToIfZ8DqI5N2KTzHMALPWuyls=;
        b=pbety+MG88OhkN8dEM6daUL/t53mzIZKWRCnFnmgnHYEV2bxDuyfui/vXMiPkvKNPS
         UYrP9kbABEGw4u5dyFAvJmBSS6F3w6egHcbLwChiD8x3qI1Dy2clwexDLTvgSKRYCS2a
         9o7bcPGI9UHJq7juH/5vy+Gqe5/h+RBxof+osd5i2oyEjnPazwYXom7F+hS0NA/C5AqI
         D25gr700RDjWOSvOZ3mm1rnLfF8utP2Kl3GecBvR+/Haq2OlrVt0cCIJaQ2af8GmIwDT
         m+FfZ/5lf8aOhHW8AEo0XroL3Kah/+1tVLzgXzNvXJwdv0dCPUIhohuSBw2zWnSd3UOT
         B6dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779968181; x=1780572981;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sTljh5Yor4x9Y98TqyToIfZ8DqI5N2KTzHMALPWuyls=;
        b=oba79/Z1lxLkRiE+wXQS7+kI50LGnaW0tkBquTznOar02eFqGnuqXQC6sA4yJDBpSu
         q35xird7CWdEuOeeUyEkCJ9ALAkbKIqHCVUZzFq0woSRHJ1/RXmujyH1RcKdZFSzs8mx
         tlthdkSklnIvuzXnqeXFQnx/f2h5WEeOj+2E0SWJRb+MH6mK1w6BHBSLRK6T/Rg+JftY
         MvwohzOB95P5Vrqr6cqUj/n0MfZeNm1JLTFD3L5D4hJKWmPlRnwVuIA0wz7gzfdJoGXp
         K0l5ij9JaRiTwfOTr1lR37+f7UCg6s1DabrcAk2XycS+D2GsR/YsWnxWhsMUPx/1ba2P
         Hh6g==
X-Forwarded-Encrypted: i=1; AFNElJ/qJz/S1czE5Ls+XZvEv15nCoSSYxeR2svZ7naqVSvGIy4mlIROVzswkIsfaJx4H3mMVKid71/sDg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzRdrfrosHLV4cGDsACcH6Uy+7NAIRjEWMJqE/mAo0dVrH8avF8
	UnFdUtzeeoq+1iVc05NUvuT96teXPIujN6BcVsNiSTxb1r/F16UxW7Evdm7/fMTfQ1E=
X-Gm-Gg: Acq92OG3w+ldp3JbpJAIztgMvRNbaA9/v63txdQpQql7oPCLw5qeAniPubJPD0fmoQh
	PBtmCYD4AtvvejcG4ite4uZIn9ADNYMAvrizBbx4GLygBmcyp6gHd7p5sTHeAzua7wpiyf4s2Vk
	9ZyRDQT5bMFqBzDzEAVDNU2Q/oAGU6YvtbIcYZuEKK9kMOSwwn6b0WqNFIKEC5PCDtvIF/UN0/F
	+8KNji39R9JXS0iqOZshyUrnqoy5swQauDCQr/d9il8tT+lzG9q52WCTv6M2Vm7YdHr5STlb+Mi
	PVv1PG05afwEJs1YaBwRrVx3pHLTdFFMRMFHcRg3GczVkE2GFNcg8AWSp9Et23bHiQjuDiJvxXf
	xJbzsnCDys+cxzMrl1WU37U3cXAF5o9QqvxWG0BdC+lyACSjoquSD9exErmibVofskrrNnR0WKQ
	06dOL0OaAMMB0Jb0KjRP4+etySMnowx6d5cQuV1/kEVsnIU/HdXkUI5CmUkwKPLquDFz9YKh236
	9PydR9Qgw3ga0CZ9Vki9/yao92K
X-Received: by 2002:a05:600c:1d99:b0:48a:53cb:8604 with SMTP id 5b1f17b1804b1-490947b5242mr17385785e9.14.1779968180934;
        Thu, 28 May 2026 04:36:20 -0700 (PDT)
Received: from ta2.c.googlers.com (231.141.38.34.bc.googleusercontent.com. [34.38.141.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49092a902bfsm60385715e9.12.2026.05.28.04.36.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 04:36:20 -0700 (PDT)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH v6 0/5] thermal: samsung: Add support for Google GS101 TMU
Date: Thu, 28 May 2026 11:36:13 +0000
Message-Id: <20260528-acpm-tmu-v6-0-b4d7ce57594b@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAK0oGGoC/2XRQW7DIBAF0KtErEsFM4Ahq96j6sLGQ4LU2Cl2U
 KvIdy9OW5nKy4/mfWmGO5soRZrY8XBniXKc4jiUYJ4OzJ/b4UQ89iUzEGCElMhbf73w+XLj0BD
 IIAg8dqyMXxOF+Pmoen0r+RyneUxfj+Ys19e/ErWVZMkF94G06R2SE+HlPQ5tGp/HdGJrS4Zau
 kpCkSSgtaiCUN7sJG5SgagkFom9t+QwiA72UtWyWjmrIm2nXbBaWYNqJ/UmNehK6lXq0FODrtF
 A/+Tyc75EH7fyAfPvDZflG7JbycaeAQAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779968180; l=6403;
 i=tudor.ambarus@linaro.org; s=20241212; h=from:subject:message-id;
 bh=fg7EB7vCgH/aDoFQebtSPxlUJ04hl+rFx5FdoRGOgAo=;
 b=ES5Dl/rGG+zwLpvXmICNTcyH1wd/NaJbYjKSYbS07sLbC0VcAxaWe3auzY3pw6st2X7RzaRXm
 RSN1HIj9XiMC84OlzyOhjn12bJncIuk8n6ItrF1haJYhhJ3/+avF+zO
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

Krzysztof agreed to prepare a stable tag for the above in a few days
(after the branch is processed by linux-next).

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
 drivers/thermal/samsung/acpm-tmu.c                 | 571 +++++++++++++++++++++
 8 files changed, 824 insertions(+)
---
base-commit: 0d177c93e6fda86a96642e51131e1db173277957
change-id: 20260113-acpm-tmu-27e21f0e2c3b

Best regards,
-- 
Tudor Ambarus <tudor.ambarus@linaro.org>

