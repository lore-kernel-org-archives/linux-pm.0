Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8BA569F04
	for <linux-pm@vger.kernel.org>; Wed,  9 Sep 2026 15:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788968532; cv=none; b=azciFHLdukmX05NImgHR9nz102g1Iok0xiNTnGKdmMEMBIaKJmdUPOHnCt8aa5k7V4AuHbej35fSOBCScQTM1eX6P+D7ahhANWDmCI73ROnFWnXzRwIJho23wXFiJ+38HSd6WICdinvGHrvOGJ0BOXrvEsPv04rb6qfcpmpEM+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788968532; c=relaxed/simple;
	bh=0NwXSncFwR6YuS62Kx37owltw4umKj8bQFmER1oSXrg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QZ08UUcjHrUQ4rWjr6aJds0QrGhTYn35dseglaLN07Zj6rcM2ntNTnj68o6FK+71Ssn0bpIxwHp93DvJT73UWlmWrCB3aVtYYX6/FA6mrGlcsgs7lq4pPoZcyZay+RT2KhYwL2kvRSrAp6q79hJhnpacOhjgKqDxxNdQeRh39Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net; spf=pass smtp.mailfrom=flipper.net; dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b=Hlt9i9zC; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flipper.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b="Hlt9i9zC"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-49b965570d7so67450645e9.0
        for <linux-pm@vger.kernel.org>; Wed, 09 Sep 2026 08:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flipper.net; s=google; t=1788968529; x=1789573329; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HJYkl8jNFFOfbd0XkHiDP5XOYtWq4UTRk/hZ80PHvcA=;
        b=Hlt9i9zC5Tyd6hvkQb390grplxqryfoxwXgHtBbFoIhwEVKSkQBcbNglmgzEbLqNLF
         eLTmUJUJzpye4a2wH+1d1SdkIRG7aaA6KQKBHjqrM842uywIm/Z8FCEY/E16DMXglGjI
         v5vDfiuSwovQc8WZRKZZYxq1EoJ+Efn80dhMpx6DBN+XY4uIBpKwsSsVEOBL9M0lAlD1
         pG5bRCwK11RN+jDBqEEf1G9wZ1i6hteyzH/HeQC5bEOa9ScSjADPFqbj8l7upagqw0RX
         UXHQOzL4tx1gCrn8aU3xoQOEeWq0AqXraMuLU2aPVfXOGt38IpOd6LdbRb97VYd7dFhW
         U9og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788968529; x=1789573329;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HJYkl8jNFFOfbd0XkHiDP5XOYtWq4UTRk/hZ80PHvcA=;
        b=jdbyQm/n0WfC7jLs+09ucEev2kHyq64DatUKzFobY2An/fvTKF9NL1GYfP34y3VnQ5
         vZZNQdpejB+ycBh+c1IPYrWkS/qEPVDWd9a2Ig7fvmpXPFfHzXbnaeyo0/e49yeNNqNR
         sPkjyJL1M0bJ+3u71N4/JkkJrEikE5bC9YC3i2YAqyOQPrz97k9dS95rN58x7E1losAX
         9BwRSJRdRH7uLuBSPDcSwvDcbLB794CtjmMGBY/aKu4RjxNdG/17sULqWBLMpFvqVZxR
         HqLgLunnT0lZwoEknu5rkJiV7BSeYoUAN6udwuhCOdRXfxEaUJ76kddk9UiOlzFWqwfN
         kbRA==
X-Forwarded-Encrypted: i=1; AKwUvBxjLiUOf3P1Sci+0buIYHrWDgR95sWkDi0s1cMa6JQak1tmjJq3J4QeZWjGksiBEACqO7+/ijieiA==@vger.kernel.org
X-Gm-Message-State: AFuF++lhY6C3v9AI2bwZn5s0CdZ+9ze7IzD/hD3KPA2eyQo8hrCAyjjT
	wvzZNMiBLUJk9KDByDkQchDcIWX5/clQYGkkNNzOLmUfuHtD4s5kU3NNUbmb1fjHHLo=
X-Gm-Gg: AYBFou1JilLmgfX85x4abmcOn+7092r0/DMaot/mXWFclOgNCuE8t5K4zyLWc6fPgQT
	pofJBT8wNC/HRAj5QTCaPEd6QSPHvn9QKf+ZJN+c+HFTKqhwW5sKpSy59A4lUt1hARsI0CgimVq
	+ymrNAr6iIWYVUPciTutyzXLQC0aOpZY8GwKNs48+yuV730f+RkJPVKtpt9aaM5HTjtJCTS3ZRL
	+orSA9tDgrOcG+oLJYt5vpr+PhWB6OhzFLTu+57nDlibmR8Xi85HWJz8jf6Sb7wh9cXN20ciQ8r
	00XzDN3BjKC926XjKo1y6nkHJqRnggFGGzSNWdKkyMKthao0asbnMdn4VXBlU/NFSlDGK4OyjIl
	TyerzOkyIiBULmDURrG0ZTNUIgZZKhW+6liZRsLuQDwWLoxVnDvgM0m+Wy43QO2tLF4Mm8EDyoy
	YRLVUwFR0eOw7ShS2cFNgl0ZNc9XztU07++8auimnXe7GnKYc/PLzSsGPEFKm2m4GBD8FfjCoI1
	s/iYt5vPjetXZe6O9w47U39KMSYwIlVMAtnLx6uf0zeVytbGlE=
X-Received: by 2002:a05:600c:1914:b0:49c:ff23:a6d5 with SMTP id 5b1f17b1804b1-49cff23a70bmr322804815e9.0.1788968528792;
        Wed, 09 Sep 2026 08:42:08 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-2-51-220-108.alshamil.net.ae. [2.51.220.108])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cf7740d44sm1042068015e9.15.2026.09.09.08.42.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 08:42:08 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Wed, 09 Sep 2026 19:41:45 +0400
Subject: [PATCH v2 2/4] power: supply: core: Allow getting battery info
 before psy is registered
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260909-bq257xx-init-v2-2-deb4076b1f02@flipper.net>
References: <20260909-bq257xx-init-v2-0-deb4076b1f02@flipper.net>
In-Reply-To: <20260909-bq257xx-init-v2-0-deb4076b1f02@flipper.net>
To: Sebastian Reichel <sre@kernel.org>, Lee Jones <lee@kernel.org>, 
 Chris Morgan <macromorgan@hotmail.com>, Pavel Machek <pavel@ucw.cz>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>, 
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Alexey Charkov <alchark@flipper.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=10260; i=alchark@flipper.net;
 h=from:subject:message-id; bh=0NwXSncFwR6YuS62Kx37owltw4umKj8bQFmER1oSXrg=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWQtrHObbC5hFPP/d9Gmn7FyHmqvWdSzf79IOH+SxWGBi
 EKpnPSSjoksDGJcDJZiiixzvy2xnWrEN2uXh8dXmDmsTCBDpEUaGICAhYEvNzGv1EjHSM9U21DP
 0EjHWMeIgYtTAKb6sAHDf4epzL9m2UcdczcwC3n++qOKnM/x7p871n05vWy36tkf9Y0M/4sTm41
 SNTP3Za68djLInXv7q0cJfBEtedmi86/NNo26xwkA
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5

Some power supplies, such as battery chargers, may need to program the
device parameters based on what their connected battery allows. Current
API requires registering the power supply to access battery information,
which is problematic because a registered power supply is immediately
available to the rest of the system, but the battery parameters may not
be set yet in the charger.

Given that the battery info helpers really only need a fwnode and a struct
device to hang devres-allocated resourses on, add a pure dev-based get/put
API alongside the existing psy-based one, which can be used to query the
battery information before registering the power supply.

Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 drivers/power/supply/power_supply_core.c | 102 ++++++++++++++++++++++---------
 include/linux/power_supply.h             |   4 ++
 2 files changed, 77 insertions(+), 29 deletions(-)

diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index 1279785645fb..09473361772f 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -725,21 +725,18 @@ struct power_supply *devm_power_supply_get_by_reference(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(devm_power_supply_get_by_reference);
 
-int power_supply_get_battery_info(struct power_supply *psy,
-				  struct power_supply_battery_info **info_out)
+static int __power_supply_get_battery_info(struct device *dev,
+					   struct fwnode_handle *srcnode,
+					   struct power_supply_battery_info **info_out)
 {
 	struct power_supply_resistance_temp_table *resist_table;
 	struct power_supply_battery_info *info;
-	struct fwnode_handle *srcnode, *fwnode;
+	struct fwnode_handle *fwnode;
 	const char *value;
 	int err, len, index, proplen;
 	u32 *propdata __free(kfree) = NULL;
 	u32 min_max[2];
 
-	srcnode = dev_fwnode(&psy->dev);
-	if (!srcnode && psy->dev.parent)
-		srcnode = dev_fwnode(psy->dev.parent);
-
 	fwnode = fwnode_find_reference(srcnode, "monitored-battery", 0);
 	if (IS_ERR(fwnode))
 		return PTR_ERR(fwnode);
@@ -750,7 +747,7 @@ int power_supply_get_battery_info(struct power_supply *psy,
 
 
 	/* Try static batteries first */
-	err = samsung_sdi_battery_get_info(&psy->dev, value, &info);
+	err = samsung_sdi_battery_get_info(dev, value, &info);
 	if (!err)
 		goto out_ret_pointer;
 	else if (err == -ENODEV)
@@ -765,7 +762,7 @@ int power_supply_get_battery_info(struct power_supply *psy,
 		goto out_put_node;
 	}
 
-	info = devm_kzalloc(&psy->dev, sizeof(*info), GFP_KERNEL);
+	info = devm_kzalloc(dev, sizeof(*info), GFP_KERNEL);
 	if (!info) {
 		err = -ENOMEM;
 		goto out_put_node;
@@ -826,7 +823,7 @@ int power_supply_get_battery_info(struct power_supply *psy,
 		else if (!strcmp("lithium-ion-manganese-oxide", value))
 			info->technology = POWER_SUPPLY_TECHNOLOGY_LiMn;
 		else
-			dev_warn(&psy->dev, "%s unknown battery type\n", value);
+			dev_warn(dev, "%s unknown battery type\n", value);
 	}
 
 	fwnode_property_read_u32(fwnode, "energy-full-design-microwatt-hours",
@@ -877,7 +874,7 @@ int power_supply_get_battery_info(struct power_supply *psy,
 		err = len;
 		goto out_put_node;
 	} else if (len > POWER_SUPPLY_OCV_TEMP_MAX) {
-		dev_err(&psy->dev, "Too many temperature values\n");
+		dev_err(dev, "Too many temperature values\n");
 		err = -EINVAL;
 		goto out_put_node;
 	} else if (len > 0) {
@@ -892,28 +889,28 @@ int power_supply_get_battery_info(struct power_supply *psy,
 		char *propname __free(kfree) = kasprintf(GFP_KERNEL, "ocv-capacity-table-%d",
 							 index);
 		if (!propname) {
-			power_supply_put_battery_info(psy, info);
+			power_supply_put_battery_info_from_dev(dev, info);
 			err = -ENOMEM;
 			goto out_put_node;
 		}
 		proplen = fwnode_property_count_u32(fwnode, propname);
 		if (proplen < 0 || proplen % 2 != 0) {
-			dev_err(&psy->dev, "failed to get %s\n", propname);
-			power_supply_put_battery_info(psy, info);
+			dev_err(dev, "failed to get %s\n", propname);
+			power_supply_put_battery_info_from_dev(dev, info);
 			err = -EINVAL;
 			goto out_put_node;
 		}
 
 		u32 *propdata __free(kfree) = kzalloc_objs(*propdata, proplen);
 		if (!propdata) {
-			power_supply_put_battery_info(psy, info);
+			power_supply_put_battery_info_from_dev(dev, info);
 			err = -EINVAL;
 			goto out_put_node;
 		}
 		err = fwnode_property_read_u32_array(fwnode, propname, propdata, proplen);
 		if (err < 0) {
-			dev_err(&psy->dev, "failed to get %s\n", propname);
-			power_supply_put_battery_info(psy, info);
+			dev_err(dev, "failed to get %s\n", propname);
+			power_supply_put_battery_info_from_dev(dev, info);
 			goto out_put_node;
 		}
 
@@ -921,9 +918,9 @@ int power_supply_get_battery_info(struct power_supply *psy,
 		info->ocv_table_size[index] = tab_len;
 
 		info->ocv_table[index] = table =
-			devm_kcalloc(&psy->dev, tab_len, sizeof(*table), GFP_KERNEL);
+			devm_kcalloc(dev, tab_len, sizeof(*table), GFP_KERNEL);
 		if (!info->ocv_table[index]) {
-			power_supply_put_battery_info(psy, info);
+			power_supply_put_battery_info_from_dev(dev, info);
 			err = -ENOMEM;
 			goto out_put_node;
 		}
@@ -939,14 +936,14 @@ int power_supply_get_battery_info(struct power_supply *psy,
 		err = 0;
 		goto out_ret_pointer;
 	} else if (proplen < 0 || proplen % 2 != 0) {
-		power_supply_put_battery_info(psy, info);
+		power_supply_put_battery_info_from_dev(dev, info);
 		err = (proplen < 0) ? proplen : -EINVAL;
 		goto out_put_node;
 	}
 
 	propdata = kzalloc_objs(*propdata, proplen);
 	if (!propdata) {
-		power_supply_put_battery_info(psy, info);
+		power_supply_put_battery_info_from_dev(dev, info);
 		err = -ENOMEM;
 		goto out_put_node;
 	}
@@ -954,17 +951,17 @@ int power_supply_get_battery_info(struct power_supply *psy,
 	err = fwnode_property_read_u32_array(fwnode, "resistance-temp-table",
 					     propdata, proplen);
 	if (err < 0) {
-		power_supply_put_battery_info(psy, info);
+		power_supply_put_battery_info_from_dev(dev, info);
 		goto out_put_node;
 	}
 
 	info->resist_table_size = proplen / 2;
-	info->resist_table = resist_table = devm_kcalloc(&psy->dev,
+	info->resist_table = resist_table = devm_kcalloc(dev,
 							 info->resist_table_size,
 							 sizeof(*resist_table),
 							 GFP_KERNEL);
 	if (!info->resist_table) {
-		power_supply_put_battery_info(psy, info);
+		power_supply_put_battery_info_from_dev(dev, info);
 		err = -ENOMEM;
 		goto out_put_node;
 	}
@@ -982,22 +979,69 @@ int power_supply_get_battery_info(struct power_supply *psy,
 	fwnode_handle_put(fwnode);
 	return err;
 }
+
+int power_supply_get_battery_info(struct power_supply *psy,
+				  struct power_supply_battery_info **info_out)
+{
+	struct fwnode_handle *srcnode;
+
+	srcnode = dev_fwnode(&psy->dev);
+	if (!srcnode && psy->dev.parent)
+		srcnode = dev_fwnode(psy->dev.parent);
+
+	return __power_supply_get_battery_info(&psy->dev, srcnode, info_out);
+}
 EXPORT_SYMBOL_GPL(power_supply_get_battery_info);
 
-void power_supply_put_battery_info(struct power_supply *psy,
-				   struct power_supply_battery_info *info)
+/**
+ * power_supply_get_battery_info_from_dev() - Get battery info without a supply
+ * @dev: Device holding the "monitored-battery" reference, which also owns the
+ *	 devres allocations made for the returned info
+ * @info_out: Pointer to store the resulting battery info
+ *
+ * Same as power_supply_get_battery_info(), but keyed off a plain device rather
+ * than a registered power supply. Chargers that program hardware limits taken
+ * from the battery node need those values *before* they can safely register
+ * their power supply: registering makes the supply callable, so a later probe
+ * failure would free driver data underneath a running callback.
+ *
+ * Release the result with power_supply_put_battery_info_from_dev().
+ *
+ * Return: 0 on success or an error code on failure.
+ */
+int power_supply_get_battery_info_from_dev(struct device *dev,
+					   struct power_supply_battery_info **info_out)
+{
+	return __power_supply_get_battery_info(dev, dev_fwnode(dev), info_out);
+}
+EXPORT_SYMBOL_GPL(power_supply_get_battery_info_from_dev);
+
+/**
+ * power_supply_put_battery_info_from_dev() - Release battery info
+ * @dev: Device passed to power_supply_get_battery_info_from_dev()
+ * @info: Battery info to release
+ */
+void power_supply_put_battery_info_from_dev(struct device *dev,
+					    struct power_supply_battery_info *info)
 {
 	int i;
 
 	for (i = 0; i < POWER_SUPPLY_OCV_TEMP_MAX; i++) {
 		if (info->ocv_table[i])
-			devm_kfree(&psy->dev, info->ocv_table[i]);
+			devm_kfree(dev, info->ocv_table[i]);
 	}
 
 	if (info->resist_table)
-		devm_kfree(&psy->dev, info->resist_table);
+		devm_kfree(dev, info->resist_table);
+
+	devm_kfree(dev, info);
+}
+EXPORT_SYMBOL_GPL(power_supply_put_battery_info_from_dev);
 
-	devm_kfree(&psy->dev, info);
+void power_supply_put_battery_info(struct power_supply *psy,
+				   struct power_supply_battery_info *info)
+{
+	power_supply_put_battery_info_from_dev(&psy->dev, info);
 }
 EXPORT_SYMBOL_GPL(power_supply_put_battery_info);
 
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index 131cafded72f..f42ae4e3bf81 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -865,6 +865,10 @@ extern int power_supply_get_battery_info(struct power_supply *psy,
 					 struct power_supply_battery_info **info_out);
 extern void power_supply_put_battery_info(struct power_supply *psy,
 					  struct power_supply_battery_info *info);
+extern int power_supply_get_battery_info_from_dev(struct device *dev,
+						  struct power_supply_battery_info **info_out);
+extern void power_supply_put_battery_info_from_dev(struct device *dev,
+						   struct power_supply_battery_info *info);
 extern bool power_supply_battery_info_has_prop(struct power_supply_battery_info *info,
 					       enum power_supply_property psp);
 extern int power_supply_battery_info_get_prop(struct power_supply_battery_info *info,

-- 
2.55.0

