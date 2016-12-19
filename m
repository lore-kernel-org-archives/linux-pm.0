From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 01/14] extcon: Add extcon_get_extcon_dev_by_cable_id function
Date: Mon, 19 Dec 2016 01:07:18 +0100
Message-ID: <20161219000731.10188-2-hdegoede@redhat.com>
References: <20161219000731.10188-1-hdegoede@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161219000731.10188-1-hdegoede@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Chen-Yu Tsai <wens@csie.org>, MyungJoo Ham <myungjoo.ham@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>
Cc: "russianneuromancer @ ya . ru" <russianneuromancer@ya.ru>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>
List-Id: linux-pm@vger.kernel.org

extcon_register_notifier() allows passing in a NULL pointer for the
extcon_device, so that extcon consumers which want extcon events of a
certain type, but do not know the extcon device name (e.g. because
there are different implementation depending on the board), can still
get such events.

But most drivers will also want to know the initial state of the cable.
Rather then adding NULL edev argument support to extcon_get_state, which
would require looking up the right edev each call, this commit allows
drivers to get the first extcon device with a requested cable-id through
a new extcon_get_extcon_dev_by_cable_id function.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/extcon/extcon.c | 24 ++++++++++++++++++++++++
 include/linux/extcon.h  |  1 +
 2 files changed, 25 insertions(+)

diff --git a/drivers/extcon/extcon.c b/drivers/extcon/extcon.c
index 7829846..505c272 100644
--- a/drivers/extcon/extcon.c
+++ b/drivers/extcon/extcon.c
@@ -890,6 +890,30 @@ struct extcon_dev *extcon_get_extcon_dev(const char *extcon_name)
 EXPORT_SYMBOL_GPL(extcon_get_extcon_dev);
 
 /**
+ * extcon_get_extcon_dev_by_cable_id() - Get an extcon device by a cable id
+ * @id:		the unique id of each external connector in extcon enumeration.
+ */
+struct extcon_dev *extcon_get_extcon_dev_by_cable_id(unsigned int id)
+{
+	struct extcon_dev *extd;
+	int idx = -EINVAL;
+
+	mutex_lock(&extcon_dev_list_lock);
+	list_for_each_entry(extd, &extcon_dev_list, entry) {
+		idx = find_cable_index_by_id(extd, id);
+		if (idx >= 0)
+			break;
+	}
+	mutex_unlock(&extcon_dev_list_lock);
+
+	if (idx < 0)
+		return NULL;
+
+	return extd;
+}
+EXPORT_SYMBOL_GPL(extcon_get_extcon_dev_by_cable_id);
+
+/**
  * extcon_register_notifier() - Register a notifiee to get notified by
  *				any attach status changes from the extcon.
  * @edev:	the extcon device that has the external connecotr.
diff --git a/include/linux/extcon.h b/include/linux/extcon.h
index b871c0c..51abda8 100644
--- a/include/linux/extcon.h
+++ b/include/linux/extcon.h
@@ -230,6 +230,7 @@ extern int devm_extcon_dev_register(struct device *dev,
 extern void devm_extcon_dev_unregister(struct device *dev,
 				       struct extcon_dev *edev);
 extern struct extcon_dev *extcon_get_extcon_dev(const char *extcon_name);
+extern struct extcon_dev *extcon_get_extcon_dev_by_cable_id(unsigned int id);
 
 /*
  * Following APIs control the memory of extcon device.
-- 
2.9.3
