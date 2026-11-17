Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794903866;
	b=aFNZkch+rHtBuTG8MHeAV/wwxyGtC+Ev+8iVNBVa8uS088jiMIdqmd2k4enuSLw0hOkg
	 k1/TSFJNFoqvkZwcPU9LlY/yyXj6EIeUSLfMarqdEuopXc4VMF7C0p8NKxysq2pCONrVK
	 EfxSsThh6HIL3U2+D3x/Di5seaL68RXR6ulKj0Q1MEaXEN7RpckRhvD94PlvR8Ggkw5Qw
	 fFpmnvJQ7QFLsoPlo63J7+TAiC/AI11m8YtFI77/Z2pKVmooLAgSVZoZKiDWYGdUElS3b
	 4x9Uinn1NQwa8jiKMPyYarb37biKYUNlGRWsxthxF/GPqoHmCI8gX43iWzRLDnpTsLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794903866;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=gOxtFzjpUfLxN/U756DChYjRW7nHZoIiexI0t8uMS64=;
	b=HYbby+ou6UFRaylNBBwApiUyKAiTiDX/sp2tnux76DxJ1zQlRrZkXgDSzn8nYvEYA4HL
	 Bv0IBqURD9IIKrqEd5XOIrsc8FF1RBDmRp3AzzOzWm6yF32lWG33Zb+ghPMP6RDzdHH1M
	 Nfb6ydWlf3BFV4QoRonhv15nm90N+8+UUN+EXo/xT8zKFU8P7EnZL+V/ADQ7uZFKq137u
	 28y+LmAfZpyYTOhuQVImL2udFBHaW8dytpJCHhytOeNI5Y4SyJTyP9l9mdE3zSJYj1H2e
	 KtJcLiXSYI5bKTW/fz2ICTAVxmdZjTvOdsuremjmWs+b3R+T0GfOmehuy1lGPyYEIug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fairphone.com;
	spf=pass smtp.mailfrom=fairphone.com;
	dkim=pass header.d=fairphone.com header.i=@fairphone.com header.a=rsa-sha256 header.s=fair header.b=uZ+N509i;
	arc=none smtp.remote-ip=209.85.208.51
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B353606A329
	for <linux-pm@vger.kernel.org>; Tue, 17 Nov 2026 08:24:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9B353606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.a=rsa-sha256 header.s=fair header.b=uZ+N509i
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6b807aab44fso2595267a12.2
        for <linux-pm@vger.kernel.org>; Tue, 17 Nov 2026 00:24:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1794903864; x=1795508664; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=gOxtFzjpUfLxN/U756DChYjRW7nHZoIiexI0t8uMS64=;
        b=uZ+N509iv4LKdxh3M+Ym2H3OFkUBdYdJ2Rr6ukqd2/dt4YbV635rE545dpLU+u+xXs
         Ng98vGPKjfZYh6uVdLznWraaN9hbTd4M2lCcalOujxH8al9EtHJozr3kGTY+axflTGc+
         /NuADXbBILxVzdY8tfWmfsksexJjx6+Vv+5n2tgqtBJZRmA/JboNR4zv9bMNlO9j4YqG
         IW41Le3smctVEk+LilijlIY0lY5RO0dNK2wYMO3DoHhQcE6LcbnjK7b9eCpJDTY5LeMF
         ZzdfgjKz6qusrmEcMnGTwSJNhi51RlNXd7s11qR67sR85d1BW3FXzQXK5WA4t8+HZ270
         6F4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794903864; x=1795508664;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=gOxtFzjpUfLxN/U756DChYjRW7nHZoIiexI0t8uMS64=;
        b=L3LmeEmQ8itEkrvsdQf+YLwbncsA+OwC8Fk8LjEqqu1i1RLmkdO4/G7tXEvMXAugGr
         7F94cyqzblh/xH28PPtxrMgGCKJEQ5cHSAWQjadh2XBlHJhcXS0l3C19XwKwnMQj2kOI
         fGrkiPHqw/4ZBPW6cEPSN/XXp+cRaZC1l40cy/mjjOuB61qXAQf8oOiqtd0C9WaH882n
         OmW+eBOH7JEuCFtreyJuej6XciVLBBTzIcwRqMTQl296H2LE+wZaitG5MiVoqGxL8W9W
         AuJwxCDnEmV4j7/fvNuu6tEgQKwGIRcZ9tOTUug/68bv9wkA0OxS7wpbwGhmFXMANR7h
         dhVQ==
X-Forwarded-Encrypted: i=1; AL+hErHlD4p4aEkgkq92cREwyRfmQRFtcQrLxRbAgQAn+vMTAaP1tMuY2eMwTcr1rLwD0FVb1U/ONNyeKg==@vger.kernel.org
X-Gm-Message-State: APuU4Z+3GWMosbAfiGKaWb8K+TSkar5LkqOmZufsiqKAXU11R9vpjLRD
	yUBdSPCccipOS5u7Ho33tk9kmlNHDlBSf3JDlpzleDHCA5OGfHqGOs9G4ZqhRlKMaHk=
X-Gm-Gg: AYBFou3L/YSnWIGNkAPyq1bcfgQcm9lbuyKahPmHCXIEos6JZoei2Lqko9JpOJw+hiQ
	IQPFyrL/xpAqFLvUQbHR/iBHk4Nz6wpXjrNQj1FXu8fkwwkLYcDrLX03IeYy5lk/cQyqGIu6k2u
	xJtxPLc3li8y+A8Wq22Vsab7CfrJrIZWBR85+wq4Qf68JW3jGnxOihA/lJUVejJCHBKnq3F0eFw
	jXO6BFjnQKXLyHU/p1Ht3Z/WszJSnZs+voRgb046Gpd3RmFiRZkzzDSR6FOaZmUbQDdTfxlXMyc
	XU+bpMygdsXCGvT5Xqf0veD2T8RZZ/Dve9LbcN0V2k/w0uiIQSAVSRwCSLqctrVISoiSZGP6WND
	9W0/QlfSDicKoeeaudO5q4jvFN69jU7bWVGKUU8pcet1xhKND4zEYhn0sES7qfP8K8YYPtdP+Gh
	yprNRfzTqoD+ZS3lzw996d5gECQ6t7r5MUdKodJs+eW4tQXQfHJben0tc0Ulf5RMaW6oZJR7/aI
	075OUbCCL6Rs+D+V14HkfQ2vKyz4ntuRFqbiUKh7yDZFVXhJvPY6Ob5OEune2g5xgYioW4CEMJc
	gjeRcYnrcn6eB3Qc4+sNf8SXrxNh4zoJju5/RLhmQidIx6CSv14Pcw8rIJ7evYj1SzeURcgGBYh
	FhgHD6OgGPPHW7FNhar2TbfJFrC2p2sUIXuReKpCye8dgU9aU
X-Received: by 2002:a05:6402:2804:b0:6b7:245a:a509 with SMTP id 4fb4d7f45d1cf-6b7c0d166cfmr8598960a12.40.1794903863999;
        Tue, 17 Nov 2026 00:24:23 -0800 (PST)
Received: from [192.168.101.179] (2001-1c04-0504-7401-4b2e-1820-6d24-b264.cable.dynamic.v6.ziggo.nl. [2001:1c04:504:7401:4b2e:1820:6d24:b264])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b7c23611casm5616953a12.9.2026.11.17.00.24.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 00:24:23 -0800 (PST)
From: Luca Weiss <luca.weiss@fairphone.com>
Subject: [PATCH v4 0/5] Battery temperature ADC plumbing on Qualcomm
 platforms
Date: Tue, 17 Nov 2026 09:23:10 +0100
Message-Id: <20261117-bat-temp-adc-v4-0-14d5d309ebfa@fairphone.com>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/23OSY7CMBAF0KtEXreRhzjYrLgHYuGh3PEiA7aJa
 KHcvYug7kVE7X5J/1U9SYGcoJBT8yQZllTSNGJovxriezt+A00BMxFMKM44o85WWmGYqQ2eaiW
 Ni8xp5TzBypwhpsfGXa7vnOF2R7W+l8TZAtRPw5DqqRnhUSnKHcchr0KfSp3yz/bOwrfG58sLp
 4wGxcFro4L13TnalOd+GuGA/IYt4g/omBB7QCAQQbYQWrBa8U+A/AfwQbkDJALHVpqjsToGw/b
 Auq6/pytrZl8BAAA=
X-Change-ID: 20251010-bat-temp-adc-8539bf0b85bc
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
 Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Laxman Dewangan <ldewangan@nvidia.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Hans de Goede <hansg@kernel.org>, 
 Jens Reidel <adrian@mainlining.org>, 
 Casey Connolly <casey.connolly@linaro.org>, Val Packett <val@packett.cool>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794903862; l=3086;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=qykqVKt9uTGSJ5RitqPySDdIMTQiACLcAePA/hsi8uM=;
 b=u96NawTqxLv3u/fbHAuMVFuEZGpZtIpIU6w/CdWExkPyFU6d1we9grj2ozoh1gv5XGR2PKbBS
 m4GD/gDw/heCcBt+La5UrW33hLFnCRUYGIf81WfggK22+AXh7iFOUn3
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

This implements a solution to get battery temperature readings working
on (for example) smartphones with Qualcomm SoCs.

The solution chosen in downstream Qualcomm kernels is exposing
ADC_BAT_THERM_PU* in the ADC driver as temperature channels with the
lookup table ("struct vadc_map_pt") for the specific NTC found in a
device's battery patched to adjust the lookup table. Patching a kernel
per-device is obviously nothing we can put upstream.

The high level solution proposed here:
* ADC driver provides temperature channel in (milli)volt as IIO channel
* generic-adc-thermal driver converts voltage to temperature based on
  provided lookup table from DT (driver has one IIO channel input, one
  IIO channel output)
* The fuel gauge driver can use that temperature IIO channel to expose
  battery temperature via the power supply device

See RFC for other variants or alternatives considered.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
Changes in v4:
- spmi-adc5/vadc-common: Fix inconsistency micro vs milli (Sashiko)
- spmi-adc5/vadc-common: use 'MICRO / MILLI' instead of 1000, use _mV (Andy)
- thermal-generic-adc: simplify devm_thermal_of_zone_register return (Andy)
- thermal-generic-adc: move iio read + convert into gadc_thermal_iio_to_temp() function (Jonathan)
- thermal-generic-adc: convert 'register failed' dev_info to dev_dbg (Jonathan)
- Link to v3: https://patch.msgid.link/20261113-bat-temp-adc-v3-0-743979a8fd90@fairphone.com

Changes in v3:
- Expand commit message on dt-bindings patch (Rob)
- Some commit message improvements in generic-adc patch (Andy)
- Fix dt node location, move higher up (Konrad)
- Pick up tags
- Link to v2: https://lore.kernel.org/r/20260220-bat-temp-adc-v2-0-fe34ed4ea851@fairphone.com

Changes in v2:
- Rebase on linux-next (a different patch to add IIO to
  generic-adc-thermal has already landed upstream)
- Un-mark as RFC
- Link to v1: https://lore.kernel.org/r/20251010-bat-temp-adc-v1-0-d51ec895dac6@fairphone.com

---
Luca Weiss (5):
      iio: adc: qcom-spmi-adc5: Add battery thermal channels
      dt-bindings: thermal: generic-adc: Document #io-channel-cells
      thermal/drivers/generic-adc: Allow probe without TZ registration
      arm64: dts: qcom: pm7250b: Define battery temperature ADC channels
      arm64: dts: qcom: sm7225-fairphone-fp4: Add battery temperature node

 .../bindings/thermal/generic-adc-thermal.yaml      |  4 ++
 arch/arm64/boot/dts/qcom/pm7250b.dtsi              | 24 +++++++
 arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts  | 83 ++++++++++++++++++++++
 drivers/iio/adc/qcom-spmi-adc5.c                   |  6 ++
 drivers/iio/adc/qcom-vadc-common.c                 | 16 +++++
 drivers/thermal/thermal-generic-adc.c              | 27 +++----
 include/linux/iio/adc/qcom-vadc-common.h           |  3 +
 7 files changed, 151 insertions(+), 12 deletions(-)
---
base-commit: 6aa7dbf8ad5ebd3babf53a4d6209018f86939f17
change-id: 20251010-bat-temp-adc-8539bf0b85bc

Best regards,
--  
Luca Weiss <luca.weiss@fairphone.com>

