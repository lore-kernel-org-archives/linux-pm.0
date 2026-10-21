Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792579891;
	b=LuMt8lu5RKXp/MUsqUtxO0yp6N9XiS59Rynlnlv70EZ7ueEPJiAzIaSXxp6kOID8FTwn
	 mQaFUOuMw+XWKrOl+KfDHONdqUxTTKoeSXj84d4L6ks0nqrOrWEeVOhagv7JcqGWG1r8T
	 WZQ0EcVUhT4Cssft40iUXJOaDPXZt7lz0P+e048Y6idtVZoC9VWlJdTLyX2EQw+DY9k8L
	 9l/Mqbxa4HWByLr/Me+e+5Iv7aZtoDfX+TQD+YZRvyOCyYQEFjCGJvXNnLLiXsJLUPffI
	 UD1tF6TpYaGb9Ka4UmOwz/+pg/3uYzZFu39hKYdUz1272X7nxFJxRORNrIVT38rXi/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792579891;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Q19lKEnG8THeG/yXYppxXwK4fJmenAR0pQMrApiY6Z4=;
	b=wgSgGTz6KDEDrd5V/3EIC2Fa10o/7iziafYbdHJiZ4jaXAdUfRkeOZlJCwIQEBYtF1bD
	 8oI88Mg1CdO3cSDd6axnHIVdKh/96gLk8ixCNRtNA4G/3jPltD6BwnfGk0L4GmNJjKdRn
	 4zQVhrKHnbv/m8YOjf1Xi67P9ZwPezEaI1/2Xt2RmWfzroZwQwtO49GJ9UiJH4lZay4Cg
	 L0TI22OpsDytZc3GAZxF11KZ0ToGa+KEdfpvXbFFTLTalKBrAC9H9Ns9SqbAcTggtlp+P
	 0ct4yBgGjrOiYyHVVMcVmbYG31ZJTlwcgfcPFX/gIK5/8mg55WDyvVa/6bNICL/oFyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=QP+1EgHr;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062BD606A320
	for <linux-pm@vger.kernel.org>; Wed, 21 Oct 2026 10:51:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 062BD606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=QP+1EgHr
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a16af2a232so3384985e9.1
        for <linux-pm@vger.kernel.org>; Wed, 21 Oct 2026 03:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792579888; x=1793184688; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Q19lKEnG8THeG/yXYppxXwK4fJmenAR0pQMrApiY6Z4=;
        b=QP+1EgHraZT0KGov01tm4BGPvg0tNu2mzHsoHm6ituMiu72VorMRkUhS42jJFS65DM
         hTmzGxBNF2CnAw+oTg4QjYgFDQ/BWA6jbObxdGJAdHQoaqL/lJ+un1A3F/egmVIak6Ab
         txQJ2xtO0/8CfnAfzIbwdqkrfbaqSb6eZPcKRgiWTwDh7tELOIG5JifFPqTqYB01oWhD
         T/vPMRY+5JQUPmvusYYJ6VVreUw9Chb4s+V6B8KY91HRs9H/fZJjb2SIS1e+YmNIRykz
         JeuasueuXOTufnH6hl0iSHHGNoCs6kn8QIYJdwAsRx8MVZZcE1n74v5kI7u53GsVFR2V
         llZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792579888; x=1793184688;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Q19lKEnG8THeG/yXYppxXwK4fJmenAR0pQMrApiY6Z4=;
        b=xTUPGuQ9JmaJgkFgLvtOkIsEAhw4ri/+OCXHrd5bk9p2+LSAG3WUwN+bBp8U9SQSxK
         93NQcUey+nYcMP6K007YnmTEwD/tRpwtOo0rugpZpi9/ZQ9ekAcjS+uHuIkukJdtZqJN
         MN1b8Mz+G/D1O2FgI07PKAhYka6BdlUWcbFmT6q2KytktmdvvRImQHqrZJG+xfo6IiSU
         QjLBg/AH1Mdb1Y8UTnW/p3lGyNE23CXoN1DaNZUpg58vuravQaJ33cJ/y2UxfiArXjg6
         g95VlncXKNZeFt2/MVppEJQiGuemtUUZJh2fD9KwH27dJil3YMUWCaSs6ll4WAmK/Rff
         LIbg==
X-Forwarded-Encrypted: i=1; AKwUvBx46xA3N0nFXE4T9pdg9ahPeia6Vz3SFBYLt30dllmaOQlvbcSxqjtNN3tiu8S/8/61Y9WbwgNJaQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYJEUjlOlqdrIE6AZfC77GIg9VYS+SDZv8phdyCxFe1pqJK5bFJn
	5y/I+BFZmt2c+GtVUxd5DG2+M+WkT/+YEWe6LVmrjxs4l6j648BIqg8V
X-Gm-Gg: AYBFou1xHQYLds4ElT3a4KkakRv6ouYDxqgY++rWHT7mBc9+TMnbalzy4AtWPM/aNAI
	ORp2vluxum046cJFPNvxSLXexMfU5VBlyi8ccoS7vkv0Lq7vZVw1G348JTh9abyOpL9vBmgrTV6
	ThLhn5hAe+zT49GQUEwREuX8FM0ZjKKYBzNb8Ict7BO4iqhI+d53i9i953sw8EBAZhbup+dQZLN
	HcO/iLyY6HmLQEixwRohBOl7FFi2GniDUcRxAFW2Rk9zHMU21b3XZpaA+UKNAqhcM/GlmlhXkR1
	/n4myeJ2TlRMGq4c/WTxOAq62Af0LidZMNlKrtHyoCVc/6Y4pk4gqKE9W1idyg3DdYM7Dg2YiAg
	LE4T5WlLAflPdj5ET5ggRrqukoU1lX2pvi5poJ1Sx1NL/F4VcfryH6Erdh9hXAwP6w7n+IaYyIc
	tULzZq+B0jVp3lx4biyWxw91+7OGU99M0vG+KNWRV0UfbI0JMgUaAtK1v/KiIGJOj2XpQInWAC5
	BKJxnTbE6L0RPqg84gBrVcnN3UIdigVH+Cfbty1alRyrAX+BWEfDJettpDeOVQFoE1370UR
X-Received: by 2002:a05:600c:4684:b0:4a1:d36f:1ba0 with SMTP id 5b1f17b1804b1-4a1fdd74b6cmr33371145e9.35.1792579888215;
        Wed, 21 Oct 2026 03:51:28 -0700 (PDT)
Received: from luca-vm.lan ([154.61.61.58])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1f2d6e2dbsm153388305e9.13.2026.10.21.03.51.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 03:51:27 -0700 (PDT)
From: Luca Leonardo Scorcia <l.scorcia@gmail.com>
To: linux-mediatek@lists.infradead.org
Cc: Luca Leonardo Scorcia <l.scorcia@gmail.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sen Chu <sen.chu@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Macpaul Lin <macpaul.lin@mediatek.com>,
	Lee Jones <lee@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Val Packett <val@packett.cool>,
	Fabien Parent <parent.f@gmail.com>,
	Akari Tsuyukusa <akkun11.open@gmail.com>,
	Chen Zhong <chen.zhong@mediatek.com>,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	mfd@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-gpio@vger.kernel.org
Subject: [PATCH v11 0/9] Add support for MT6392 PMIC
Date: Wed, 21 Oct 2026 12:47:18 +0200
Message-ID: <20261021105109.199886-1-l.scorcia@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The MediaTek MT6392 PMIC is usually found on devices powered by
the MT8516/MT8167 SoC and is yet another MT6323/MT6397 variant.

This series is mostly based around patches submitted a couple
years ago by Fabien Parent and not merged and from Val Packett's
submission from Jan 2025 that included extra cleanups, fixes, and a
new dtsi file similar to ones that exist for other PMICs. Some
comments weren't addressed and the series was ultimately not merged.

These patches enable four functions: keys, regulator, pinctrl and RTC.
Mono speaker amp will follow later as I need to work further on the
audio codec.

I added a handful of device tree improvements to fix some dtbs_check
errors, added support for the pinctrl device and addressed the comments
from last year's reviews.

Please note that patch 0006 and 0008 depend on patch 0005 as they need the
registers.h file, but belong to different driver areas. I'm not sure if
I'm supposed to squash them even if they belong to different driver
areas of if it's fine like this. Any advice is welcome.

Patch 0009 also depends on patch 0003 because of mt6392-regulator.h.

The series has been tested on Xiaomi Mi Smart Clock X04G, on the
Lenovo Smart Clock 2 CD-24502F, on Sony PlayStation Classic Mini
SCPH-1000R and on the Lenovo Tab E7 TB-7104F.

Changes in v11:
- Removed the example from the PMIC binding, fixing some bisecting issues.

Changes in v10 [12]:
- Removed the fallback on mediatek,mt6323 in the MFD binding document
  and in the dtsi file. Suggested by Sashiko [11], thus removed the
  Reviewed-by tag provided by Kryzsztof Kozlowski in patch #1, version 9.

Changes in v9 [10]:
- Correct binding for vrtc as it does not support mode setting.

From Sashiko:
- Added missing include in MFD documentation example.
- Fixed constraints for regulator-initial-mode in regulator binding.
- Fixed wrong register write while setting LDO standby mode.
- Added missing pmic interrupt definition in the pumpkin-common include.

Changes in v8 [9]:
From reviewers:
- Added example code to the MFD device binding, removed it from the
  regulators docs.
- Added minItems/maxItems constraints on the regulator mode definitions,
  improved the mode constants.
- Fixed formatting issues in the regulator binding.
- Import the mt6392.dtsi file in pumpkin-common.dtsi, as it was originally
  meant in [8].

From sashiko:
- Added more explicit constraints on the regulator modes definitions.
- Use the appropriate modeget register for LDO regulators, Buck registers
  don't have the corresponding register according to the data sheet.
- Added the missing of_map_mode function.
- Removed some debugging code that had no use and masked error codes.

Changes in v7 [7]:
- Removed patch 0008 dependency on patch 0003.
- Reintroduced the regulator driver. In earlier revisions of this series,
  it was proposed to remove the dedicated compatible for the regulator
  device [3]. The driver does not use actually it, but it is not possible
  at this time to remove it from the bindings since it's a required
  property.

  Making the regulator-required property conditional was NACKed in [5],
  with the suggestion to create a separate binding altogether for devices
  that do not require the compatible property. I tried implementing this,
  but since the parent device needs to be declared as compatible with
  mt6323, it leads to a warning in dt_binding_check since mt6323 would
  be declared as a compatible in both mt6392 and mt6397.

  In the end the only regulator driver from the mt6397 documentation that
  still declares an of_match is mt6397-regulator and it does not seem
  to be necessary, so it should be possible to remove it and make the
  regulator compatible optional for all regulators, but that change would
  probably deserve its own separate patch series.

Changes in v6 [6]:
- Dropped the regulators driver for the moment
- Explained the FCHR key name origin in the commit message
- Introduced the MFD_CELL_* macro in the sub-devices definitions.
  A separate, independent commit introduced MFD_CELL_* to all the
  subdevices in the mt6397-core.c file for consistency
- Replaced of_device_get_match_data with device_get_match_data
- Removed the mfd_match_data enum in favor of the preexisting
  chip_id enum
- Adjusted the error message if the device is unsupported

Changes in v5 [5]:
- Double checked regulator driver with data sheet and Android sources.
  The data sheet I have misses a lot of register descriptions, but
  Android sources have been helpful to fill the gaps
- Reintroduced the required attribute for the regulator compatible
  in the bindings
- Fixed the missing reference to the MT6392 schema
- Fixed casts/unused vars reported by kernel test robot
- Removed Reviewed-by tags from the regulator patches as they have been
  modified in this version

Changes in v4 [4]:
- Dropped usage of the regulator compatible
- Fixed commit messages text to properly reference the target subsystem
- Added supply rails to the regulator
- Reworked the regulator schema and PMIC dtsi. Now all supplies are
  documented and the schema no longer includes voltage information
- Removed redundant ldo- / buck- prefixes
- Renamed the pinfunc header to mediatek,mt6392-pinfunc.h
- Modified the MFD driver to use a simple identifier in the of_match
  data properties

Changes in v3 [3]:
- Added pinctrl device
- Changed mt6397-rtc fallback to mt6323-rtc
- Added schema for regulators
- Fixed checkpatch issues

Changes in v2 [2]:
- Replaced explicit compatibles with fallbacks

Initial version: [1]

[1] https://lore.kernel.org/linux-mediatek/cover.1771865014.git.l.scorcia@gmail.com/
[2] https://lore.kernel.org/linux-mediatek/20260306120521.163654-1-l.scorcia@gmail.com/
[3] https://lore.kernel.org/linux-mediatek/20260317184507.523060-1-l.scorcia@gmail.com/
[4] https://lore.kernel.org/linux-mediatek/20260330083429.359819-1-l.scorcia@gmail.com/
[5] https://lore.kernel.org/linux-mediatek/20260420213529.1645560-1-l.scorcia@gmail.com/
[6] https://lore.kernel.org/linux-mediatek/20260612200717.361018-1-l.scorcia@gmail.com/
[7] https://lore.kernel.org/linux-mediatek/20260615071836.362883-1-l.scorcia@gmail.com/
[8] https://lore.kernel.org/linux-mediatek/20190323211612.860-25-fparent@baylibre.com/
[9] https://lore.kernel.org/linux-mediatek/20260620200032.334192-1-l.scorcia@gmail.com/
[10] https://lore.kernel.org/linux-mediatek/20260820122242.120039-1-l.scorcia@gmail.com/
[11] https://sashiko.dev/#/message/20260820125850.3B34D1F000E9%40smtp.kernel.org
[12] https://lore.kernel.org/linux-mediatek/20260902193351.185771-1-l.scorcia@gmail.com/

Fabien Parent (3):
  dt-bindings: input: mtk-pmic-keys: Add MT6392 PMIC keys
  mfd: mt6397: Add support for MT6392 PMIC
  regulator: Add MediaTek MT6392 regulator

Luca Leonardo Scorcia (4):
  dt-bindings: mfd: mt6397: Add MT6392 PMIC
  regulator: dt-bindings: Add MediaTek MT6392 PMIC
  mfd: mt6397: Use MFD_CELL_* to describe sub-devices
  pinctrl: mediatek: mt6397: Add MediaTek MT6392

Val Packett (2):
  input: keyboard: mtk-pmic-keys: Add MT6392 support
  arm64: dts: mediatek: Add MediaTek MT6392 PMIC dtsi

 .../bindings/input/mediatek,pmic-keys.yaml    |   1 +
 .../bindings/mfd/mediatek,mt6397.yaml         |   6 +
 .../regulator/mediatek,mt6392-regulator.yaml  | 112 +++
 arch/arm64/boot/dts/mediatek/mt6392.dtsi      | 145 ++++
 .../boot/dts/mediatek/pumpkin-common.dtsi     |   7 +
 drivers/input/keyboard/mtk-pmic-keys.c        |  18 +
 drivers/mfd/mt6397-core.c                     | 307 ++++---
 drivers/mfd/mt6397-irq.c                      |   8 +
 drivers/pinctrl/mediatek/pinctrl-mt6397.c     |  37 +-
 drivers/pinctrl/mediatek/pinctrl-mtk-mt6392.h |  64 ++
 drivers/regulator/Kconfig                     |   9 +
 drivers/regulator/Makefile                    |   1 +
 drivers/regulator/mt6392-regulator.c          | 764 ++++++++++++++++++
 .../regulator/mediatek,mt6392-regulator.h     |  23 +
 include/linux/mfd/mt6392/core.h               |  43 +
 include/linux/mfd/mt6392/registers.h          | 488 +++++++++++
 include/linux/mfd/mt6397/core.h               |   1 +
 include/linux/regulator/mt6392-regulator.h    |  42 +
 18 files changed, 1908 insertions(+), 168 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/regulator/mediatek,mt6392-regulator.yaml
 create mode 100644 arch/arm64/boot/dts/mediatek/mt6392.dtsi
 create mode 100644 drivers/pinctrl/mediatek/pinctrl-mtk-mt6392.h
 create mode 100644 drivers/regulator/mt6392-regulator.c
 create mode 100644 include/dt-bindings/regulator/mediatek,mt6392-regulator.h
 create mode 100644 include/linux/mfd/mt6392/core.h
 create mode 100644 include/linux/mfd/mt6392/registers.h
 create mode 100644 include/linux/regulator/mt6392-regulator.h

-- 
2.43.0

