Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE46394462
	for <linux-pm@vger.kernel.org>; Fri, 15 May 2026 10:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778840205; cv=none; b=LQVfCD+F4FShf59PkG+uBdzsp0BzS2nHiBEmYMWiSRDnGYgKjQ3fZZI55i1mo2w+39mmSlmYhgszY7iT0UDI8JwJfTzrTtuRC53mTm6KRdnfRB9t8HTkA4jVnE8/3arG2orXR9B6vHkUsUY2ZaW1ai1T9TH4+z8b0SB1KPGwsIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778840205; c=relaxed/simple;
	bh=paEo6XQ4TpPacAd3eovvsX+tblBlJQAumUzHvha1NAk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZbbHpqDUb8lb2G1jWV8W6+vGz8pQWHQUvqLW/SONTOkBVqTtYmdkMLCVmxltU6FvqheEiddIykPGxeXw5dEoQXpoN26MPE5baCbW9A5TSEHlv+VsWDf24cFctdFtTBg/uKHM5SVbmGuFSb/bPMy/lwsQ6I7qGIBJkN8xES1qWnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=GwBp72Xu; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="GwBp72Xu"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-43d73422431so6574867f8f.2
        for <linux-pm@vger.kernel.org>; Fri, 15 May 2026 03:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1778840201; x=1779445001; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pff9w99T5ZbZZPWBhC6gx1TuWA3/n1q9cr6Drpme758=;
        b=GwBp72Xup//1nq7NO+LfmXZniVdoPFAka4iBUZunz91IBweqSUJdmKfPQJxPfAWP4u
         vv4Jt87mqsi1z296dYTjA6NWZuY8nfY6t+BKurW67Pg3FZT1Cf7X9w/xcgsKfps9xl0l
         MWShgAZM5xaR/cqgQs0yDgZeESreBbRA/ZGnbqMGfKLP90sN8X8oQXkyES5H7kF5N3q2
         FXHxNI/Sk9c1/lmx/XvaasVhqBRJokKCzyjZv+QH44ROyuL8oquRc3knwMCKmE466zpc
         yrBoG3I3cLRCfRiErfBHTeEHp9Y6aPMrfu+y6EQzLFMiX6bIV1ByZlh2mIl7BZRRUZjL
         9LFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778840201; x=1779445001;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pff9w99T5ZbZZPWBhC6gx1TuWA3/n1q9cr6Drpme758=;
        b=WhbGWyaMABcB9vA831INkgMRojYqspJ9dbhp7pPzKqAxWQXUXAXzA9xTGZsaULbI/d
         DsptUwin2J72ZlYamYKhe7FEOtjXXhvOXo4WjpFWAMFGcPyIcDijU91rpVD1KyCVUEzw
         QrRx0ZRdevrvKe49Q5C1GHx9TJrLnKd31JShe1t1PbEVLbA4Pw9EERauVGHIpuJLXekj
         be/72jDmdnXE0EGPZlQfQIrYtf6W6VUVkXYJUKFPwk7WX6ZdedUB0R+k+k+F9afyq6lA
         qxPoRdF7QArXLi4hS9Wi0GuaMxkTzCjs1ISi8vgBaaUG0lGeKRcmBY9aK3/rv5WIW481
         Oyqg==
X-Forwarded-Encrypted: i=1; AFNElJ9KdjHSHAilY4O4daVmiXLRL5gBuK5wFhW1Au8Sk7qp54aQfi8iwt7U0zQG7Dlb/RnT6HRVRaFf6g==@vger.kernel.org
X-Gm-Message-State: AOJu0YyB2mwY65ybC6mW8p1fWIznmeraRXEv9rc6f1UPA8uHMY/Oe7Jn
	IpBaSt/B1VFSd4S9Zg5QI+b8TWJVKlFCZc/zTkCYNUKZrM5Nb9zCphXW9g07xktr7vk=
X-Gm-Gg: Acq92OGuxWwLUsND6h9yeEIdv4XgnK5/WjGhPtToK97DUoEBWA6YOHqLWgm5UPVG4Qs
	UvCqNb++VYFhGwysf2ytmefArB+rvtvR3mSsnif4HpIx99ymvNKerLkM/O/t5LwGw/sGxjf7aPR
	FtoFFliwtd6ymHQXtXsG3wb6OzoGn2mGUbtbV1mYnlgy9Gec8nlSJlEuLd2wnZhh1TANzpNYHeg
	2+FznZswMijWtVovx8iIBfNwhPKkJcXL+F7ZnNspHQjVBSCr7lbJTWLm2Ed53TU6rnkCXjQid48
	HHGB8Oc4JAUyY8Uk/S+sIiVcHzfL7BBAFtlqNe5IY/zCiuDNuJGXFmTgyvcZPhPXVKHTuqV+biG
	GCSKrc0Cm89hUtBBc2GFMgu+cnH7KZbhPUYLtPo7+pXXz36e3AYQxp0Ie+UDSI8pzh5cqtOis4o
	iJ9MXNty1iaEfvQ7WTY7wHn9XBAXqZz4XXxLDohQFSyy/4ptQG8dleshe9Ep3qy5DnlHDJZMabq
	16PUuSsfiyAhlU=
X-Received: by 2002:a05:6000:288f:b0:439:ccd7:cdb6 with SMTP id ffacd0b85a97d-45e5c5ca06bmr4523947f8f.14.1778840199944;
        Fri, 15 May 2026 03:16:39 -0700 (PDT)
Received: from localhost (p200300f65f47db04b9fad853b28b1de0.dip0.t-ipconnect.de. [2003:f6:5f47:db04:b9fa:d853:b28b:1de0])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-45da0a1a22csm12830955f8f.19.2026.05.15.03.16.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 03:16:39 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: Sebastian Reichel <sre@kernel.org>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>,
	=?utf-8?q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
	Tobias Schrammm <t.schramm@manjaro.org>,
	Iskren Chernev <me@iskren.info>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Matheus Castello <matheus@castello.eng.br>,
	Hans de Goede <hansg@kernel.org>,
	Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>,
	Purism Kernel Team <kernel@puri.sm>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>,
	Bhavin Sharma <bhavin.sharma@siliconsignals.io>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] power: supply: Use named initializers for arrays of i2c_device_data
Date: Fri, 15 May 2026 12:16:28 +0200
Message-ID: <20260515101629.4132270-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=28493; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=paEo6XQ4TpPacAd3eovvsX+tblBlJQAumUzHvha1NAk=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBqBvJ9UvENPZ7CCGH/bwQHmW+uho0WIJU+hqQt0 YpDvsog+K6JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCagbyfQAKCRCPgPtYfRL+ TuG/B/9bxqXk73wlVuBqL5NQLRvKIpFKPeT6f1XvWamBq9G65/9Lzzla6in8cMC0Gi8lrtqLFAa v9PprTxGbWyNJpdg57I1alHvoOlKQ9+ohRXf8f8h28FjGkZ8xMZBzqPo/+8mk2+AeQyPPlu0odl 6gYCOKowb5+ISl9OK2gzGN5VGbQMgqxEhtajxVGfsFdhYttCyr+15FiDYKRivrk3sPZeDYFYfaM Zh5m2HICopGPinI572RzvBoLwh2psj5i+fk1ms3TNpZKKMX4u11Jdix1vECgCkIP0MJKOhX8kKd fDFlTOvQx66ZuFytDajBO0NY1CQQfjnbi/056OsUSlRq+hdL
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

While being less compact, using named initializers allows to more easily
see which members of the structs are assigned which value without having
to lookup the declaration of the struct. And it's also more robust
against changes to the struct definition.

The mentioned robustness is relevant for a planned change to struct
i2c_device_id that replaces .driver_data by an anonymous union.

While touching all these arrays, unify usage of whitespace and commas.

This patch doesn't modify the compiled arrays, only their representation
in source form benefits. The former was confirmed with x86 and arm64
builds.

Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
Hello,

this series is a preparation for

	diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devicetable.h
	index 23ff24080dfd..aebd3a5e90af 100644
	--- a/include/linux/mod_devicetable.h
	+++ b/include/linux/mod_devicetable.h
	@@ -477,7 +477,11 @@ struct rpmsg_device_id {
	 
	 struct i2c_device_id {
		char name[I2C_NAME_SIZE];
	-	kernel_ulong_t driver_data;	/* Data private to the driver */
	+	union {
	+		/* Data private to the driver */
	+		kernel_ulong_t driver_data;
	+		const void *driver_data_ptr;
	+	};
	 };
	 
	 /* pci_epf */

and this requires that .driver_data is assigned via a named initializer
for static data. This requirement isn't a bad one because named
initializers are also much better readable than list initializers.

The union added to struct i2c_device_id enables further cleanups like:

        diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
        index 8a082ff034dd..b2aac7348d22 100644
        --- a/drivers/iio/accel/kxcjk-1013.c
        +++ b/drivers/iio/accel/kxcjk-1013.c
	@@ -1429,7 +1429,7 @@ static int kxcjk1013_probe(struct i2c_client *client)
	 
		if (id) {
			name = id->name;
	-		data->info = (const struct kx_chipset_info *)(id->driver_data);
	+		data->info = id->driver_data_ptr;
		} else {
			name = iio_get_acpi_device_name_and_data(&client->dev, &ddata);
			data->info = ddata;
	@@ -1630,11 +1630,11 @@ static const struct dev_pm_ops kxcjk1013_pm_ops = {
	 };
	 
	 static const struct i2c_device_id kxcjk1013_id[] = {
	-	{ .name = "kxcjk1013", .driver_data = (kernel_ulong_t)&kxcjk1013_info },
	-	{ .name = "kxcj91008", .driver_data = (kernel_ulong_t)&kxcj91008_info },
	-	{ .name = "kxtj21009", .driver_data = (kernel_ulong_t)&kxtj21009_info },
	-	{ .name = "kxtf9", .driver_data = (kernel_ulong_t)&kxtf9_info },
	-	{ .name = "kx023-1025", .driver_data = (kernel_ulong_t)&kx0231025_info },
	+	{ .name = "kxcjk1013", .driver_data_ptr = &kxcjk1013_info },
	+	{ .name = "kxcj91008", .driver_data_ptr = &kxcj91008_info },
	+	{ .name = "kxtj21009", .driver_data_ptr = &kxtj21009_info },
	+	{ .name = "kxtf9", .driver_data_ptr = &kxtf9_info },
	+	{ .name = "kx023-1025", .driver_data_ptr = &kx0231025_info },
		{ }
	 };
	 MODULE_DEVICE_TABLE(i2c, kxcjk1013_id);

that are an improvement for readability (again!) and it keeps some
properties of the pointers (here: being const) without having to pay
attention for that. (I didn't find a good example in drivers/power, so an
iio driver was used to demonstrate the gain.)

My additional motivation for this effort is CHERI[1]. This is a hardware
extension that uses 128 bit pointers but unsigned long is still 64 bit.
So with CHERI you cannot store pointers in unsigned long variables.

There are no analogous changes needed in drivers/power outside of
drivers/power/supply.

Best regards
Uwe

 drivers/power/supply/adp5061.c                |  2 +-
 drivers/power/supply/bq2415x_charger.c        | 28 ++++----
 drivers/power/supply/bq24190_charger.c        | 16 ++---
 drivers/power/supply/bq24257_charger.c        |  8 +--
 drivers/power/supply/bq24735-charger.c        |  4 +-
 drivers/power/supply/bq2515x_charger.c        |  6 +-
 drivers/power/supply/bq256xx_charger.c        | 16 ++---
 drivers/power/supply/bq25890_charger.c        | 10 +--
 drivers/power/supply/bq25980_charger.c        |  8 +--
 drivers/power/supply/bq27xxx_battery_i2c.c    | 64 +++++++++----------
 drivers/power/supply/cw2015_battery.c         |  2 +-
 drivers/power/supply/ds2782_battery.c         |  6 +-
 drivers/power/supply/lp8727_charger.c         |  2 +-
 drivers/power/supply/ltc2941-battery-gauge.c  | 10 +--
 drivers/power/supply/ltc4162-l-charger.c      |  8 +--
 .../power/supply/max14656_charger_detector.c  |  4 +-
 drivers/power/supply/max17040_battery.c       | 18 +++---
 drivers/power/supply/max17042_battery.c       | 12 ++--
 drivers/power/supply/max77976_charger.c       |  2 +-
 drivers/power/supply/max8971_charger.c        |  2 +-
 drivers/power/supply/mm8013.c                 |  4 +-
 drivers/power/supply/rt5033_battery.c         |  2 +-
 drivers/power/supply/rt9455_charger.c         |  2 +-
 drivers/power/supply/sbs-battery.c            |  8 +--
 drivers/power/supply/sbs-charger.c            |  2 +-
 drivers/power/supply/sbs-manager.c            |  4 +-
 drivers/power/supply/smb347-charger.c         |  8 +--
 drivers/power/supply/stc3117_fuel_gauge.c     |  2 +-
 drivers/power/supply/ug3105_battery.c         |  2 +-
 29 files changed, 131 insertions(+), 131 deletions(-)

diff --git a/drivers/power/supply/adp5061.c b/drivers/power/supply/adp5061.c
index 458fd3024373..7d5754c24553 100644
--- a/drivers/power/supply/adp5061.c
+++ b/drivers/power/supply/adp5061.c
@@ -727,7 +727,7 @@ static int adp5061_probe(struct i2c_client *client)
 }
 
 static const struct i2c_device_id adp5061_id[] = {
-	{ "adp5061" },
+	{ .name = "adp5061" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, adp5061_id);
diff --git a/drivers/power/supply/bq2415x_charger.c b/drivers/power/supply/bq2415x_charger.c
index b50a28b9dd38..9f801717bfb0 100644
--- a/drivers/power/supply/bq2415x_charger.c
+++ b/drivers/power/supply/bq2415x_charger.c
@@ -1738,20 +1738,20 @@ static void bq2415x_remove(struct i2c_client *client)
 }
 
 static const struct i2c_device_id bq2415x_i2c_id_table[] = {
-	{ "bq2415x", BQUNKNOWN },
-	{ "bq24150", BQ24150 },
-	{ "bq24150a", BQ24150A },
-	{ "bq24151", BQ24151 },
-	{ "bq24151a", BQ24151A },
-	{ "bq24152", BQ24152 },
-	{ "bq24153", BQ24153 },
-	{ "bq24153a", BQ24153A },
-	{ "bq24155", BQ24155 },
-	{ "bq24156", BQ24156 },
-	{ "bq24156a", BQ24156A },
-	{ "bq24157s", BQ24157S },
-	{ "bq24158", BQ24158 },
-	{},
+	{ .name = "bq2415x", .driver_data = BQUNKNOWN },
+	{ .name = "bq24150", .driver_data = BQ24150 },
+	{ .name = "bq24150a", .driver_data = BQ24150A },
+	{ .name = "bq24151", .driver_data = BQ24151 },
+	{ .name = "bq24151a", .driver_data = BQ24151A },
+	{ .name = "bq24152", .driver_data = BQ24152 },
+	{ .name = "bq24153", .driver_data = BQ24153 },
+	{ .name = "bq24153a", .driver_data = BQ24153A },
+	{ .name = "bq24155", .driver_data = BQ24155 },
+	{ .name = "bq24156", .driver_data = BQ24156 },
+	{ .name = "bq24156a", .driver_data = BQ24156A },
+	{ .name = "bq24157s", .driver_data = BQ24157S },
+	{ .name = "bq24158", .driver_data = BQ24158 },
+	{ }
 };
 MODULE_DEVICE_TABLE(i2c, bq2415x_i2c_id_table);
 
diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/supply/bq24190_charger.c
index 55da91bacc3e..6700d578a98f 100644
--- a/drivers/power/supply/bq24190_charger.c
+++ b/drivers/power/supply/bq24190_charger.c
@@ -2308,14 +2308,14 @@ static const struct dev_pm_ops bq24190_pm_ops = {
 };
 
 static const struct i2c_device_id bq24190_i2c_ids[] = {
-	{ "bq24190", (kernel_ulong_t)&bq24190_chip_info_tbl[BQ24190] },
-	{ "bq24192", (kernel_ulong_t)&bq24190_chip_info_tbl[BQ24192] },
-	{ "bq24192i", (kernel_ulong_t)&bq24190_chip_info_tbl[BQ24192i] },
-	{ "bq24193", (kernel_ulong_t)&bq24190_chip_info_tbl[BQ24193] },
-	{ "bq24196", (kernel_ulong_t)&bq24190_chip_info_tbl[BQ24196] },
-	{ "bq24296", (kernel_ulong_t)&bq24190_chip_info_tbl[BQ24296] },
-	{ "bq24297", (kernel_ulong_t)&bq24190_chip_info_tbl[BQ24297] },
-	{ },
+	{ .name = "bq24190", .driver_data = (kernel_ulong_t)&bq24190_chip_info_tbl[BQ24190] },
+	{ .name = "bq24192", .driver_data = (kernel_ulong_t)&bq24190_chip_info_tbl[BQ24192] },
+	{ .name = "bq24192i", .driver_data = (kernel_ulong_t)&bq24190_chip_info_tbl[BQ24192i] },
+	{ .name = "bq24193", .driver_data = (kernel_ulong_t)&bq24190_chip_info_tbl[BQ24193] },
+	{ .name = "bq24196", .driver_data = (kernel_ulong_t)&bq24190_chip_info_tbl[BQ24196] },
+	{ .name = "bq24296", .driver_data = (kernel_ulong_t)&bq24190_chip_info_tbl[BQ24296] },
+	{ .name = "bq24297", .driver_data = (kernel_ulong_t)&bq24190_chip_info_tbl[BQ24297] },
+	{ }
 };
 MODULE_DEVICE_TABLE(i2c, bq24190_i2c_ids);
 
diff --git a/drivers/power/supply/bq24257_charger.c b/drivers/power/supply/bq24257_charger.c
index 766eecb35694..72f1bfea8d54 100644
--- a/drivers/power/supply/bq24257_charger.c
+++ b/drivers/power/supply/bq24257_charger.c
@@ -1133,10 +1133,10 @@ static const struct bq2425x_chip_info bq24257_info = {
 };
 
 static const struct i2c_device_id bq24257_i2c_ids[] = {
-	{ "bq24250", (kernel_ulong_t)&bq24250_info },
-	{ "bq24251", (kernel_ulong_t)&bq24251_info },
-	{ "bq24257", (kernel_ulong_t)&bq24257_info },
-	{}
+	{ .name = "bq24250", .driver_data = (kernel_ulong_t)&bq24250_info },
+	{ .name = "bq24251", .driver_data = (kernel_ulong_t)&bq24251_info },
+	{ .name = "bq24257", .driver_data = (kernel_ulong_t)&bq24257_info },
+	{ }
 };
 MODULE_DEVICE_TABLE(i2c, bq24257_i2c_ids);
 
diff --git a/drivers/power/supply/bq24735-charger.c b/drivers/power/supply/bq24735-charger.c
index 637e0da65f87..99abbaf0470f 100644
--- a/drivers/power/supply/bq24735-charger.c
+++ b/drivers/power/supply/bq24735-charger.c
@@ -489,8 +489,8 @@ static int bq24735_charger_probe(struct i2c_client *client)
 }
 
 static const struct i2c_device_id bq24735_charger_id[] = {
-	{ "bq24735-charger" },
-	{}
+	{ .name = "bq24735-charger" },
+	{ }
 };
 MODULE_DEVICE_TABLE(i2c, bq24735_charger_id);
 
diff --git a/drivers/power/supply/bq2515x_charger.c b/drivers/power/supply/bq2515x_charger.c
index 437bff5bc420..0208358ebbe4 100644
--- a/drivers/power/supply/bq2515x_charger.c
+++ b/drivers/power/supply/bq2515x_charger.c
@@ -1137,9 +1137,9 @@ static const struct bq2515x_info bq25155 = {
 };
 
 static const struct i2c_device_id bq2515x_i2c_ids[] = {
-	{ "bq25150", (kernel_ulong_t)&bq25150 },
-	{ "bq25155", (kernel_ulong_t)&bq25155 },
-	{}
+	{ .name = "bq25150", .driver_data = (kernel_ulong_t)&bq25150 },
+	{ .name = "bq25155", .driver_data = (kernel_ulong_t)&bq25155 },
+	{ }
 };
 MODULE_DEVICE_TABLE(i2c, bq2515x_i2c_ids);
 
diff --git a/drivers/power/supply/bq256xx_charger.c b/drivers/power/supply/bq256xx_charger.c
index 563f512709b3..5a6634fde837 100644
--- a/drivers/power/supply/bq256xx_charger.c
+++ b/drivers/power/supply/bq256xx_charger.c
@@ -1768,14 +1768,14 @@ static int bq256xx_probe(struct i2c_client *client)
 }
 
 static const struct i2c_device_id bq256xx_i2c_ids[] = {
-	{ "bq25600", (kernel_ulong_t)&bq256xx_chip_info_tbl[BQ25600] },
-	{ "bq25600d", (kernel_ulong_t)&bq256xx_chip_info_tbl[BQ25600D] },
-	{ "bq25601", (kernel_ulong_t)&bq256xx_chip_info_tbl[BQ25601] },
-	{ "bq25601d", (kernel_ulong_t)&bq256xx_chip_info_tbl[BQ25601D] },
-	{ "bq25611d", (kernel_ulong_t)&bq256xx_chip_info_tbl[BQ25611D] },
-	{ "bq25618", (kernel_ulong_t)&bq256xx_chip_info_tbl[BQ25618] },
-	{ "bq25619", (kernel_ulong_t)&bq256xx_chip_info_tbl[BQ25619] },
-	{}
+	{ .name = "bq25600", .driver_data = (kernel_ulong_t)&bq256xx_chip_info_tbl[BQ25600] },
+	{ .name = "bq25600d", .driver_data = (kernel_ulong_t)&bq256xx_chip_info_tbl[BQ25600D] },
+	{ .name = "bq25601", .driver_data = (kernel_ulong_t)&bq256xx_chip_info_tbl[BQ25601] },
+	{ .name = "bq25601d", .driver_data = (kernel_ulong_t)&bq256xx_chip_info_tbl[BQ25601D] },
+	{ .name = "bq25611d", .driver_data = (kernel_ulong_t)&bq256xx_chip_info_tbl[BQ25611D] },
+	{ .name = "bq25618", .driver_data = (kernel_ulong_t)&bq256xx_chip_info_tbl[BQ25618] },
+	{ .name = "bq25619", .driver_data = (kernel_ulong_t)&bq256xx_chip_info_tbl[BQ25619] },
+	{ }
 };
 MODULE_DEVICE_TABLE(i2c, bq256xx_i2c_ids);
 
diff --git a/drivers/power/supply/bq25890_charger.c b/drivers/power/supply/bq25890_charger.c
index 868e86e1749b..c1c12a447178 100644
--- a/drivers/power/supply/bq25890_charger.c
+++ b/drivers/power/supply/bq25890_charger.c
@@ -1617,11 +1617,11 @@ static const struct dev_pm_ops bq25890_pm = {
 };
 
 static const struct i2c_device_id bq25890_i2c_ids[] = {
-	{ "bq25890" },
-	{ "bq25892" },
-	{ "bq25895" },
-	{ "bq25896" },
-	{}
+	{ .name = "bq25890" },
+	{ .name = "bq25892" },
+	{ .name = "bq25895" },
+	{ .name = "bq25896" },
+	{ }
 };
 MODULE_DEVICE_TABLE(i2c, bq25890_i2c_ids);
 
diff --git a/drivers/power/supply/bq25980_charger.c b/drivers/power/supply/bq25980_charger.c
index 44af3a0c92e5..eced3aecc7d2 100644
--- a/drivers/power/supply/bq25980_charger.c
+++ b/drivers/power/supply/bq25980_charger.c
@@ -1266,10 +1266,10 @@ static int bq25980_probe(struct i2c_client *client)
 }
 
 static const struct i2c_device_id bq25980_i2c_ids[] = {
-	{ "bq25980", BQ25980 },
-	{ "bq25975", BQ25975 },
-	{ "bq25960", BQ25960 },
-	{},
+	{ .name = "bq25980", .driver_data = BQ25980 },
+	{ .name = "bq25975", .driver_data = BQ25975 },
+	{ .name = "bq25960", .driver_data = BQ25960 },
+	{ }
 };
 MODULE_DEVICE_TABLE(i2c, bq25980_i2c_ids);
 
diff --git a/drivers/power/supply/bq27xxx_battery_i2c.c b/drivers/power/supply/bq27xxx_battery_i2c.c
index 868e95f0887e..c4e7a9521d08 100644
--- a/drivers/power/supply/bq27xxx_battery_i2c.c
+++ b/drivers/power/supply/bq27xxx_battery_i2c.c
@@ -225,38 +225,38 @@ static void bq27xxx_battery_i2c_remove(struct i2c_client *client)
 }
 
 static const struct i2c_device_id bq27xxx_i2c_id_table[] = {
-	{ "bq27200", BQ27000 },
-	{ "bq27210", BQ27010 },
-	{ "bq27500", BQ2750X },
-	{ "bq27510", BQ2751X },
-	{ "bq27520", BQ2752X },
-	{ "bq27500-1", BQ27500 },
-	{ "bq27510g1", BQ27510G1 },
-	{ "bq27510g2", BQ27510G2 },
-	{ "bq27510g3", BQ27510G3 },
-	{ "bq27520g1", BQ27520G1 },
-	{ "bq27520g2", BQ27520G2 },
-	{ "bq27520g3", BQ27520G3 },
-	{ "bq27520g4", BQ27520G4 },
-	{ "bq27521", BQ27521 },
-	{ "bq27530", BQ27530 },
-	{ "bq27531", BQ27531 },
-	{ "bq27541", BQ27541 },
-	{ "bq27542", BQ27542 },
-	{ "bq27546", BQ27546 },
-	{ "bq27742", BQ27742 },
-	{ "bq27545", BQ27545 },
-	{ "bq27411", BQ27411 },
-	{ "bq27421", BQ27421 },
-	{ "bq27425", BQ27425 },
-	{ "bq27426", BQ27426 },
-	{ "bq27441", BQ27441 },
-	{ "bq27621", BQ27621 },
-	{ "bq27z561", BQ27Z561 },
-	{ "bq28z610", BQ28Z610 },
-	{ "bq34z100", BQ34Z100 },
-	{ "bq78z100", BQ78Z100 },
-	{},
+	{ .name = "bq27200", .driver_data = BQ27000 },
+	{ .name = "bq27210", .driver_data = BQ27010 },
+	{ .name = "bq27500", .driver_data = BQ2750X },
+	{ .name = "bq27510", .driver_data = BQ2751X },
+	{ .name = "bq27520", .driver_data = BQ2752X },
+	{ .name = "bq27500-1", .driver_data = BQ27500 },
+	{ .name = "bq27510g1", .driver_data = BQ27510G1 },
+	{ .name = "bq27510g2", .driver_data = BQ27510G2 },
+	{ .name = "bq27510g3", .driver_data = BQ27510G3 },
+	{ .name = "bq27520g1", .driver_data = BQ27520G1 },
+	{ .name = "bq27520g2", .driver_data = BQ27520G2 },
+	{ .name = "bq27520g3", .driver_data = BQ27520G3 },
+	{ .name = "bq27520g4", .driver_data = BQ27520G4 },
+	{ .name = "bq27521", .driver_data = BQ27521 },
+	{ .name = "bq27530", .driver_data = BQ27530 },
+	{ .name = "bq27531", .driver_data = BQ27531 },
+	{ .name = "bq27541", .driver_data = BQ27541 },
+	{ .name = "bq27542", .driver_data = BQ27542 },
+	{ .name = "bq27546", .driver_data = BQ27546 },
+	{ .name = "bq27742", .driver_data = BQ27742 },
+	{ .name = "bq27545", .driver_data = BQ27545 },
+	{ .name = "bq27411", .driver_data = BQ27411 },
+	{ .name = "bq27421", .driver_data = BQ27421 },
+	{ .name = "bq27425", .driver_data = BQ27425 },
+	{ .name = "bq27426", .driver_data = BQ27426 },
+	{ .name = "bq27441", .driver_data = BQ27441 },
+	{ .name = "bq27621", .driver_data = BQ27621 },
+	{ .name = "bq27z561", .driver_data = BQ27Z561 },
+	{ .name = "bq28z610", .driver_data = BQ28Z610 },
+	{ .name = "bq34z100", .driver_data = BQ34Z100 },
+	{ .name = "bq78z100", .driver_data = BQ78Z100 },
+	{ }
 };
 MODULE_DEVICE_TABLE(i2c, bq27xxx_i2c_id_table);
 
diff --git a/drivers/power/supply/cw2015_battery.c b/drivers/power/supply/cw2015_battery.c
index 286524d2318c..7496295d2948 100644
--- a/drivers/power/supply/cw2015_battery.c
+++ b/drivers/power/supply/cw2015_battery.c
@@ -733,7 +733,7 @@ static int __maybe_unused cw_bat_resume(struct device *dev)
 static SIMPLE_DEV_PM_OPS(cw_bat_pm_ops, cw_bat_suspend, cw_bat_resume);
 
 static const struct i2c_device_id cw_bat_id_table[] = {
-	{ "cw2015" },
+	{ .name = "cw2015" },
 	{ }
 };
 
diff --git a/drivers/power/supply/ds2782_battery.c b/drivers/power/supply/ds2782_battery.c
index cae95d35d398..ed44837473e7 100644
--- a/drivers/power/supply/ds2782_battery.c
+++ b/drivers/power/supply/ds2782_battery.c
@@ -423,9 +423,9 @@ static int ds278x_battery_probe(struct i2c_client *client)
 }
 
 static const struct i2c_device_id ds278x_id[] = {
-	{"ds2782", DS2782},
-	{"ds2786", DS2786},
-	{},
+	{ .name = "ds2782", .driver_data = DS2782 },
+	{ .name = "ds2786", .driver_data = DS2786 },
+	{ }
 };
 MODULE_DEVICE_TABLE(i2c, ds278x_id);
 
diff --git a/drivers/power/supply/lp8727_charger.c b/drivers/power/supply/lp8727_charger.c
index 4186fcd37512..641e0445a410 100644
--- a/drivers/power/supply/lp8727_charger.c
+++ b/drivers/power/supply/lp8727_charger.c
@@ -584,7 +584,7 @@ static const struct of_device_id lp8727_dt_ids[] __maybe_unused = {
 MODULE_DEVICE_TABLE(of, lp8727_dt_ids);
 
 static const struct i2c_device_id lp8727_ids[] = {
-	{ "lp8727" },
+	{ .name = "lp8727" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, lp8727_ids);
diff --git a/drivers/power/supply/ltc2941-battery-gauge.c b/drivers/power/supply/ltc2941-battery-gauge.c
index a1ddc4b060ce..5b6760722f38 100644
--- a/drivers/power/supply/ltc2941-battery-gauge.c
+++ b/drivers/power/supply/ltc2941-battery-gauge.c
@@ -600,11 +600,11 @@ static SIMPLE_DEV_PM_OPS(ltc294x_pm_ops, ltc294x_suspend, ltc294x_resume);
 
 
 static const struct i2c_device_id ltc294x_i2c_id[] = {
-	{ "ltc2941", LTC2941_ID, },
-	{ "ltc2942", LTC2942_ID, },
-	{ "ltc2943", LTC2943_ID, },
-	{ "ltc2944", LTC2944_ID, },
-	{ },
+	{ .name = "ltc2941", .driver_data = LTC2941_ID },
+	{ .name = "ltc2942", .driver_data = LTC2942_ID },
+	{ .name = "ltc2943", .driver_data = LTC2943_ID },
+	{ .name = "ltc2944", .driver_data = LTC2944_ID },
+	{ }
 };
 MODULE_DEVICE_TABLE(i2c, ltc294x_i2c_id);
 
diff --git a/drivers/power/supply/ltc4162-l-charger.c b/drivers/power/supply/ltc4162-l-charger.c
index 9dd74fa9552d..5c09e0368e6f 100644
--- a/drivers/power/supply/ltc4162-l-charger.c
+++ b/drivers/power/supply/ltc4162-l-charger.c
@@ -1229,10 +1229,10 @@ static void ltc4162l_alert(struct i2c_client *client,
 }
 
 static const struct i2c_device_id ltc4162l_i2c_id_table[] = {
-	{ "ltc4015", (kernel_ulong_t)&ltc4015_chip_info },
-	{ "ltc4162-f", (kernel_ulong_t)&ltc4162f_chip_info },
-	{ "ltc4162-l", (kernel_ulong_t)&ltc4162l_chip_info },
-	{ "ltc4162-s", (kernel_ulong_t)&ltc4162s_chip_info },
+	{ .name = "ltc4015", .driver_data = (kernel_ulong_t)&ltc4015_chip_info },
+	{ .name = "ltc4162-f", .driver_data = (kernel_ulong_t)&ltc4162f_chip_info },
+	{ .name = "ltc4162-l", .driver_data = (kernel_ulong_t)&ltc4162l_chip_info },
+	{ .name = "ltc4162-s", .driver_data = (kernel_ulong_t)&ltc4162s_chip_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, ltc4162l_i2c_id_table);
diff --git a/drivers/power/supply/max14656_charger_detector.c b/drivers/power/supply/max14656_charger_detector.c
index a5b42b42d134..b6c3bc0d9ec1 100644
--- a/drivers/power/supply/max14656_charger_detector.c
+++ b/drivers/power/supply/max14656_charger_detector.c
@@ -300,8 +300,8 @@ static int max14656_probe(struct i2c_client *client)
 }
 
 static const struct i2c_device_id max14656_id[] = {
-	{ "max14656" },
-	{}
+	{ .name = "max14656" },
+	{ }
 };
 MODULE_DEVICE_TABLE(i2c, max14656_id);
 
diff --git a/drivers/power/supply/max17040_battery.c b/drivers/power/supply/max17040_battery.c
index 48453508688a..e94d53b36aa4 100644
--- a/drivers/power/supply/max17040_battery.c
+++ b/drivers/power/supply/max17040_battery.c
@@ -598,15 +598,15 @@ static SIMPLE_DEV_PM_OPS(max17040_pm_ops, max17040_suspend, max17040_resume);
 #endif /* CONFIG_PM_SLEEP */
 
 static const struct i2c_device_id max17040_id[] = {
-	{ "max17040", ID_MAX17040 },
-	{ "max17041", ID_MAX17041 },
-	{ "max17043", ID_MAX17043 },
-	{ "max77836-battery", ID_MAX17043 },
-	{ "max17044", ID_MAX17044 },
-	{ "max17048", ID_MAX17048 },
-	{ "max17049", ID_MAX17049 },
-	{ "max17058", ID_MAX17058 },
-	{ "max17059", ID_MAX17059 },
+	{ .name = "max17040", .driver_data = ID_MAX17040 },
+	{ .name = "max17041", .driver_data = ID_MAX17041 },
+	{ .name = "max17043", .driver_data = ID_MAX17043 },
+	{ .name = "max77836-battery", .driver_data = ID_MAX17043 },
+	{ .name = "max17044", .driver_data = ID_MAX17044 },
+	{ .name = "max17048", .driver_data = ID_MAX17048 },
+	{ .name = "max17049", .driver_data = ID_MAX17049 },
+	{ .name = "max17058", .driver_data = ID_MAX17058 },
+	{ .name = "max17059", .driver_data = ID_MAX17059 },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(i2c, max17040_id);
diff --git a/drivers/power/supply/max17042_battery.c b/drivers/power/supply/max17042_battery.c
index 167fb3fb3732..90b38bcb0f14 100644
--- a/drivers/power/supply/max17042_battery.c
+++ b/drivers/power/supply/max17042_battery.c
@@ -1335,12 +1335,12 @@ MODULE_DEVICE_TABLE(of, max17042_dt_match);
 #endif
 
 static const struct i2c_device_id max17042_id[] = {
-	{ "max17042", MAXIM_DEVICE_TYPE_MAX17042 },
-	{ "max17047", MAXIM_DEVICE_TYPE_MAX17047 },
-	{ "max17050", MAXIM_DEVICE_TYPE_MAX17050 },
-	{ "max17055", MAXIM_DEVICE_TYPE_MAX17055 },
-	{ "max77759-fg", MAXIM_DEVICE_TYPE_MAX77759 },
-	{ "max77849-battery", MAXIM_DEVICE_TYPE_MAX17047 },
+	{ .name = "max17042", .driver_data = MAXIM_DEVICE_TYPE_MAX17042 },
+	{ .name = "max17047", .driver_data = MAXIM_DEVICE_TYPE_MAX17047 },
+	{ .name = "max17050", .driver_data = MAXIM_DEVICE_TYPE_MAX17050 },
+	{ .name = "max17055", .driver_data = MAXIM_DEVICE_TYPE_MAX17055 },
+	{ .name = "max77759-fg", .driver_data = MAXIM_DEVICE_TYPE_MAX77759 },
+	{ .name = "max77849-battery", .driver_data = MAXIM_DEVICE_TYPE_MAX17047 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, max17042_id);
diff --git a/drivers/power/supply/max77976_charger.c b/drivers/power/supply/max77976_charger.c
index 3d6ff4005533..9a8a09d2a55e 100644
--- a/drivers/power/supply/max77976_charger.c
+++ b/drivers/power/supply/max77976_charger.c
@@ -484,7 +484,7 @@ static int max77976_probe(struct i2c_client *client)
 }
 
 static const struct i2c_device_id max77976_i2c_id[] = {
-	{ MAX77976_DRIVER_NAME },
+	{ .name = MAX77976_DRIVER_NAME },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, max77976_i2c_id);
diff --git a/drivers/power/supply/max8971_charger.c b/drivers/power/supply/max8971_charger.c
index 26416d26f235..49a05858bef8 100644
--- a/drivers/power/supply/max8971_charger.c
+++ b/drivers/power/supply/max8971_charger.c
@@ -731,7 +731,7 @@ static const struct of_device_id max8971_match_ids[] = {
 MODULE_DEVICE_TABLE(of, max8971_match_ids);
 
 static const struct i2c_device_id max8971_i2c_id[] = {
-	{ "max8971" },
+	{ .name = "max8971" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, max8971_i2c_id);
diff --git a/drivers/power/supply/mm8013.c b/drivers/power/supply/mm8013.c
index 93c50cff31bc..819667a27cad 100644
--- a/drivers/power/supply/mm8013.c
+++ b/drivers/power/supply/mm8013.c
@@ -284,8 +284,8 @@ static int mm8013_probe(struct i2c_client *client)
 }
 
 static const struct i2c_device_id mm8013_id_table[] = {
-	{ "mm8013" },
-	{}
+	{ .name = "mm8013" },
+	{ }
 };
 MODULE_DEVICE_TABLE(i2c, mm8013_id_table);
 
diff --git a/drivers/power/supply/rt5033_battery.c b/drivers/power/supply/rt5033_battery.c
index b2674adfa30b..63333f6aa819 100644
--- a/drivers/power/supply/rt5033_battery.c
+++ b/drivers/power/supply/rt5033_battery.c
@@ -174,7 +174,7 @@ static int rt5033_battery_probe(struct i2c_client *client)
 }
 
 static const struct i2c_device_id rt5033_battery_id[] = {
-	{ "rt5033-battery", },
+	{ .name = "rt5033-battery" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, rt5033_battery_id);
diff --git a/drivers/power/supply/rt9455_charger.c b/drivers/power/supply/rt9455_charger.c
index 5130d2395e88..7045d2908148 100644
--- a/drivers/power/supply/rt9455_charger.c
+++ b/drivers/power/supply/rt9455_charger.c
@@ -1719,7 +1719,7 @@ static void rt9455_remove(struct i2c_client *client)
 }
 
 static const struct i2c_device_id rt9455_i2c_id_table[] = {
-	{ RT9455_DRIVER_NAME },
+	{ .name = RT9455_DRIVER_NAME },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, rt9455_i2c_id_table);
diff --git a/drivers/power/supply/sbs-battery.c b/drivers/power/supply/sbs-battery.c
index 43c48196c167..017ec06be766 100644
--- a/drivers/power/supply/sbs-battery.c
+++ b/drivers/power/supply/sbs-battery.c
@@ -1254,10 +1254,10 @@ static SIMPLE_DEV_PM_OPS(sbs_pm_ops, sbs_suspend, NULL);
 #endif
 
 static const struct i2c_device_id sbs_id[] = {
-	{ "bq20z65", SBS_FLAGS_TI_BQ20ZX5 },
-	{ "bq20z75", SBS_FLAGS_TI_BQ20ZX5 },
-	{ "sbs-battery", 0 },
-	{}
+	{ .name = "bq20z65", .driver_data = SBS_FLAGS_TI_BQ20ZX5 },
+	{ .name = "bq20z75", .driver_data = SBS_FLAGS_TI_BQ20ZX5 },
+	{ .name = "sbs-battery", .driver_data = 0 },
+	{ }
 };
 MODULE_DEVICE_TABLE(i2c, sbs_id);
 
diff --git a/drivers/power/supply/sbs-charger.c b/drivers/power/supply/sbs-charger.c
index 7d5e67620580..a00c710601e8 100644
--- a/drivers/power/supply/sbs-charger.c
+++ b/drivers/power/supply/sbs-charger.c
@@ -244,7 +244,7 @@ MODULE_DEVICE_TABLE(of, sbs_dt_ids);
 #endif
 
 static const struct i2c_device_id sbs_id[] = {
-	{ "sbs-charger" },
+	{ .name = "sbs-charger" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, sbs_id);
diff --git a/drivers/power/supply/sbs-manager.c b/drivers/power/supply/sbs-manager.c
index 343ad4ab4082..9ad3fb117a4d 100644
--- a/drivers/power/supply/sbs-manager.c
+++ b/drivers/power/supply/sbs-manager.c
@@ -389,8 +389,8 @@ static int sbsm_probe(struct i2c_client *client)
 }
 
 static const struct i2c_device_id sbsm_ids[] = {
-	{ "sbs-manager" },
-	{ "ltc1760" },
+	{ .name = "sbs-manager" },
+	{ .name = "ltc1760" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, sbsm_ids);
diff --git a/drivers/power/supply/smb347-charger.c b/drivers/power/supply/smb347-charger.c
index 8b95f7e8712f..d9624b6a898c 100644
--- a/drivers/power/supply/smb347-charger.c
+++ b/drivers/power/supply/smb347-charger.c
@@ -1609,10 +1609,10 @@ static void smb347_shutdown(struct i2c_client *client)
 }
 
 static const struct i2c_device_id smb347_id[] = {
-	{ "smb345", SMB345 },
-	{ "smb347", SMB347 },
-	{ "smb358", SMB358 },
-	{ },
+	{ .name = "smb345", .driver_data = SMB345 },
+	{ .name = "smb347", .driver_data = SMB347 },
+	{ .name = "smb358", .driver_data = SMB358 },
+	{ }
 };
 MODULE_DEVICE_TABLE(i2c, smb347_id);
 
diff --git a/drivers/power/supply/stc3117_fuel_gauge.c b/drivers/power/supply/stc3117_fuel_gauge.c
index a1bc5970370a..469f2b359920 100644
--- a/drivers/power/supply/stc3117_fuel_gauge.c
+++ b/drivers/power/supply/stc3117_fuel_gauge.c
@@ -584,7 +584,7 @@ static int stc3117_probe(struct i2c_client *client)
 }
 
 static const struct i2c_device_id stc3117_id[] = {
-	{ "stc3117", 0 },
+	{ .name = "stc3117", .driver_data = 0 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, stc3117_id);
diff --git a/drivers/power/supply/ug3105_battery.c b/drivers/power/supply/ug3105_battery.c
index 210e0f9aa5e0..0cbf45856fac 100644
--- a/drivers/power/supply/ug3105_battery.c
+++ b/drivers/power/supply/ug3105_battery.c
@@ -195,7 +195,7 @@ static SIMPLE_DEV_PM_OPS(ug3105_pm_ops, ug3105_suspend,
 			ug3105_resume);
 
 static const struct i2c_device_id ug3105_id[] = {
-	{ "ug3105" },
+	{ .name = "ug3105" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, ug3105_id);

base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
-- 
2.47.3

