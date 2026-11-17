Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794895562;
	b=TrKoJ73djAPetGNDB5HXcpi4hlrmKTxeyU+JNp5GLDolUBwUtF7Z3gq/PMzwqxIi5Tkw
	 kVmNSNbIwNv9DFBzVKQ09WK7R7i6vmDNA1fAHmY1AY4wRYMqwObMoU4lMf+fMqKXvlhv6
	 bmW+W/tBmvR2xnROHsO3JdnfM5QltKs4egiwhQVm6OGIQGqQOoCj3Lfq0tN/zUqTv+5t0
	 zo6tpz/6sK/rD3vyFh+nXphGMz/Gqtl6jCy1l99A3CnMH1zOz6eAQtZcITTHTVoa/SPMc
	 RtFYPRF/lzZTxh2KJJYpjCOIoZcupyOIIi8NHom5z7CX0k5H6ABJkOoVPkTE+kN9vbg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794895562;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=AZ+Nts8V7XrClS1oZQvmfEVzXa+kntyG6oy84QvWVxM=;
	b=r+6OkXGvFIWN+yNPHlLjDuGUVjTqh4/YTac9Hawepap3pj5iT+AfaaUXqRn2nTRyg2Rb
	 sqQizP8v2Ab9qR1gsAokrR1+iselMWzPQqcP7MKgbAQ1iL3TdJzle5H4yxgDfK8KIKD7U
	 3fxnfT5HEv0cj8c0yevzhf3JPJ7jdWYFkZQEEQAehAlOmqI5d/NwVmpisyyw484ylqKqO
	 5JL3JzmN6GsIGcWr8I/wPhIVsvEU02f0HoH3oyI0sU3S/ilPhA3EGm3x5a6NQh0SZ/vPb
	 1fA8ukJpVhPAsMifvrBsKFf0oIKsOOGCzI8aGuaSHW0/NIEbm72F/ewzg9hs1B2Moew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LtQkGBNB;
	arc=none smtp.remote-ip=209.85.210.172
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B95A606A329
	for <linux-pm@vger.kernel.org>; Tue, 17 Nov 2026 06:06:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0B95A606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LtQkGBNB
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-8a05b210703so1868719b3a.0
        for <linux-pm@vger.kernel.org>; Mon, 16 Nov 2026 22:06:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794895561; x=1795500361; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=AZ+Nts8V7XrClS1oZQvmfEVzXa+kntyG6oy84QvWVxM=;
        b=LtQkGBNBtFlMhQ915KOkq/VELhj0hHpL9kotE3e1lf+d+nrQmIoTNN211bWM1OO1Xh
         xN0Bonp5CY6clcr1V1vBDBXNhwlEEKLccovysqMH40Rp9Vfa4BnwtODC5rwqkLlHecVr
         L7pNw7s9qNoDKmlEbQmNnxhi+DRJGMLxVkQ/icdOCyZYjHe2PG34ye5dAeeOZEvCQbCo
         v1V60CRBu/GmWgKwXqRhmWVQ9vD371jCQayNuW86NrxhZLBDRTHXJ2cK7RcZ9+L3wKvp
         MWecAqjErbYOUipKjoKZWAlMveyVbZA9zyF6KVL09GONEVrti79GHQliulOLp2BRiOIc
         04gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794895561; x=1795500361;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AZ+Nts8V7XrClS1oZQvmfEVzXa+kntyG6oy84QvWVxM=;
        b=FfywvI2IlyyAIqvOsLVF1qQGHoPs8ukxJ2bngndtufLsJhv0M1QAsUBrwgVsFBII1z
         Xq09DxWVkgskFxTUROai3YubUgkvdkbnuy+N2XeubsOte0PmH2UB43Dbl1NpeGOeumTV
         n2hRrUo0Hd6xjr7z620Q6X/PS0kjnQuRLhiAodZV754ZsijKov4eU5aOhurYvivcG+CN
         5aBr43P84eoyZtoa7AyECU+X4/98gUhbmgszbqSk4hs0/Tl3w361yhwn75CZ4uOA12Zm
         tkc7AY5VOvSpbAfb8L4hqRO3NltEcFrGX5Zmc01Pplj1NXGP7FANtRgtlHOG5u+zyD5y
         uhgw==
X-Forwarded-Encrypted: i=1; AL+hErHeU2CSlypuG3w9X+z6LyAlzaQNwD1COc1O/zInR02qnhSfKyuOo0g4XU5Q/MYubEtLVXMTTuiR+g==@vger.kernel.org
X-Gm-Message-State: APuU4Z8L8maD/Z7qelNUMI7Dkw0qxIx7uJWIfwFwPD68jmgY1kbpkvfW
	KtCBQHs34VAdwh3euXDMyP8R4fiuEysvPpDWmj8lKc8CMQEN+TWF5l9v
X-Gm-Gg: AYBFou13R0bNfKYpWLrYNJ8lTjgZ+/1YNK5RmAp/7/3rPxf6uV1lGap+RL42wyl0+v0
	JhXS5JYmaQGtx11XLpMBEi3HIVE48yzlpykgYMu6nfEPJQCtG2e09/Q8WpySk1KlSM14nhCh5hI
	MyN1zCi/7WB1taYYtX+/TKyPWTGUn/1SQP76axr0edZFGbfb6rkOY5sDgdp5RaZ7IMZUE+cM8C3
	+YK/rxBnCAdzf9tQ4jjU8edIZaeZR5XLTDtxuV4kj395Swqyv8Ex7WDcbGB84EoOJGlr9md6Nye
	HhbckqGWvEII2QSOOnFMfZPB24Jkme/SI5u+3YOkhiPAYgcH7y35X+fZA7brAAP4Ch1MbGE/QiJ
	tG48Wzc5H+4UIUh9BqtYj9eZbXPxZGl9dj/maYeXMvDNI2d95tCSuRlff9mNh3zQpo0S/ObZnlK
	HkF/buF4yPWGKYcSrxh+CHrdc8TJPgwrJpoOgNwaKwG1Rx+VkBu0TyNkGBGMafakDNyyPSbk6hG
	pj+AVpB2/8sfo4adACTXQybIv07TSKhmkmVMgXj/x/bC2wRonBF46/njdeMRaeGGL4Th2mYqoed
	mnzqYAA/LqtYpNgv11SKqfsC2CPZc9E8DO23/yb3d81/KXVMnFViMY3YsnToxw4fbrUls5xd0iu
	a0LQL86dqpGxT
X-Received: by 2002:a05:6a00:94dc:b0:886:a52a:316f with SMTP id d2e1a72fcca58-8beb2e7e862mr11025811b3a.4.1794895561290;
        Mon, 16 Nov 2026 22:06:01 -0800 (PST)
Received: from localhost.localdomain (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8bed12a8172sm4464623b3a.13.2026.11.16.22.05.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 22:06:00 -0800 (PST)
From: Zi-Yu Chen <zychennvt@gmail.com>
To: rafael@kernel.org,
	daniel.lezcano@kernel.org
Cc: ychuang3@nuvoton.com,
	schung@nuvoton.com,
	p.zabel@pengutronix.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	rui.zhang@intel.com,
	lukasz.luba@arm.com,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zi-Yu Chen <zychennvt@gmail.com>
Subject: [PATCH 0/4] Add Nuvoton MA35D1 thermal sensor support
Date: Tue, 17 Nov 2026 14:04:57 +0800
Message-Id: <20261117060501.2611071-1-zychennvt@gmail.com>
X-Mailer: git-send-email 2.34.1
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

This series adds support for the on-chip temperature sensor of the
Nuvoton MA35D1 SoC.

The sensor has no register region of its own; it is controlled through
a single register in the system management (SYS) block, which is
already described in DT and bound to the MA35D1 reset driver. Rather
than adding a child node that would only exist to instantiate a driver,
the SYS node is made the thermal sensor provider, and the reset driver
creates an auxiliary device that the thermal driver binds to.

Patch 1 documents #thermal-sensor-cells for the SYS node, patch 2 makes
the reset driver create the auxiliary device, patch 3 adds the thermal
driver and patch 4 adds the thermal zone to the SoC dtsi.

Tested on the MA35D1-SOM board.

Zi-Yu Chen (4):
  dt-bindings: reset: nuvoton,ma35d1-reset: Add #thermal-sensor-cells
  reset: ma35d1: Register auxiliary device for the temperature sensor
  thermal/drivers/ma35d1: Add Nuvoton MA35D1 thermal sensor driver
  arm64: dts: nuvoton: ma35d1: Add thermal zone

 .../bindings/reset/nuvoton,ma35d1-reset.yaml  |  13 +-
 arch/arm64/boot/dts/nuvoton/ma35d1.dtsi       |  16 ++
 drivers/reset/Kconfig                         |   1 +
 drivers/reset/reset-ma35d1.c                  |  11 +-
 drivers/thermal/Kconfig                       |  11 ++
 drivers/thermal/Makefile                      |   1 +
 drivers/thermal/ma35d1_thermal.c              | 149 ++++++++++++++++++
 7 files changed, 198 insertions(+), 4 deletions(-)
 create mode 100644 drivers/thermal/ma35d1_thermal.c

-- 
2.34.1

