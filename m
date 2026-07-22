Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5BCE3F4DCF
	for <linux-pm@vger.kernel.org>; Wed, 22 Jul 2026 20:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784752441; cv=none; b=r1mykbwKG5jHirsdlVoJ4pU7EqBxTVquhHZv6aYYsFzZ1ElwACvs/EX9v06HNPOCTW6nMgdSg4guss5Re9G+Aa4W8ia5Yc2SBy3v9OHi0kqytmLiKABUt4vZTE3ZT/VXjjtUIi5hgwW3kvRhOIaiK+0p6xdSsc9/TLUMWFKQsGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784752441; c=relaxed/simple;
	bh=jmoCVhQ8DzIGiKmzKU0sXQH0a1YiKOKD1szhVoiS8N4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gMgfaucv0afTCNoS+GLdQaIBMGf5XUn5dBrJeBArVZ8Fd/IBpYWf7S/+S2/u84yocwrzq69xUIj3C2K5qcQSzvxcb/uM/e039SYyYmHJ99fb6WTX/BnBSntzZsvrdcABtikG9c9u/7z6iXG/08koOCPJDqJKlWSeToFMe1FOx2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CY6jaHER; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CY6jaHER"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4954aff6088so38938095e9.3
        for <linux-pm@vger.kernel.org>; Wed, 22 Jul 2026 13:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784752438; x=1785357238; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hPNYOvoeyuyNbMmH40+o4vpJO4lwHxLJGrBhXaLvXKU=;
        b=CY6jaHERMaH6qFJKOk626jIbVFeVG2SCXj/KVLlZ1klZTeNPZcogMDmtMLGhmRLAEq
         XDw9ki19D7lVt+ESrlw2pAhZQmYb03t9h/bOJgY5F8bgUegR09Uu3jQIpN4GgLkkdgbo
         lxKBtQI2sjZl8G32WSr8JdroHDCRCTsml9q6uuppnfPM1Wod5StqFq3DYdleid5j6nyG
         dUWCpjeiVmnMirxhQsoHOkboXegs5KOp/DTbCg9mc8PdXBa0av/Kb4KTOtvMx08sI79I
         dkPpOctzhluLrvzaTfx+MPyh6h5AbYxXwUqYlEd9OKmTbAHKYl3DULnQgVaUBTd5ew/G
         cz7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784752438; x=1785357238;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hPNYOvoeyuyNbMmH40+o4vpJO4lwHxLJGrBhXaLvXKU=;
        b=EC7mDR0zCijMQUOpRnMhdglqYAYzFmhPIM5dYRlwCyN8vupLC7FwHEuhf37oFmaimi
         kztWhXZBdhmPW8mQaOrnJOdom9sZTktZTe8MIZa0nITj7oyXwt+uIPBYpdoUK7xGlZgO
         OwVVwoi2jP57Wg6+TzqelHLZL0r3dgabuwV6sLORtfmAO43pQLByT4kvsh7ZgvytN9uN
         1WwYZSkJwd+M0w+bXTDkkyVxvdaI/rr0q2xkBQ/GV8+82X1xurz9yk2y3PZ5z09RsVLm
         Ot+K66cyl0pi3zlboujA7ro3tI4SdBTvG22lECN4OJk6LGIzMiQNuYhtfpQj91DPnpOQ
         PaQQ==
X-Gm-Message-State: AOJu0Yz3tGUw6unUM6jR3d3FpHmb+wn96ow3A6WD2zKyf5LUS3egIC+j
	qYHEaB4Z09BED/kJzvFuZ8f1At/Fl9KOdNnG7rr/NmY/y9GnxFQCzWZJ4bztaW+zzDLpyw==
X-Gm-Gg: AR+sD132lpV37VUPeTr+B0PJZWEBss4Wn6QqAypkbWjbmMEAgKhBfpPwT/nPMtTJp0J
	DYiH4BO5u8NCPlN4MXofxeLJ0rQaqltj3PD1HsqTu4JWyp9HmJppCpJ8DG+JXa89/GRx+hLfA9f
	TJyLDrDWQnkotL34nsTzIpzebe26nZG52OIRLlKvNfWNDU88vxCHU5cdLYfnfMACNP4niMn9A9j
	4/5OaOrKj1D9hxFTdoKfiJwuRq8gpVlC63Efv/JVz6H/X3G/MDyXhdyiQVwwYm/WrsVluqCFbp3
	UsUO0FbLsgP9boMKcbI0vy+4hkkeTd/oi4HzLijRDR/dS/TwzYwq1xMgHs3OQqregpQ5/957MFz
	bubuDy3hA7P2XlpF/pC0haAsDyGZquB7n/EpUhFMnmPkEroqRGgkukcTth1/baMADC9sxgMudJ0
	4ODKkeNQmgMyQHziyrRONxOEUA
X-Received: by 2002:a05:600c:c4a2:b0:495:4e17:cad5 with SMTP id 5b1f17b1804b1-49573ce96aemr2250455e9.26.1784752437615;
        Wed, 22 Jul 2026 13:33:57 -0700 (PDT)
Received: from coolemuke.fritz.box ([2a00:6020:b320:1a00:c256:1463:a40b:d8c6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4956ab2f0a2sm63134945e9.1.2026.07.22.13.33.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 13:33:57 -0700 (PDT)
From: "=?UTF-8?q?S=C3=B6ren=20Hantel?=" <fugininsane@gmail.com>
X-Google-Original-From: =?UTF-8?q?S=C3=B6ren=20Hantel?= <fugininsane@googlemail.com>
To: linux-pm@vger.kernel.org
Cc: Vasily Khoruzhick <anarsoul@gmail.com>,
	Yangtao Li <tiny.windzz@gmail.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Rossak <embed3d@gmail.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	FuginInsanE <FuginInsanE@googlemail.com>
Subject: [PATCH 0/3] thermal/drivers/sun8i: Add support for the Allwinner A80 thermal sensor
Date: Wed, 22 Jul 2026 22:33:38 +0200
Message-ID: <20260722203341.2917852-1-fugininsane@googlemail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: FuginInsanE <FuginInsanE@googlemail.com>

This series adds support for the thermal sensor of the Allwinner A80
(sun9i), the last SoC of the family with an in-tree DT but no THS
support.

The A80 THS is an early relative of the A83T/H3-era sensor generation:
same register semantics, but the block, bus gate, module clock and
reset line are shared with the GPADC, the THS registers start at
offset 0x40, and there are four sensors (big cluster, DRAM, GPU,
little cluster).

Philipp Rossak posted a driver for this hardware back in 2018 as part
of a larger THS rework which never landed for the A80; Armbian has
been carrying his DT patches ever since. This series takes the
mainline sun8i_thermal driver as the base instead: patch 2 adds a
chip description derived from the vendor BSP (register init values,
protection thresholds and the temperature formula), and patch 3
revives Philipp's DT patch with a fixed interrupt number (SPI 115 as
in the vendor BSP - verified on hardware, the original SPI 31 never
fires) and critical trip points.

Two A80 particularities are worth calling out: the data-ready
interrupt fires at the conversion rate on this SoC, so it stays
disabled and the sensors are polled, with the interrupt line serving
the alarm/shutdown events only (as in the vendor BSP). And the A80
SID is not yet supported by the sunxi nvmem driver, so calibration
data is unavailable for now and the driver falls back to defaults,
which produce plausible values on real hardware.

Tested on a Cubietech Cubieboard4: all four zones report
load-reactive temperatures (idle ~40 degC, ~54 degC under sustained
full load) tracking the BSP formula across the range we could
provoke.

Philipp Rossak (1):
  ARM: dts: sun9i-a80: Add thermal sensor and thermal zones

Sören Hantel (2):
  dt-bindings: thermal: sun8i: Add binding for the A80 THS controller
  thermal/drivers/sun8i: Add support for the A80 THS

 .../thermal/allwinner,sun8i-a83t-ths.yaml     |  1 +
 arch/arm/boot/dts/allwinner/sun9i-a80.dtsi    | 68 ++++++++++++++
 drivers/thermal/sun8i_thermal.c               | 93 ++++++++++++++++++-
 3 files changed, 161 insertions(+), 1 deletion(-)

-- 
2.43.0

