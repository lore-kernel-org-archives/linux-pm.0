Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795806602;
	b=gheGFn96NegalU1cP6NGjE23gEFvkEH2OypOgAXURfRjSUSeLcRB5Z4PJDk5GbqhBY1c
	 DobKg4fQoXrFGnPfWddhmr3bQj5w5KcovDre7DkIlsMtE1OlDXKLubxiY/9nf39Tw4Iib
	 ioer6R9QY53P6PJ1nq/czH4N0bY9Zb0V1X4Gwyeed28wjogoA7kYOlE/1xcq+tAOB3bv/
	 IhfMmyfxUMEAOmeQqTKKtkrO/trnOea8tjzuty0Gp63IbwjhboHBraYiUfcuLRj2OTk40
	 4RIi0AUzBHAIlBdtblOwccL2mA/L+H4a5xqgcKLEjkwDWQ1kn/HFAaBaufAi8APOD7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795806602;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=dXu+gupJbDF26JL/eklQw0L6HJEJA1Tcvg7uSiLYsuo=;
	b=Jq2AeqxmA1ALGglZzq4M2xXBJPiEn25/d8+I2Sj3cqacaRqvknxAeIs99y0omTvC0UoL
	 A6XL6nriPAvJafLv8aVtvjMgwZ16XcZUv7zp8CPE0fS2tIrh5BHPxzxOcbDg2MeE0GJ77
	 Y3lA0AC7+Bx8s5ZpqqiC+SY49jnBvckOXu0RlXWaz/a80k73okDl5tk3VFnh0MnUFOLTH
	 OKT6wBymXE3HClX5GDLLxtn1zEJ1GRemi1QsZjsnXrBmD0UgGAqAQoPU+mfPuCSuMyuJa
	 Xf9+cYL5pO6o1MpERG8kCMvrsjEM4HC6IGvqOoZzejy8Mtdzly1C71E8C+hHE741Qwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=v5NDyGX9;
	arc=none smtp.remote-ip=209.85.208.45
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6269A606A338
	for <linux-pm@vger.kernel.org>; Fri, 27 Nov 2026 19:10:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6269A606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=v5NDyGX9
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6b87a1a2babso16295132a12.0
        for <linux-pm@vger.kernel.org>; Fri, 27 Nov 2026 11:10:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1795806600; x=1796411400; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dXu+gupJbDF26JL/eklQw0L6HJEJA1Tcvg7uSiLYsuo=;
        b=v5NDyGX9bx5iCRd+RO1Fb8xxoFOd2//fw/XIw0IFXooZe7HgV5FVwJt3lh/QC2A3Uf
         uH259pqTOFiqf14C8YyRM+EhllJI77UuCnqN+XajFIejY6MxCzWnAlveBGR18ki6yBmh
         8MDj0F5T2Awe/3OW2OeYtLbswMxeDL0y5z9htwpXpN+9wwoXU9ur9BnGm5kIYabbZwk8
         L8e2umOkby0k1JJmXFDqm0zsjK0bj6Mbvk5FfdhNRhVUMoirZAc598N/wn885LZxv5kD
         ZCqZU7rc4stKlSBeXCxSTgQx9q+QsMLk244HZ89oXEexZgxa4so350hnZZEP6vn6BEB5
         J5Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795806600; x=1796411400;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dXu+gupJbDF26JL/eklQw0L6HJEJA1Tcvg7uSiLYsuo=;
        b=eh2dLxkwrlKbrEKsCGWLs884GH3ddD9w6VhjD1nErunCudQie3Q0Y9OcaBKLmkQkq2
         fW2/uTGaxQsN6LBcVdg0+P6efhlErtIPM+rbxHnuoir6kfM15HQg0lqgXyj/Aq9nwDqQ
         m58w8ChrBTGaJbcxeLZ10Yhat+gzRtMWmuLoQUQwpjt9D4w/KvmBgjoVHz4fbhDsXT2E
         CPnRJpVUaxkrue1qW/Q1vUrlAs3nnC19PhclXTUNp8/brKRO7cLkwv7fWSEuLNWduxWw
         j5ldOmTU+EzD5tERSM2l7gmyKxe5nBkakq7o7QaOpNMqHZA5c4BW8r603L1t2SI1x+EI
         /Vrw==
X-Forwarded-Encrypted: i=1; AL+hErFqSv+tJwQfsZbTeLjrGc9qvNviSQ/hcwY3/FSI0ckfto/84EPnwID7VbemiWZX0mCE69hJiLrXFA==@vger.kernel.org
X-Gm-Message-State: APuU4Z/OeS3yyYdwfnGHPibyR4fypzcduSSgH1Pvm3vgkDfd8IOcvjhU
	riq3/giQFSEUib5j0tAgzhg+XHBzSU0oEMiwp+M9MAI8J6kloyfijmqs7VOf3qsAQcM=
X-Gm-Gg: AZFdTZfHB7EGylzcvyWrOevboRkwiFGwzX4PnZgy24MSEW2Op4FiknMgvDq89ToNDgB
	NqVsLGsuhvTP5QTOrmWEBGLbN7WtmRzD7T044+6dhvYLYtpuUMR1RRXkwicrC2IT9Yw/U2ciYhr
	3NN20UxIWGBuT8qmhqbLywF4loPB0w55nKADMUrKGNDGF+j2XjWhN1kYcb8MN3lBcy5hxT3nPme
	24jji1q7eyg8eg/qzqxqqmLmH2pzc/tnSIrd/No57Eeg+Ruuy/Xv1O6VAwv/aXmFdagAaiqob3+
	Kl0fKx7cjbntVApL6MGNReP4yF1ZJqQrUQSMuAn1AcCTMxTbxkcNx/fQ3N0RMPv9/tR+VMsEzTZ
	RkRIFQtdRsagHZ0UxvnefQgiI1udvMjJIcVMrS76m9stNWu6JqeRQ/6h3aKN1Nz45XB2RWxVDMy
	9w3NugNZdRTIO7oflqeS/jFK/yZYbZeFFUjN8IkIWYravXC7juuoPSScFSZV5gRFDppXN0D2Xox
	m/ILJG8EiIfP7Yu8hY/wKfPLN11jYU/mUOuODYJwzqIzTl8HcfBtS1fstBPDaqIXC6CL2q9isqI
	FtQ2sP9TIaYtjDIgyzsYsNFRL1ZMPQgtS3GtFhMohKs/qxniZFz3VOKPuZlClpB6AfbRAViDqkn
	oCTAzJXSNmVZ35GS+qg==
X-Received: by 2002:a17:907:8e95:b0:c46:9745:ac13 with SMTP id a640c23a62f3a-c5131a79f69mr2232389066b.32.1795806599650;
        Fri, 27 Nov 2026 11:09:59 -0800 (PST)
Received: from puffmais2.c.googlers.com (226.124.90.34.bc.googleusercontent.com. [34.90.124.226])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513afe85fdsm909175266b.69.2026.11.27.11.09.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 11:09:58 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Fri, 27 Nov 2026 19:09:57 +0000
Subject: [PATCH 6/6] power: supply: max77759: follow the supplier from DT
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
Content-Transfer-Encoding: 8bit
Message-Id: <20261127-max77759-charger-fixes-v1-6-b364a0862d72@linaro.org>
References: <20261127-max77759-charger-fixes-v1-0-b364a0862d72@linaro.org>
In-Reply-To: <20261127-max77759-charger-fixes-v1-0-b364a0862d72@linaro.org>
To: Amit Sunil Dhamne <amitsd@google.com>, 
 Sebastian Reichel <sre@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Lee Jones <lee@kernel.org>
Cc: Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, Juan Yescas <jyescas@google.com>, 
 kernel-team@android.com, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, mfd@lists.linux.dev, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 stable+noautosel@kernel.org
X-Mailer: b4 0.14.3

max77759_charger can follow the wrong power supply on systems with
multiple Type-C ports, misses suppliers not named "tcpm-source*", and
starts charging from any unrelated "tcpm-source*" supply even when the
PMIC DT node lists no power-supplies property.

Although the driver passes psy_cfg.fwnode when registering its power
supply, it ignores the power_supply core's DT supplier tracking and
instead uses a global notifier and power_supply_for_each_psy() to match
any supply whose name starts with "tcpm-source".

Replace the global notifier, power_supply_for_each_psy() scan, and
delayed work with .external_power_changed and
power_supply_get_property_from_supplier(), which follow the DT
power-supplies relation. Wire max77759_charger_init() into
power_supply_desc.init so hardware initialization completes before
device_add() exposes the supply to callbacks, serialize supplier syncs
with chg->sync_lock so chg->lock is never held across supplier property
reads (lock order: [consumer epc_sem] -> sync_lock -> supplier epc_sem,
and sync_lock -> chg->lock; get_online() and the regulator ops take only
chg->lock), and invoke max77759_charger_external_power_changed() at the
end of probe for the initial sync.

Behavioural differences from the previous implementation:
- The 3 x 10 ms work retry loop is dropped, matching other charger
  drivers: transient I2C arbitration loss (-EAGAIN) is already retried
  by the I2C core, and any remaining error is logged with dev_err()
  rather than retried by the driver.
- Previously, charging started whenever any "tcpm-source*" supply
  appeared, even if the PMIC DT node lacked a power-supplies property.
  Now, a PMIC node without a configured supplier logs a warning at probe
  and leaves charging off. The in-tree gs101-pixel-common.dtsi gained
  power-supplies only in v7.4-rc1 via commit 3653ea2aa0a2 ("arm64: dts:
  exynos: gs101-pixel-common: add supply and regulator properties"),
  whereas both the charger driver and the power-supplies binding
  reference in maxim,max77759.yaml landed in v7.1-rc1, so booting with a
  v7.1-v7.3 DTB loses charging and logs the warning. Dropping this
  undocumented name-matching fallback is warranted even as a potential
  DT ABI change: maxim,max77759.yaml documents explicit power-supplies
  wiring, and matching by name risks binding to an unrelated power
  supply.

Fixes: 70d7dd27f6dc ("power: supply: max77759: add charger driver")
Cc: stable+noautosel@kernel.org # v7.3+ .init, v7.4+ DTS, psy core fixes
Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 drivers/power/supply/max77759_charger.c | 219 ++++++++++----------------------
 1 file changed, 65 insertions(+), 154 deletions(-)

diff --git a/drivers/power/supply/max77759_charger.c b/drivers/power/supply/max77759_charger.c
index fe71e8143954..655061a1dc93 100644
--- a/drivers/power/supply/max77759_charger.c
+++ b/drivers/power/supply/max77759_charger.c
@@ -8,7 +8,6 @@
 #include <linux/bitfield.h>
 #include <linux/cleanup.h>
 #include <linux/device.h>
-#include <linux/devm-helpers.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/linear_range.h>
@@ -21,15 +20,11 @@
 #include <linux/regmap.h>
 #include <linux/regulator/driver.h>
 #include <linux/string_choices.h>
-#include <linux/workqueue.h>
 
 /* Default values for Fast Charge Current & Float Voltage */
 #define CHG_CC_DEFAULT_UA			2266770
 #define CHG_FV_DEFAULT_UV			4300000
 
-#define MAX_NUM_RETRIES				3
-#define PSY_WORK_RETRY_DELAY_MS			10
-
 #define FOREACH_IRQ(S)			\
 	S(AICL),			\
 	S(CHGIN),			\
@@ -76,13 +71,8 @@ struct max77759_charger {
 	struct regmap *regmap;
 	struct power_supply *psy;
 	struct regulator_dev *chgin_otg_rdev;
-	struct notifier_block nb;
-	struct delayed_work psy_work;
-	struct mutex retry_lock; /* Protects psy_work state below */
-	int tcpm_current_limit;
-	int tcpm_online;
-	u32 psy_work_retry_cnt;
 	int irqs[NUM_IRQS];
+	struct mutex sync_lock; /* serializes supplier sync */
 	struct mutex lock; /* protects the state below */
 	enum max77759_chgr_mode mode;
 };
@@ -422,14 +412,6 @@ static int max77759_charger_get_property(struct power_supply *psy,
 	return ret < 0 ? ret : 0;
 }
 
-static const struct power_supply_desc max77759_charger_desc = {
-	.name = "max77759-charger",
-	.type = POWER_SUPPLY_TYPE_USB,
-	.properties = max77759_charger_props,
-	.num_properties = ARRAY_SIZE(max77759_charger_props),
-	.get_property = max77759_charger_get_property,
-};
-
 static int charger_set_mode(struct max77759_charger *chg,
 			    enum max77759_chgr_mode mode, bool *changed)
 {
@@ -460,6 +442,53 @@ static int charger_set_mode(struct max77759_charger *chg,
 	return 0;
 }
 
+static void max77759_charger_external_power_changed(struct power_supply *psy)
+{
+	struct max77759_charger *chg = power_supply_get_drvdata(psy);
+	enum max77759_chgr_mode target = MAX77759_CHGR_MODE_OFF;
+	union power_supply_propval current_limit, online;
+	bool changed = false;
+	int ret, ret2;
+
+	scoped_guard(mutex, &chg->sync_lock) {
+		ret = power_supply_get_property_from_supplier(psy,
+							      POWER_SUPPLY_PROP_ONLINE,
+							      &online);
+		if (!ret && online.intval)
+			ret = power_supply_get_property_from_supplier(psy,
+								      POWER_SUPPLY_PROP_CURRENT_MAX,
+								      &current_limit);
+
+		if (ret) {
+			/*
+			 * power_supply_get_property_from_supplier() collapses
+			 * absent suppliers and supplier read errors to -ENODEV.
+			 */
+			if (ret == -ENODEV) {
+				dev_dbg(chg->dev,
+					"Supplier unavailable, disabling charging\n");
+				ret = 0;
+			}
+		} else if (online.intval && current_limit.intval) {
+			ret = set_input_current_limit(chg, current_limit.intval,
+						      &changed);
+			if (!ret)
+				target = MAX77759_CHGR_MODE_CHG_BUCK_ON;
+		}
+
+		ret2 = charger_set_mode(chg, target, &changed);
+		if (!ret)
+			ret = ret2;
+	}
+
+	if (changed)
+		power_supply_changed(psy);
+
+	if (ret)
+		dev_err(chg->dev, "Failed to sync with supplier: %pe\n",
+			ERR_PTR(ret));
+}
+
 static int enable_chgin_otg(struct regulator_dev *rdev)
 {
 	struct max77759_charger *chg = rdev_get_drvdata(rdev);
@@ -554,8 +583,9 @@ static int max77759_init_irqhandler(struct max77759_charger *chg)
 	return 0;
 }
 
-static int max77759_charger_init(struct max77759_charger *chg)
+static int max77759_charger_init(struct power_supply *psy)
 {
+	struct max77759_charger *chg = power_supply_get_drvdata(psy);
 	struct power_supply_battery_info *info;
 	u32 regval, fast_chg_curr, fv;
 	int ret;
@@ -569,7 +599,7 @@ static int max77759_charger_init(struct max77759_charger *chg)
 	if (ret)
 		return ret;
 
-	if (power_supply_get_battery_info(chg->psy, &info)) {
+	if (power_supply_get_battery_info(psy, &info)) {
 		fv = CHG_FV_DEFAULT_UV;
 		fast_chg_curr = CHG_CC_DEFAULT_UA;
 	} else {
@@ -607,116 +637,15 @@ static int max77759_charger_init(struct max77759_charger *chg)
 	return ret;
 }
 
-static void psy_work_item(struct work_struct *work)
-{
-	struct max77759_charger *chg =
-		container_of(work, struct max77759_charger, psy_work.work);
-	int current_limit, online, ret;
-	bool changed = false;
-
-	scoped_guard(mutex, &chg->retry_lock) {
-		current_limit = chg->tcpm_current_limit;
-		online = chg->tcpm_online;
-	}
-
-	if (online && current_limit) {
-		ret = set_input_current_limit(chg, current_limit, &changed);
-		if (ret) {
-			dev_err(chg->dev,
-				"Unable to set current limit, ret=%d\n", ret);
-			goto err;
-		}
-
-		charger_set_mode(chg, MAX77759_CHGR_MODE_CHG_BUCK_ON, &changed);
-	} else {
-		charger_set_mode(chg, MAX77759_CHGR_MODE_OFF, &changed);
-	}
-
-	if (changed)
-		power_supply_changed(chg->psy);
-
-	scoped_guard(mutex, &chg->retry_lock) {
-		if (chg->psy_work_retry_cnt)
-			dev_dbg(chg->dev,
-				"chg psy_work succeeded after %u tries\n",
-				chg->psy_work_retry_cnt);
-		chg->psy_work_retry_cnt = 0;
-	}
-
-	return;
-
-err:
-	charger_set_mode(chg, MAX77759_CHGR_MODE_OFF, &changed);
-	if (changed)
-		power_supply_changed(chg->psy);
-	scoped_guard(mutex, &chg->retry_lock) {
-		if (chg->psy_work_retry_cnt >= MAX_NUM_RETRIES) {
-			dev_err(chg->dev, "chg psy work failed, giving up\n");
-			return;
-		}
-
-		++chg->psy_work_retry_cnt;
-		dev_dbg(chg->dev, "Retrying %u/%u chg psy_work\n",
-			chg->psy_work_retry_cnt, MAX_NUM_RETRIES);
-		schedule_delayed_work(&chg->psy_work,
-				      msecs_to_jiffies(PSY_WORK_RETRY_DELAY_MS));
-	}
-}
-
-static int max77759_sync_tcpm_psy(struct power_supply *psy, void *data)
-{
-	union power_supply_propval current_limit, online;
-	static const char *psy_name = "tcpm-source";
-	struct max77759_charger *chg = data;
-	int ret;
-
-	if (!strnstr(psy->desc->name, psy_name, strlen(psy_name)))
-		return 0;
-
-	scoped_guard(mutex, &chg->retry_lock) {
-		ret = power_supply_get_property(psy, POWER_SUPPLY_PROP_ONLINE,
-						&online);
-		if (!ret && online.intval)
-			ret = power_supply_get_property(psy,
-							POWER_SUPPLY_PROP_CURRENT_MAX,
-							&current_limit);
-		if (ret) {
-			if (ret != -ENODEV)
-				dev_err(chg->dev,
-					"Failed to get supplier psy property: %d\n",
-					ret);
-			online.intval = 0;
-		}
-
-		chg->tcpm_online = online.intval;
-		chg->tcpm_current_limit = online.intval ?
-					  current_limit.intval : 0;
-		chg->psy_work_retry_cnt = 0;
-	}
-
-	schedule_delayed_work(&chg->psy_work, 0);
-
-	return 1;
-}
-
-static int psy_changed(struct notifier_block *nb, unsigned long evt, void *data)
-{
-	struct max77759_charger *chg = container_of(nb, struct max77759_charger,
-						    nb);
-	struct power_supply *psy = data;
-
-	if (evt != PSY_EVENT_PROP_CHANGED)
-		return NOTIFY_OK;
-
-	max77759_sync_tcpm_psy(psy, chg);
-
-	return NOTIFY_OK;
-}
-
-static void max_tcpci_unregister_psy_notifier(void *nb)
-{
-	power_supply_unreg_notifier(nb);
-}
+static const struct power_supply_desc max77759_charger_desc = {
+	.name = "max77759-charger",
+	.type = POWER_SUPPLY_TYPE_USB,
+	.properties = max77759_charger_props,
+	.num_properties = ARRAY_SIZE(max77759_charger_props),
+	.get_property = max77759_charger_get_property,
+	.external_power_changed = max77759_charger_external_power_changed,
+	.init = max77759_charger_init,
+};
 
 static int max77759_charger_probe(struct platform_device *pdev)
 {
@@ -741,10 +670,10 @@ static int max77759_charger_probe(struct platform_device *pdev)
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to initialize lock\n");
 
-	ret = devm_mutex_init(dev, &chg->retry_lock);
+	ret = devm_mutex_init(dev, &chg->sync_lock);
 	if (ret)
 		return dev_err_probe(dev, ret,
-				     "Failed to initialize retry_lock\n");
+				     "Failed to initialize sync lock\n");
 
 	psy_cfg.fwnode = dev_fwnode(dev);
 	psy_cfg.drv_data = chg;
@@ -754,10 +683,8 @@ static int max77759_charger_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, PTR_ERR(chg->psy),
 				     "Failed to register psy\n");
 
-	ret = max77759_charger_init(chg);
-	if (ret)
-		return dev_err_probe(dev, ret,
-				     "Failed to initialize max77759 charger\n");
+	if (!chg->psy->num_supplies)
+		dev_warn(dev, "No supplier configured, charging disabled\n");
 
 	chgin_otg_reg_cfg.dev = dev;
 	chgin_otg_reg_cfg.driver_data = chg;
@@ -768,27 +695,11 @@ static int max77759_charger_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, PTR_ERR(chg->chgin_otg_rdev),
 				     "Failed to register chgin otg regulator\n");
 
-	ret = devm_delayed_work_autocancel(dev, &chg->psy_work, psy_work_item);
-	if (ret)
-		return dev_err_probe(dev, ret, "Failed to initialize psy work\n");
-
-	chg->nb.notifier_call = psy_changed;
-	ret = power_supply_reg_notifier(&chg->nb);
-	if (ret)
-		return dev_err_probe(dev, ret,
-				     "Unable to register psy notifier\n");
-
-	ret = devm_add_action_or_reset(dev, max_tcpci_unregister_psy_notifier,
-				       &chg->nb);
-	if (ret)
-		return dev_err_probe(dev, ret,
-				     "Failed to add devm action to unregister psy notifier\n");
-
 	ret = max77759_init_irqhandler(chg);
 	if (ret)
 		return ret;
 
-	power_supply_for_each_psy(chg, max77759_sync_tcpm_psy);
+	max77759_charger_external_power_changed(chg->psy);
 
 	return 0;
 }

-- 
2.56.1.839.g22a8290db9-goog

