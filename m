Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D230B3DAABB;
	Fri, 24 Jul 2026 09:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784886535; cv=none; b=GInu+RG1kLNEQTo2Q+YkclQ6/e92ZnodOnha0sLNtKG4BhBxipVTTXItJIFCqZj8oVr9iyenGR7s5Dp2xPM2ByH63CqvmMYliCubTcR0RVEyvZ1biv8XCFJK8shpyOLvDub3vlTBqhtx8FCuuFxup0dCnJx6RftwuSpCk4MriEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784886535; c=relaxed/simple;
	bh=pxtHOcJbFKxOkoLlbzwW0DxQD7uFg+0oE5SkF3UtaoY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Kv6iaqnhEWWTLV6cbgwOyLugqYLN/v/gXZVU8CRaonYV764W2bWtAdQz5xfcw3fKKhQYH0VzS1f8WznMKxBVcd7zMlZCjtA1obgr/MZPQea48RO0Ixl28ixlvzuRhyDmd7QTfBxub2d1nhDSuzE8gm0DOyBrWyeYH7JabUVt4zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ifqfPuP/; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ifqfPuP/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Gx
	7mdo4pUDWI/erjpt6QpJ2OWfAEDJaemcerLl7F9hs=; b=ifqfPuP/PCBfRiZHoD
	Z0F2ZB0CDRB8Av6kVzy4XixJ+nDZ7dIKHlKqxbmNwVgRrK2zDww4Mqp29sxSO41k
	2QVrgZyPlO+wOGGyRbx2vytX8HZGvB8dgE0aP/Sw0M9gc+g5pDsI0PkoSuFE7B0a
	U+Kb09y2JmiVwt/YovnKoHwtU=
Received: from QD202103290168A.neusoft.internal (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wD3vJLVNGNqc5tILQ--.52442S2;
	Fri, 24 Jul 2026 17:48:07 +0800 (CST)
From: Jianing Li <m13940358460@163.com>
To: Sebastian Reichel <sre@kernel.org>
Cc: Iskren Chernev <me@iskren.info>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Matheus Castello <matheus@castello.eng.br>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jianing Li <m13940358460@163.com>
Subject: [PATCH] power: supply: max17040: propagate register read errors
Date: Fri, 24 Jul 2026 17:47:59 +0800
Message-Id: <20260724094759.3568-1-m13940358460@163.com>
X-Mailer: git-send-email 2.23.0.windows.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3vJLVNGNqc5tILQ--.52442S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxWF1UKw1ruFy3uF17Kr13XFb_yoW5Xw4rpa
	15KFn8Grn8Jayru397ta15AFy3K3yDtrWxCrWxC39YyF12yr4UK345ta43KFyUCryxZF4x
	tr4xKa45GrsIqwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pErcT9UUUUU=
X-CM-SenderInfo: jprtmkaqtvmkiwq6il2tof0z/xtbC4Bi28GpjNNhXaAAA3k

max17040_get_vcell() and max17040_get_soc() ignore errors returned by
regmap_read().  When an I2C transfer fails, the uninitialized register
value is converted and reported to userspace as a valid voltage or state
of charge.  The polling worker can also replace the cached state of charge
with the bogus value and emit a spurious change event.

Propagate read errors through the power supply get_property callback and
keep the last valid cached state of charge when polling fails.

Fixes: c6f4a42de60b ("Add MAX17040 Fuel Gauge driver")
Cc: stable@vger.kernel.org
Signed-off-by: Jianing Li <m13940358460@163.com>
---
 drivers/power/supply/max17040_battery.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/drivers/power/supply/max17040_battery.c b/drivers/power/supply/max17040_battery.c
index e94d53b36aa4..948670fb6c4a 100644
--- a/drivers/power/supply/max17040_battery.c
+++ b/drivers/power/supply/max17040_battery.c
@@ -192,19 +192,21 @@ static int max17040_raw_vcell_to_uvolts(struct max17040_chip *chip, u16 vcell)
 static int max17040_get_vcell(struct max17040_chip *chip)
 {
 	u32 vcell;
+	int ret;
 
-	regmap_read(chip->regmap, MAX17040_VCELL, &vcell);
+	ret = regmap_read(chip->regmap, MAX17040_VCELL, &vcell);
 
-	return max17040_raw_vcell_to_uvolts(chip, vcell);
+	return ret ? ret : max17040_raw_vcell_to_uvolts(chip, vcell);
 }
 
 static int max17040_get_soc(struct max17040_chip *chip)
 {
 	u32 soc;
+	int ret;
 
-	regmap_read(chip->regmap, MAX17040_SOC, &soc);
+	ret = regmap_read(chip->regmap, MAX17040_SOC, &soc);
 
-	return soc >> (chip->quirk_double_soc ? 9 : 8);
+	return ret ? ret : soc >> (chip->quirk_double_soc ? 9 : 8);
 }
 
 static int max17040_get_version(struct max17040_chip *chip)
@@ -261,7 +263,11 @@ static int max17040_get_of_data(struct max17040_chip *chip)
 
 static void max17040_check_changes(struct max17040_chip *chip)
 {
-	chip->soc = max17040_get_soc(chip);
+	int soc;
+
+	soc = max17040_get_soc(chip);
+	if (soc >= 0)
+		chip->soc = soc;
 }
 
 static void max17040_queue_work(struct max17040_chip *chip)
@@ -396,10 +402,16 @@ static int max17040_get_property(struct power_supply *psy,
 		val->intval = max17040_get_online(chip);
 		break;
 	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
-		val->intval = max17040_get_vcell(chip);
+		ret = max17040_get_vcell(chip);
+		if (ret < 0)
+			return ret;
+		val->intval = ret;
 		break;
 	case POWER_SUPPLY_PROP_CAPACITY:
-		val->intval = max17040_get_soc(chip);
+		ret = max17040_get_soc(chip);
+		if (ret < 0)
+			return ret;
+		val->intval = ret;
 		break;
 	case POWER_SUPPLY_PROP_CAPACITY_ALERT_MIN:
 		val->intval = chip->low_soc_alert;
-- 
2.39.0

