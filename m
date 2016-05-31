From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH v3 2/2] extcon: Remove the deprecated extcon functions
Date: Tue, 31 May 2016 18:34:40 +0900
Message-ID: <1464687280-8155-3-git-send-email-cw00.choi@samsung.com>
References: <1464687280-8155-1-git-send-email-cw00.choi@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1464687280-8155-1-git-send-email-cw00.choi@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, wens@csie.org
Cc: myungjoo.ham@samsung.com, cw00.choi@samsung.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

This patch removes the deprecated extcon functions using string type
to identify the type of external connector. The Commit 2a9de9c0f08d61
("extcon: Use the unique id for external connector instead of string)
uses the unique id to separate the type of external connector instead of
string name.
- extcon_register_interest()
- extcon_unregister_interest()
- extcon_set_cable_state()
- extcon_get_cable_state()

And, extcon_register_interest() finds the first extcon device to include the
requested external connector from extcon client device and then register the
notifier if extcon device argument is NULL. Instead, extcon_register_notifier()
supports this feature.

But, this patch remains the deprecatd function definition to prevent
the build break.

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 drivers/extcon/extcon.c | 201 ++++++------------------------------------------
 include/linux/extcon.h  |  80 ++++++-------------
 2 files changed, 47 insertions(+), 234 deletions(-)

diff --git a/drivers/extcon/extcon.c b/drivers/extcon/extcon.c
index 21a123cadf78..4fef9ab4b148 100644
--- a/drivers/extcon/extcon.c
+++ b/drivers/extcon/extcon.c
@@ -127,38 +127,6 @@ static int find_cable_index_by_id(struct extcon_dev *edev, const unsigned int id
 	return -EINVAL;
 }
 
-static int find_cable_id_by_name(struct extcon_dev *edev, const char *name)
-{
-	int id = -EINVAL;
-	int i = 0;
-
-	/* Find the id of extcon cable */
-	while (extcon_name[i]) {
-		if (!strncmp(extcon_name[i], name, CABLE_NAME_MAX)) {
-			id = i;
-			break;
-		}
-		i++;
-	}
-
-	return id;
-}
-
-static int find_cable_index_by_name(struct extcon_dev *edev, const char *name)
-{
-	int id;
-
-	if (edev->max_supported == 0)
-		return -EINVAL;
-
-	/* Find the the number of extcon cable */
-	id = find_cable_id_by_name(edev, name);
-	if (id < 0)
-		return id;
-
-	return find_cable_index_by_id(edev, id);
-}
-
 static bool is_extcon_changed(u32 prev, u32 new, int idx, bool *attached)
 {
 	if (((prev >> idx) & 0x1) != ((new >> idx) & 0x1)) {
@@ -374,25 +342,6 @@ int extcon_get_cable_state_(struct extcon_dev *edev, const unsigned int id)
 EXPORT_SYMBOL_GPL(extcon_get_cable_state_);
 
 /**
- * extcon_get_cable_state() - Get the status of a specific cable.
- * @edev:	the extcon device that has the cable.
- * @cable_name:	cable name.
- *
- * Note that this is slower than extcon_get_cable_state_.
- */
-int extcon_get_cable_state(struct extcon_dev *edev, const char *cable_name)
-{
-	int id;
-
-	id = find_cable_id_by_name(edev, cable_name);
-	if (id < 0)
-		return id;
-
-	return extcon_get_cable_state_(edev, id);
-}
-EXPORT_SYMBOL_GPL(extcon_get_cable_state);
-
-/**
  * extcon_set_cable_state_() - Set the status of a specific cable.
  * @edev:		the extcon device that has the cable.
  * @id:			the unique id of each external connector
@@ -422,28 +371,6 @@ int extcon_set_cable_state_(struct extcon_dev *edev, unsigned int id,
 EXPORT_SYMBOL_GPL(extcon_set_cable_state_);
 
 /**
- * extcon_set_cable_state() - Set the status of a specific cable.
- * @edev:		the extcon device that has the cable.
- * @cable_name:		cable name.
- * @cable_state:	the new cable status. The default semantics is
- *			true: attached / false: detached.
- *
- * Note that this is slower than extcon_set_cable_state_.
- */
-int extcon_set_cable_state(struct extcon_dev *edev,
-			const char *cable_name, bool cable_state)
-{
-	int id;
-
-	id = find_cable_id_by_name(edev, cable_name);
-	if (id < 0)
-		return id;
-
-	return extcon_set_cable_state_(edev, id, cable_state);
-}
-EXPORT_SYMBOL_GPL(extcon_set_cable_state);
-
-/**
  * extcon_get_extcon_dev() - Get the extcon device instance from the name
  * @extcon_name:	The extcon name provided with extcon_dev_register()
  */
@@ -467,105 +394,6 @@ out:
 EXPORT_SYMBOL_GPL(extcon_get_extcon_dev);
 
 /**
- * extcon_register_interest() - Register a notifier for a state change of a
- *				specific cable, not an entier set of cables of a
- *				extcon device.
- * @obj:		an empty extcon_specific_cable_nb object to be returned.
- * @extcon_name:	the name of extcon device.
- *			if NULL, extcon_register_interest will register
- *			every cable with the target cable_name given.
- * @cable_name:		the target cable name.
- * @nb:			the notifier block to get notified.
- *
- * Provide an empty extcon_specific_cable_nb. extcon_register_interest() sets
- * the struct for you.
- *
- * extcon_register_interest is a helper function for those who want to get
- * notification for a single specific cable's status change. If a user wants
- * to get notification for any changes of all cables of a extcon device,
- * he/she should use the general extcon_register_notifier().
- *
- * Note that the second parameter given to the callback of nb (val) is
- * "old_state", not the current state. The current state can be retrieved
- * by looking at the third pameter (edev pointer)'s state value.
- */
-int extcon_register_interest(struct extcon_specific_cable_nb *obj,
-			     const char *extcon_name, const char *cable_name,
-			     struct notifier_block *nb)
-{
-	unsigned long flags;
-	int ret;
-
-	if (!obj || !cable_name || !nb)
-		return -EINVAL;
-
-	if (extcon_name) {
-		obj->edev = extcon_get_extcon_dev(extcon_name);
-		if (!obj->edev)
-			return -ENODEV;
-
-		obj->cable_index = find_cable_index_by_name(obj->edev,
-							cable_name);
-		if (obj->cable_index < 0)
-			return obj->cable_index;
-
-		obj->user_nb = nb;
-
-		spin_lock_irqsave(&obj->edev->lock, flags);
-		ret = raw_notifier_chain_register(
-					&obj->edev->nh[obj->cable_index],
-					obj->user_nb);
-		spin_unlock_irqrestore(&obj->edev->lock, flags);
-	} else {
-		struct class_dev_iter iter;
-		struct extcon_dev *extd;
-		struct device *dev;
-
-		if (!extcon_class)
-			return -ENODEV;
-		class_dev_iter_init(&iter, extcon_class, NULL, NULL);
-		while ((dev = class_dev_iter_next(&iter))) {
-			extd = dev_get_drvdata(dev);
-
-			if (find_cable_index_by_name(extd, cable_name) < 0)
-				continue;
-
-			class_dev_iter_exit(&iter);
-			return extcon_register_interest(obj, extd->name,
-						cable_name, nb);
-		}
-
-		ret = -ENODEV;
-	}
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(extcon_register_interest);
-
-/**
- * extcon_unregister_interest() - Unregister the notifier registered by
- *				  extcon_register_interest().
- * @obj:	the extcon_specific_cable_nb object returned by
- *		extcon_register_interest().
- */
-int extcon_unregister_interest(struct extcon_specific_cable_nb *obj)
-{
-	unsigned long flags;
-	int ret;
-
-	if (!obj)
-		return -EINVAL;
-
-	spin_lock_irqsave(&obj->edev->lock, flags);
-	ret = raw_notifier_chain_unregister(
-			&obj->edev->nh[obj->cable_index], obj->user_nb);
-	spin_unlock_irqrestore(&obj->edev->lock, flags);
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(extcon_unregister_interest);
-
-/**
  * extcon_register_notifier() - Register a notifiee to get notified by
  *				any attach status changes from the extcon.
  * @edev:	the extcon device that has the external connecotr.
@@ -582,14 +410,33 @@ int extcon_register_notifier(struct extcon_dev *edev, unsigned int id,
 	unsigned long flags;
 	int ret, idx;
 
-	if (!edev || !nb)
+	if (!nb)
 		return -EINVAL;
 
-	idx = find_cable_index_by_id(edev, id);
+	if (edev) {
+		idx = find_cable_index_by_id(edev, id);
 
-	spin_lock_irqsave(&edev->lock, flags);
-	ret = raw_notifier_chain_register(&edev->nh[idx], nb);
-	spin_unlock_irqrestore(&edev->lock, flags);
+		spin_lock_irqsave(&edev->lock, flags);
+		ret = raw_notifier_chain_register(&edev->nh[idx], nb);
+		spin_unlock_irqrestore(&edev->lock, flags);
+	} else {
+		struct extcon_dev *extd;
+
+		mutex_lock(&extcon_dev_list_lock);
+		list_for_each_entry(extd, &extcon_dev_list, entry) {
+			idx = find_cable_index_by_id(extd, id);
+			if (idx >= 0)
+				break;
+		}
+		mutex_unlock(&extcon_dev_list_lock);
+
+		if (idx >= 0) {
+			edev = extd;
+			return extcon_register_notifier(extd, id, nb);
+		} else {
+			ret = -ENODEV;
+		}
+	}
 
 	return ret;
 }
diff --git a/include/linux/extcon.h b/include/linux/extcon.h
index 7abf674c388c..cec5c543afc6 100644
--- a/include/linux/extcon.h
+++ b/include/linux/extcon.h
@@ -146,22 +146,6 @@ struct extcon_cable {
 	struct attribute *attrs[3]; /* to be fed to attr_g.attrs */
 };
 
-/**
- * struct extcon_specific_cable_nb - An internal data for
- *				     extcon_register_interest().
- * @user_nb:		user provided notifier block for events from
- *			a specific cable.
- * @cable_index:	the target cable.
- * @edev:		the target extcon device.
- * @previous_value:	the saved previous event value.
- */
-struct extcon_specific_cable_nb {
-	struct notifier_block *user_nb;
-	int cable_index;
-	struct extcon_dev *edev;
-	unsigned long previous_value;
-};
-
 #if IS_ENABLED(CONFIG_EXTCON)
 
 /*
@@ -207,23 +191,6 @@ extern int extcon_get_cable_state_(struct extcon_dev *edev, unsigned int id);
 extern int extcon_set_cable_state_(struct extcon_dev *edev, unsigned int id,
 				   bool cable_state);
 
-extern int extcon_get_cable_state(struct extcon_dev *edev,
-				  const char *cable_name);
-extern int extcon_set_cable_state(struct extcon_dev *edev,
-				  const char *cable_name, bool cable_state);
-
-/*
- * Following APIs are for notifiees (those who want to be notified)
- * to register a callback for events from a specific cable of the extcon.
- * Notifiees are the connected device drivers wanting to get notified by
- * a specific external port of a connection device.
- */
-extern int extcon_register_interest(struct extcon_specific_cable_nb *obj,
-				    const char *extcon_name,
-				    const char *cable_name,
-				    struct notifier_block *nb);
-extern int extcon_unregister_interest(struct extcon_specific_cable_nb *nb);
-
 /*
  * Following APIs are to monitor every action of a notifier.
  * Registrar gets notified for every external port of a connection device.
@@ -246,6 +213,7 @@ extern struct extcon_dev *extcon_get_edev_by_phandle(struct device *dev,
 /* Following API to get information of extcon device */
 extern const char *extcon_get_edev_name(struct extcon_dev *edev);
 
+
 #else /* CONFIG_EXTCON */
 static inline int extcon_dev_register(struct extcon_dev *edev)
 {
@@ -306,18 +274,6 @@ static inline int extcon_set_cable_state_(struct extcon_dev *edev,
 	return 0;
 }
 
-static inline int extcon_get_cable_state(struct extcon_dev *edev,
-			const char *cable_name)
-{
-	return 0;
-}
-
-static inline int extcon_set_cable_state(struct extcon_dev *edev,
-			const char *cable_name, int state)
-{
-	return 0;
-}
-
 static inline struct extcon_dev *extcon_get_extcon_dev(const char *extcon_name)
 {
 	return NULL;
@@ -337,24 +293,34 @@ static inline int extcon_unregister_notifier(struct extcon_dev *edev,
 	return 0;
 }
 
-static inline int extcon_register_interest(struct extcon_specific_cable_nb *obj,
-					   const char *extcon_name,
-					   const char *cable_name,
-					   struct notifier_block *nb)
+static inline struct extcon_dev *extcon_get_edev_by_phandle(struct device *dev,
+							    int index)
 {
-	return 0;
+	return ERR_PTR(-ENODEV);
 }
+#endif /* CONFIG_EXTCON */
 
-static inline int extcon_unregister_interest(struct extcon_specific_cable_nb
-						    *obj)
+/*
+ * Following structure and API are deprecated. EXTCON remains the function
+ * definition to prevent the build break.
+ */
+struct extcon_specific_cable_nb {
+       struct notifier_block *user_nb;
+       int cable_index;
+       struct extcon_dev *edev;
+       unsigned long previous_value;
+};
+
+static inline int extcon_register_interest(struct extcon_specific_cable_nb *obj,
+			const char *extcon_name, const char *cable_name,
+			struct notifier_block *nb)
 {
-	return 0;
+	return -EINVAL;
 }
 
-static inline struct extcon_dev *extcon_get_edev_by_phandle(struct device *dev,
-							    int index)
+static inline int extcon_unregister_interest(struct extcon_specific_cable_nb
+						    *obj)
 {
-	return ERR_PTR(-ENODEV);
+	return -EINVAL;
 }
-#endif /* CONFIG_EXTCON */
 #endif /* __LINUX_EXTCON_H__ */
-- 
1.9.1
