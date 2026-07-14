Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944D73F823B;
	Tue, 14 Jul 2026 21:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784063477; cv=none; b=W+oj6iXbtMf/60eLoaaK9jcYOgzc8MKkpQ9LdTclgN/BApHIJf7BqXwi890NkPTYvqnDW9J5HRX+F84A16xfsMmPdlvegH9zfZjt3YLjYD1Oypeck1XgzZsexmqAEYnoda75VHO4fkxspYdIe7Z6dzAFsxVB/OGLsvWkyP406nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784063477; c=relaxed/simple;
	bh=D7fXlQJ2CZHXotFhti4uO9B0jQVg+HhX4hXFs1vBv5o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=W0yt66TwLZ1p20fh9ZSFKCkAGjBGwk7qPLRTXM09YwZ9P8GalKZi4RNgzGwqwv3pa8twKwkO/1ZE/YZ3CxJYoZI3ANXOv+6bF0OF997BdqKWyPRK58TiPWLlv1ZbVSnMZp848sqYrbH/Up+VLMDcqeVQ/ScOPZ5ycqrvc074hxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MqKzHDsj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MqKzHDsj"
Received: by smtp.kernel.org (Postfix) with ESMTPS id D5576C2BCC9;
	Tue, 14 Jul 2026 21:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1784063476;
	bh=D7fXlQJ2CZHXotFhti4uO9B0jQVg+HhX4hXFs1vBv5o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=MqKzHDsjosxVQXnDx8iEtC2z8wTEBm1+bvu9ruV7fs6foS2FQq4EKSo5DNTdXf+am
	 Ch69Z+d5zYPlID0J9QyjuBgDxllpFzB6q+9MX9aLZRj+SjdlaHrX/Eti3w1MjbOqOg
	 777bhQz7qCTE6vWFgnTfkQx+gW/N8rtQ/TF4nNGqZkwtjswZiIWM9pTqZqrFJ1kFNT
	 EkZPaXGnbAFdVZI4PCoSFNy01R0QpJemAi15AIZP4V8Dplyfhoq3eBJntZfvopIUk/
	 yrGxOhbVCz2+CxoOgCFkpVuCTS/6j1M79K6atI2lqoZNmZk42bWsnPdqxSF4KHKYkw
	 w1Xi+IVd2ebSA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3865C4450B;
	Tue, 14 Jul 2026 21:11:16 +0000 (UTC)
From: Amit Sunil Dhamne via B4 Relay <devnull+amitsd.google.com@kernel.org>
Date: Tue, 14 Jul 2026 21:10:52 +0000
Subject: [PATCH v5 1/2] power: supply: Add helpers to get and put arrays of
 power supply handles
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260714-batt-status-v5-1-9de4aa900b69@google.com>
References: <20260714-batt-status-v5-0-9de4aa900b69@google.com>
In-Reply-To: <20260714-batt-status-v5-0-9de4aa900b69@google.com>
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
 Kyle Tso <kyletso@google.com>, Amit Sunil Dhamne <amitsd@google.com>, 
 Hans de Goede <johannes.goede@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784063476; l=6279;
 i=amitsd@google.com; s=20241031; h=from:subject:message-id;
 bh=OMFNsEpFN65Wd7eYcBGOg9maGAOHsLIXqZwssi3Q8WQ=;
 b=gg+cB/kYJ+ccXIHry9Cw/TSD0o69XqPwg1rz4gR/04yUoiwxWo2GvhmOWoP6QPGuUzUSp1SZC
 QoR2nittLGsBZqKCiHl7xHKrqmfDgOz+ckwnjrGFESWpw0+O9lt8Wun
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
Reviewed-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
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
2.55.0.141.g00534a21ce-goog


