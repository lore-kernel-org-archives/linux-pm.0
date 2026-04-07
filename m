Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ADAB3C870D;
	Tue,  7 Apr 2026 15:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775577094; cv=none; b=KMOiwrvq7kcu7pZCFMSNzYfWkeqToScFerYiPnDdZxZo+NQO073CZoW5MR1ScQT0zzbuTTRHymqXP3/sLgCVxqt7DMRz7a5Vte3/MCveCH55q4gC72AN9OQb2tdHhq/nVHtrJMNZKyBL4v3KPcJxBU36TlaShs/aTAzK0Z9hV9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775577094; c=relaxed/simple;
	bh=sREiKra0Hr7rptFuzwyQcLefiJWqafvh9ub6OVn9bg4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t+Fyj0O0DNEEybgeju04IsBog+F0hGwK7q75yt/nfdMu1Wid4o4UdEHuwErvOs6QNwnLxD1H2qLYDmbxYj4D1lzk1CGLfx28LoneD8TcOL08ZZK3YXtvhiO9FDlhFrNLV7S8yzQlrO8bhvV+acl/R9AW8RTgzjhvw6Sg8lfhLzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EKZYXSBA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EKZYXSBA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2FF1C19424;
	Tue,  7 Apr 2026 15:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775577094;
	bh=sREiKra0Hr7rptFuzwyQcLefiJWqafvh9ub6OVn9bg4=;
	h=From:To:Cc:Subject:Date:From;
	b=EKZYXSBARUyKsB5R/pEmMMCKiu2j+qGKKJ674dBYKsTOh14HglTADG9bmIquUYlyR
	 0xKahVNAIRb7amWUVctC0GL2ystkMP+ghETcE1f3fSp//z+XT9XeOKGiKvAMZCF3dY
	 h7mZxUdyqN0+KzfQh6U4PLJnXsgVTwOMnmaKPrkEH/PtsIVHnYa9rYASASpcXH2Fd/
	 AezehHQTa0R6Wz1qBFlZrFVJ63xu5t71XOBKmcmUGL0ExaiMRMEqXFLVEs75M2aSyf
	 UdGw7Y2MfnZ1e2w9aShLNOFThXmIGF+e92CGKMxFlvAToTS+uf7ma/xhS3mXgWrgUp
	 J3eSZwWgbE1Dg==
From: Daniel Lezcano <daniel.lezcano@kernel.org>
To: rafael@kernel.org
Cc: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	linux-pm@vger.kernel.org (open list:THERMAL),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] thermal/of: Move OF code where it belongs to
Date: Tue,  7 Apr 2026 17:51:10 +0200
Message-ID: <20260407155110.3920703-1-daniel.lezcano@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>

The functions:
 - thermal_of_cooling_device_register()
 - devm_thermal_of_cooling_device_register()

 are related to thermal-of but they are implemented in
 thermal-core. Move these functions to the right file.

Pure move patch.

No functional change intended.

Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@kernel.org>
---
 drivers/thermal/thermal_core.c | 75 +---------------------------------
 drivers/thermal/thermal_core.h |  5 +++
 drivers/thermal/thermal_of.c   | 72 ++++++++++++++++++++++++++++++++
 3 files changed, 78 insertions(+), 74 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index b7d706ed7ed9..f0049cff1128 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1054,7 +1054,7 @@ static void thermal_cooling_device_init_complete(struct thermal_cooling_device *
  * Return: a pointer to the created struct thermal_cooling_device or an
  * ERR_PTR. Caller must check return value with IS_ERR*() helpers.
  */
-static struct thermal_cooling_device *
+struct thermal_cooling_device *
 __thermal_cooling_device_register(struct device_node *np,
 				  const char *type, void *devdata,
 				  const struct thermal_cooling_device_ops *ops)
@@ -1162,79 +1162,6 @@ thermal_cooling_device_register(const char *type, void *devdata,
 }
 EXPORT_SYMBOL_GPL(thermal_cooling_device_register);
 
-/**
- * thermal_of_cooling_device_register() - register an OF thermal cooling device
- * @np:		a pointer to a device tree node.
- * @type:	the thermal cooling device type.
- * @devdata:	device private data.
- * @ops:		standard thermal cooling devices callbacks.
- *
- * This function will register a cooling device with device tree node reference.
- * This interface function adds a new thermal cooling device (fan/processor/...)
- * to /sys/class/thermal/ folder as cooling_device[0-*]. It tries to bind itself
- * to all the thermal zone devices registered at the same time.
- *
- * Return: a pointer to the created struct thermal_cooling_device or an
- * ERR_PTR. Caller must check return value with IS_ERR*() helpers.
- */
-struct thermal_cooling_device *
-thermal_of_cooling_device_register(struct device_node *np,
-				   const char *type, void *devdata,
-				   const struct thermal_cooling_device_ops *ops)
-{
-	return __thermal_cooling_device_register(np, type, devdata, ops);
-}
-EXPORT_SYMBOL_GPL(thermal_of_cooling_device_register);
-
-static void thermal_cooling_device_release(struct device *dev, void *res)
-{
-	thermal_cooling_device_unregister(
-				*(struct thermal_cooling_device **)res);
-}
-
-/**
- * devm_thermal_of_cooling_device_register() - register an OF thermal cooling
- *					       device
- * @dev:	a valid struct device pointer of a sensor device.
- * @np:		a pointer to a device tree node.
- * @type:	the thermal cooling device type.
- * @devdata:	device private data.
- * @ops:	standard thermal cooling devices callbacks.
- *
- * This function will register a cooling device with device tree node reference.
- * This interface function adds a new thermal cooling device (fan/processor/...)
- * to /sys/class/thermal/ folder as cooling_device[0-*]. It tries to bind itself
- * to all the thermal zone devices registered at the same time.
- *
- * Return: a pointer to the created struct thermal_cooling_device or an
- * ERR_PTR. Caller must check return value with IS_ERR*() helpers.
- */
-struct thermal_cooling_device *
-devm_thermal_of_cooling_device_register(struct device *dev,
-				struct device_node *np,
-				const char *type, void *devdata,
-				const struct thermal_cooling_device_ops *ops)
-{
-	struct thermal_cooling_device **ptr, *tcd;
-
-	ptr = devres_alloc(thermal_cooling_device_release, sizeof(*ptr),
-			   GFP_KERNEL);
-	if (!ptr)
-		return ERR_PTR(-ENOMEM);
-
-	tcd = __thermal_cooling_device_register(np, type, devdata, ops);
-	if (IS_ERR(tcd)) {
-		devres_free(ptr);
-		return tcd;
-	}
-
-	*ptr = tcd;
-	devres_add(dev, ptr);
-
-	return tcd;
-}
-EXPORT_SYMBOL_GPL(devm_thermal_of_cooling_device_register);
-
 static bool thermal_cooling_device_present(struct thermal_cooling_device *cdev)
 {
 	struct thermal_cooling_device *pos = NULL;
diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
index d3acff602f9c..bdd59947b24f 100644
--- a/drivers/thermal/thermal_core.h
+++ b/drivers/thermal/thermal_core.h
@@ -269,6 +269,11 @@ void thermal_zone_device_critical_shutdown(struct thermal_zone_device *tz);
 void thermal_governor_update_tz(struct thermal_zone_device *tz,
 				enum thermal_notify_event reason);
 
+struct thermal_cooling_device *
+__thermal_cooling_device_register(struct device_node *np,
+				  const char *type, void *devdata,
+				  const struct thermal_cooling_device_ops *ops);
+
 /* Helpers */
 #define for_each_trip_desc(__tz, __td)	\
 	for (__td = __tz->trips; __td - __tz->trips < __tz->num_trips; __td++)
diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index 99085c806a1f..398157e740fc 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -510,3 +510,75 @@ void devm_thermal_of_zone_unregister(struct device *dev, struct thermal_zone_dev
 			       devm_thermal_of_zone_match, tz));
 }
 EXPORT_SYMBOL_GPL(devm_thermal_of_zone_unregister);
+
+/**
+ * thermal_of_cooling_device_register() - register an OF thermal cooling device
+ * @np:		a pointer to a device tree node.
+ * @type:	the thermal cooling device type.
+ * @devdata:	device private data.
+ * @ops:		standard thermal cooling devices callbacks.
+ *
+ * This function will register a cooling device with device tree node reference.
+ * This interface function adds a new thermal cooling device (fan/processor/...)
+ * to /sys/class/thermal/ folder as cooling_device[0-*]. It tries to bind itself
+ * to all the thermal zone devices registered at the same time.
+ *
+ * Return: a pointer to the created struct thermal_cooling_device or an
+ * ERR_PTR. Caller must check return value with IS_ERR*() helpers.
+ */
+struct thermal_cooling_device *
+thermal_of_cooling_device_register(struct device_node *np,
+				   const char *type, void *devdata,
+				   const struct thermal_cooling_device_ops *ops)
+{
+	return __thermal_cooling_device_register(np, type, devdata, ops);
+}
+EXPORT_SYMBOL_GPL(thermal_of_cooling_device_register);
+
+static void thermal_cooling_device_release(struct device *dev, void *res)
+{
+	thermal_cooling_device_unregister(*(struct thermal_cooling_device **)res);
+}
+
+/**
+ * devm_thermal_of_cooling_device_register() - register an OF thermal cooling
+ *					       device
+ * @dev:	a valid struct device pointer of a sensor device.
+ * @np:		a pointer to a device tree node.
+ * @type:	the thermal cooling device type.
+ * @devdata:	device private data.
+ * @ops:	standard thermal cooling devices callbacks.
+ *
+ * This function will register a cooling device with device tree node reference.
+ * This interface function adds a new thermal cooling device (fan/processor/...)
+ * to /sys/class/thermal/ folder as cooling_device[0-*]. It tries to bind itself
+ * to all the thermal zone devices registered at the same time.
+ *
+ * Return: a pointer to the created struct thermal_cooling_device or an
+ * ERR_PTR. Caller must check return value with IS_ERR*() helpers.
+ */
+struct thermal_cooling_device *
+devm_thermal_of_cooling_device_register(struct device *dev,
+					struct device_node *np,
+					const char *type, void *devdata,
+					const struct thermal_cooling_device_ops *ops)
+{
+	struct thermal_cooling_device **ptr, *tcd;
+
+	ptr = devres_alloc(thermal_cooling_device_release, sizeof(*ptr),
+			   GFP_KERNEL);
+	if (!ptr)
+		return ERR_PTR(-ENOMEM);
+
+	tcd = __thermal_cooling_device_register(np, type, devdata, ops);
+	if (IS_ERR(tcd)) {
+		devres_free(ptr);
+		return tcd;
+	}
+
+	*ptr = tcd;
+	devres_add(dev, ptr);
+
+	return tcd;
+}
+EXPORT_SYMBOL_GPL(devm_thermal_of_cooling_device_register);
-- 
2.43.0

