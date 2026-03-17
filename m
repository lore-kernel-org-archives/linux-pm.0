Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0086633557B
	for <linux-pm@vger.kernel.org>; Tue, 17 Mar 2026 18:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773773135; cv=none; b=YJWuThCtahfyvhX/GRVIR1dP/oJZJCkhfhkd5i1Z+Vbf2T5p4rWxSsjN6Os6NCWYFBYKnrjLPoEKIArErCo1cu7WEOsqSGZcrvn3bS9JLurjr41Ytw9x5CwYVdO9+HPOWwxh9yHr2lx2JANhLEzgQ7MuzqzoV9KaZ81WI4sVgd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773773135; c=relaxed/simple;
	bh=23lDuwiMBcQoU8N9rqzbooiORZF0W9JIIdfd/pF8Z3U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SevRBmOEQr8qgbFnx83WNMCYK1TpJwkVNmppT1AaJ0Cqfc+woKx69rPiPz6uGhNC+V9oOJ9+dpjWc+pByF97s4NfGPITMo/YNOQ0pvKp14qo56Pl26BPoqFiVBXWjKuWmZEPMwtsjRppzX+IOeHYcKrjzcOsbSm4kcZl24gj89E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f1yasjep; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f1yasjep"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-48334ee0aeaso54718105e9.1
        for <linux-pm@vger.kernel.org>; Tue, 17 Mar 2026 11:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773773128; x=1774377928; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=L3B+l1nCm3FNhk4kBJBwRpPq14NGITcxDK6Zz7w/Wh0=;
        b=f1yasjep3jkdPbWLcpNonfqPp60E0QH1oZMh43Olt1XVx5ODaGOkjmS4suHC9/6bbF
         eg4gMObHdgn4wLWAXZBgmaPefWlEwVkdWgn420NF9MqiOi8pR1qek1IHwr4Ltjg11ufd
         njpisY3sf/qIKm1wqDo9Pez9bseAQcg3FHXfMSaClxszUkypJydDtdJlduKqtlFKbvOS
         Oa280ublF9moJEzJWkMO5QnBYpXn9FgEc1K7VkZ2ri1cEjJiuehmbluKUn9mADmGmf43
         zEjtDiSTe/+qWU247ngEKzNG7qgcjAdZkc9bSANM8l541Pw+x7kCgxkoX42D9ocwWu1f
         dpFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773773128; x=1774377928;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L3B+l1nCm3FNhk4kBJBwRpPq14NGITcxDK6Zz7w/Wh0=;
        b=H7vZphQ/5G/UuDtaZtaYy8xfGJuqgXKLltOxpLfUWbJmFq95IBPTC81+1zNlMdHwZO
         Hi3+Da54XrgvGZJgAqND/YeHh7qPD8yTd6SvOL5Hh5MBOGVggWzOLwoZj0V5isc5DqSl
         wzaBnHiBMs/O36+my5ou2JEc+OqAG/SHGd6H4a+QuVvc3rg4VrSQDxiIxHCR1/NiXDZh
         JhzlbiwsV0A9YAQjYWk7tGGtoer79nfKXP5VrahqTwlQ/6iOujTnIfXirPL66GxvgVaQ
         bsal/K/+ZJ64eBA9lW73eumWHkfy5u8HKKn8pzFpkJEhH4nTZo5VN1r0nvPbOXYROxl7
         05WQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmPQwFhQJN/hbYNrAOXrDIhjvRcp6jHM0qk9UvPPG96lGJ37VkEaaSiapPjAbS6lYanRbFw1wDkw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxfuz0bvx/fAs6fE0Opv+D5pqB8QnjlMR1LcpdkxmBP7r3LBU1v
	y43JS/d9xKv+yMbLhqxGXF8Lxg7yHIwvuYHmvI+8e26Z+wFmfpxCoHt4
X-Gm-Gg: ATEYQzw8RyNR+rORH0peDwd8MeMwZARf3q3KyKrj8Mff65FcML10plNtY464VCu/qlA
	zzmGrOsKDtnn5qzLxREBU2cTcgMMNakBaXk4B8Ki2ud1T4hgte9c2GC2VT04O1P52xBpRM7qC/m
	SXHTwR0Zcu3fZcZfj4KqMBVrVhE3knhc8STuDB0Y8Xtc8+K6h1Y+kQ9N83amL9Eo37XOFUsCo9G
	yC2Cn6+HGnPVZmXkRec/Mbf7sOB0qRTj9xeL3nau/sxcZP7q35Xo6kM1q2mIMU2OhGzPyvAHQO9
	6SNJF8QJoPkv/sGy527DU1lrmXmLne7bmH6cO2xVgtsMZNg5KC3efwtoZzmm64X+aj6TW0p9wA1
	BPDs+lH7e7cn0XkVpRM0U9Xp5165OXxrE8eZPkBuRFBfmfnPyHK0KdSXjRrFsrg0poKWta7SihD
	hbA2vhgVxr6gibOIb23vA=
X-Received: by 2002:a05:600c:198c:b0:483:7980:4687 with SMTP id 5b1f17b1804b1-486f457232dmr11065415e9.17.1773773127876;
        Tue, 17 Mar 2026 11:45:27 -0700 (PDT)
Received: from luca-vm.lan ([154.61.61.58])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486f4ba760esm102725e9.24.2026.03.17.11.45.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 11:45:27 -0700 (PDT)
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
	Julien Massot <julien.massot@collabora.com>,
	Val Packett <val@packett.cool>,
	Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>,
	Gary Bisson <bisson.gary@gmail.com>,
	Fabien Parent <parent.f@gmail.com>,
	Chen Zhong <chen.zhong@mediatek.com>,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-gpio@vger.kernel.org
Subject: [PATCH v3 0/9] Add support for mt6392 PMIC
Date: Tue, 17 Mar 2026 18:43:03 +0000
Message-ID: <20260317184507.523060-1-l.scorcia@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The MediaTek mt6392 PMIC is usually found on devices powered by
the mt8516/mt8167 SoC, and is yet another mt6323/mt6397 variant.

This series is mostly based around patches submitted a couple
years ago by Fabien Parent and not merged and from Val Packett's
submission from Jan 2025 that included extra cleanups, fixes, and a
new dtsi file similar to ones that exist for other PMICs. Some
comments weren't addressed and the series was ultimately not merged.

This series only enables four functions: regulators, keys, pinctrl
and RTC.

I added a handful of device tree improvements to fix some dtbs_check
errors and addressed the comments from last year's reviews.
The series has been tested on Xiaomi Mi Smart Clock x04g. In order for
pinctrl to probe successfully patch [1] has to be merged too, but
each patch code has no dependency on the other.

[1] https://lists.infradead.org/pipermail/linux-mediatek/2026-March/105005.html

v3: Added pinctrl device, changed mt6397-rtc fallback to mt6323-rtc,
    added schema for regulators and fixed checkpatch issues.
v2: Review feedback - replaced explicit compatibles with fallbacks

Fabien Parent (4):
  dt-bindings: mfd: mt6397: Add bindings for MT6392 PMIC
  dt-bindings: input: mtk-pmic-keys: add MT6392 binding definition
  mfd: mt6397: Add support for MT6392 pmic
  regulator: mt6392: Add support for MT6392 regulator

Luca Leonardo Scorcia (3):
  dt-bindings: regulator: Document MediaTek MT6392 PMIC Regulators
  dt-bindings: pinctrl: mt65xx: Document MT6392 pinctrl
  pinctrl: mediatek: mt6397: Add support for MT6392 variant

Val Packett (2):
  input: keyboard: mtk-pmic-keys: add MT6392 support
  arm64: dts: mt6392: add mt6392 PMIC dtsi

 .../bindings/input/mediatek,pmic-keys.yaml    |   1 +
 .../bindings/mfd/mediatek,mt6397.yaml         |   9 +
 .../pinctrl/mediatek,mt65xx-pinctrl.yaml      |   1 +
 .../regulator/mediatek,mt6392-regulator.yaml  | 318 ++++++++++++
 arch/arm64/boot/dts/mediatek/mt6392.dtsi      | 141 +++++
 drivers/input/keyboard/mtk-pmic-keys.c        |  17 +
 drivers/mfd/mt6397-core.c                     |  46 ++
 drivers/mfd/mt6397-irq.c                      |   8 +
 drivers/pinctrl/mediatek/pinctrl-mt6397.c     |  37 +-
 drivers/pinctrl/mediatek/pinctrl-mtk-mt6392.h |  64 +++
 drivers/regulator/Kconfig                     |   9 +
 drivers/regulator/Makefile                    |   1 +
 drivers/regulator/mt6392-regulator.c          | 487 ++++++++++++++++++
 include/dt-bindings/pinctrl/mt6392-pinfunc.h  |  39 ++
 .../regulator/mediatek,mt6392-regulator.h     |  24 +
 include/linux/mfd/mt6392/core.h               |  42 ++
 include/linux/mfd/mt6392/registers.h          | 487 ++++++++++++++++++
 include/linux/mfd/mt6397/core.h               |   1 +
 include/linux/regulator/mt6392-regulator.h    |  40 ++
 19 files changed, 1770 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/regulator/mediatek,mt6392-regulator.yaml
 create mode 100644 arch/arm64/boot/dts/mediatek/mt6392.dtsi
 create mode 100644 drivers/pinctrl/mediatek/pinctrl-mtk-mt6392.h
 create mode 100644 drivers/regulator/mt6392-regulator.c
 create mode 100644 include/dt-bindings/pinctrl/mt6392-pinfunc.h
 create mode 100644 include/dt-bindings/regulator/mediatek,mt6392-regulator.h
 create mode 100644 include/linux/mfd/mt6392/core.h
 create mode 100644 include/linux/mfd/mt6392/registers.h
 create mode 100644 include/linux/regulator/mt6392-regulator.h

-- 
2.43.0

