Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795398640;
	b=3Ovi5ivdqd0BZfavRh6RmiUQGCHzhVyrSL6iBxNph87G+3zDFZbwmxxGFzNfRcUH/E0o
	 /j4y0dmZADSEO5uGCFky9nQPm1aGHQapwaEx395e5wvL5XoOKhHY2skwE01nUIng/nB03
	 8JTRPHFkwTUGs96an7pGCQGA8vQprdf/adG0Xo84JavO9z6eUARBxMnD4dYmrSdZNZK1G
	 sid1MSH3nvxoa5rToNioLc7cU5KRWFPlw+ovxN2Z9Jhzhta5PeD84JiYgdWwARXG/Ceqd
	 2lq++Oighjk4YsEen72nSqDZW1nAoqNrbI9977neLO23Pg558tQO3O3+K+7OiX9MGfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795398640;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=veZxcNVuo2b3ptIF4Zf8vJr2Tg8zlMewCoNyj0061vg=;
	b=brg9x6W9YV5VDRwxywTgCIOshHxnoWPsSUVKQALom31+YF9cdOTahN0b8txuD2T6tes3
	 c/Zr6WNfv4sBCxzch9nCTC9xPix8WBLAApXQh9RPfv8bwv0PBpajFdqpC38aRFYTuvXtB
	 LgVMPPK0zBy92d1cWNRAzvOIr7GOdiEX4iTJ6TDjCsRzp9DQJUvNC2JY8V4q5W8KxwXlt
	 C4JBNsKeu5l0MCyUJ2UlArOl3XufswkeGdTFRGHNiRiEFScRR3r9f1KsIHOFJjdtw8Di4
	 Tr1u/USiUHBKwy8q3llf8Sr9UZvBR/F2ZjbSEF8i+vZT5CsVujVggWS5BNZaNvMGc2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QjWoDyK4;
	arc=none smtp.remote-ip=209.85.160.52
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB31606A31E
	for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2026 01:50:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BAB31606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QjWoDyK4
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-4adf4431ca0so534406fac.2
        for <linux-pm@vger.kernel.org>; Sun, 22 Nov 2026 17:50:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795398639; x=1796003439; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=veZxcNVuo2b3ptIF4Zf8vJr2Tg8zlMewCoNyj0061vg=;
        b=QjWoDyK4MYWUM0oJVT+Wu8JPCgWODjsHYWS/9NkHJD5pLycFjxmmqYOKbIPNpL7SDm
         25NsJoz6Qeeur2xybZT2Ew9puAApyxafkfes5NukfuGdAkrb47Ii9CJMUdfYww386Thc
         WQTaprlI8IxrnJ1sbiooQyfYAohoTsz1FDDvvEr+za/xsYzfG3/Nny7tTjTK6fPU4se+
         cexsM2cYBfDQvgEGR5F99CAZy0UlFeUI7IB5XQAu31+f7w0cz9rs4cAGfm8/XltDguv/
         FBTdMS9t677xWD6VdoTJGkEWnoL2V6JA1WYL0xMNDFQozXvoaSNBCd6xDAy2vCGELD7a
         YVoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795398639; x=1796003439;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=veZxcNVuo2b3ptIF4Zf8vJr2Tg8zlMewCoNyj0061vg=;
        b=UHZGWuuyMGOmyPBEBcIKtnWC7/4tX/Poy03bT8RF2TCsRMqdSz3Vmo5elc6ttUeIS1
         dMyuUxGWQO+lRf6L6OKaKjT7qTBNcZ8xpIukDRWPIg9DU6BuTzTnO52sP2fZoystZ+yD
         0hmr9A+KWy1/wfiG99OeTqS71t1L+OQ+3QUrCLKu4Yvch/Ag3FaDmDMmtHbaQJp8lF79
         8LpELZvOQkVRXSF54Qe6QS6olBci1Wl/QRCUSEsHXn5xmg+ILHsiXVNe8RHAmR3ShYZd
         HUMWjElGanYAS/E+YGXxSVOWj4QH3D+YsgfPYqfRCxn6GTV+dTs/Hzic247FqMHvbIwJ
         EMfg==
X-Forwarded-Encrypted: i=1; AL+hErHLimSkf7cp9xbGFMQyF7BML8QRhA9xE5+JsthilzvdBY0le27ui3O8Ot5Dq9b6NPbDdCeikvFgKQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z9luorfvcEIds/MflhJBm6gdaYwfm/oRIwtargM6qsXkzCwt3Vq
	pTPkOqkgODNIFUkbZPSePMkKfpw7G5QrTp/X4ffqCpjL7E6YD7xTdzhxy6BUzQnu
X-Gm-Gg: AZFdTZcnWNJCDfGcTfE3xApCFvWEhxFcu8ezp2WHFTodBnEbcvYPg2rGi74EmKBD7CG
	OX9NURks+/gMrcHNI9IHEtyI7OgzxvxmROqvnj2/XwwEljvO/PhNSH+RV3ZePj1wpJqWp2wNR/Q
	/5M5nFaoE44rlj6PPWZPnxkpDkX3+qqpwcNAxXz+h7n5tiAXx+ev5bRuDSAz/ixqNHpVO8gTP//
	MDjrChGgzx5+bTf5KluFWW74JmalJz9aBvnp0bA2Fj+YcD/HxSkiPRHjaZszd++DZ9Ft9MtOfdq
	SEsmZIVPVkyX4YTIjkKreiEAP48M8KmcoIy8qLeItfmQ32eZhWY2WbfOfmzwiIb/yRJUg/50KUs
	1HVR/EuBIr6OOd6PTQkbVSggXzTndb7Bpky9qKczC2NSSRYaefAVFck3R9gEzbWJXenRaRKRRH3
	EUe3DzyahDktBVaa3JtimfS4wX2qTMqahsHXX55wH7USSFYy1uISxOoczPzkhu5aMDFYAAQVlxt
	mW2V3cAc3yPVD5Do+H62TAJt8zxG4HFWm4FUtFF0FXScYNG1nBggGdjJSrSj7XgYvhO2ikzsP6M
	sWPuWxJzAgtrcy5weRtaek719lR7nw==
X-Received: by 2002:a05:6870:810e:b0:4a7:8aff:348b with SMTP id 586e51a60fabf-4bc81ca0d2bmr9676309fac.16.1795398638564;
        Sun, 22 Nov 2026 17:50:38 -0800 (PST)
Received: from neuromancer ([75.28.21.198])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4bc5f7ae7dcsm9209484fac.8.2026.11.22.17.50.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 17:50:38 -0800 (PST)
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
Subject: [PATCH V3 0/3] Add Cellwise CW2217
Date: Sun, 22 Nov 2026 19:50:32 -0600
Message-ID: <20261123015035.369192-1-macroalpha82@gmail.com>
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
  arm64: dts: rockchip: Add Battery Gauge to Anbernic Vita-Pro

 .../bindings/power/supply/cw2015_battery.yaml |  41 +-
 .../rockchip/rk3576-anbernic-rg-vita-pro.dts  |  21 +-
 drivers/power/supply/Kconfig                  |  11 +
 drivers/power/supply/Makefile                 |   1 +
 drivers/power/supply/cw2217_battery.c         | 878 ++++++++++++++++++
 5 files changed, 945 insertions(+), 7 deletions(-)
 create mode 100644 drivers/power/supply/cw2217_battery.c

-- 
2.53.0

