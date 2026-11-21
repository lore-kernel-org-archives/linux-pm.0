Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.36.144.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795293705;
	b=o3siQXvdG2O1TVUfWKlOgXijL4FJaay+yWFkoA2dBG+1YmJ4zJgMcvMZQQyH5oBoNGyP
	 eU2zTdpsiqLYQgo4L3hI+UDH4jWC+5WjLTNErhqunKlFYIiLMhx3B+Sf4vRELM+6zt/Fq
	 A+ZSWs3k4uQdeP15zWtzh3vAvJj8JM5njsufdiNTb2fMMx7JaMSKNrY8jsdt+mJFHq6ze
	 fQ8/+ZBNeM5o0vKtAK7kaxM7Tzmx9p7kI2yH7fuMGAfSjcVnGahekLXMMAWcSC1EBPoWY
	 5a85bWesfJzta3EK1kRwiZVGHL6zjgXCE/R34vbrE7m+CiIvO1nenCe3AwtZzgpdUnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795293705;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=qO/lDjAU8oXQuWFOSHzah7/JqbLGrQuaoNk2c0caW0s=;
	b=3AiKmlRHx/6aRfpkF3/xAhGxiWooRsGxMVDTk9nTqoYEITkjYWB/B2hPOSDemTYJ2hGp
	 pjYEiUCDNSHYLAT0ivk9DDHZofqDJNHCXwDYQi+5J1YQLbFcaeSXEYpNalcBFZo+Gejdz
	 OtGETCksnUYq5DiFrZfwRC4APcbqFw4Nv2E2nL/0cFe/9nPKYp/7xKsR97rF2ylxe2jUD
	 DgrGjyY6Kxk0umIx+2hBBp8zhCOLOGiIFy6uavZrY5ZOju1gb+OAIUAE07IjFqkqhV+f6
	 MpTDGfaVJdgKpdki89dIrXIZSDsLYItIJ59ehB7m9ZkfrhMQaZIoNrMhu2dt1od8rFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=yoxcu.de;
	spf=pass smtp.mailfrom=yoxcu.de;
	dkim=pass header.d=yoxcu.de header.i=@yoxcu.de header.a=rsa-sha256 header.s=dkim header.b=IpdCpZcO;
	arc=none smtp.remote-ip=194.36.144.171
Received: from morty.yoxcu.de (morty.yoxcu.de [194.36.144.171])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A782C606A680;
	Sat, 21 Nov 2026 20:41:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A782C606A680
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=yoxcu.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yoxcu.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yoxcu.de header.i=@yoxcu.de header.a=rsa-sha256 header.s=dkim header.b=IpdCpZcO
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id AE3F71D87262;
	Sat, 21 Nov 2026 21:41:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yoxcu.de; s=dkim;
	t=1795293703; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=qO/lDjAU8oXQuWFOSHzah7/JqbLGrQuaoNk2c0caW0s=;
	b=IpdCpZcOWVcycutqYseU5wnSuDe2svkoSXPTxnInWUKn8NIdjZGtZCvCjT2/DCc4wQJj3P
	FGkfggUf6RPU5SWOHCqDJfNa2x7gisx8Sk9g7Tvj8lYdWJ0bMUamJHrhPadvBxhnqgClh7
	TkdENt1m62l9122QzY1jfVeYS9bojwA164Csr4XBub0uSmdbywF+3tuDwkQI4ijvc+5pd/
	1QkkIOvqAOw0mV9seMt4OBSzEbhVL1GY7h2pIqLBisOiLtTFIUxbfAylKXLbUXl6XOlBGp
	HipLSGP8jY3N5Q+zxjUM+u3/OMa1t6WECHa4OMsQHD/d9nTYwdMG6qET5lcF6w==
From: Michael Auer <mick@yoxcu.de>
To: Sebastian Reichel <sre@kernel.org>
Cc: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michael Auer <mick@yoxcu.de>
Subject: [PATCH 3/3] power: supply: bq27xxx: keep the last values over a short read failure
Date: Sat, 21 Nov 2026 21:41:37 +0100
Message-ID: <20261121204137.848173-4-mick@yoxcu.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261121204137.848173-1-mick@yoxcu.de>
References: <20261121204137.848173-1-mick@yoxcu.de>
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
X-Last-TLS-Session-Version: TLSv1.3

When the flags read of an update fails, the driver caches the error:
"present" reads 0 and every other property returns the error until an
update succeeds. Updates come from the poll work (every 360 s by
default), a charger change, or a property read more than 5 s after the
last update. So a gauge that misses one update makes the battery
disappear for at least 5 s, and user space treats it as empty.

If a gauge that answered before fails an update, keep the last capacity
and flags, so "present" stays 1, and re-check every second. Report the
failure as before only once it has lasted 30 s. In that window a
failed "status" read returns the status of the last good update.
-ENODEV (no I2C adapter, or a bq27000 without battery) is reported at
once.

Start with cache.flags = -ENODATA instead of 0, so that a failure of
the very first update is reported and not bridged with an all-zero
cache.

A battery that disappears for good is now reported 30 s later.

Signed-off-by: Michael Auer <mick@yoxcu.de>
---
 drivers/power/supply/bq27xxx_battery.c | 41 ++++++++++++++++++++++++++
 include/linux/power/bq27xxx_battery.h  |  2 ++
 2 files changed, 43 insertions(+)

diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
index dccb0f84ea1d..6a0a916ec05c 100644
--- a/drivers/power/supply/bq27xxx_battery.c
+++ b/drivers/power/supply/bq27xxx_battery.c
@@ -1128,6 +1128,10 @@ module_param_cb(poll_interval, &param_ops_poll_interval, &poll_interval, 0644);
 MODULE_PARM_DESC(poll_interval,
 		 "battery poll interval in seconds - 0 disables polling");
 
+/* Keep the last values this long when the gauge stops answering, re-check this often */
+#define BQ27XXX_STALE_TIMEOUT	(30 * HZ)
+#define BQ27XXX_STALE_RECHECK	HZ
+
 /*
  * Common code for BQ27xxx devices
  */
@@ -1968,6 +1972,35 @@ static int bq27xxx_battery_current_and_status(
 	return 0;
 }
 
+/*
+ * A gauge can fail a read for a moment, e.g. right after resume. Keep the last
+ * values and re-check soon, and report the error only once it has lasted
+ * BQ27XXX_STALE_TIMEOUT. -ENODEV is reported at once.
+ * Returns true if the failed update was bridged and must not be applied.
+ */
+static bool bq27xxx_battery_bridge_error(struct bq27xxx_device_info *di, int flags)
+{
+	if (flags >= 0 || flags == -ENODEV || di->cache.flags < 0) {
+		di->stale = false;
+		return false;
+	}
+
+	if (!di->stale) {
+		di->stale = true;
+		di->stale_since = jiffies;
+		dev_warn(di->dev, "gauge read failed (%d), keeping the last values\n", flags);
+	} else if (time_after(jiffies, di->stale_since + BQ27XXX_STALE_TIMEOUT)) {
+		di->stale = false;
+		return false;
+	}
+
+	di->last_update = jiffies;
+	if (!di->removed)
+		mod_delayed_work(system_percpu_wq, &di->work, BQ27XXX_STALE_RECHECK);
+
+	return true;
+}
+
 static void bq27xxx_battery_update_unlocked(struct bq27xxx_device_info *di)
 {
 	union power_supply_propval status = di->last_status;
@@ -1977,6 +2010,8 @@ static void bq27xxx_battery_update_unlocked(struct bq27xxx_device_info *di)
 	cache.flags = bq27xxx_read(di, BQ27XXX_REG_FLAGS, has_singe_flag);
 	if (di->chip == BQ27000 && (cache.flags & 0xff) == 0xff)
 		cache.flags = -ENODEV; /* bq27000 hdq read error */
+	if (bq27xxx_battery_bridge_error(di, cache.flags))
+		return;
 	if (cache.flags >= 0) {
 		cache.capacity = bq27xxx_battery_read_soc(di);
 
@@ -2192,6 +2227,11 @@ static int bq27xxx_battery_get_property(struct power_supply *psy,
 	switch (psp) {
 	case POWER_SUPPLY_PROP_STATUS:
 		ret = bq27xxx_battery_current_and_status(di, NULL, val, NULL);
+		if (ret < 0 && di->stale) {
+			/* Status of the last good update, like the cached capacity */
+			val->intval = di->last_status.intval;
+			ret = 0;
+		}
 		break;
 	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
 		ret = bq27xxx_battery_voltage(di, val);
@@ -2304,6 +2344,7 @@ int bq27xxx_battery_setup(struct bq27xxx_device_info *di)
 	di->unseal_key = bq27xxx_chip_data[di->chip].unseal_key;
 	di->dm_regs    = bq27xxx_chip_data[di->chip].dm_regs;
 	di->opts       = bq27xxx_chip_data[di->chip].opts;
+	di->cache.flags = -ENODATA; /* nothing read yet: no values to bridge an error with */
 
 	psy_desc = devm_kzalloc(di->dev, sizeof(*psy_desc), GFP_KERNEL);
 	if (!psy_desc)
diff --git a/include/linux/power/bq27xxx_battery.h b/include/linux/power/bq27xxx_battery.h
index 731ea837aac3..9c2a55f40f76 100644
--- a/include/linux/power/bq27xxx_battery.h
+++ b/include/linux/power/bq27xxx_battery.h
@@ -67,6 +67,8 @@ struct bq27xxx_device_info {
 	int voltage_max_design;
 	bool removed;
 	unsigned long last_update;
+	bool stale;			/* failed update(s) being bridged with the last values */
+	unsigned long stale_since;	/* jiffies of the first of them */
 	union power_supply_propval last_status;
 	struct delayed_work work;
 	struct power_supply *bat;
-- 
2.43.0

