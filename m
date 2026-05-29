Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F4632B13A
	for <linux-pm@vger.kernel.org>; Fri, 29 May 2026 10:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780049923; cv=none; b=Fl/pIeGDwwMqrXkQontngif+ssGtlylPa9T5oO6bEur/zSe3qen7AoCFw6oSSv7pQ/cpA0YSiqUZ5ISBIgs72WZ9xO8XBCJE1OUSWOvaK2snblXfjffuOuzCncs5vmz6kfHdn6byUjjitgOkJvLQpcN1abEpgVVAqpQxKN1/CiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780049923; c=relaxed/simple;
	bh=HR0BG2x5gStI8qVvDgUBsjfK17M95+4vrnDaD2QTsYk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aqXYybN2EWaAwTkKk7Ol3S31X/YeiH/a2smW5TmIAmVzb9DYfJ9/lCMLK9RE32fz87LrwbVdI0tKNecFanss8zO0Qe5DsBIuVXunRrPuuaFuN0ATbj0SZF/CGtwS8Mh83KvHKbdHpncIpX8FXuCc5Wa9cLsfKUDcC9HSySiEZcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=ic69qTHO; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="ic69qTHO"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-45ef4223be7so198503f8f.2
        for <linux-pm@vger.kernel.org>; Fri, 29 May 2026 03:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1780049919; x=1780654719; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gRuenZrko78jZddy0UFWO+BRki0zaXyQrkNHtJpBvQk=;
        b=ic69qTHO3nWGxkij2JWg1mpvBzwwIiQhZV/FL9b+CQxGiaeb7puaTqQZviCv7FL4IX
         EKOy4/o0tM1j7w65GqwBf5IF4Xqc/Aog9cOThFMn8a1sP26uBy8g2lbKQ5++iSPga+S6
         ccoqXyuHIRvkJ4YWh7d9e3LIY1ZmBpNtpHMdD0mxhqjP6P2UarY8OcS0CNFlmjFqijFS
         sXiYsNWYlk4fYjsE809lSc0oDmGIE4zxttdgygkTNkltx2kDhSnl33eyohqKP2jsnMp7
         GiWPMX4dacScUYYyXEn0acTAUuHTnc9plUCxQf/Ic9pcCmlBUcYL6PgADRozySZTu4As
         7hmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780049919; x=1780654719;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gRuenZrko78jZddy0UFWO+BRki0zaXyQrkNHtJpBvQk=;
        b=OmFecxU69an05Azh1tG0L/AHbDp20DNK3mRM199jFUE/4qZ5GGSED9UK5Cu16rhowy
         SNbQhdO+1LuwGzEucuK63pGXxDV3Rsjpg6RzDJVQFA9gjdmTJTVrUKhz/b/sjzPuLdWM
         9p1IRjD/PbPbj8X4PnuiRsN+QRmDrtww4vjwvFYdcgHDwjeK2AO9tERtaYr9hX6U5XOs
         GL8I8Nivh3q4OY9j/0TZ/xqtQ/KV5gMh+uHgooKLd6LKnKYKPFHydUohQ+fpISu7W7Q4
         baGyW1ydF917k9RvPK+T8mIVsnBz6etw8P1ttLa8T53u6wMIjuv0lV6l6Fdj7WO8JQb5
         T3FA==
X-Forwarded-Encrypted: i=1; AFNElJ/KyXiKPifiVXcg8hC+vGv5NKxjzLtpnODwhCqlMBhAWB+dU8OaVI1uoa03WEsEh+PgOn1LRitoMA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyr6adYREyIyfl6DMRilixyEJvtrH0D1+xiAXyRD16Vmirrakov
	6DpLVNqAfENSEnQ3hMfO6t7tVW+8WnWKQOZlwAjktcEu7TuHXcSxyXX2AOeashN7gls=
X-Gm-Gg: Acq92OGzu0x0ODH6z6+bWGdtFEupRn5q2JPJhF1HJV5Y/qdF9aNxNWJUNvkIXcl3W0y
	2d9Wme7hxFiJCH7tzMkmme8jVQuhhp6vWyzJBg1ffZsd8KOAN9pk2dqM+/k5VfwijhMBpmEtGIc
	Ib0INHqsc5Jb7Zjyyq1Y0CGEzElE0OdmD1+0BZF9jw844BmtikEgAJlb3YKRmRcmS6k3BBrxtOx
	PrYY8IB/AiCmJn8cd1rLQiWr6cU2Vk1Ufn8wPKVCAxrXQ5NfGjRv8D+J/fAdsGfsEZsbagWCVJb
	4LNPd+uCgdeIAUZpz4zYbkXsjE8BzsQc567dSVkAFQr5x1PJb0l6p/8noIokF1mO1/8G5nXo0az
	As5EIYlRBBzVm5mgAimNjjYECFjPu17MtQ1UpnOxWk2mIWSaOShw+955/RMmF1vOG02pL71BiKk
	60/jgjuhRQvUEwxaf0hjeeAxLKHpcTkDwvdzAS5rNzF0XOY1JOWLS0/alfrKlY81IIx5vu5E8tn
	YVDRDYlpBZG/nsOiMA+UQIhjw==
X-Received: by 2002:a5d:6f03:0:b0:45e:ef4a:8192 with SMTP id ffacd0b85a97d-45ef14aeca6mr4456766f8f.38.1780049919017;
        Fri, 29 May 2026 03:18:39 -0700 (PDT)
Received: from localhost (p200300f65f47db043f932d8b97293bf6.dip0.t-ipconnect.de. [2003:f6:5f47:db04:3f93:2d8b:9729:3bf6])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-45ef354cd7csm2359192f8f.18.2026.05.29.03.18.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 03:18:38 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: Sebastian Reichel <sre@kernel.org>
Cc: Kuan-Wei Chiu <visitorckw@gmail.com>,
	Benson Leung <bleung@chromium.org>,
	Guenter Roeck <groeck@chromium.org>,
	=?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	chrome-platform@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Hans de Goede <hansg@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>,
	Purism Kernel Team <kernel@puri.sm>,
	Yixun Lan <dlan@kernel.org>,
	Andreas Kemnade <andreas@kemnade.info>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Sven Peter <sven@kernel.org>,
	Janne Grunau <j@jannau.net>,
	Neal Gompa <neal@gompa.dev>,
	Amit Sunil Dhamne <amitsd@google.com>,
	Samuel Kayode <samkay014@gmail.com>,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev,
	asahi@lists.linux.dev,
	imx@lists.linux.dev,
	Chen-Yu Tsai <wens@kernel.org>
Subject: [PATCH v1 0/6] power: Use named initializers for platform_device_id arrays
Date: Fri, 29 May 2026 12:18:15 +0200
Message-ID: <cover.1780048925.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=5698; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=HR0BG2x5gStI8qVvDgUBsjfK17M95+4vrnDaD2QTsYk=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBqGWfoDIuZ0g/W2ypE62dFHULfUWoyzPSByuJOy zumyQmeqqeJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCahln6AAKCRCPgPtYfRL+ TsKPB/9mAyfp+pLZiIDxZa/Gq+SSHanqJrTQwpZ9rQFWh6BTlVwAzfy9/iK3DTaEC0m73vbGFfQ SrrV9RH9jd6SuuSNJEy+P030qdvrNgwnqe9+Kw6h9Ox1Xf/WbmVgbFqiAvBlC9bWaxNYlaSXA6b k6D0JHKSjZPpHgGWSl8de58GW9wTOhD4G7APcHqvig2ElcuxKXGEJMbDiI5C+wM6c/uNZYGDKQH Gyln8usdt6LIe+L24f+S0WZZOkN5b75oBqE1U4SirbgWSV0oQR/VgR5R3MVvLMMrmyqPiFaaawD fWqFsf8PmmOgcfZvBQ4ZGzTElp/ezMarN1H6m653QUtXR1kb
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Hello,

this series targets to use named initializers for platform_device_id
arrays. In general these are better readable for humans and more robust
to changes in the respective struct definition.

This robustness is needed as I want to do

	diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devicetable.h
	--- a/include/linux/mod_devicetable.h
	+++ b/include/linux/mod_devicetable.h
	@@ -610,4 +610,7 @@ struct dmi_system_id {
	 struct platform_device_id {
		char name[PLATFORM_NAME_SIZE];
	-	kernel_ulong_t driver_data;
	+	union {
	+		kernel_ulong_t driver_data;
	+		const void *driver_data_ptr;
	+	};
	 };

which allows dropping several casts and eases porting CHERI to mainline
linux. A possible follow-up change is the following example:

	diff --git a/drivers/gpio/gpio-pxa.c b/drivers/gpio/gpio-pxa.c
	index 5d61053e0596..03bc8e859d73 100644
	--- a/drivers/gpio/gpio-pxa.c
	+++ b/drivers/gpio/gpio-pxa.c
	@@ -534,7 +534,7 @@ static struct irq_chip pxa_muxed_gpio_chip = {
	 static int pxa_gpio_nums(struct platform_device *pdev)
	 {
		const struct platform_device_id *id = platform_get_device_id(pdev);
	-	struct pxa_gpio_id *pxa_id = (struct pxa_gpio_id *)id->driver_data;
	+	struct pxa_gpio_id *pxa_id = id->driver_data_ptr;
		int count = 0;
	 
		switch (pxa_id->type) {
	@@ -708,14 +708,14 @@ static int pxa_gpio_probe(struct platform_device *pdev)
	 }
	 
	 static const struct platform_device_id gpio_id_table[] = {
	-	{ .name = "pxa25x-gpio",	.driver_data = (unsigned long)&pxa25x_id },
	-	{ .name = "pxa26x-gpio",	.driver_data = (unsigned long)&pxa26x_id },
	-	{ .name = "pxa27x-gpio",	.driver_data = (unsigned long)&pxa27x_id },
	-	{ .name = "pxa3xx-gpio",	.driver_data = (unsigned long)&pxa3xx_id },
	-	{ .name = "pxa93x-gpio",	.driver_data = (unsigned long)&pxa93x_id },
	-	{ .name = "mmp-gpio",		.driver_data = (unsigned long)&mmp_id },
	-	{ .name = "mmp2-gpio",		.driver_data = (unsigned long)&mmp2_id },
	-	{ .name = "pxa1928-gpio",	.driver_data = (unsigned long)&pxa1928_id },
	+	{ .name = "pxa25x-gpio",	.driver_data_ptr = &pxa25x_id },
	+	{ .name = "pxa26x-gpio",	.driver_data_ptr = &pxa26x_id },
	+	{ .name = "pxa27x-gpio",	.driver_data_ptr = &pxa27x_id },
	+	{ .name = "pxa3xx-gpio",	.driver_data_ptr = &pxa3xx_id },
	+	{ .name = "pxa93x-gpio",	.driver_data_ptr = &pxa93x_id },
	+	{ .name = "mmp-gpio",		.driver_data_ptr = &mmp_id },
	+	{ .name = "mmp2-gpio",		.driver_data_ptr = &mmp2_id },
	+	{ .name = "pxa1928-gpio",	.driver_data_ptr = &pxa1928_id },
		{ }
	 };
 
increasing readability due to less casting. Also this results in the
compiler warning:

	drivers/gpio/gpio-pxa.c: In function ‘pxa_gpio_nums’:
	drivers/gpio/gpio-pxa.c:537:38: error: initialization discards ‘const’ qualifier from pointer target type [-Werror=discarded-qualifiers]
	  537 |         struct pxa_gpio_id *pxa_id = id->driver_data_ptr;
	      |                                      ^~

which is a good thing as adding the needed const to fix this warning
improves type safety. (Sorry, no driver below drivers/power benefits
here, so the example is from a different subsystem.)

Patch #5 is just an unrelated change where I spotted the patch
opportunity while preparing this series. It's included here just for my
convenience and could be applied independently.

If you consider the last patch mostly churn, just drop it.

There are no dependencies between the patches, the only file that is
touched in more than one patch is drivers/power/supply/mt6360_charger.c
and even if these (i.e. patches #1 and #5) are reordered, git should be
able to cope with that without conflicts.

Note that this series is only build tested, and there is the possibility
that I failed to spot driver data usage that render patches #2 and/or #3
wrong. So a deeper look on at least those two won't hurt.

Best regards
Uwe

Uwe Kleine-König (The Capable Hub) (6):
  power: Drop unused assignment of platform_device_id driver data
  power: supply: max14577: Drop driver data in of and platform device id
    arrays
  power: supply: max17042: Drop driver data in of and platform device id
    arrays
  power: Use named initializers for platform_device_id arrays
  power: supply: mt6360_charger: Use of match table unconditionally
  power: Unify code style for platform_device_id arrays

 drivers/power/reset/qemu-virt-ctrl.c           |  2 +-
 drivers/power/reset/spacemit-p1-reboot.c       |  4 ++--
 drivers/power/reset/tps65086-restart.c         |  2 +-
 drivers/power/supply/axp288_charger.c          |  2 +-
 drivers/power/supply/axp288_fuel_gauge.c       |  2 +-
 drivers/power/supply/bd71828-power.c           |  8 ++++----
 drivers/power/supply/charger-manager.c         |  4 ++--
 drivers/power/supply/cros_charge-control.c     |  4 ++--
 drivers/power/supply/cros_peripheral_charger.c |  4 ++--
 drivers/power/supply/cros_usbpd-charger.c      |  4 ++--
 drivers/power/supply/macsmc-power.c            |  2 +-
 drivers/power/supply/max14577_charger.c        | 12 +++++-------
 drivers/power/supply/max17042_battery.c        | 14 +++++++-------
 drivers/power/supply/max77693_charger.c        |  2 +-
 drivers/power/supply/max77759_charger.c        |  2 +-
 drivers/power/supply/max8997_charger.c         |  2 +-
 drivers/power/supply/max8998_charger.c         |  2 +-
 drivers/power/supply/mt6360_charger.c          |  6 +++---
 drivers/power/supply/pf1550-charger.c          |  2 +-
 drivers/power/supply/rt5033_charger.c          |  2 +-
 20 files changed, 40 insertions(+), 42 deletions(-)


base-commit: f7af91adc230aa99e23330ecf85bc9badd9780ad
-- 
2.47.3

