Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794825719;
	b=4aTxhNrME71004tdt5ayw9KFsgDaxGIwtC2k3iVal2TeOVHyfENMhKJgxHS0vNvV8FCc
	 NJj70GCxWlPcamHLT/wh8LYsFCAtRpN38R4L6aM7iJxJD0Sk+3niZg0VhQnoX4LxwQRrw
	 CVGe5J82ONDrYQiUpEBwox+uHTLpGshRLHn9ebBGZqa9STv2MfkjH2NBawkPXe4ihQ6E4
	 EwKwc1FrMCAt2+uJiX+sHOj6bBozqn70B86rm9vlLi03lmviSNmefFBF5zy0HvuUxTV4W
	 6gT9SHf61/L72ZJ1s7EytW+Gm2xrmnz0nY/0hX1E/ClEyKCMr9SVxbeKw+diE4Yyrkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794825719;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=NIq308VQGUr/7Gxe2x540xjoV4Zdx2xWDIRiVtWnXPw=;
	b=j1HsiqiMDANcJWYsDcmRORI7E5+cPOhvFWTFdHCoVwsl94VTcgWJiAWBOUuQPrJXyVBe
	 84cBOXeFoKlu73DV6yNDsbspXcBsFjXnsH0R1VT575SGUfCTP3njQWV/PgpbjdgP94qmT
	 1p24mNNwS2nEW3mdmaWDx/WYYxFX0U72s9V5bKUip7YbiJ4BWOtopbinWgwglguNqN8pO
	 UrtTTSzr6oEddXdkTDEpa3T970ZIaDxJZir2lZS6nSaemoAOYeziM66zlatk318S0PA84
	 xzo1pwZYYgrdfM+v+5K6RJAZT6jzzRMoxFr+YINHE0rNwi7eYYaB5czif42FTj0wz6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=flipper.net;
	spf=pass smtp.mailfrom=flipper.net;
	dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256 header.s=google header.b=hN0USg6S;
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A00AB606A31C
	for <linux-pm@vger.kernel.org>; Mon, 16 Nov 2026 10:41:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A00AB606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flipper.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256 header.s=google header.b=hN0USg6S
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a210470b49so26405655e9.2
        for <linux-pm@vger.kernel.org>; Mon, 16 Nov 2026 02:41:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flipper.net; s=google; t=1794825717; x=1795430517; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=NIq308VQGUr/7Gxe2x540xjoV4Zdx2xWDIRiVtWnXPw=;
        b=hN0USg6Sa3Y5g+9XzVi3ZgaYLhuQyWBIqQghnDZ16ETnPpDYiqoEjrDUQCj4oQWsxr
         lVqeCsqDVZRrjJMi9wz6S6kAjxlauH55t2ejuOcaVAn9z7t5cnVjbE/RuUEpuYcTtuVn
         mNMJKBRBxydA1RKVyy9GYzLYCJvwTNdRQldZGcXK7rh4X8Ie5dGFZV3ysJQtHzIkH10N
         Fw6UmzNcztsb12cwcRrH5+hf2ew1ruCQ35k4i55TcckQhqHqNlVneLAOdvVtK68L5uYE
         L//ZEvxsaFEOpfOYFpZdnkyeNTpkDtdUAMQnRk8ypBvLHSrdaqchRd7O/nzpRWl8KOVP
         HPrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794825717; x=1795430517;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=NIq308VQGUr/7Gxe2x540xjoV4Zdx2xWDIRiVtWnXPw=;
        b=Tg6VZSHal9L8UupIYleWBj7XqwJTtHDRvxbKD9RpgbmBUm7lRHCUf1Vx3WBm791Zu2
         XYBGm7N4pXS6BCzo/qRDMVI8W3CMmMKmgZ/O4hsOGpKdqTtPuP3YGZ2wiSZRywB4l8pT
         Xd8TRePm9Oa+TTjT2yPJBevPdwtvSqdzWem/Rs0bEWnqmpqDxPaOuAjceU90UUM5LdGd
         /f54g75uYH+RSAqG2Fzp9wpJ4C7I0jALhmfikJSWspkTNTYSFX99bv/7ARBBax64df1b
         +neZ+3uDaBClLv7QHYuuIk8ENz2OUd0iN5/PFbjUK+Z7aueoiiPoap8KWp9GpuYXzi6P
         g16w==
X-Gm-Message-State: APuU4Z9Sedg/3hmkST51yRPtRlmZa8D5mwNMPzI9nxm3Yyf/x7gpUL6C
	erUEs7hU9zcW3B0An6H21YjnXQxV8GVtnBqmK5QHVXpo01NCeDlDqA1f1Uy/eYjDxTk=
X-Gm-Gg: AYBFou2E3H3+5BNZeOBX/JXeYMjn3VQIHPlObOUX7g9IPzPuZnU7pr+MaceksQG/2qj
	ULZpaSqPZi75PzL+gdJdux2EQ4CN0MvY0XOtDJ8+Yhv4J7q/mjXAHkqUtxfnB+UkR+PqXV7vEHo
	75uAC0TbdQznwdLXjeKp3zEITXDBI1+/rzKyKLIbStRXB/7dIfGnicrig1MkcI+Sf1CnYbTlF3W
	nevF/9mj0FtqfnHalR3l+u1NoJcBr0VBr3AEDol2CW9juU+EdZ8aPyvuhHzl7dyDq/SEHrvptK8
	C9B4ltdP0ssdy/fNAP9jfjy+Xxekd8jQzHurWNpuGjzGBBQ92n7ZL2PGNUDIOY2f4v9E6jMT4Vq
	U5H2+VYYcTEsSycw7ilGin7+AeWwgdrnjLt0Q5I65LyWDTUwYngZil38cm9yK5GjKf1Y90HO4h+
	vZcipg9QS9Rff9Vqvj9e2k6M7Dvhajr3lAoUQT/tVepRbjV65ZWbQ0Fu/8dN2TETf7/4gfSMUpD
	CFlA/GhgRqnOXRQ2VWFPm394/nEZ+1JOsEk64TDfGjf5xnUpigmNvCyXHmNLT9VWq4CYWiAzAJc
	Ygi/nVwfpf9jpA0Zc6IqOsd2y6zGczep1y/TAD4y3kSmE+0XBZ53A5W73u0wBRCcfbp9D6BJeRS
	nXnfggCDHkg==
X-Received: by 2002:a05:600c:1989:b0:4bb:665c:a078 with SMTP id 5b1f17b1804b1-4bb665ca43amr133221345e9.28.1794825716789;
        Mon, 16 Nov 2026 02:41:56 -0800 (PST)
Received: from alchark-surface.localdomain (bba-86-98-194-229.alshamil.net.ae. [86.98.194.229])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb64ec7b58sm218180305e9.5.2026.11.16.02.41.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 02:41:56 -0800 (PST)
From: Alexey Charkov <alchark@flipper.net>
Date: Mon, 16 Nov 2026 14:41:51 +0400
Subject: [PATCH] power: supply: bq27xxx: Recheck the status after an
 external power change
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-bq28z620-status-recheck-v1-1-e3ef211c7fd9@flipper.net>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQrCQAxA0auUrA3MRBrUq4iLThptFKpOpiKW3
 r2jLt/i/xlcs6nDoZkh68vc7mNF3DQgQzdeFK2vBgrEMUbG9KTdhymgl65MjlllULkhs+heUmh
 72kKtH1nP9v6dj6e/fUpXlfLdwbKs4H4B1HsAAAA=
X-Change-ID: 20261116-bq28z620-status-recheck-66ce9cb05d23
To: =?utf-8?q?Pali_Roh=C3=A1r?= <pali@kernel.org>, 
 Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Alexey Charkov <alchark@flipper.net>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5560; i=alchark@flipper.net;
 h=from:subject:message-id; bh=yMAsrt3cEsFJF91tvPe7B50jfdiEKkYHfq19JenF93A=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWT9uvtZV++zgbDG9NSsmOWCK/eGRctOuvK56e05tav/t
 i+RUlF50jGRhUGMi8FSTJFl7rcltlON+Gbt8vD4CjOHlQlkiLRIAwMQsDDw5SbmlRrpGOmZahvq
 GRrpGOsYMXBxCsBUG69gZJhy8mGQiQnb07fuESo8Pp/X8FysSrgqb/7boi+iuWK62DNGhiV9yy4
 ve1DMaKFrzb1h2dxDnQYOldcTvj0KYJaxT2nP5QYA
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5

The status of the signed-current gauges follows the sign of the current
they measure, and that only flips once the gauge's next measurement picks
up the charger change. A BQ28Z620 behind a BQ25798 charger shows positive
current up to 0.8s after the charger reports charging, and negative current
about 1.1s after its input goes away. The single check 0.5s after the
change often sees the old sign, raises no uevent, and leaves the status to
the next poll, by default 360s later, so userspace that only watches the
battery (upower, for one) keeps showing the old status for minutes.

A property read in that window loses the check outright: its refresh
pushes the pending work out to poll_interval. upowerd reads the battery
right after the charger's uevent, so on unplug the check never ran at all.

Keep the first check 0.5s after the change, but repeat it up to five
times, 0.5s apart, until the status changes. Count a refresh from a
property read as one of those checks instead of letting it postpone the
rest.

Stop at the first status change rather than running every check. Each
uevent makes userspace reread all battery properties, and the window right
after a replug is when a USB PD port controller on the same bus needs it
most. A status that only lasts a moment then holds until the next refresh,
the price of keeping the bus quiet.

Leave the gauges without a signed current (BQ27XXX_O_ZERO) with the single
check. Their status follows a flag rather than the current, so it never
counts as changed here and they would always use up all five checks.

Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 drivers/power/supply/bq27xxx_battery.c | 39 +++++++++++++++++++++++++++++-----
 include/linux/power/bq27xxx_battery.h  |  1 +
 2 files changed, 35 insertions(+), 5 deletions(-)

diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
index a955feb6cdfb..e4ea92e78a61 100644
--- a/drivers/power/supply/bq27xxx_battery.c
+++ b/drivers/power/supply/bq27xxx_battery.c
@@ -1124,6 +1124,10 @@ module_param_cb(poll_interval, &param_ops_poll_interval, &poll_interval, 0644);
 MODULE_PARM_DESC(poll_interval,
 		 "battery poll interval in seconds - 0 disables polling");
 
+/* Status checks after an external power change, and the delay between them */
+#define BQ27XXX_STATUS_CHECKS		5
+#define BQ27XXX_STATUS_CHECK_DELAY	(HZ / 2)
+
 /*
  * Common code for BQ27xxx devices
  */
@@ -1898,6 +1902,7 @@ static void bq27xxx_battery_update_unlocked(struct bq27xxx_device_info *di)
 	union power_supply_propval status = di->last_status;
 	struct bq27xxx_reg_cache cache = {0, };
 	bool has_singe_flag = di->opts & BQ27XXX_O_ZERO;
+	bool status_changed;
 
 	cache.flags = bq27xxx_read(di, BQ27XXX_REG_FLAGS, has_singe_flag);
 	if (di->chip == BQ27000 && (cache.flags & 0xff) == 0xff)
@@ -1913,9 +1918,10 @@ static void bq27xxx_battery_update_unlocked(struct bq27xxx_device_info *di)
 			bq27xxx_battery_current_and_status(di, NULL, &status, &cache);
 	}
 
+	status_changed = di->last_status.intval != status.intval;
+
 	if ((di->cache.capacity != cache.capacity) ||
-	    (di->cache.flags != cache.flags) ||
-	    (di->last_status.intval != status.intval)) {
+	    (di->cache.flags != cache.flags) || status_changed) {
 		di->last_status.intval = status.intval;
 		power_supply_changed(di->bat);
 	}
@@ -1925,7 +1931,22 @@ static void bq27xxx_battery_update_unlocked(struct bq27xxx_device_info *di)
 
 	di->last_update = jiffies;
 
-	if (!di->removed && poll_interval > 0)
+	if (di->removed)
+		return;
+
+	/*
+	 * Once the status reflects an external power change, stop checking for
+	 * it; otherwise use up the remaining checks before going back to polling.
+	 */
+	if (status_changed)
+		di->status_checks = 0;
+	else if (di->status_checks)
+		di->status_checks--;
+
+	if (di->status_checks)
+		mod_delayed_work(system_percpu_wq, &di->work,
+				 BQ27XXX_STATUS_CHECK_DELAY);
+	else if (poll_interval > 0)
 		mod_delayed_work(system_percpu_wq, &di->work, poll_interval * HZ);
 }
 
@@ -2201,8 +2222,16 @@ static void bq27xxx_external_power_changed(struct power_supply *psy)
 {
 	struct bq27xxx_device_info *di = power_supply_get_drvdata(psy);
 
-	/* After charger plug in/out wait 0.5s for things to stabilize */
-	mod_delayed_work(system_percpu_wq, &di->work, HZ / 2);
+	/*
+	 * After charger plug in/out the current takes a varying time to settle,
+	 * so check the status a few times rather than once on gauges that derive
+	 * it from the sign of the current.
+	 */
+	mutex_lock(&di->lock);
+	if (!(di->opts & BQ27XXX_O_ZERO))
+		di->status_checks = BQ27XXX_STATUS_CHECKS;
+	mod_delayed_work(system_percpu_wq, &di->work, BQ27XXX_STATUS_CHECK_DELAY);
+	mutex_unlock(&di->lock);
 }
 
 int bq27xxx_battery_setup(struct bq27xxx_device_info *di)
diff --git a/include/linux/power/bq27xxx_battery.h b/include/linux/power/bq27xxx_battery.h
index 731ea837aac3..dad3119454c6 100644
--- a/include/linux/power/bq27xxx_battery.h
+++ b/include/linux/power/bq27xxx_battery.h
@@ -68,6 +68,7 @@ struct bq27xxx_device_info {
 	bool removed;
 	unsigned long last_update;
 	union power_supply_propval last_status;
+	unsigned int status_checks;
 	struct delayed_work work;
 	struct power_supply *bat;
 	struct list_head list;

---
base-commit: 84abb955b1015477aa11a96e2f3ac1b938b77f48
change-id: 20261116-bq28z620-status-recheck-66ce9cb05d23

Best regards,
--  
Alexey Charkov <alchark@flipper.net>

