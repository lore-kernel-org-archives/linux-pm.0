Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793795196;
	b=B+o8CEQ9LD+TrKJvPj02NGLHSu8nwg08mzDlery50jZX8LyNFz2eO7KxJPdZrs+4o9v5
	 awd5+h3jH/VtFr618HRtT2ip0ye7Zb9hPT7ugV92NY3l8IXMHaZWCqQeqhACYeZlyqlaL
	 ZOd2n+XghD70DnPAc7s6vz4brxsFmBI0w3NyRQnQpMGwF82IfTuNoLhMtq1kN7RTGsVi5
	 EfY3l9GHH5mM60W4if1/RvOECNZyVgXcWC2SaLngx/jVnuUv2p/ZC3MfY96p8H7Vy+8D4
	 cEx5sG5eX/LpbGxD0Av0JnP9jeqcU30wdVmSRe3Xp7j4FjQMVqN+CWf/eqOvoX9eFCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793795196;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=SxQIyo1i8rUtN8cIQi0PeWuiVCxCXkpVy81a4gul2ns=;
	b=oP+A27ycbDD3KMnKFagpHQtCAtS0cD+RZ8mQUMcjn7TXP7uTmH/0H16LRW7CTNd/7Jpm
	 TISBBWLIBkaYDwos/5hw0gI1AbTDwsV3iqNoZD8wg/O1cUnj34QNhtLOzP0it8H0jyAXU
	 gaUJjnbr6fKc+YzjyyvT7yHI4Lc3YdVy/6IEJlu8ozDwq1yjtdbXfhzVrBKxwSBHYv+4k
	 +oOlDwpmkkxit9KWZWQ6VejPHATXmY5WLctKUJOWMkrd7mRlsEL8IoBk3ZgQB2NsNNpoE
	 jNvwwt7fPpx+eIVzUZX18vFRnFIytMOIRILh0gNr0l6lwtzscuyPq9Czwtex5IbUJ0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=guYyfD3d;
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949D9606D821
	for <linux-pm@vger.kernel.org>; Wed,  4 Nov 2026 12:26:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 949D9606D821
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=guYyfD3d
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a2069b9710so5383565e9.2
        for <linux-pm@vger.kernel.org>; Wed, 04 Nov 2026 04:26:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793795195; x=1794399995; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SxQIyo1i8rUtN8cIQi0PeWuiVCxCXkpVy81a4gul2ns=;
        b=guYyfD3dz8+4XRLKrK/wqOadhFdn3VwQYXC4hjM/jI9P2wzDL7y2iFS5AdtzYQ5MF5
         66e6k658CHP9dj0b+9hLW1RsunWnMoKBQKoBVugMrziz2/Jy9GBEodkmolbQ4yHL1ZLu
         msJH1L1Po03+ykdGirDaL+5fgL8JxjDcW8Bye+Qb9Pe6a8J0N81p+CVfH7EpGD+KUdeb
         TpyY9WpHh0xDV/e0dTyNWUjljog5OPOXZAKR0M1SCzBlZ0JY7J4azq9BvbcASWuHn8ci
         P5SlLs4x8WlkbbzcpGFSh7FyltDRYN/1NXZMzzRvvhqyXpdeRPtoB6DOr9R25eLWXcl8
         jP0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793795195; x=1794399995;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SxQIyo1i8rUtN8cIQi0PeWuiVCxCXkpVy81a4gul2ns=;
        b=h0gCGwFozD1sGrXa0OqQ6J8uw1d68cA+/rDck3pH/B2CwWaQtvwkTYs0JI3rCyDyrJ
         xMI2dAvbOc5/R++vKAARVtQTPz4b1nADz4iXTfRb4mCARQBa/WKDLN0X/vmxoKRwyHDI
         fVpDoQ3yN24J869GetfPzUNoV6nZsyd8q8WMIHFAqis/JcVWUU07tvc1IGLj3XZ2o7z7
         +B3gSgiegqZNTkzMsnYeOupY5uT2eoi2BV09gGrLFPloIiuHUi5qnV4hZIhNcOiwojEr
         Mxz5/5brcR7hb0mLm53SqkoBnhZRQGQfEOm1q+imdHBzhgrwRo9o1blARPUhY9lg485s
         4QdQ==
X-Forwarded-Encrypted: i=1; AKwUvBwlXzYYzduB7Md0lwS/sQAMzYp4RI7mknZoFAHnlGPltbd0rhSIYTtdi7ZZJgIvfRIgbP3TJDXNjw==@vger.kernel.org
X-Gm-Message-State: APuU4Z/YM+MzcJPZKvAQAt/SRgf/79hBYt+l89WAcUub9DwmaTrU0aXZ
	H7lgzCTl/7j9AGUQy4bjm+mB/oik1PEynF+2J+fgm8vF0NdsgcJPwPvU
X-Gm-Gg: AYBFou1++v5oVdsDRr/4aSpjmOf7lOhbIC8IJO1j5Ze+dZjhIOMoyI0ZrluqV6Igj2X
	kCzXZyXyopzrreJSFcA0cVa1RTNI9dFQ9+nlHdU0iSeMno5KoJlDbFCXZH6hNIRLOX1MesUbsWP
	7fKdK1qAWECIXX4puFXKpcrX5evmTe1wzJ1/Yno5n57G2d76vJnWSC8yUKlG+4esMLpk6ae3l/w
	tuQYr9y+vPSIQMx9gLfv7JZ+Bhk1L5U+q4nrDrGEmDLHnxi5+wdWRz0+9SLAlMFWm9a8R491icl
	OwI9EUo5YdR5v9OFuBFw9/TvEGjQbzc+7BmrjxFDHjx6K0xBUFVvwr0H0GbFmfHEAMavBRfT8in
	eWXzWrJ7N18btFCba4PlwY4w4jHeT48dLhjpONKwXqZFOoXtEboARKXnSCXpO4UC2tHiu6JlIB0
	Pc/1Xa4eV+Ozb/n9oMFsWPvxJJEHRgun4Yg24BHD7RaMgDP5aW8R7nfmepPqiMuqpa19L+py8sw
	8Szej1VOIBh2SNRil3e/fPI7UjjLmM7UtmZGxqB1BfkJ6JAR2UpkZDaxEn0/yrXAEruSF7wEUfe
	Gmq5hdYhcUqeo149zeo30i7AyH2/+FABRDr2kHOWBUVKYxX/Yw==
X-Received: by 2002:a05:600c:524b:b0:4b2:612d:908c with SMTP id 5b1f17b1804b1-4b2612d90d4mr136608635e9.34.1793795194957;
        Wed, 04 Nov 2026 04:26:34 -0800 (PST)
Received: from xeon ([188.163.112.62])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b43da9825bsm50492415e9.15.2026.11.04.04.26.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 04:26:34 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Griffin Kroah-Hartman <griffin@kroah.com>,
	Sebastian Reichel <sre@kernel.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>,
	Ion Agorria <ion@agorria.com>,
	=?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
	Florian Krischer <florian.krischer@fkr.dev>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org,
	mfd@lists.linux.dev,
	linux-leds@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v13 5/7] leds: Add driver for ASUS Transformer LEDs
Date: Wed,  4 Nov 2026 14:26:04 +0200
Message-ID: <20261104122606.215629-6-clamor95@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261104122606.215629-1-clamor95@gmail.com>
References: <20261104122606.215629-1-clamor95@gmail.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Michał Mirosław <mirq-linux@rere.qmqm.pl>

ASUS Transformer tablets have a green and an amber LED on both the Pad
and the Dock.

Co-developed-by: Svyatoslav Ryhel <clamor95@gmail.com>
Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 drivers/leds/Kconfig                    |  11 +++
 drivers/leds/Makefile                   |   1 +
 drivers/leds/leds-asus-transformer-ec.c | 114 ++++++++++++++++++++++++
 3 files changed, 126 insertions(+)
 create mode 100644 drivers/leds/leds-asus-transformer-ec.c

diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
index 7ec2c8d785426..788e689fe875c 100644
--- a/drivers/leds/Kconfig
+++ b/drivers/leds/Kconfig
@@ -120,6 +120,17 @@ config LEDS_OSRAM_AMS_AS3668
 	  To compile this driver as a module, choose M here: the module
 	  will be called leds-as3668.
 
+config LEDS_ASUS_TRANSFORMER_EC
+	tristate "LED Support for Asus Transformer charging LED"
+	depends on LEDS_CLASS
+	depends on MFD_ASUS_TRANSFORMER_EC
+	help
+	  This option enables support for charging indicator on
+	  Asus Transformer's Pad and its Dock.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called leds-asus-transformer-ec.
+
 config LEDS_AW200XX
 	tristate "LED support for Awinic AW20036/AW20054/AW20072/AW20108"
 	depends on LEDS_CLASS
diff --git a/drivers/leds/Makefile b/drivers/leds/Makefile
index 4d4b089156e24..3da746279bb81 100644
--- a/drivers/leds/Makefile
+++ b/drivers/leds/Makefile
@@ -15,6 +15,7 @@ obj-$(CONFIG_LEDS_ADP5520)		+= leds-adp5520.o
 obj-$(CONFIG_LEDS_AN30259A)		+= leds-an30259a.o
 obj-$(CONFIG_LEDS_APU)			+= leds-apu.o
 obj-$(CONFIG_LEDS_ARIEL)		+= leds-ariel.o
+obj-$(CONFIG_LEDS_ASUS_TRANSFORMER_EC)	+= leds-asus-transformer-ec.o
 obj-$(CONFIG_LEDS_OSRAM_AMS_AS3668)	+= leds-as3668.o
 obj-$(CONFIG_LEDS_AW200XX)		+= leds-aw200xx.o
 obj-$(CONFIG_LEDS_AW2013)		+= leds-aw2013.o
diff --git a/drivers/leds/leds-asus-transformer-ec.c b/drivers/leds/leds-asus-transformer-ec.c
new file mode 100644
index 0000000000000..f797dcefd16e6
--- /dev/null
+++ b/drivers/leds/leds-asus-transformer-ec.c
@@ -0,0 +1,114 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/err.h>
+#include <linux/leds.h>
+#include <linux/mfd/asus-transformer-ec.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+
+enum {
+	ASUSEC_LED_AMBER,
+	ASUSEC_LED_GREEN,
+	ASUSEC_LED_MAX
+};
+
+struct asus_ec_led_config {
+	const char *name;
+	unsigned int color;
+	u64 ctrl_bit;
+};
+
+struct asus_ec_led {
+	const struct asusec_core *ec;
+	struct led_classdev cdev;
+	u64 ctrl_bit;
+};
+
+static const struct asus_ec_led_config asus_ec_leds[] = {
+	[ASUSEC_LED_AMBER] = {
+		.name = "amber",
+		.color = LED_COLOR_ID_AMBER,
+		.ctrl_bit = ASUSEC_CTL_LED_AMBER,
+	},
+	[ASUSEC_LED_GREEN] = {
+		.name = "green",
+		.color = LED_COLOR_ID_GREEN,
+		.ctrl_bit = ASUSEC_CTL_LED_GREEN,
+	},
+};
+
+static enum led_brightness asus_ec_led_get_brightness(struct led_classdev *cdev)
+{
+	struct asus_ec_led *led = container_of(cdev, struct asus_ec_led, cdev);
+	const struct asusec_core *ec = led->ec;
+	u64 ctl;
+	int ret;
+
+	ret = asus_dockram_access_ctl(ec->dockram, &ctl, 0, 0);
+	if (ret)
+		return LED_OFF;
+
+	return ctl & led->ctrl_bit ? LED_ON : LED_OFF;
+}
+
+static int asus_ec_led_set_brightness(struct led_classdev *cdev, enum led_brightness brightness)
+{
+	struct asus_ec_led *led = container_of(cdev, struct asus_ec_led, cdev);
+	const struct asusec_core *ec = led->ec;
+
+	if (brightness)
+		return asus_dockram_access_ctl(ec->dockram, NULL, led->ctrl_bit, led->ctrl_bit);
+
+	return asus_dockram_access_ctl(ec->dockram, NULL, led->ctrl_bit, 0);
+}
+
+static int asus_ec_led_probe(struct platform_device *pdev)
+{
+	const struct asusec_core *ec = dev_get_drvdata(pdev->dev.parent);
+	struct device *dev = &pdev->dev;
+	struct asus_ec_led *leds;
+	int ret;
+
+	leds = devm_kcalloc(dev, ASUSEC_LED_MAX, sizeof(*leds), GFP_KERNEL);
+	if (!leds)
+		return -ENOMEM;
+
+	for (int i = 0; i < ASUSEC_LED_MAX; i++) {
+		const struct asus_ec_led_config *cfg = &asus_ec_leds[i];
+		struct asus_ec_led *led = &leds[i];
+
+		led->cdev.name = devm_kasprintf(dev, GFP_KERNEL, "%s:%s", ec->name, cfg->name);
+		if (!led->cdev.name)
+			return -ENOMEM;
+
+		led->cdev.max_brightness = 1;
+		led->cdev.color = cfg->color;
+		led->cdev.flags = LED_CORE_SUSPENDRESUME | LED_RETAIN_AT_SHUTDOWN;
+		led->cdev.brightness_get = asus_ec_led_get_brightness;
+		led->cdev.brightness_set_blocking = asus_ec_led_set_brightness;
+
+		led->ec = ec;
+		led->ctrl_bit = cfg->ctrl_bit;
+
+		ret = devm_led_classdev_register(dev, &led->cdev);
+		if (ret)
+			return dev_err_probe(dev, ret, "Failed to register %s LED\n", cfg->name);
+	}
+
+	return 0;
+}
+
+static struct platform_driver asus_ec_led_driver = {
+	.driver = {
+		.name = "asus-transformer-ec-led",
+	},
+	.probe = asus_ec_led_probe,
+};
+module_platform_driver(asus_ec_led_driver);
+
+MODULE_ALIAS("platform:asus-transformer-ec-led");
+MODULE_AUTHOR("Michał Mirosław <mirq-linux@rere.qmqm.pl>");
+MODULE_AUTHOR("Svyatoslav Ryhel <clamor95@gmail.com>");
+MODULE_DESCRIPTION("ASUS Transformer's charging LED driver");
+MODULE_LICENSE("GPL");
-- 
2.53.0

