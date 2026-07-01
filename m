Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9BF11CA9;
	Wed,  1 Jul 2026 00:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782866075; cv=none; b=VJlKJ+TgFRTGKQC/DcXiK6qkO3veTMiBm3SwcjTiEKXNL1lqcQsPM+O8R35tZxK0zltA3FiMuSAdai5rWY4ZAwHxqM8QetozNPC4wvXK3IEmRy+GpJ6U/dbIyBohQJU+IfKq6bGkL/70mCEwKn/k/3po5LEISJ4AdPOv09UuMU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782866075; c=relaxed/simple;
	bh=3OJgRHe9Sd6n6S8VAOpjifbG3KgrcWmYMylguKBPZTM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eez5RW8jFJG/lX0JorxzJuBBHBCzLiTVLiO19fJzTe4OA5O047A1wUHBGaDJU+VSNwiUraGFjsRQVpP44sqlffqxPxA7ByWevG2LMctIVBYzsporlk/6WdcThmvGu/MuLW43pN+8UPA35s1wwgRA4EpXbvRxklpAdb+iyn5WiWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YF/4N3dc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YF/4N3dc"
Received: by smtp.kernel.org (Postfix) with ESMTPS id E103CC2BCF4;
	Wed,  1 Jul 2026 00:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1782866075;
	bh=3OJgRHe9Sd6n6S8VAOpjifbG3KgrcWmYMylguKBPZTM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=YF/4N3dcZHf658oD/y10nwj/6meXTTHLZXokWqFhOPfaa5GA5BK5W8Fqy+EMPt8qh
	 Bzl1AS0PIERXvIMt1wbJ4rzePMlNHzJIPHEJs1o2xVVBiyCJezMw+x6zOc+HOIcVeQ
	 J+oE0+3schc3dJk9NbhyQ7nvZpw0ir7/Tsnl8CiSsaUw3e0ZCH5JkejhLeiDEfWHmE
	 VMp0bj6TCVxfglUWRfjXxPCz4AU+n6NX5lG1escnFF95SoVWU3x29thzksZQxq1W3/
	 NPsAk4/lElo4MoqHhm8VVzJD4QCUgcqxtIPqpHMTfQTz1P9WK5WbGZ21g/UlOjR7c7
	 MOuqEZr2pmZ8w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE163C43327;
	Wed,  1 Jul 2026 00:34:34 +0000 (UTC)
From: Amit Sunil Dhamne via B4 Relay <devnull+amitsd.google.com@kernel.org>
Date: Wed, 01 Jul 2026 00:34:18 +0000
Subject: [PATCH v4 1/2] power: supply: Add helpers to get and put arrays of
 power supply handles
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260701-batt-status-v4-1-a31d97b1ae57@google.com>
References: <20260701-batt-status-v4-0-a31d97b1ae57@google.com>
In-Reply-To: <20260701-batt-status-v4-0-a31d97b1ae57@google.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782866074; l=6221;
 i=amitsd@google.com; s=20241031; h=from:subject:message-id;
 bh=gvdYw83SlBQnEVfW0ZcpDG4WOMw9avUKEx52LOGumVc=;
 b=H32nRc+fa+3ucffN0tuPR0ZsFUV7cTi3WBdtCNh9Mp3KrR/s58OiTkRIUWhYuJa3veQCU6K2/
 aDCyp/1jsJQCR3xNq9VKS9cXClcrX5tclQjG4mj81u0Tn7FEi/NnJcE
X-Developer-Key: i=amitsd@google.com; a=ed25519;
 pk=wD+XZSST4dmnNZf62/lqJpLm7fiyT8iv462zmQ3H6bI=
X-Endpoint-Received: by B4 Relay for amitsd@google.com/20241031 with
 auth_id=262
X-Original-From: Amit Sunil Dhamne <amitsd@google.com>
Reply-To: amitsd@google.com

From: Amit Sunil Dhamne <amitsd@google.com>

Add power_supply_get_system_batteries() to allow drivers to obtain
a list of registered battery type power supply references in the
system. Also add power_supply_put_system_batteries() to perform
cleanup after the former function is called.

Signed-off-by: Amit Sunil Dhamne <amitsd@google.com>
---
 drivers/power/supply/power_supply_core.c | 153 +++++++++++++++++++++++++++++++
 include/linux/power_supply.h             |  15 +++
 2 files changed, 168 insertions(+)

diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index 2532e221b2e1..70f35f64cc72 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -477,6 +477,159 @@ struct power_supply *power_supply_get_by_name(const char *name)
 }
 EXPORT_SYMBOL_GPL(power_supply_get_by_name);
 
+static bool power_supply_is_system_battery(struct power_supply *psy)
+{
+	union power_supply_propval val;
+
+	if (psy->desc->type != POWER_SUPPLY_TYPE_BATTERY)
+		return false;
+
+	if (!power_supply_get_property_direct(psy, POWER_SUPPLY_PROP_SCOPE,
+					      &val))
+		if (val.intval == POWER_SUPPLY_SCOPE_DEVICE)
+			return false;
+
+	return true;
+}
+
+static int __power_supply_get_num_system_batteries(struct power_supply *epsy,
+						   void *data)
+{
+	int *count = data;
+
+	if (power_supply_is_system_battery(epsy))
+		(*count)++;
+
+	return 0;
+}
+
+static int power_supply_get_num_system_batteries(struct device *dev)
+{
+	int ret, count = 0;
+
+	ret = power_supply_for_each_psy(&count,
+					__power_supply_get_num_system_batteries);
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
+static int
+__power_supply_populate_system_batteries_array(struct power_supply *epsy,
+					       void *_data)
+{
+	struct psy_get_supplies_data *data = _data;
+
+	if (power_supply_is_system_battery(epsy)) {
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
+static int
+power_supply_populate_system_batteries_array(struct device *dev, int size,
+					     struct power_supply **batteries)
+{
+	int ret;
+
+	struct psy_get_supplies_data data = {
+		.cnt = 0,
+		.size = size,
+		.psys = batteries,
+	};
+
+	ret = power_supply_for_each_psy(&data,
+					__power_supply_populate_system_batteries_array);
+
+	dev_dbg(dev, "%s Found %d batteries with array size %d ret %d\n",
+		__func__, data.cnt, data.size, ret);
+
+	if (ret < 0 || !data.cnt) {
+		power_supply_put_system_batteries(batteries, data.cnt);
+		return ret;
+	}
+
+	return data.cnt;
+}
+
+/**
+ * power_supply_get_system_batteries() - Fetches references to battery type
+ *                                       power supplies in the system.
+ * @dev: Pointer to device requesting the power supply refs.
+ * @psys: Pointer to an array of power supply refs.
+ *
+ * Helper function to get handles to battery type power supplies in the system.
+ * If acquiring a ref to a power supply fails, then the search for battery type
+ * power supplies will abort and the acquired power supply references will be
+ * released.
+ *
+ * Return: Indicates the number of battery type power supplies returned on
+ * success or a negative error code on failure.
+ *
+ * Call power_supply_put_system_batteries() after use to cleanup resources.
+ */
+int __must_check power_supply_get_system_batteries(struct device *dev,
+						   struct power_supply ***psys)
+{
+	int ret;
+
+	if (!psys)
+		return -EINVAL;
+
+	ret = power_supply_get_num_system_batteries(dev);
+	if (ret <= 0) {
+		*psys = NULL;
+		return ret;
+	}
+
+	*psys = kzalloc_objs(**psys, ret);
+	if (!*psys)
+		return -ENOMEM;
+
+	ret = power_supply_populate_system_batteries_array(dev, ret, *psys);
+	if (ret <= 0)
+		*psys = NULL;
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(power_supply_get_system_batteries);
+
+/**
+ * power_supply_put_system_batteries() - Cleanup resources allocated by
+ *                                       power_supply_get_system_batteries()
+ * @psys: Array of power supply references to release and free.
+ * @count: Number of elements in the array.
+ */
+void power_supply_put_system_batteries(struct power_supply **psys, int count)
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
+EXPORT_SYMBOL_GPL(power_supply_put_system_batteries);
+
 /**
  * power_supply_put() - Drop reference obtained with power_supply_get_by_name
  * @psy: Reference to put
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index 7a5e4c3242a0..9167a33d074b 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -806,11 +806,26 @@ extern int power_supply_reg_notifier(struct notifier_block *nb);
 extern void power_supply_unreg_notifier(struct notifier_block *nb);
 #if IS_ENABLED(CONFIG_POWER_SUPPLY)
 extern struct power_supply *power_supply_get_by_name(const char *name);
+extern int __must_check power_supply_get_system_batteries(struct device *dev,
+							  struct power_supply ***psys);
+extern void power_supply_put_system_batteries(struct power_supply **psys, int count);
 extern void power_supply_put(struct power_supply *psy);
 #else
 static inline void power_supply_put(struct power_supply *psy) {}
 static inline struct power_supply *power_supply_get_by_name(const char *name)
 { return NULL; }
+static inline int __must_check power_supply_get_system_batteries(struct device *dev,
+								 struct power_supply ***psys)
+{
+	if (psys)
+		*psys = NULL;
+	return 0;
+}
+
+static inline void power_supply_put_system_batteries(struct power_supply **psys,
+						     int count)
+{
+}
 #endif
 extern struct power_supply *power_supply_get_by_reference(struct fwnode_handle *fwnode,
 							  const char *property);

-- 
2.55.0.rc0.799.gd6f94ed593-goog


