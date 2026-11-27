Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795806599;
	b=bCsomdS1lEQWnmeW1zjZynTDeh5eDf6JV+njCaWxIjWYkY4yFRbfRhJsSoqOglHI5pf/
	 perWHb6v9hm4KsCdZXKm0nrVNtCU5WT6fYz4sV2Hp6ElslpC0rK9ihpRwbU1A80eAyIh4
	 8aIzx106Lfxy9lGOW9lK+hmVyrmcHlYwc4+XQLif1iHYOuCb7KlOih7jvn2HbVTGq9BMw
	 566cBvUvJRuAHBqyPwz9ZagDbQ9py5MLva1g+qaQu4LxRJ/AqIqZ0LhHdTRL955sHqGgo
	 7/eJdl/HAbVdVC2ZypQYC3WrhaLN1zY2fEPRSTjtd8oGTeKj76JtpM688DthSL1flVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795806599;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=nSwTlk+qW9HaX1IW1y5n0J0zLzYJ3qzpDghagGtO0AE=;
	b=fJvRYBrM+pW6qAHH8sPRAY4dW1Eg5StqnIP47TxTaHZkYpj3OLXzWBqvjRZAnBRebE48
	 lufFdM0AvdQlYF5su+o4lrCFHmCdqqMClwClveeT6pMyrUDMNsyr7JWmoTd9u+41YqH13
	 pSHPJKZoedXqrvbOH+NvD5bdsdOCOX1WlVqfhDRwQaSksPn9htUd2SmLZpQiBPCMgAmGI
	 iZuMCEdL/DSv7U9Rwbt6rHYsi14Jf1M1SnFg6GOUEzLfOzaXEe63h5BfYvERhG3okhEp0
	 xDjs16S2ABFLWTZX+6RFq9O4m0Rgch8lw/KSL9BACOUY3GkHuPlxBcAnibyx1/p4EIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=ZBCD39nP;
	arc=none smtp.remote-ip=209.85.218.48
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51922606A6A2
	for <linux-pm@vger.kernel.org>; Fri, 27 Nov 2026 19:09:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 51922606A6A2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=ZBCD39nP
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c50ac25cdd4so1062290766b.1
        for <linux-pm@vger.kernel.org>; Fri, 27 Nov 2026 11:09:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1795806598; x=1796411398; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nSwTlk+qW9HaX1IW1y5n0J0zLzYJ3qzpDghagGtO0AE=;
        b=ZBCD39nPvH4exZZJgv7VykpkHGuo91cS3rRVnhV+HRIsdUwxGMWrrhaukdIQp1rNMC
         aIHtoTLHA1RQmmQTCFT+mqhkAfBnqaVqK7zv3tMX76ZvWDVkfai1FSxg8bNfb1yrrrvJ
         9RIzMUqL5aVLxO96fTeqEKRwGSm2GYaP3M8fgxdyG6i27rdQ+ZrHnNOR3nSlLhHuq0I3
         AO/gzLGzzEBPOO+aG3ZFCh30UUDo3D4vTyq3jWYJBkppcPt6Ld+epujPgsCGw5bt+enC
         D4by+qYX0RcAmdTzK4yCAnh6xB2CQqWgdQK0ZSty0RMTgiETj1iL+YnF/maxUgLnL4EW
         23ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795806598; x=1796411398;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nSwTlk+qW9HaX1IW1y5n0J0zLzYJ3qzpDghagGtO0AE=;
        b=KJoFs+3oMIap4y8wy3UrPcR+roYrIfQl/G+hoYZwgjRXxanC1yUufff1ZcjmE5TExr
         /MUnq49EAnxic2HNBJcmLy6EiZcU19F7ki8OpOdxH98dnfrmvGl/HBuLyVB+dFnMHyMD
         2CKol5i2XveFBet6dJqrrnh7TW4e8UqMYHGf72mvu9PMcvxUBX5Kuy84d3WfmH/YG65W
         2KwjMBjSBozLe2bfLMlIWp+0RUwF//4wmfw6Ter4k093k37lnWgiS8HeULznGAbj93dv
         Pw8kAAtzToR/9ob/g0xdShCImtm5Kb2KWYWPW2PeYYZHpMvzetVB0IIXY6QbmIrOn90s
         Wdqw==
X-Forwarded-Encrypted: i=1; AL+hErGY4TSwT1695wLj7y2fgVgcezLC4kdD7TaSm6dVt6yznHvRwljxRgenFGeB6T5dB/SNIWUKYiq6Ig==@vger.kernel.org
X-Gm-Message-State: APuU4Z8RxgRjph23kR3qncVeEr6zX1P2+il7N4x73PgxU6emOkXB1Dv7
	zaXSvwLhGSyuE75mJ90nQPnwdmXzPaMKV2o8hDJdddlutVpNG6hIqQuklSRRLqQtgy0=
X-Gm-Gg: AZFdTZfJwtIoFV/Cw9toUn7LX2pnZjxJlhgu/OQ5Atxjo10WByfXaeVLqeMmq4YklED
	+pFKn2JVH5o/8S8Ckau5rKk2Bmuepagj278S6e7nMUKK3KiqSlStG2LwpphmONlR0dNLqH9c+wv
	Hn6U2Ea22qSjpdvz+kB5lgIa9IWHHDT4MIKyXqmy7Qi0hoAkQtkt9yjwx1wOouX9u4OruNVnj7V
	FjGn9kftbxCK9M1VHex5v4JLp/awHp4vAsqZ9HxGIxhfXESth4kt9b1tLiFFtTVwa3Ns+FVN+Kk
	NIw4ciK3raDIoAqgtJIUnS7Ue4DAmc4UDNcODfdCrK/Mw3P/tIjJ1iGYOw9p/Iykq+fNxl9YEYg
	5UYSV87R5RtjC4nBh4PQWuWlLI53WA96rhd7ZbA/AEhPhhin64YF1ZUnt+p2FqaqzjxfmQBOyBa
	piv7PSWitWojoIuFascEJptYnAMhK+xFdC9l2j2UIxw2V6SmIEqDU1Qcl7YkiTJbmIcaVejAUKG
	DfZZUbJa0/q7O5L+4hakI3kxM6eAXy6bHp3L7MsA3UwZRnTuObYugJknMXUczO+Wh90QEZtPGp7
	mTT7XnAqq66zB7uSkUJVHdXVAtcpjHpzUOOcmzkvku5mrvcnQru4awhgjp5R2O2pUKqmI3m70Pd
	9fVyDYXdsmwV9aGPJrw==
X-Received: by 2002:a17:907:9d81:b0:c51:3697:d0de with SMTP id a640c23a62f3a-c513a81488emr1386646666b.20.1795806597885;
        Fri, 27 Nov 2026 11:09:57 -0800 (PST)
Received: from puffmais2.c.googlers.com (226.124.90.34.bc.googleusercontent.com. [34.90.124.226])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513afe85fdsm909175266b.69.2026.11.27.11.09.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 11:09:57 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Fri, 27 Nov 2026 19:09:55 +0000
Subject: [PATCH 4/6] power: supply: max77759: notify on mode or input limit
 change
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
Message-Id: <20261127-max77759-charger-fixes-v1-4-b364a0862d72@linaro.org>
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
 stable@vger.kernel.org
X-Mailer: b4 0.14.3

Event-driven userspace (such as UPower or healthd), downstream consumers
(such as the max17042 fuel gauge), and power_supply LED triggers miss
changes to the charger's ONLINE or INPUT_CURRENT_LIMIT properties when
psy_work_item() changes the charger mode or input current limit in
response to a supplier update without triggering a charger hardware
interrupt (for example, changing CHGIN_ILIM while already charging, or
toggling mode with a full battery).

Only the charger interrupt handlers call power_supply_changed().
set_input_current_limit() and charger_set_mode() do not report whether
the hardware state changed, and psy_work_item() never notifies the
power_supply core.

Add a bool *changed output parameter to set_input_current_limit() (via
regmap_update_bits_check()) and charger_set_mode(), and call
power_supply_changed(chg->psy) from psy_work_item() whenever either
changes.

Fixes: 70d7dd27f6dc ("power: supply: max77759: add charger driver")
Cc: stable@vger.kernel.org
Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 drivers/power/supply/max77759_charger.c | 48 ++++++++++++++++++++++-----------
 1 file changed, 33 insertions(+), 15 deletions(-)

diff --git a/drivers/power/supply/max77759_charger.c b/drivers/power/supply/max77759_charger.c
index 49ab1766cc5d..7a7d9a54d888 100644
--- a/drivers/power/supply/max77759_charger.c
+++ b/drivers/power/supply/max77759_charger.c
@@ -345,21 +345,30 @@ static int get_input_current_limit(struct max77759_charger *chg)
 	return ret ? ret : val;
 }
 
-static int set_input_current_limit(struct max77759_charger *chg, int ilim_ua)
+static int set_input_current_limit(struct max77759_charger *chg, int ilim_ua,
+				   bool *changed)
 {
+	bool ilim_changed;
 	u32 regval;
+	int ret;
 
 	if (ilim_ua < 0)
 		return -EINVAL;
 
 	linear_range_get_selector_within(chgin_ilim_ranges, ilim_ua, &regval);
 
-	return regmap_update_bits(chg->regmap, MAX77759_CHGR_REG_CHG_CNFG_09,
-				  MAX77759_CHGR_REG_CHG_CNFG_09_NO_AUTOIBUS |
-				  MAX77759_CHGR_REG_CHG_CNFG_09_CHGIN_ILIM,
-				  MAX77759_CHGR_REG_CHG_CNFG_09_NO_AUTOIBUS |
-				  FIELD_PREP(MAX77759_CHGR_REG_CHG_CNFG_09_CHGIN_ILIM,
-					     regval));
+	ret = regmap_update_bits_check(chg->regmap,
+				       MAX77759_CHGR_REG_CHG_CNFG_09,
+				       MAX77759_CHGR_REG_CHG_CNFG_09_NO_AUTOIBUS |
+				       MAX77759_CHGR_REG_CHG_CNFG_09_CHGIN_ILIM,
+				       MAX77759_CHGR_REG_CHG_CNFG_09_NO_AUTOIBUS |
+				       FIELD_PREP(MAX77759_CHGR_REG_CHG_CNFG_09_CHGIN_ILIM,
+						  regval),
+				       &ilim_changed);
+	if (!ret && changed && ilim_changed)
+		*changed = true;
+
+	return ret;
 }
 
 static const enum power_supply_property max77759_charger_props[] = {
@@ -422,7 +431,7 @@ static const struct power_supply_desc max77759_charger_desc = {
 };
 
 static int charger_set_mode(struct max77759_charger *chg,
-			    enum max77759_chgr_mode mode)
+			    enum max77759_chgr_mode mode, bool *changed)
 {
 	int ret;
 
@@ -445,6 +454,9 @@ static int charger_set_mode(struct max77759_charger *chg,
 		return ret;
 
 	chg->mode = mode;
+	if (changed)
+		*changed = true;
+
 	return 0;
 }
 
@@ -452,14 +464,14 @@ static int enable_chgin_otg(struct regulator_dev *rdev)
 {
 	struct max77759_charger *chg = rdev_get_drvdata(rdev);
 
-	return charger_set_mode(chg, MAX77759_CHGR_MODE_OTG_BOOST_ON);
+	return charger_set_mode(chg, MAX77759_CHGR_MODE_OTG_BOOST_ON, NULL);
 }
 
 static int disable_chgin_otg(struct regulator_dev *rdev)
 {
 	struct max77759_charger *chg = rdev_get_drvdata(rdev);
 
-	return charger_set_mode(chg, MAX77759_CHGR_MODE_OFF);
+	return charger_set_mode(chg, MAX77759_CHGR_MODE_OFF, NULL);
 }
 
 static int chgin_otg_status(struct regulator_dev *rdev)
@@ -553,7 +565,7 @@ static int max77759_charger_init(struct max77759_charger *chg)
 		return ret;
 
 	chg->mode = FIELD_GET(MAX77759_CHGR_REG_CHG_CNFG_00_MODE, regval);
-	ret = charger_set_mode(chg, MAX77759_CHGR_MODE_OFF);
+	ret = charger_set_mode(chg, MAX77759_CHGR_MODE_OFF, NULL);
 	if (ret)
 		return ret;
 
@@ -600,6 +612,7 @@ static void psy_work_item(struct work_struct *work)
 	struct max77759_charger *chg =
 		container_of(work, struct max77759_charger, psy_work.work);
 	int current_limit, online, ret;
+	bool changed = false;
 
 	scoped_guard(mutex, &chg->retry_lock) {
 		current_limit = chg->tcpm_current_limit;
@@ -607,18 +620,21 @@ static void psy_work_item(struct work_struct *work)
 	}
 
 	if (online && current_limit) {
-		ret = set_input_current_limit(chg, current_limit);
+		ret = set_input_current_limit(chg, current_limit, &changed);
 		if (ret) {
 			dev_err(chg->dev,
 				"Unable to set current limit, ret=%d\n", ret);
 			goto err;
 		}
 
-		charger_set_mode(chg, MAX77759_CHGR_MODE_CHG_BUCK_ON);
+		charger_set_mode(chg, MAX77759_CHGR_MODE_CHG_BUCK_ON, &changed);
 	} else {
-		charger_set_mode(chg, MAX77759_CHGR_MODE_OFF);
+		charger_set_mode(chg, MAX77759_CHGR_MODE_OFF, &changed);
 	}
 
+	if (changed)
+		power_supply_changed(chg->psy);
+
 	scoped_guard(mutex, &chg->retry_lock) {
 		if (chg->psy_work_retry_cnt)
 			dev_dbg(chg->dev,
@@ -630,7 +646,9 @@ static void psy_work_item(struct work_struct *work)
 	return;
 
 err:
-	charger_set_mode(chg, MAX77759_CHGR_MODE_OFF);
+	charger_set_mode(chg, MAX77759_CHGR_MODE_OFF, &changed);
+	if (changed)
+		power_supply_changed(chg->psy);
 	scoped_guard(mutex, &chg->retry_lock) {
 		if (chg->psy_work_retry_cnt >= MAX_NUM_RETRIES) {
 			dev_err(chg->dev, "chg psy work failed, giving up\n");

-- 
2.56.1.839.g22a8290db9-goog

