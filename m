Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795806600;
	b=VbKhBIM87CSxRXg5XhMsdJJSYR4ImJXT2eK3UHczTEnbYKODL6xpnPBTiHg6gA+HULvn
	 RPbCxTO9w3VAe9g+KfDk9E3S4mRbSVgrSBwjZhCKk5PZ7641UWDsapWYrCm78BGsD8ixT
	 r98gTJZ3UQMBmwnkeioMa1DzyH7Cw7IsMpNFiE4qGhbTyqvXAM9rBZAmxLJlwMvMbO9MG
	 Y9ED2V6Z/snMiEu5yKUVrchkMBe73FWn05C1V5HtnYuKqQ1UnDwcy5FXTQ+U9hPXYcrT7
	 57EiXvFC7LyxZPP/wr/Bkj6YpCjX64G0BrKyQ3kF2BcrQX7l/wwbeU8vn1iM5rTDq7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795806600;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=gMUEHr5+RLy5VN9K88In7HKPCt0PQK7KPkn/dGa+2MI=;
	b=YvR6wAZ/OSjOFm/viidS8Cp20pTiwiA3JZ+IuY6/F0cE5pYXdEtF9S8ZgKzxIq4d5E/I
	 h6WUB3WQFhPrLMcD4QbvUtXRcn+0/JLj5qL//NA7o5yOdyI+IocKsdC0o5eaLMx9YYVNP
	 Jhv637IOFEx7UsX3Gsipyeks4+q0fQ4RSSte4mPKcxL6ewykFa1LLhTOl6dIyVgPCNsjX
	 sTS5M7T79+fY42m60YNEbgUGkA2KeKkMcd1y3koO/7vJJwuPtsgtP/lG1FiMlbBMTD8m5
	 UNaLIE5KKMXR+aP0t3oSpZTPv2q6WFIxenV9xcLpy/42Kah9ELB7EpwirEgKSb8ZWPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=NHAqD3p4;
	arc=none smtp.remote-ip=209.85.218.52
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E73A5606A6B5
	for <linux-pm@vger.kernel.org>; Fri, 27 Nov 2026 19:09:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E73A5606A6B5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=NHAqD3p4
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c51bf011392so354516866b.3
        for <linux-pm@vger.kernel.org>; Fri, 27 Nov 2026 11:09:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1795806598; x=1796411398; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gMUEHr5+RLy5VN9K88In7HKPCt0PQK7KPkn/dGa+2MI=;
        b=NHAqD3p4/CgaMMToaEN7P74q0g/caivQ/b+ti0c0fLLKp1cZi98di9wkKw4rsBvdSq
         h7itirNf7U2rBjiZmNVVPGwLRRYw73tIUZ+7vcsgvTU/DDiMPaJe07UeC7r8ah+kNTqw
         0tx4AebCuvY+IhRAa1Pu0StyO8OCUlZHh24CiOhfL4sTELqBXSaW8O3FYibSmOG9LUhP
         4MXKggtPIJ2d+mxDYuMHDOfx+A4UBzZp1iStQUAMGf89UihTdMNAlCddox66SUEgxJh8
         LLR42ozQSaIPi/nGbrf3smVKtcHT8ysYFrgNxGE1DwkOjFKWIONr4zh1kdBI4GDOo2Dy
         J9hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795806598; x=1796411398;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gMUEHr5+RLy5VN9K88In7HKPCt0PQK7KPkn/dGa+2MI=;
        b=d3ZxoxshZgDX7czDnVxvQniMxF+qT5CsqbqcdPJbRG8Mq0e1eWANpW3UwUneUBZ1O9
         E8Gr3k+DJW3F2eArj6JkAjMmLOuBITr+/gYny/IjC/HEZ+z4u5w/z7p5hGYlfXp5zPAW
         hjFa3FtkgSMMS/r5vPN0CP/WzhfLd7tNh5Rrnw230XM3prBu7t27RmjSS+PCk81A/qbg
         Skr7hHs3VNXfNzhudDh2bxEHn/xmRSYAnCIqOBJgO10a3M8Q4PRZ1YxjISi1n0ycjrPc
         LMatEXalIuf/Bh4qnh5hSsIUmDq0Z54SzU5IVXdFoFyELYAn5U+l4EvqxByNOgcOjic5
         0eeg==
X-Forwarded-Encrypted: i=1; AL+hErFNsbFug3+QAA7fVacE2hZwT774Elzb8/5fYjaOV3JeP9FKkwaSw77pppVSdW3rg73mfdcvDPXROw==@vger.kernel.org
X-Gm-Message-State: APuU4Z/WlVJ930QKlcwax9w5YPTZLn6eG3uF9ehGULHQn8qzwp9NbJFY
	n4I2PCjaKdz6+siNYmc7HfFRcdkZX/J976gfVfuNOSASYUx7BisFAnGoy95lz90uOQM=
X-Gm-Gg: AZFdTZexCcMsVKD9kdQeHe0J+LQ0kNjMbsZw4SvlWGz7Ce9iwygbsEgC9YbgHFQrZ5r
	ZTNS25niG0U/OWwbmzlGkIZp59575cpxS8d95PYS2+9ecITRNoSzs9st1bsPIXm1NCCTxNXpLtu
	tLwYdElprIBRaxh9NNsdYLGipDbiK17dDqCvGzBISEcrHwBQMbgAY4p8AuEYpLl9KwOsP2hIvvF
	k5EjHYTbG140sLBIgPA19nz24Buv4so7Ct4pT9H9oAWr+y692qnG6CEuiTjb1U1AfWVizTujRFH
	W2fxfwXTKer20PZCe5zyLrUCdm53YwTQvVaOjBNTd/lCCGBWDr0bUJ9GYdVSB8ENtR1U0e+b7C6
	1x34q/PN/uyGIsxvuWNL/8aOAIlntDqF1oy2tcYqhLifjukrMa9shncKN51TDUzVZ6oCrIAgaAO
	4tAR59OT4WSr3qC6jW93+XOcTU2KKexqgs/NySEDoHygxle+2k30YxqiQFVxULxvCPhhC0bqd5S
	RkEYUAmRBAjuzo5smQmvQK8yKm+0WHfEZBz31RZ1pRbhhLNFeioZ6kf2H394G3qquWCjXbiwmdU
	gSavA3+ly5x15O/klZ50TtJNpAOuxTgiNbDa1gv2Cn2nP/wYARTgRsgwvnV132R8ACdqAM0ind4
	TAxhBbtX5xXGFChmT4A==
X-Received: by 2002:a17:907:7f91:b0:c50:c747:a4ce with SMTP id a640c23a62f3a-c513a4b083bmr2229259766b.4.1795806598370;
        Fri, 27 Nov 2026 11:09:58 -0800 (PST)
Received: from puffmais2.c.googlers.com (226.124.90.34.bc.googleusercontent.com. [34.90.124.226])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513afe85fdsm909175266b.69.2026.11.27.11.09.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 11:09:58 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Fri, 27 Nov 2026 19:09:56 +0000
Subject: [PATCH 5/6] power: supply: max77759: sync supplier state at probe
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
Message-Id: <20261127-max77759-charger-fixes-v1-5-b364a0862d72@linaro.org>
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

Supplier events emitted before max77759_charger finishes probing (or
before reloading the charger module) are missed, leaving charging off
until the next supplier event.

max77759_charger_probe() calls max77759_charger_init(), which forces
MODE_OFF, and then registers the power_supply notifier without reading
the supplier's current state.

Extract the supplier read and work scheduling from psy_changed() into
max77759_sync_tcpm_psy() and run it via power_supply_for_each_psy() at
the end of probe. Hold chg->retry_lock across the property reads and
state update so the initial scan cannot overwrite a concurrent notifier
event with stale values.

Fixes: 70d7dd27f6dc ("power: supply: max77759: add charger driver")
Cc: stable@vger.kernel.org
Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 drivers/power/supply/max77759_charger.c | 61 +++++++++++++++++++++------------
 1 file changed, 39 insertions(+), 22 deletions(-)

diff --git a/drivers/power/supply/max77759_charger.c b/drivers/power/supply/max77759_charger.c
index 7a7d9a54d888..fe71e8143954 100644
--- a/drivers/power/supply/max77759_charger.c
+++ b/drivers/power/supply/max77759_charger.c
@@ -663,34 +663,31 @@ static void psy_work_item(struct work_struct *work)
 	}
 }
 
-static int psy_changed(struct notifier_block *nb, unsigned long evt, void *data)
+static int max77759_sync_tcpm_psy(struct power_supply *psy, void *data)
 {
-	struct max77759_charger *chg = container_of(nb, struct max77759_charger,
-						    nb);
 	union power_supply_propval current_limit, online;
 	static const char *psy_name = "tcpm-source";
-	struct power_supply *psy = data;
+	struct max77759_charger *chg = data;
 	int ret;
 
-	if (!strnstr(psy->desc->name, psy_name, strlen(psy_name)) ||
-	    evt != PSY_EVENT_PROP_CHANGED)
-		return NOTIFY_OK;
-
-	ret = power_supply_get_property(psy, POWER_SUPPLY_PROP_ONLINE,
-					&online);
-	if (!ret && online.intval)
-		ret = power_supply_get_property(psy,
-						POWER_SUPPLY_PROP_CURRENT_MAX,
-						&current_limit);
-	if (ret) {
-		if (ret != -ENODEV)
-			dev_err(chg->dev,
-				"Failed to get supplier psy property: %d\n",
-				ret);
-		online.intval = 0;
-	}
+	if (!strnstr(psy->desc->name, psy_name, strlen(psy_name)))
+		return 0;
 
 	scoped_guard(mutex, &chg->retry_lock) {
+		ret = power_supply_get_property(psy, POWER_SUPPLY_PROP_ONLINE,
+						&online);
+		if (!ret && online.intval)
+			ret = power_supply_get_property(psy,
+							POWER_SUPPLY_PROP_CURRENT_MAX,
+							&current_limit);
+		if (ret) {
+			if (ret != -ENODEV)
+				dev_err(chg->dev,
+					"Failed to get supplier psy property: %d\n",
+					ret);
+			online.intval = 0;
+		}
+
 		chg->tcpm_online = online.intval;
 		chg->tcpm_current_limit = online.intval ?
 					  current_limit.intval : 0;
@@ -699,6 +696,20 @@ static int psy_changed(struct notifier_block *nb, unsigned long evt, void *data)
 
 	schedule_delayed_work(&chg->psy_work, 0);
 
+	return 1;
+}
+
+static int psy_changed(struct notifier_block *nb, unsigned long evt, void *data)
+{
+	struct max77759_charger *chg = container_of(nb, struct max77759_charger,
+						    nb);
+	struct power_supply *psy = data;
+
+	if (evt != PSY_EVENT_PROP_CHANGED)
+		return NOTIFY_OK;
+
+	max77759_sync_tcpm_psy(psy, chg);
+
 	return NOTIFY_OK;
 }
 
@@ -773,7 +784,13 @@ static int max77759_charger_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, ret,
 				     "Failed to add devm action to unregister psy notifier\n");
 
-	return max77759_init_irqhandler(chg);
+	ret = max77759_init_irqhandler(chg);
+	if (ret)
+		return ret;
+
+	power_supply_for_each_psy(chg, max77759_sync_tcpm_psy);
+
+	return 0;
 }
 
 static const struct platform_device_id max77759_charger_id[] = {

-- 
2.56.1.839.g22a8290db9-goog

