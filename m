Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B263ACA70
	for <linux-pm@vger.kernel.org>; Mon, 30 Mar 2026 08:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774859688; cv=none; b=alShGkglcI/F08t/TvrgD9/ZKC0mZYdgTgCrA/NbgWwdWBfE+TnbeZeE4OwlSDG5npg1m9q9EKTV5eSzYex+ek1c3zDQLDtQtEp94kSGuTJRbIRkwL1eTDJtFuVsspP13HBCmwLBDcmF459pn62PE0OSU5QSekhjX0eFTI9cMQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774859688; c=relaxed/simple;
	bh=S/riY656uNQaeNQIky9DTnq91bWvKnSdxYdiKTr3GZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FGgYNsZwSw/nYsyEoPYucbd2fGtDjiU3aZRudUGyKpt+l76Yj5enEeKP933P2C7IKiBt7bjeZKcxd3kwnoyhhhjc506Ye5qKbCdhhqOLmU5F9enu7+ntCUD3w5KFdJuQTfbuBpcuNsf14FCVjtOhVnsIvx6fPPWyIKksJI3ExNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pJLHg8Ru; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pJLHg8Ru"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-487035181a7so27401695e9.2
        for <linux-pm@vger.kernel.org>; Mon, 30 Mar 2026 01:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774859685; x=1775464485; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/ffjqD22wwfmhO+ld9/luMon3GDz24nlqdVKsWtkc/0=;
        b=pJLHg8RuVw6tBdC1BFRqcf+pLBJ06iKWnzRW+K61Cz9uvmpI5VXT2FrXFZtB0JPhHC
         P6svvq/BvO6JKr56uFBtV0+T+4IrH9KMuxxbjMqtGXZ1sjZUodGSrbp9aMjlO69up1Et
         SUKVWZf8qaFcYSWDfjGH8OQSVUQN7vDLoGfCbqK0jTbI5SNrr0zIGx7cYH0uIktY0EBa
         Ao8E+8gd2tmjtxecJ0qAQWv24dI3oiLMmVWp8RHkLgw5qy7jjk5KAQwsB2m6DVeGyacP
         Eejnz/mzMhjCIm9yeKjGQ0e5jILrj9bv+jdnCkUuBTkMTlrkM7ODJJ60GdYrXv7f0AwU
         vlAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774859685; x=1775464485;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/ffjqD22wwfmhO+ld9/luMon3GDz24nlqdVKsWtkc/0=;
        b=iTw5DBm+oc7q/z0nhvPVzxZZItnKt9mr/8geddF9/ERfQpFyJvTh5D9768Sr0sbTNi
         TZh1uGWqP828mfxx6odDxcb6gM33VZFODmnYtHG3BRvGuULfTvFWg79wcdKmRkiUafv9
         iNDVuvOhK5oqS0zXLBP/FtcAQwAJsKBgqCkrZ7ubmip7PMVePKEZO/b8t0/HLa32hiRQ
         1UwZgK7Ih8uynZObZhUKcKHbL1XmAU2NlgMRxNe6ca72r56wnfM6Wyk6g2nwZlRn3MMs
         6dcC6J8Ec4ad/l36njaw94j4BWT/5Ht635Ey8gJAp9NZAOE6iXg3RHAGaAzzl5tKREsK
         rr7g==
X-Forwarded-Encrypted: i=1; AJvYcCXK566ACYm343+QJ2g1sNexm032aIjeM9G8tQ77i8YP+HPDt3ABDHJje0HtgTVZ6ILIz5a5U3d9tg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzZbuPwpthw7vQ+wlN1OlRvcPOTe4DFWlmFJXUGb7PjpeHlx2MC
	Vq4Bah9STMkoCbcqTkjnXiO3GM3sV15ZKjzk5BjYr+AJGiXaOUUeD+C3
X-Gm-Gg: ATEYQzyX7K2vsMeRu001Y3drykj03rt2OVGa5O0xRahioZ/Tny6xTyHykG+2D5GwpRp
	6aADq/WqzlRS7attJH8j8lqCPzNS5RYK4uJd8oTTRV3l6CtGcum+B6Np6tE9z0GyntdlJmF4kq0
	eUlaYQsk2eUqs3BuWxki8yv/PbGNiUDIHq65f/ZJ4iAZXgsy1j7OMtwg+XcLeGA4wMelQrpxHzQ
	6sST0Jk/eiz/lqNVf2PLEi+MU+fXNHUJBI3Br9/6Ye9/UbJliB8hPS+1Kis+S2FmYPCF/UL7jCE
	3WP8hgxHbOSH5n00Vf91mSxWyxizI+ZNKeht1s4ircRzG6RRoIf8VSxtM+/7xjMPAg890A09cAZ
	Baf2HQuRBCuCzqvtRKg6ob4++wVNXyg+X88o3hnHIeB3gulMnCM8bxlMW3Kr9BTCKSIPReruqSK
	NcghaN8CMQpuwtZc+Oa1g=
X-Received: by 2002:a05:600c:6287:b0:485:3b5b:eb8 with SMTP id 5b1f17b1804b1-48727ef6617mr197260045e9.26.1774859684663;
        Mon, 30 Mar 2026 01:34:44 -0700 (PDT)
Received: from luca-vm.lan ([154.61.61.58])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48722c6b495sm508329995e9.2.2026.03.30.01.34.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 01:34:44 -0700 (PDT)
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
	Linus Walleij <linusw@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Gary Bisson <bisson.gary@gmail.com>,
	Val Packett <val@packett.cool>,
	Julien Massot <julien.massot@collabora.com>,
	Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>,
	Fabien Parent <parent.f@gmail.com>,
	Chen Zhong <chen.zhong@mediatek.com>,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-gpio@vger.kernel.org
Subject: [PATCH v4 0/9] Add support for mt6392 PMIC
Date: Mon, 30 Mar 2026 09:29:34 +0100
Message-ID: <20260330083429.359819-1-l.scorcia@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The MediaTek mt6392 PMIC is usually found on devices powered by
the mt8516/mt8167 SoC and is yet another mt6323/mt6397 variant.

This series is mostly based around patches submitted a couple
years ago by Fabien Parent and not merged and from Val Packett's
submission from Jan 2025 that included extra cleanups, fixes, and a
new dtsi file similar to ones that exist for other PMICs. Some
comments weren't addressed and the series was ultimately not merged.

This series only enables four functions: regulators, keys, pinctrl
and RTC.

I added a handful of device tree improvements to fix some dtbs_check
errors, added support for the pinctrl device and addressed the comments
from last year's reviews.

The series has been tested on Xiaomi Mi Smart Clock x04g. In order for
pinctrl to probe successfully patch [1] has to be merged too, but
each patch set is independent from the other.

Changes in v4:
- Dropped usage of the regulator compatible
- Fixed commit messages text to properly reference the target subsystem
- Added supply rails to the regulator
- Reworked the regulator schema and PMIC dtsi. Now all supplies are
  documented and the schema no longer includes voltage information
- Removed redundant ldo- / buck- prefixes
- Renamed the pinfunc header to mediatek,mt6392-pinfunc.h
- Modified the MFD driver to use a simple identifier in the of_match
  data properties

Changes in v3 [2]:
- Added pinctrl device
- Changed mt6397-rtc fallback to mt6323-rtc
- Added schema for regulators
- Fixed checkpatch issues

Changes in v2 [3]:
- Replaced explicit compatibles with fallbacks

[1] https://lore.kernel.org/linux-mediatek/20260317110249.391552-1-l.scorcia@gmail.com/
[2] https://lore.kernel.org/linux-mediatek/20260317184507.523060-1-l.scorcia@gmail.com/
[3] https://lore.kernel.org/linux-mediatek/20260306120521.163654-1-l.scorcia@gmail.com/

Fabien Parent (4):
  dt-bindings: mfd: mt6397: Add MT6392 PMIC
  dt-bindings: input: mtk-pmic-keys: Add MT6392 PMIC keys
  mfd: mt6397: Add support for MT6392 PMIC
  regulator: Add MediaTek MT6392 regulator

Luca Leonardo Scorcia (3):
  regulator: dt-bindings: Add MediaTek MT6392 PMIC
  dt-bindings: pinctrl: mediatek,mt65xx: Add MT6392 pinctrl
  pinctrl: mediatek: mt6397: Add MediaTek MT6392

Val Packett (2):
  input: keyboard: mtk-pmic-keys: Add MT6392 support
  arm64: dts: mediatek: Add MediaTek MT6392 PMIC dtsi

 .../bindings/input/mediatek,pmic-keys.yaml    |   1 +
 .../bindings/mfd/mediatek,mt6397.yaml         |  11 +-
 .../pinctrl/mediatek,mt65xx-pinctrl.yaml      |   1 +
 .../regulator/mediatek,mt6392-regulator.yaml  |  74 +++
 arch/arm64/boot/dts/mediatek/mt6392.dtsi      |  73 +++
 drivers/input/keyboard/mtk-pmic-keys.c        |  17 +
 drivers/mfd/mt6397-core.c                     | 118 +++-
 drivers/mfd/mt6397-irq.c                      |   8 +
 drivers/pinctrl/mediatek/pinctrl-mt6397.c     |  37 +-
 drivers/pinctrl/mediatek/pinctrl-mtk-mt6392.h |  64 +++
 drivers/regulator/Kconfig                     |   9 +
 drivers/regulator/Makefile                    |   1 +
 drivers/regulator/mt6392-regulator.c          | 509 ++++++++++++++++++
 .../pinctrl/mediatek,mt6392-pinfunc.h         |  39 ++
 .../regulator/mediatek,mt6392-regulator.h     |  24 +
 include/linux/mfd/mt6392/core.h               |  42 ++
 include/linux/mfd/mt6392/registers.h          | 487 +++++++++++++++++
 include/linux/mfd/mt6397/core.h               |   1 +
 include/linux/regulator/mt6392-regulator.h    |  42 ++
 19 files changed, 1527 insertions(+), 31 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/regulator/mediatek,mt6392-regulator.yaml
 create mode 100644 arch/arm64/boot/dts/mediatek/mt6392.dtsi
 create mode 100644 drivers/pinctrl/mediatek/pinctrl-mtk-mt6392.h
 create mode 100644 drivers/regulator/mt6392-regulator.c
 create mode 100644 include/dt-bindings/pinctrl/mediatek,mt6392-pinfunc.h
 create mode 100644 include/dt-bindings/regulator/mediatek,mt6392-regulator.h
 create mode 100644 include/linux/mfd/mt6392/core.h
 create mode 100644 include/linux/mfd/mt6392/registers.h
 create mode 100644 include/linux/regulator/mt6392-regulator.h

-- 
2.43.0

