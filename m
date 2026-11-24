Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795547632;
	b=SzbvNuny4G//mLFmbljDDgxiAttkCEWmjTm72ozXmCRs+FU0j1EY0LEn6ttxzeLGRkoZ
	 3vxUlnKGXHHPpxdtMPpGhvtrzVUHaY+Uec5mx0KGTc26NszRBhukuYGTom5BJGRe82seC
	 L/ofewTJyPj8v4P/kt5anOrUh9V+mBcqOJugk7J/Ao00zzThqkZNeA/2OSX0TB7Q4iDs8
	 pa71jz4c7G3XU6kytx6o3KeKRfHhq33bEgVrWCx9PTHMap3tCAGEgrPr+5QtJMvW0GbhH
	 VzCQx1WxnsFLtXxXk1qnjpmnHqqPX1LOetQOsvM4XU1R+T8UH6sgKo848BGBTdWv2vA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795547632;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=XeNdzIttNMTE0MJO+i5BOMI8/bNW8dsc8julRJQrMKc=;
	b=LpTqpuRO04v6g7ji6qmnxBWbszNXAbNV62b7L47k77SHwWnM+9LjXl3A8edW2aTaxSDL
	 6Aum7zisG06vzQ4bnLWYYm1+SQZrxU+Oe/JF+ejkeP1/VNMLq0KqsNeYicG+ET1MWZM9U
	 PmCakiN9mxG1DXU6VN/Ad/XI8fYdKkYh9RSOuB03xryRkhF0GE1LVatPB5yek6anL6b+L
	 VHB4SPKSGKMahmSY9kdtI3htgMpuQGEc4p1UJQG6oJ4AOoy3AL0bnUAIOdsbmzcmgkO5Q
	 2OF3fr9ZTZytjmiUDjUHkkUGzUeEaHuJayyMc9q4cUfstx8q6lHRnvJqj7c7QfjyOyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cLkts1ip;
	arc=none smtp.remote-ip=209.85.167.174
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B6F3606A321
	for <linux-pm@vger.kernel.org>; Tue, 24 Nov 2026 19:13:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9B6F3606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cLkts1ip
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-57e4bd7fb1eso413053b6e.0
        for <linux-pm@vger.kernel.org>; Tue, 24 Nov 2026 11:13:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795547630; x=1796152430; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=XeNdzIttNMTE0MJO+i5BOMI8/bNW8dsc8julRJQrMKc=;
        b=cLkts1iprVLlgY9F+WAkIn7UyO2Lkr9VzsxUclyufbtEI1GTf/GdU9TUzrwfw+Q4jB
         7jVIK4tVXYHUr28akTYoAfrdbRxIT1W8imb3q21ogLZ0/M3sV1pxyY6PQnfrfrdQ84KG
         q8aGxP3bB2LY1Wc02OeJpAuqIazw3RisdacbYmW53Cuq6pjbB0SnJlfbzLeQUIwjWQlf
         qewCLwXQvYcS4DIGZiEhmh7dCwUzVIgjiA7xOAvvPib1s/Js49jQR4TeRrMg/olqLArQ
         fVrR2xwDIKBwYzx6NFBaQqagip/U7eBEUI64MZ6QGWxeZwVaOL0Yy/T5j9QjBqt4p/3+
         cW+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795547630; x=1796152430;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XeNdzIttNMTE0MJO+i5BOMI8/bNW8dsc8julRJQrMKc=;
        b=uqPPW8Wb4jGX6xEMA83Sc9SWjVL9MNaNMSq8j17OZtl1MnCg/pG4fEkjSbOIHH0NKd
         /yUSTUHNgnIbqemX3L8kB0M8coaOil34phjeWxq6XcxzVFU4NRQzNafRoY1uTpYHgY8V
         vAQUsgnZWt54PxO5xAjLfL7uRGu6VDQQSeejHKg7uj0EH8CsJYbrTPG/fW7u4FRNBnkR
         /kOaqO34SlciH2MXBQNhhHEktmCrkY7Xk/+horUiUahVs4F+trDk3F9o+KVBcOSF4ItY
         NdCGjFG71MCVpPj2LVXPShUlDK4fIYrXWru21SgnYTE3LdbumEVj+/RjdeT6EsLoH8TG
         rNJw==
X-Forwarded-Encrypted: i=1; AL+hErFKPORwWMYQMHtv5dMBh+QIg57/a49QKbbmoVOm+1TJ029QqDEX9EO5J7Nfm79ruPlq6qsXNF1+JQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z+tZIJrrrOzuQ09TTIzRWFkvHRVDq+/p/aOM5biF1HynuWTGfzV
	EXrsMa5dGRbNostDN/2XLFn5ZU3ua/wOnN6BN3nH4hm8/s6bT65ke9FDoDwWtQ==
X-Gm-Gg: AZFdTZeaqOZDuF43DPqHty5vhF2+SCEMPw1dBAsr0xFw4SVaVXno2B9hGw/ifHYVT3Q
	FVwib56TiI7jV+SQajzmLBn29qArBrFOtFAGieLJY0VnPR5ySUzC9WHB/DjkMmKoCU32YYWm4d4
	3VHh2QyjrpsC6ps47r5cvtMo4aALCaSk13jIyZ1KWF4VN/MxII1c+PYHrUS4+nrgbldMO97zpGw
	uQbCG2221dnEyoB3R6GkJv+weggfL7+sIROx79t/hOK3TMY7+rNp/HrlUhsjnnMZK4Mk+NFBEmA
	U27eJxv1RjQzeaw/HAVlthzHTBzYahZOH/qO3CysjYazmZlIHu5EkfKIMuM5JSbenjVs6v0kXQg
	JI3YkKDUmaYnMp2nJJ5Vy96PTHV9nL5uetczV0EXsyWyDw1IL9LkDCCbBNDkwOANf5+LzALMdEL
	gGmL8j5lXb8GYJSrTvqAMgHSNwpg2+uW72R0x94fp9E+LgqSBfbGhLGy4BkMxfqfmDvNWgdD0PI
	IZ8o6iBFKkNW9FsKBs04EPoRi8dLKYh++P2UjI1Jq8N9zjyy+mCFiYWSm4KtsCAshDRmwOiHFe4
	2xdxMaIpMaakw8zjxIRH3DLx02HxmfQ=
X-Received: by 2002:a05:6808:c1d3:b0:572:f1d1:d6b0 with SMTP id 5614622812f47-57a0c9c5064mr14920907b6e.65.1795547630522;
        Tue, 24 Nov 2026 11:13:50 -0800 (PST)
Received: from neuromancer ([75.28.21.198])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-57a362575fbsm12774058b6e.17.2026.11.24.11.13.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 11:13:49 -0800 (PST)
From: Chris Morgan <macroalpha82@gmail.com>
To: linux-rockchip@lists.infradead.org
Cc: devicetree@vger.kernel.org,
	shawn.lin@rock-chips.com,
	linux-pm@vger.kernel.org,
	heiko@sntech.de,
	conor+dt@kernel.org,
	krzk+dt@kernel.org,
	robh@kernel.org,
	sre@kernel.org,
	t.schramm@manjaro.org,
	xsf@rock-chips.com,
	Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH V4 0/3] Add Cellwise CW2217
Date: Tue, 24 Nov 2026 13:13:43 -0600
Message-ID: <20261124191346.434143-1-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.53.0
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

From: Chris Morgan <macromorgan@hotmail.com>

Add the Cellwise CW2217 battery gauge driver. This driver is based on
the sources used for Rockchip's Board Support package [1] but has
been updated to use the regmap API and devm helpers.

[1] https://github.com/rockchip-linux/kernel/blob/develop-6.12/drivers/power/supply/cw221x_battery.c

Changes Since V3:
 - Two more small fixes requested by Sashiko, one trivial fix for the
   to not always write CW2217_CONFIG_RESTART for the cw2217_active
   method and a small fix for the regmap writeable/volatile ranges.

Changes Since V2:
 - Fixed more bugs pointed out by Sashiko.
 - Corrected an integer overflow condition when measuring current.
 - Corrected logic for when we don't have a user specified battery
   profile.
 - Added power supply changed logic in the worker.
 - Updated the Kconfig text to note support for the cw2215 and cw2218.
 - Added a check to ensure polling interval cannot be below 250ms.

Changes Since V1:
 - Added a default value for the shunt resistor in the binding
   documentation, and updated the commit description to note that the
   min and max for the battery profile is now per-compatible string.
 - Fixed bugs pointed out by Sashiko bot, and corrected units for
   temp and shunt resistor values.
 - Corrected include pointed out by kernel test robot.
 - Noted in the commit message the patch is based on original work by
   Xu Shengfei at Rockchip. I did not list him as co-developed or
   signed-off since I did not have his permission (yet) to do so,
   but I have his authorship included in the file itself.

Chris Morgan (3):
  dt-bindings: power: cw2015: add cw2215, cw2217, and cw2218
  power: supply: cw2217: Add support for Cellwise cw2217
  arm64: dts: rockchip: Add Battery Gauge to Anbernic  Vita-Pro

 .../bindings/power/supply/cw2015_battery.yaml |  41 +-
 .../rockchip/rk3576-anbernic-rg-vita-pro.dts  |  21 +-
 drivers/power/supply/Kconfig                  |  11 +
 drivers/power/supply/Makefile                 |   1 +
 drivers/power/supply/cw2217_battery.c         | 878 ++++++++++++++++++
 5 files changed, 945 insertions(+), 7 deletions(-)
 create mode 100644 drivers/power/supply/cw2217_battery.c

-- 
2.53.0

