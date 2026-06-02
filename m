Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 290CB338936;
	Tue,  2 Jun 2026 22:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780440450; cv=none; b=orBvIqXSPOljbFm24/GMR2pYCTr45i8PGizN/J5KXK6GhFJRq+jxoY6y4rXpKfML+4E+37x7HY5te5U3Jz5OaBhgwWXczWk5Motfhp2ubIP8JqbxTZELRrt/3hHK/SIPm34EECkTeFVLZ51CmIN9nzlJLvFl0s7mbTcYHpwHoKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780440450; c=relaxed/simple;
	bh=DwWFAL9zm6baOK1xRDhamTlOqRvlsoNjK7vhr+fWTnY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WPink+6IAfn4gMRP2QfO+RsJceZnAj3UgvNm7CGs6/m1OUFf5/awu/gsme9kdunzQBBS9bAyLDcU8TbhlfESUCBO14Q+tUm1ikluwA2hYLcLtVlld4XxHqE6VOckGSFYD/E1DZA7UGbKHL/pFx7G0QAhtOx760X9FOqWCEzGxFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n+nZ3S4C; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n+nZ3S4C"
Received: by smtp.kernel.org (Postfix) with ESMTPS id C5747C2BCC7;
	Tue,  2 Jun 2026 22:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1780440449;
	bh=DwWFAL9zm6baOK1xRDhamTlOqRvlsoNjK7vhr+fWTnY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=n+nZ3S4CrRIM730VEx3t7Tmg+EvFsYbu84rg8yZjxlqKzP/4i2pGKBj1m/kjTg2XD
	 b5eN5QxVExdjAlIorJtpzKB+Xg4pUdD3WcqP2ey1eGA1VmEj2U1rm4ClKkcZ91uhMt
	 wN8VDnNY2HyI36rrFOX3w/C2HnSshpy2n2r5+tosffiTaHRTzLCce+O1JJed56INZk
	 vs8tYXTtvfvPnabk0GhJyLbu1TssIvZAaJKYPprsER1wAwkmiiOOk6jT62AI9qHfvQ
	 FK6W6kJ8AtflLc/0Iw8xGR7X+miXF+vZfHc/iId442iMo7b5RIxhh7MCh2dcnqh/tI
	 QG6rXU2AONsBw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF62DCD5BD1;
	Tue,  2 Jun 2026 22:47:29 +0000 (UTC)
From: Amit Sunil Dhamne via B4 Relay <devnull+amitsd.google.com@kernel.org>
Date: Tue, 02 Jun 2026 22:47:06 +0000
Subject: [PATCH v3 1/2] power: supply: Add helpers to get and put arrays of
 power supply handles
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260602-batt-status-v3-1-a7c1c271f3b0@google.com>
References: <20260602-batt-status-v3-0-a7c1c271f3b0@google.com>
In-Reply-To: <20260602-batt-status-v3-0-a7c1c271f3b0@google.com>
To: Sebastian Reichel <sre@kernel.org>, 
 Badhri Jagan Sridharan <badhri@google.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Hans de Goede <hansg@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>, 
 Purism Kernel Team <kernel@puri.sm>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-usb@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Peter Griffin <peter.griffin@linaro.org>, RD Babiera <rdbabiera@google.com>, 
 Kyle Tso <kyletso@google.com>, Amit Sunil Dhamne <amitsd@google.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780440449; l=5657;
 i=amitsd@google.com; s=20241031; h=from:subject:message-id;
 bh=+oFK9DK6dA282t97V5KFkOWT/2XMjPAyRjRR4RM0SBA=;
 b=0vIgf49wwOzDSqg5dCDSJsWWQWStmt7NVlbAs824NcAcXjZQMkGMiuS/8MstDZN57XnZiGfSg
 LN757LxguQWDGSX3M/0cbgfN8cVVHnGRO5QBjQYB8bzdZR6jv6keTkn
X-Developer-Key: i=amitsd@google.com; a=ed25519;
 pk=wD+XZSST4dmnNZf62/lqJpLm7fiyT8iv462zmQ3H6bI=
X-Endpoint-Received: by B4 Relay for amitsd@google.com/20241031 with
 auth_id=262
X-Original-From: Amit Sunil Dhamne <amitsd@google.com>
Reply-To: amitsd@google.com

From: Amit Sunil Dhamne <amitsd@google.com>

Add power_supply_get_battery_all() to allow drivers to obtain a list of
registered battery type power supply references in the system. Also add
power_supply_put_battery_all() to perform cleanup after the former
function is called.

Signed-off-by: Amit Sunil Dhamne <amitsd@google.com>
---
 drivers/power/supply/power_supply_core.c | 133 +++++++++++++++++++++++++++++++
 include/linux/power_supply.h             |  15 ++++
 2 files changed, 148 insertions(+)

diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index a446d3d086fc..8da4eb275c47 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -482,6 +482,139 @@ struct power_supply *power_supply_get_by_name(const char *name)
 }
 EXPORT_SYMBOL_GPL(power_supply_get_by_name);
 
+static int __power_supply_get_num_battery(struct power_supply *epsy, void *data)
+{
+	int *count = data;
+
+	if (epsy->desc->type == POWER_SUPPLY_TYPE_BATTERY)
+		(*count)++;
+
+	return 0;
+}
+
+static int power_supply_get_num_battery(struct device *dev)
+{
+	int ret, count = 0;
+
+	ret = power_supply_for_each_psy(&count, __power_supply_get_num_battery);
+
+	dev_dbg(dev, "%s: count: %d ret %d\n", __func__, count, ret);
+
+	if (ret)
+		return ret;
+
+	return count;
+}
+
+struct psy_get_supplies_data {
+	int cnt;
+	int size;
+	struct power_supply **psys;
+};
+
+static int __power_supply_populate_battery_array(struct power_supply *epsy,
+						 void *_data)
+{
+	struct psy_get_supplies_data *data = _data;
+
+	if (epsy->desc->type == POWER_SUPPLY_TYPE_BATTERY) {
+		if (data->size <= data->cnt)
+			return -EOVERFLOW;
+
+		get_device(&epsy->dev);
+		data->psys[data->cnt] = epsy;
+		atomic_inc(&epsy->use_cnt);
+		data->cnt++;
+	}
+
+	return 0;
+}
+
+static int power_supply_populate_battery_array(struct device *dev, int size,
+					       struct power_supply **batteries)
+{
+	int ret;
+
+	struct psy_get_supplies_data data = {
+		.cnt = 0,
+		.size = size,
+		.psys = batteries,
+	};
+
+	ret = power_supply_for_each_psy(&data, __power_supply_populate_battery_array);
+
+	dev_dbg(dev, "%s Found %d batteries with array size %d ret %d\n",
+		__func__, data.cnt, data.size, ret);
+
+	if (ret < 0 || !data.cnt) {
+		power_supply_put_battery_all(batteries, data.cnt);
+		return ret;
+	}
+
+	return data.cnt;
+}
+
+/**
+ * power_supply_get_battery_all() - Fetches references to all battery type power
+ *                                  supplies.
+ * @dev: Pointer to device requesting the power supply refs.
+ * @psys: Pointer to an array of power supply refs.
+ *
+ * Helper function to get handles to all battery type power supplies.
+ * If acquiring a ref to a power supply fails, then the search for battery
+ * type power supplies will abort and the acquired power supply references will
+ * be released.
+ *
+ * Return: Indicates the number of battery type power supplies returned on
+ * success or a negative error code on failure.
+ *
+ * Call power_supply_put_battery_all() after use to cleanup resources.
+ */
+int __must_check power_supply_get_battery_all(struct device *dev,
+					      struct power_supply ***psys)
+{
+	int ret;
+
+	if (!psys)
+		return -EINVAL;
+
+	ret = power_supply_get_num_battery(dev);
+	if (ret <= 0) {
+		*psys = NULL;
+		return ret;
+	}
+
+	*psys = kzalloc_objs(**psys, ret);
+	if (!*psys)
+		return -ENOMEM;
+
+	ret = power_supply_populate_battery_array(dev, ret, *psys);
+	if (ret <= 0)
+		*psys = NULL;
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(power_supply_get_battery_all);
+
+/**
+ * power_supply_put_battery_all() - Cleanup resources allocated by
+ *                                  power_supply_get_battery_all()
+ * @psys: Array of power supply references to release and free.
+ * @count: Number of elements in the array.
+ */
+void power_supply_put_battery_all(struct power_supply **psys, int count)
+{
+	int i;
+
+	for (i = 0; i < count; i++) {
+		if (psys[i])
+			power_supply_put(psys[i]);
+	}
+
+	kfree(psys);
+}
+EXPORT_SYMBOL_GPL(power_supply_put_battery_all);
+
 /**
  * power_supply_put() - Drop reference obtained with power_supply_get_by_name
  * @psy: Reference to put
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index 7a5e4c3242a0..f2070ebc93dc 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -806,11 +806,26 @@ extern int power_supply_reg_notifier(struct notifier_block *nb);
 extern void power_supply_unreg_notifier(struct notifier_block *nb);
 #if IS_ENABLED(CONFIG_POWER_SUPPLY)
 extern struct power_supply *power_supply_get_by_name(const char *name);
+extern int __must_check power_supply_get_battery_all(struct device *dev,
+						     struct power_supply ***psys);
+extern void power_supply_put_battery_all(struct power_supply **psys, int count);
 extern void power_supply_put(struct power_supply *psy);
 #else
 static inline void power_supply_put(struct power_supply *psy) {}
 static inline struct power_supply *power_supply_get_by_name(const char *name)
 { return NULL; }
+static inline int __must_check power_supply_get_battery_all(struct device *dev,
+							    struct power_supply ***psys)
+{
+	if (psys)
+		*psys = NULL;
+	return 0;
+}
+
+static inline void power_supply_put_battery_all(struct power_supply **psys,
+						int count)
+{
+}
 #endif
 extern struct power_supply *power_supply_get_by_reference(struct fwnode_handle *fwnode,
 							  const char *property);

-- 
2.54.0.1013.g208068f2d8-goog


