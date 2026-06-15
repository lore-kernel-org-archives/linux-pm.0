Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49FDE3E274D
	for <linux-pm@vger.kernel.org>; Mon, 15 Jun 2026 12:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781527909; cv=none; b=KUnkkl9qKeTw1WyZJkquLSyY/S2uD1eMiUHBTiZQ0YlNFUnZ1+V+nWPfYxxcC00YRc5WN3i41HFd6sANO68BbagKt3bR+Rghh2hQ7psji53jCH4EUKObVTdkPC+67Xu/Mzl778kmB4jvyafxOijqYOYDLEIfMm5LNLxPk/pifT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781527909; c=relaxed/simple;
	bh=qvJVXowb04UsIXxBDYgZ54VKsJDx0YmokNWEWgHEC24=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=A/6TslcDRrQejwKXMiOnEIclHQ5tjb8ZZKlG1bnCIP3WHkE/rG1y4mS5FLoWo0phsh2PeW6SnDPI0P7D6tt6/N3UpOvW1XA37jH40XteTqOsy+lI+Jpx6ICHcavCIPwvBJ+/fc+E5tCP6dXEdI341KVqFtLWERbnxDjFglSgNwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=jIWeFxpM; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="jIWeFxpM"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-460662fcb4eso2186561f8f.0
        for <linux-pm@vger.kernel.org>; Mon, 15 Jun 2026 05:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1781527907; x=1782132707; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5lb8/KSqs2mkhShiOS7gzeEphH2sgfBl4sVBkM5ax/8=;
        b=jIWeFxpMMU8bj8hipff0kiPFDE2WELyOaVrNCbUAkF+WDvfAa180bRhaVYQY9rsVQP
         ToEkqoOLc6Mloi/9oygv8cZ4bSJqz+WjKl4kBi2zCXRwNP32p70r5I2LraT34j/sDCqL
         CZPi6lBMm+AmuGDK5MemOZpex4EmuMhVl6NSLxwvSKwNh942SWfTIjZGZCvBGlFdxaGU
         2Ww7YT+rxNtx788heL8dPFPQmp1TL1TDbwBQuBrVWYHObyDlXERkHV2F4aXPyesKdAiZ
         dXS6TWW3gWJUhsNyvsnECbbkX0q+8PThgvwiDj1721XuepxI1XvFlnVhnZXirm5dbSTc
         8bgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781527907; x=1782132707;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5lb8/KSqs2mkhShiOS7gzeEphH2sgfBl4sVBkM5ax/8=;
        b=c+W5kjrqpm+VKmSawknG2GnXbQa7BzG7bBAzv1/yJoF9tqByS5u+WjEvFs/Z2wItP8
         Q9DykIxizwPDiQwlSJb6eEIU4PWEuMYSrCcvijugacPaUcrJZYZjBOIiWg9r7sEkA5+r
         qKkeVSVnTVb2WDhxtvZzzjoKqbL+5viVYbwxWmDnbQp+qQqQdIqJb35z9TXMZr8YLicN
         v6n8eS2NteZV0FsGgnSKqXF/6Dh8vYa3076zbqxhk9sjCRAYh8D/alVX/RctsLYR7zxm
         sGo3wodGtPez6Mww8SeIPR1h1m5AiMvcQTjxqkEmBvHp06QyiAthJXy87VUXCttKq6OK
         TkcA==
X-Gm-Message-State: AOJu0YyUFT6RNjZf3h3Y04ZMaPCT5btLgf+3gywSoasp3psUdpSFHA3c
	U6pVKMtENqimOYpiEtgxgNl2HsQfcEygOd+kpMSKbZ63SYpytYiVLxoBv12d5sKD254=
X-Gm-Gg: Acq92OGQyIIV99F5rD6V1oAmdLuqtLlIaw/7519gQL6PyuDuEbNantd5/6HdAOXi9ej
	yBdzQdy54wMDJl/Tl0O7hG5pcfG137XhszY8th2kjS0Vrukk+bDJH9Bb7sS86ouSmzpZXfFkkRs
	n59IMLfuG2O5B6SVYffeXQepmztpjSA0/xz0f5lUF9cKGG76790YWUSW1UQz37IUEwb19NSivcP
	rOtQnl3mMOXM2MQQbzp3ghlF7ERL0IDEItIP6zViIWDsXBTZKu8mENe3lmZ94RVrmjihLgkDs5e
	PXFqQuDMUwHrv7GhEacLTp1mJIp5cgIkkAlqHcFTj0ddPPhF7ZHE2R/mt1TxgI5dPTVZb2LRQVJ
	IO/DzJiTEqM4cr/+Y+7A7HsP6Icg3LvmiDmxaaP4yMbnWj5hKKKD8gNtunR6Ykb14RP7uYo5oo7
	TVU80QoERk24EOnfRLlJh/Adj68XAG
X-Received: by 2002:a05:6000:400c:b0:45e:b99d:dad with SMTP id ffacd0b85a97d-4606dbe5a84mr18890507f8f.38.1781527906562;
        Mon, 15 Jun 2026 05:51:46 -0700 (PDT)
Received: from localhost ([2a02:8071:56d1:2de0:559d:eec2:887f:c200])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-4606f263923sm34621556f8f.2.2026.06.15.05.51.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 05:51:45 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: Maximilian Luz <luzmaximilian@gmail.com>,
	Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] power: supply: surface_{battery,charger}: Consistently define ssam_device_ids using named initializers
Date: Mon, 15 Jun 2026 14:51:37 +0200
Message-ID:  <bc8eff03b2f36c82af5a75fc7114c277228921db.1781526433.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2783; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=qvJVXowb04UsIXxBDYgZ54VKsJDx0YmokNWEWgHEC24=; b=owGbwMvMwMXY3/A7olbonx/jabUkhiz9r1EMjw5dtTi2wLDnzuxQnUlXm69EqzoYTLRR3vXzt vXeePu6TkZjFgZGLgZZMUUW+8Y1mVZVcpGda/9dhhnEygQ2hYtTACbC4cDB0JIpVRqw+k77qVu1 zR03vstKSHft5XiRNVf2zer/Gg0X3NbF880PZ85m+lWV49/hUlUzi+nLlFsfLQzv3ri77dfObj2 POyc7/EPaEyP7Iy6vXeoy33KNkbrXNcZLj43LF0Ul/utKyNv8XGFFGru0c/W9hW/7VULLvnQW6K m81NTO+3jkwWdL+6VKjOHRq/UdX16d3CbzzrjfZLt9aq7A7mULjp5fLCLz/MryzdO1c1c/vuL55 PbFi78FsiRvrOmbmZnOV7riR0+FU+Y8R9Xlx39rs5xRZexNdOKMLVMSywq9enpjD+dkjderp//q uNK0fJ+VYPWnnvTyEm693reRe2VT90q0FN5bwVlUM/U3AA==
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

The .driver_data member of the the two struct ssam_device_id arrays were
initialized by list expressions. This isn't easily readable if you don't
work with the Surface System Aggregator core regularily. Using named
initializers is more explicit and thus easier to parse and also more
robust to changes of the struct definition. This robustness is relevant
for a planned change to struct ssam_device_id replacing .driver_data
by an anonymous union.

While touching these arrays, also drop the comma after the list
terminators.

This change doesn't introduce changes to the compiled ssam_device_id
arrays.

Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
Hello,

the mentioned change to ssam_device_id is similar to
https://lore.kernel.org/all/cover.1779878004.git.u.kleine-koenig@baylibre.com/.

That allows to get rid of the casts in these two drivers and thus
benefits a bit more of the (admittedly weak) type safety of C.

But IMHO the improved readability alone also justifies this change.

Best regards
Uwe

 drivers/power/supply/surface_battery.c | 11 ++++++++---
 drivers/power/supply/surface_charger.c |  7 +++++--
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/power/supply/surface_battery.c b/drivers/power/supply/surface_battery.c
index c759add4df49..1273b6082311 100644
--- a/drivers/power/supply/surface_battery.c
+++ b/drivers/power/supply/surface_battery.c
@@ -852,9 +852,14 @@ static const struct spwr_psy_properties spwr_psy_props_bat2_sb3 = {
 };
 
 static const struct ssam_device_id surface_battery_match[] = {
-	{ SSAM_SDEV(BAT, SAM, 0x01, 0x00), (unsigned long)&spwr_psy_props_bat1     },
-	{ SSAM_SDEV(BAT, KIP, 0x01, 0x00), (unsigned long)&spwr_psy_props_bat2_sb3 },
-	{ },
+	{
+		SSAM_SDEV(BAT, SAM, 0x01, 0x00),
+		.driver_data = (unsigned long)&spwr_psy_props_bat1,
+	}, {
+		SSAM_SDEV(BAT, KIP, 0x01, 0x00),
+		.driver_data = (unsigned long)&spwr_psy_props_bat2_sb3,
+	},
+	{ }
 };
 MODULE_DEVICE_TABLE(ssam, surface_battery_match);
 
diff --git a/drivers/power/supply/surface_charger.c b/drivers/power/supply/surface_charger.c
index 90b823848c99..d4bba6b41794 100644
--- a/drivers/power/supply/surface_charger.c
+++ b/drivers/power/supply/surface_charger.c
@@ -260,8 +260,11 @@ static const struct spwr_psy_properties spwr_psy_props_adp1 = {
 };
 
 static const struct ssam_device_id surface_ac_match[] = {
-	{ SSAM_SDEV(BAT, SAM, 0x01, 0x01), (unsigned long)&spwr_psy_props_adp1 },
-	{ },
+	{
+		SSAM_SDEV(BAT, SAM, 0x01, 0x01),
+		.driver_data = (unsigned long)&spwr_psy_props_adp1,
+	},
+	{ }
 };
 MODULE_DEVICE_TABLE(ssam, surface_ac_match);
 

base-commit: c425609d6ac4012c8bbf01ec2e10e801b1923a7b
-- 
2.47.3

