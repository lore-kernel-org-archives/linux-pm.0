Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792749846;
	b=G0dkwrgWaS1xYGdc/tgzTC78N3AB72q1nXcjjIXH36aMxJNFhaXphjz6VJO8Dt9Eh9bR
	 HEX0f4K0VoOunpEx/q10uteUlUMCm8NvSdLwXpm0WUXDom+R7ilrYXgTpoMSDtm/Tnx69
	 +g0TxhZW8Dwpi0ABHv9c58aKt29KQ5dw08LT2OJiKrZMhk/SkVwwTB33JgOo4tS2CgiWD
	 Q/0Ju2RB3nzxxx6zXw7/Qe5CH41oJrRy8UHSwLDtaQsbuDmwVQ0kvnuGC2G+hlHxkrBKf
	 7bpv7hNJFBfKaMsSJiXTzeO1at6xbyF9+71wzp067MXgHGT1wiCDHMZT+m3euDUyN4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792749846;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=uMSmtL8aALIL7nW1ScT+iJ8InFRsxd+68YkyGBJ0A5s=;
	b=fBM3st4w/SCT37VmHYllbL0tjwhtZ41E2fJWBzL04j7ycIgjazZclIAx5OtBC3/K76YL
	 8uB9/SbhiChYURdAjhh660YUIRwFuPvnx9QL1esAEG+XzPSDCIv4lXvVbBXgqKm6A2wl3
	 RzSDw3uDAEXJBA55vDo2p0s1epwLfz/TP3oK5VY8aDyqyTyodGfTaavKRHzEVl1fw1NUu
	 gdpypY5nT51/39i3/gmZEkL+TvPDh73hRaIqgG2WeUMDNx6UzeP89tKZf7yTX7GLpD48r
	 Mfg9mR+k6MZ+opIbNzQnHLKEPNAcrwSCSWg2qW6mnpN/EAUOFUXewedwsD5wwM59YRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=mgcrea.io;
	spf=pass smtp.mailfrom=mg-crea.com;
	dkim=pass header.d=mg-crea-com.20251104.gappssmtp.com header.i=@mg-crea-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=mdifZK1c;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF51606A321
	for <linux-pm@vger.kernel.org>; Fri, 23 Oct 2026 10:04:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5FF51606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=mgcrea.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mg-crea.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mg-crea-com.20251104.gappssmtp.com header.i=@mg-crea-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=mdifZK1c
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4980fe6b3beso11219195e9.0
        for <linux-pm@vger.kernel.org>; Fri, 23 Oct 2026 03:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mg-crea-com.20251104.gappssmtp.com; s=20251104; t=1792749845; x=1793354645; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=uMSmtL8aALIL7nW1ScT+iJ8InFRsxd+68YkyGBJ0A5s=;
        b=mdifZK1ciy5XSd8Gf2qveGaW4UfjXieOLWuZf2VGaPr6OQpj+wI0/4q/K6jj6JK9k2
         lpCp7MvIyWCnm+Sj6E9TGHNPws17sjIX0rPsQPoVEjBHlsR1b7ciQ05ifR2XToLr5ivp
         jT3MHzprvRGitkFnW4BQD9RI/9WDIZXj1GeU9Znc+L99HspF7QwiDli0rOsk15skHy8C
         5CoGluNGh7/gJu8nEhUS9dwVgKaUXzehOGIRK6saqou+GByPeyzZGVlTPINqr382KB8/
         B+pg/WLDw3FFgLh8TPRFUOZuX69VGxFHcrnFbhdPxp4+l23Gq/lADqHiJ1t/CaDnqaiY
         l7ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792749845; x=1793354645;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uMSmtL8aALIL7nW1ScT+iJ8InFRsxd+68YkyGBJ0A5s=;
        b=HDL0uC5pjChYJi4AeGUXUQbb7KtxxtX39UraHTCOXMscnDkg3c//OwvXr8zt+fQFqA
         qX4r5LWVs69WhHjkX2oTLdsfY4/JhX/uC7f0oW0ZWjbz674DlSMMh6Dn01VajHj+lhBN
         HaMgmh59j6BDkpwo7tj1ZLBlqBry9PjWE7lAeHW1UWKzNBY0x77aSBIvC+i85uhHlu+o
         9UcVtoyynUXiVkiErE5l6AfHM6omBRmIZ2bh5yzv0xBiXMtvj8iqW8P3WvqlJwTgLib7
         swfVmcKK0q+BZfB3UKCQCcwBDD0Ox/ptLuWwAsAkKpRem6Vqh0GL1E6KddSslSvjeZpc
         tTcQ==
X-Forwarded-Encrypted: i=1; AKwUvBxGcfwCsGRYZ3d1s9C5piGDERi6aPUZInkPUv2h3tnjqdR49yfGYtdHBUG1kQljmYP3LhndlaQfFg==@vger.kernel.org
X-Gm-Message-State: AFq9FYI5MoCSj+wyU7N+UhNdN+reWnrdjTDVANAU/0nUNTdjJGGm3tqz
	4xEu/6J9M8g5PCzqlqbdhJ6OEooPVkwUy2mJIi6sLuBfck5a7iW9+hKF5DrPhDcth6A=
X-Gm-Gg: AYBFou2IZ9IGrHbjfm6CrVAzi0M3/4O/ZnKkqp14+ZKYHS92i82qp091FdTKZzElXRX
	8EC94ws7ixrWa8QowyXeHR7pgENj/5Da6DZp7AW42rVfJWC7sSrqI9p/ed8srMgx0CxqRvdJsY5
	K9k+2Bf22DGFBWo3MCo6w+UdWjtvLHZV2b9OOYsVYVTQOaLI/f9JxeQAM8iOyCE0gOsVWwJn2cI
	fC47i7mEkkDnAMrAf00G01C+7kM4MjDU7dFmkjfxQAa4xNY8hlxwJ5S3LbFK25IVvaRTjNPq3l1
	wAiEF3To2yanG0FiM+lqfYswiujB0Bqwut7vj2K8iiMKSNtD9c2FopAEtTsyXc38sd/QTourlrw
	dLrs8EWmM5x2GvMnIidSxd+UTnsBkaR9+AmIe5ehhQAiG1NxHG7ryD3JXBsYzbYIP8baYiF+a0D
	5Zk/ToS6MUuM9TfcwFaf0fn0O8W1AVByUOzV3hw4nfLQ+wqYErG+BqMXmG7WWYtCSpsikD9QwT5
	UFvCcpqM2SEGwAxt9omRhrRji+H7YeUsmQAMULTAgkrtbbE3x4UK/7bpHtdOtiOPowhp3rI89LU
	EXkjeIdnvSQs
X-Received: by 2002:a05:600c:470d:b0:49e:65f2:db64 with SMTP id 5b1f17b1804b1-4a211c51ae0mr27667465e9.5.1792749843285;
        Fri, 23 Oct 2026 03:04:03 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:9c3:9990:6877:44a0:5297:9502])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a21045df9dsm75761435e9.8.2026.10.23.03.04.02
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 23 Oct 2026 03:04:02 -0700 (PDT)
From: Olivier Louvignes <olivier@mgcrea.io>
To: Lee Jones <lee@kernel.org>,
	Chen-Yu Tsai <wens@kernel.org>
Cc: Olivier Louvignes <olivier@mgcrea.io>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Sebastian Reichel <sre@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	mfd@lists.linux.dev
Subject: [PATCH 0/7] Add support for the X-Powers AXP2101 PMIC
Date: Fri, 23 Oct 2026 12:03:54 +0200
Message-ID: <20261023100401.67592-1-olivier@mgcrea.io>
X-Mailer: git-send-email 2.54.0
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

This adds the AXP2101 to the axp20x drivers: the MFD core with its
registers and interrupts, the regulators, the USB power supply and the
battery charger. The PMIC is on the HiBy R1, a music player built on an
Ingenic X1600. It follows how the AXP717 was added: the existing
drivers are extended, and the two power supplies get their own
compatibles because their registers differ.

Not handled yet: the PMIC's own fuel gauge (the R1 uses a CW2015, and the
AXP2101's reads 0% without a battery model), the power key, the ADC
channels, the TS pin, and writing the input current limit.

Sources: there is no datasheet behind this. The register map comes from
the GPL-2.0 AXP2101 driver of the hiby-custom-kernel project
(github.com/Jepl4r/hiby-custom-kernel), an open replacement for HiBy's
closed module, and was checked against the chip on a running R1.

Tested on the R1, on v7.3 with out-of-tree board patches:
- The rails the stock firmware turns on (DCDC1-4 at 3.3, 1.1, 1.8 and
  1.2 V, ALDO2 3.3 V, ALDO3 1.1 V, ALDO4 3.3 V, BLDO1 and BLDO2 2.8 V)
  read back at their stock voltages, and the regulator registers
  0x80-0x9a stay byte for byte as the stock firmware left them. No
  voltage was changed from Linux. BLDO1 and BLDO2 (2.8 V, the LCD
  supplies) are switched on and off from Linux by the panel driver, which
  claims them: bits 4 and 5 of register 0x90 clear and set again with
  the screen blanking and unblanking, about 20 cycles over 8 boots, with
  the selectors (0x96 and 0x97) staying at 0x17. That does not change a
  voltage, since the registers already held 2.8 V. DCDC5, ALDO1, DLDO1-2
  and CPUSLDO are off on the R1 and only come from the register map.
- "poweroff -f" turns the R1 off, through COMM_CFG.
- Unplugging and replugging USB gives one VBUS_REMOVAL and one
  VBUS_PLUGIN interrupt, and the USB supply goes online 1, 0, 1.
- The charger registers read back as the stock firmware's values after
  boot, and the battery status is Full on USB, Discharging unplugged and
  Charging after a replug.

Every patch builds on 734bef548a96 (v7.3-7363) with W=1, passes
checkpatch --strict, and the three bindings pass dt_binding_check.

Open questions: whether extending the axp20x drivers is what you want
here (the alternative is a driver of its own), and whether programming
the charger from the monitored battery at probe, read-only afterwards,
is acceptable for the battery supply.

Olivier Louvignes (7):
  dt-bindings: mfd: x-powers,axp152: Add the AXP2101
  mfd: axp20x: Add support for the AXP2101
  regulator: axp20x: Add support for the AXP2101
  dt-bindings: power: supply: axp20x-usb-power: Add the AXP2101
  power: supply: axp20x_usb_power: Add support for the AXP2101
  dt-bindings: power: supply: axp20x-battery: Add the AXP2101
  power: supply: axp20x_battery: Add support for the AXP2101

 .../bindings/mfd/x-powers,axp152.yaml         |   3 +
 .../x-powers,axp20x-battery-power-supply.yaml |   1 +
 .../x-powers,axp20x-usb-power-supply.yaml     |   1 +
 drivers/mfd/axp20x-i2c.c                      |   2 +
 drivers/mfd/axp20x.c                          | 107 ++++++++-
 drivers/power/supply/axp20x_battery.c         | 221 ++++++++++++++++++
 drivers/power/supply/axp20x_usb_power.c       |  86 +++++++
 drivers/regulator/axp20x-regulator.c          |  88 +++++++
 include/linux/mfd/axp20x.h                    | 114 +++++++++
 9 files changed, 621 insertions(+), 2 deletions(-)


base-commit: 734bef548a96e8774d6eef5dfa2026c6edc4e80b
-- 
2.39.5

