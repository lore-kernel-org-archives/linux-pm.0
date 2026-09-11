Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13B5489873;
	Fri, 11 Sep 2026 13:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789132146; cv=none; b=qOg4PFWBvF+Kb3OXe4qRFhxTXmSj14B7F5Bj5C4mh9+aBO/uiLEVs3Q6+e1WIEw1BcWRjmeweSs4s+YluAK+aXoIn1Gsn1Lbvpk2YgedXdN23U/wlP/uBFThNI6piM12RwWsELEWVAJ6WTtOEZywgjOduTcUVU2Um8/kVnRTDsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789132146; c=relaxed/simple;
	bh=PMgGOYXgfickf/QuOMJtDkzu5/+jk/DA8jHUhYFa2vc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HpVq6eagFgl6Ldwq7pOgnJCEudbBKSDjWxYyq+rRZFGtNq6q8nQBESkZ7yPbOTVmdb/ZvQKX7aJAjRxY78cUxxyPaVtCI1bCG9nSbehHWwWKzN3KILoKzf6utCjloYaZN3JROA+rUg+cpDVQ/tvkS+vo7QlgnTinamzN+UNQDXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RqAf7QFa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RqAf7QFa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 920831F000FF;
	Fri, 11 Sep 2026 13:09:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789132144;
	bh=43tGsppuXBql+9kbp1xCgbpgL12536uT0HveC+btTOI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RqAf7QFaKTsmrpEcCmy+4YPE7iZDPSx69p1no6UzD7Bz6EK43ANsILmO0zf7R4HBU
	 F+xSJpzWC99lIiGseJ7T5J0Cf3hA42QXK2TkWfGYzov1C10A5ipLodKJXKnmpzRGE1
	 XqZKPOG9UBmngZoyrhGtbNnwNFTxaa4gc+M4eEjJaFeKC5Y/pbl5llYaGCCuwa5rCw
	 nZ5N9WFPbaVnw4kyou1LAySmebY41q26Gfj1+bCuQ1/D6H4qIw8nDvThrqPnQdCG6A
	 8l1ZAWIrsVoZPR6eqLWFkL4Q0g+JqjM4AYcJsmNDB7Lc6UEnXNmRpyTJrb4Pdu6D24
	 frKAyTW3Xb5qw==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, Hans de Goede <hansg@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 Lukasz Luba <lukasz.luba@arm.com>, Armin Wolf <w_armin@gmx.de>
Subject:
 [PATCH v1 03/10] thermal: core: Introduce thermal_cooling_device_create()
Date: Fri, 11 Sep 2026 15:02:09 +0200
Message-ID: <8729484.T7Z3S40VBb@rafael.j.wysocki>
Organization: Linux Kernel Development - Intel
In-Reply-To: <1965933.tdWV9SEqCh@rafael.j.wysocki>
References: <1965933.tdWV9SEqCh@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

Currently, thermal cooling devices have no parents, but it would be
generally useful to be able to create them under specific parents in
the device hierarchy (for instance, it may help to identify the device
representing the actual cooling hardware).

To make that possible, add thermal_cooling_device_create() that will
work like thermal_cooling_device_register() except that it will take
an additional parent argument (which may be NULL).

Redefine thermal_cooling_device_register() as a static inline wrapper
around thermal_cooling_device_create().

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/thermal_core.c | 28 ++++++++++++++++------------
 drivers/thermal/thermal_core.h |  3 ++-
 drivers/thermal/thermal_of.c   |  2 +-
 include/linux/thermal.h        | 19 ++++++++++++++-----
 4 files changed, 33 insertions(+), 19 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 82e2f0d8a26d..ac928c199829 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1005,7 +1005,8 @@ thermal_cooling_device_alloc(const char *type, const struct thermal_cooling_devi
 	return ERR_PTR(ret);
 }
 
-int thermal_cooling_device_add(struct thermal_cooling_device *cdev, void *devdata)
+int thermal_cooling_device_add(struct thermal_cooling_device *cdev,
+			       struct device *parent, void *devdata)
 {
 	unsigned long current_state;
 	int ret;
@@ -1013,6 +1014,7 @@ int thermal_cooling_device_add(struct thermal_cooling_device *cdev, void *devdat
 	mutex_init(&cdev->lock);
 	INIT_LIST_HEAD(&cdev->thermal_instances);
 	cdev->updated = false;
+	cdev->device.parent = parent;
 	cdev->device.class = &thermal_class;
 	cdev->device.release = thermal_cdev_release;
 	device_initialize(&cdev->device);
@@ -1062,21 +1064,23 @@ int thermal_cooling_device_add(struct thermal_cooling_device *cdev, void *devdat
 }
 
 /**
- * thermal_cooling_device_register() - register a new thermal cooling device
+ * thermal_cooling_device_create() - register a new thermal cooling device
+ * @parent:	parent device (optional).
  * @type:	the thermal cooling device type.
  * @devdata:	device private data.
  * @ops:	standard thermal cooling devices callbacks.
  *
- * This interface function adds a new thermal cooling device (fan/processor/...)
- * to /sys/class/thermal/ folder as cooling_device[0-*]. It tries to bind itself
- * to all the thermal zone devices registered at the same time.
+ * Allocate and register a new thermal cooling device under the given parent (if
+ * not NULL) and with the given type, device data, and operations.  During the
+ * registration, it will be matched against all of the registered thermal zones
+ * and it will be bound to the matching ones.
  *
- * Return: a pointer to the created struct thermal_cooling_device or an
- * ERR_PTR. Caller must check return value with IS_ERR*() helpers.
+ * Return: A pointer to the created struct thermal_cooling_device or an ERR_PTR.
+ * Callers must use IS_ERR*() helpers to check the return value.
  */
-struct thermal_cooling_device *
-thermal_cooling_device_register(const char *type, void *devdata,
-				const struct thermal_cooling_device_ops *ops)
+struct thermal_cooling_device *thermal_cooling_device_create(
+			struct device *parent, const char *type, void *devdata,
+			const struct thermal_cooling_device_ops *ops)
 {
 	struct thermal_cooling_device *cdev;
 	int ret;
@@ -1085,13 +1089,13 @@ thermal_cooling_device_register(const char *type, void *devdata,
 	if (IS_ERR(cdev))
 		return cdev;
 
-	ret = thermal_cooling_device_add(cdev, devdata);
+	ret = thermal_cooling_device_add(cdev, parent, devdata);
 	if (ret)
 		return ERR_PTR(ret);
 
 	return cdev;
 }
-EXPORT_SYMBOL_GPL(thermal_cooling_device_register);
+EXPORT_SYMBOL_GPL(thermal_cooling_device_create);
 
 static void thermal_cooling_device_release(void *data)
 {
diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
index e98b0aa5aacc..7ef7c6cab437 100644
--- a/drivers/thermal/thermal_core.h
+++ b/drivers/thermal/thermal_core.h
@@ -270,7 +270,8 @@ void thermal_governor_update_tz(struct thermal_zone_device *tz,
 struct thermal_cooling_device *
 thermal_cooling_device_alloc(const char *type, const struct thermal_cooling_device_ops *ops);
 
-int thermal_cooling_device_add(struct thermal_cooling_device *cdev, void *devdata);
+int thermal_cooling_device_add(struct thermal_cooling_device *cdev,
+			       struct device *parent, void *devdata);
 
 /* Helpers */
 #define for_each_trip_desc(__tz, __td)	\
diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index 0217a49b08ae..14dfac9359b8 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -561,7 +561,7 @@ thermal_of_cooling_device_register(struct device_node *np, u32 cdev_id,
 	cdev->np = np;
 	cdev->cdev_id = cdev_id;
 
-	ret = thermal_cooling_device_add(cdev, devdata);
+	ret = thermal_cooling_device_add(cdev, NULL, devdata);
 	if (ret)
 		return ERR_PTR(ret);
 
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 083b4f533933..306ad17aed89 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -293,8 +293,9 @@ struct device *thermal_zone_device(struct thermal_zone_device *tzd);
 void thermal_zone_device_update(struct thermal_zone_device *,
 				enum thermal_notify_event);
 
-struct thermal_cooling_device *thermal_cooling_device_register(const char *,
-		void *, const struct thermal_cooling_device_ops *);
+struct thermal_cooling_device *thermal_cooling_device_create(
+			struct device *parent, const char *type, void *devdata,
+			const struct thermal_cooling_device_ops *ops);
 
 struct thermal_cooling_device *
 devm_thermal_cooling_device_register(struct device *dev, const char *type, void *devdata,
@@ -340,9 +341,9 @@ static inline void thermal_zone_device_update(struct thermal_zone_device *tz,
 					      enum thermal_notify_event event)
 { }
 
-static inline struct thermal_cooling_device *
-thermal_cooling_device_register(const char *type, void *devdata,
-	const struct thermal_cooling_device_ops *ops)
+static inline struct thermal_cooling_device *thermal_cooling_device_create(
+			struct device *parent, const char *type, void *devdata,
+			const struct thermal_cooling_device_ops *ops)
 { return ERR_PTR(-ENODEV); }
 
 static inline struct thermal_cooling_device *
@@ -391,4 +392,12 @@ static inline void thermal_pm_prepare(void) {}
 static inline void thermal_pm_complete(void) {}
 #endif /* CONFIG_THERMAL */
 
+static inline struct thermal_cooling_device *thermal_cooling_device_register(
+				const char *type, void *devdata,
+				const struct thermal_cooling_device_ops *ops)
+{
+	return thermal_cooling_device_create(NULL, type, devdata, ops);
+}
+
+
 #endif /* __THERMAL_H__ */
-- 
2.51.0




