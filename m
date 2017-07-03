From: Baolin Wang <baolin.wang@linaro.org>
Subject: [PATCH v2 2/3] usb: phy: Add USB charger support
Date: Mon,  3 Jul 2017 14:07:14 +0800
Message-ID: <9ccafadb156d1c7f6f5a06b86ed406bd6b60dee3.1499061617.git.baolin.wang@linaro.org>
References: <cover.1499061617.git.baolin.wang@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1499061617.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1499061617.git.baolin.wang@linaro.org>
References: <cover.1499061617.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: balbi@kernel.org, gregkh@linuxfoundation.org, sre@kernel.org
Cc: jun.li@nxp.com, peter.chen@freescale.com, broonie@kernel.org, john.stultz@linaro.org, neilb@suse.com, patches@opensource.wolfsonmicro.com, baolin.wang@linaro.org, linux-pm@vger.kernel.org, linux-usb@vger.kernel.org, device-mainlining@lists.linuxfoundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

This patch introduces the usb charger support based on usb phy that
makes an enhancement to a power driver. The basic conception of the
usb charger is that, when one usb charger is added or removed by
reporting from the extcon device state change, the usb charger will
report to power user to set the current limitation.

Power user can register a notifiee on the usb phy by issuing
usb_register_notifier() to get notified by charger status changes
or charger current changes.

we can notify what current to be drawn to power user according to
different charger type, and now we have 2 methods to get charger type.
One is get charger type from extcon subsystem, which also means the
charger state changes. Another is we can get the charger type from
USB controller detecting or PMIC detecting, and the charger state
changes should be told by issuing usb_phy_set_charger_state().

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/usb/phy/phy.c   |  265 +++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/usb/phy.h |   49 +++++++++
 2 files changed, 314 insertions(+)

diff --git a/drivers/usb/phy/phy.c b/drivers/usb/phy/phy.c
index 032f5af..db72802 100644
--- a/drivers/usb/phy/phy.c
+++ b/drivers/usb/phy/phy.c
@@ -18,6 +18,18 @@
 
 #include <linux/usb/phy.h>
 
+/* Default current range by charger type. */
+#define DEFAULT_SDP_CUR_MIN	2
+#define DEFAULT_SDP_CUR_MAX	500
+#define DEFAULT_SDP_CUR_MIN_SS	150
+#define DEFAULT_SDP_CUR_MAX_SS	900
+#define DEFAULT_DCP_CUR_MIN	500
+#define DEFAULT_DCP_CUR_MAX	5000
+#define DEFAULT_CDP_CUR_MIN	1500
+#define DEFAULT_CDP_CUR_MAX	5000
+#define DEFAULT_ACA_CUR_MIN	1500
+#define DEFAULT_ACA_CUR_MAX	5000
+
 static LIST_HEAD(phy_list);
 static LIST_HEAD(phy_bind_list);
 static DEFINE_SPINLOCK(phy_lock);
@@ -77,6 +89,216 @@ static struct usb_phy *__of_usb_find_phy(struct device_node *node)
 	return ERR_PTR(-EPROBE_DEFER);
 }
 
+static void usb_phy_set_default_current(struct usb_phy *usb_phy)
+{
+	usb_phy->chg_cur.sdp_min = DEFAULT_SDP_CUR_MIN;
+	usb_phy->chg_cur.sdp_max = DEFAULT_SDP_CUR_MAX;
+	usb_phy->chg_cur.dcp_min = DEFAULT_DCP_CUR_MIN;
+	usb_phy->chg_cur.dcp_max = DEFAULT_DCP_CUR_MAX;
+	usb_phy->chg_cur.cdp_min = DEFAULT_CDP_CUR_MIN;
+	usb_phy->chg_cur.cdp_max = DEFAULT_CDP_CUR_MAX;
+	usb_phy->chg_cur.aca_min = DEFAULT_ACA_CUR_MIN;
+	usb_phy->chg_cur.aca_max = DEFAULT_ACA_CUR_MAX;
+}
+
+/**
+ * usb_phy_notify_charger_work - notify the USB charger state
+ * @work - the charger work to notify the USB charger state
+ *
+ * This work can be issued when USB charger state has been changed or
+ * USB charger current has been changed, then we can notify the current
+ * what can be drawn to power user and the charger state to userspace.
+ *
+ * If we get the charger type from extcon subsystem, we can notify the
+ * charger state to power user automatically by usb_phy_get_charger_type()
+ * issuing from extcon subsystem.
+ *
+ * If we get the charger type from ->charger_detect() instead of extcon
+ * subsystem, the usb phy driver should issue usb_phy_set_charger_state()
+ * to set charger state when the charger state has been changed.
+ */
+static void usb_phy_notify_charger_work(struct work_struct *work)
+{
+	struct usb_phy *usb_phy = container_of(work, struct usb_phy, chg_work);
+	char uchger_state[50] = { 0 };
+	char *envp[] = { uchger_state, NULL };
+	unsigned int min, max;
+
+	switch (usb_phy->chg_state) {
+	case USB_CHARGER_PRESENT:
+		usb_phy_get_charger_current(usb_phy, &min, &max);
+
+		atomic_notifier_call_chain(&usb_phy->notifier, max, usb_phy);
+		snprintf(uchger_state, ARRAY_SIZE(uchger_state),
+			 "USB_CHARGER_STATE=%s", "USB_CHARGER_PRESENT");
+		break;
+	case USB_CHARGER_ABSENT:
+		usb_phy_set_default_current(usb_phy);
+
+		atomic_notifier_call_chain(&usb_phy->notifier, 0, usb_phy);
+		snprintf(uchger_state, ARRAY_SIZE(uchger_state),
+			 "USB_CHARGER_STATE=%s", "USB_CHARGER_ABSENT");
+		break;
+	default:
+		dev_warn(usb_phy->dev, "Unknown USB charger state: %d\n",
+			 usb_phy->chg_state);
+		return;
+	}
+
+	kobject_uevent_env(&usb_phy->dev->kobj, KOBJ_CHANGE, envp);
+}
+
+/**
+ * usb_phy_get_charger_type - get charger type from extcon subsystem
+ * @nb -the notifier block to determine charger type
+ * @state - the cable state
+ * @data - private data
+ *
+ * Determin the charger type from extcon subsystem which also means the
+ * charger state has been chaned, then we should notify this event.
+ */
+static int usb_phy_get_charger_type(struct notifier_block *nb,
+				    unsigned long state, void *data)
+{
+	struct usb_phy *usb_phy = container_of(nb, struct usb_phy, type_nb);
+
+	if (extcon_get_state(usb_phy->edev, EXTCON_CHG_USB_SDP) > 0) {
+		usb_phy->chg_type = SDP_TYPE;
+		usb_phy->chg_state = USB_CHARGER_PRESENT;
+	} else if (extcon_get_state(usb_phy->edev, EXTCON_CHG_USB_CDP) > 0) {
+		usb_phy->chg_type = CDP_TYPE;
+		usb_phy->chg_state = USB_CHARGER_PRESENT;
+	} else if (extcon_get_state(usb_phy->edev, EXTCON_CHG_USB_DCP) > 0) {
+		usb_phy->chg_type = DCP_TYPE;
+		usb_phy->chg_state = USB_CHARGER_PRESENT;
+	} else if (extcon_get_state(usb_phy->edev, EXTCON_CHG_USB_ACA) > 0) {
+		usb_phy->chg_type = ACA_TYPE;
+		usb_phy->chg_state = USB_CHARGER_PRESENT;
+	} else {
+		usb_phy->chg_type = UNKNOWN_TYPE;
+		usb_phy->chg_state = USB_CHARGER_ABSENT;
+	}
+
+	schedule_work(&usb_phy->chg_work);
+	return NOTIFY_OK;
+}
+
+/**
+ * usb_phy_set_charger_current - set the USB charger current
+ * @usb_phy - the USB phy to be used
+ * @mA - the current need to be set
+ *
+ * Usually we only change the charger default current when USB finished the
+ * enumeration as one SDP charger. As one SDP charger, usb_phy_set_power()
+ * will issue this function to change charger current when after setting USB
+ * configuration, or suspend/resume USB. For other type charger, we should
+ * use the default charger current and we do not suggest to issue this function
+ * to change the charger current.
+ *
+ * When USB charger current has been changed, we need to notify the power users.
+ */
+void usb_phy_set_charger_current(struct usb_phy *usb_phy, unsigned int mA)
+{
+	switch (usb_phy->chg_type) {
+	case SDP_TYPE:
+		if (usb_phy->chg_cur.sdp_max == mA)
+			return;
+
+		usb_phy->chg_cur.sdp_max = (mA > DEFAULT_SDP_CUR_MAX_SS) ?
+			DEFAULT_SDP_CUR_MAX_SS : mA;
+		break;
+	case DCP_TYPE:
+		if (usb_phy->chg_cur.dcp_max == mA)
+			return;
+
+		usb_phy->chg_cur.dcp_max = (mA > DEFAULT_DCP_CUR_MAX) ?
+			DEFAULT_DCP_CUR_MAX : mA;
+		break;
+	case CDP_TYPE:
+		if (usb_phy->chg_cur.cdp_max == mA)
+			return;
+
+		usb_phy->chg_cur.cdp_max = (mA > DEFAULT_CDP_CUR_MAX) ?
+			DEFAULT_CDP_CUR_MAX : mA;
+		break;
+	case ACA_TYPE:
+		if (usb_phy->chg_cur.aca_max == mA)
+			return;
+
+		usb_phy->chg_cur.aca_max = (mA > DEFAULT_ACA_CUR_MAX) ?
+			DEFAULT_ACA_CUR_MAX : mA;
+		break;
+	default:
+		return;
+	}
+
+	schedule_work(&usb_phy->chg_work);
+}
+EXPORT_SYMBOL_GPL(usb_phy_set_charger_current);
+
+/**
+ * usb_phy_get_charger_current - get the USB charger current
+ * @usb_phy - the USB phy to be used
+ * @min - the minimum current
+ * @max - the maximum current
+ *
+ * Usually we will notify the maximum current to power user, but for some
+ * special case, power user also need the minimum current value. Then the
+ * power user can issue this function to get the suitable current.
+ */
+void usb_phy_get_charger_current(struct usb_phy *usb_phy,
+				 unsigned int *min, unsigned int *max)
+{
+	switch (usb_phy->chg_type) {
+	case SDP_TYPE:
+		*min = usb_phy->chg_cur.sdp_min;
+		*max = usb_phy->chg_cur.sdp_max;
+		break;
+	case DCP_TYPE:
+		*min = usb_phy->chg_cur.dcp_min;
+		*max = usb_phy->chg_cur.dcp_max;
+		break;
+	case CDP_TYPE:
+		*min = usb_phy->chg_cur.cdp_min;
+		*max = usb_phy->chg_cur.cdp_max;
+		break;
+	case ACA_TYPE:
+		*min = usb_phy->chg_cur.aca_min;
+		*max = usb_phy->chg_cur.aca_max;
+		break;
+	default:
+		*min = 0;
+		*max = 0;
+		break;
+	}
+}
+EXPORT_SYMBOL_GPL(usb_phy_get_charger_current);
+
+/**
+ * usb_phy_set_charger_state - set the USB charger state
+ * @usb_phy - the USB phy to be used
+ * @state - the new state need to be set for charger
+ *
+ * The usb phy driver can issue this function when the usb phy driver
+ * detected the charger state has been changed, in this case the charger
+ * type should be get from ->charger_detect().
+ */
+void usb_phy_set_charger_state(struct usb_phy *usb_phy,
+			       enum usb_charger_state state)
+{
+	if (usb_phy->chg_state == state || !usb_phy->charger_detect)
+		return;
+
+	usb_phy->chg_state = state;
+	if (usb_phy->chg_state == USB_CHARGER_PRESENT)
+		usb_phy->chg_type = usb_phy->charger_detect(usb_phy);
+	else
+		usb_phy->chg_type = UNKNOWN_TYPE;
+
+	schedule_work(&usb_phy->chg_work);
+}
+EXPORT_SYMBOL_GPL(usb_phy_set_charger_state);
+
 static void devm_usb_phy_release(struct device *dev, void *res)
 {
 	struct usb_phy *phy = *(struct usb_phy **)res;
@@ -124,6 +346,44 @@ static int usb_add_extcon(struct usb_phy *x)
 					"register VBUS notifier failed\n");
 				return ret;
 			}
+		} else {
+			x->type_nb.notifier_call = usb_phy_get_charger_type;
+
+			ret = devm_extcon_register_notifier(x->dev, x->edev,
+							    EXTCON_CHG_USB_SDP,
+							    &x->type_nb);
+			if (ret) {
+				dev_err(x->dev,
+					"register extcon USB SDP failed.\n");
+				return ret;
+			}
+
+			ret = devm_extcon_register_notifier(x->dev, x->edev,
+							    EXTCON_CHG_USB_CDP,
+							    &x->type_nb);
+			if (ret) {
+				dev_err(x->dev,
+					"register extcon USB CDP failed.\n");
+				return ret;
+			}
+
+			ret = devm_extcon_register_notifier(x->dev, x->edev,
+							    EXTCON_CHG_USB_DCP,
+							    &x->type_nb);
+			if (ret) {
+				dev_err(x->dev,
+					"register extcon USB DCP failed.\n");
+				return ret;
+			}
+
+			ret = devm_extcon_register_notifier(x->dev, x->edev,
+							    EXTCON_CHG_USB_ACA,
+							    &x->type_nb);
+			if (ret) {
+				dev_err(x->dev,
+					"register extcon USB ACA failed.\n");
+				return ret;
+			}
 		}
 
 		if (x->id_nb.notifier_call) {
@@ -145,6 +405,11 @@ static int usb_add_extcon(struct usb_phy *x)
 		}
 	}
 
+	usb_phy_set_default_current(x);
+	INIT_WORK(&x->chg_work, usb_phy_notify_charger_work);
+	x->chg_type = UNKNOWN_TYPE;
+	x->chg_state = USB_CHARGER_DEFAULT;
+
 	return 0;
 }
 
diff --git a/include/linux/usb/phy.h b/include/linux/usb/phy.h
index 2992451..de881b1 100644
--- a/include/linux/usb/phy.h
+++ b/include/linux/usb/phy.h
@@ -12,6 +12,7 @@
 #include <linux/extcon.h>
 #include <linux/notifier.h>
 #include <linux/usb.h>
+#include <uapi/linux/usb/charger.h>
 
 enum usb_phy_interface {
 	USBPHY_INTERFACE_MODE_UNKNOWN,
@@ -72,6 +73,17 @@ struct usb_phy_io_ops {
 	int (*write)(struct usb_phy *x, u32 val, u32 reg);
 };
 
+struct usb_charger_current {
+	unsigned int sdp_min;
+	unsigned int sdp_max;
+	unsigned int dcp_min;
+	unsigned int dcp_max;
+	unsigned int cdp_min;
+	unsigned int cdp_max;
+	unsigned int aca_min;
+	unsigned int aca_max;
+};
+
 struct usb_phy {
 	struct device		*dev;
 	const char		*label;
@@ -91,6 +103,13 @@ struct usb_phy {
 	struct extcon_dev	*id_edev;
 	struct notifier_block	vbus_nb;
 	struct notifier_block	id_nb;
+	struct notifier_block	type_nb;
+
+	/* Support USB charger */
+	enum usb_charger_type	chg_type;
+	enum usb_charger_state	chg_state;
+	struct usb_charger_current	chg_cur;
+	struct work_struct		chg_work;
 
 	/* for notification of usb_phy_events */
 	struct atomic_notifier_head	notifier;
@@ -129,6 +148,12 @@ struct usb_phy {
 			enum usb_device_speed speed);
 	int	(*notify_disconnect)(struct usb_phy *x,
 			enum usb_device_speed speed);
+
+	/*
+	 * Charger detection method can be implemented if you need to
+	 * manually detect the charger type.
+	 */
+	enum usb_charger_type (*charger_detect)(struct usb_phy *x);
 };
 
 /**
@@ -219,6 +244,12 @@ extern struct usb_phy *devm_usb_get_phy_by_node(struct device *dev,
 extern int usb_bind_phy(const char *dev_name, u8 index,
 				const char *phy_dev_name);
 extern void usb_phy_set_event(struct usb_phy *x, unsigned long event);
+extern void usb_phy_set_charger_current(struct usb_phy *usb_phy,
+					unsigned int mA);
+extern void usb_phy_get_charger_current(struct usb_phy *usb_phy,
+					unsigned int *min, unsigned int *max);
+extern void usb_phy_set_charger_state(struct usb_phy *usb_phy,
+				      enum usb_charger_state state);
 #else
 static inline struct usb_phy *usb_get_phy(enum usb_phy_type type)
 {
@@ -270,11 +301,29 @@ static inline int usb_bind_phy(const char *dev_name, u8 index,
 static inline void usb_phy_set_event(struct usb_phy *x, unsigned long event)
 {
 }
+
+static inline void usb_phy_set_charger_current(struct usb_phy *usb_phy,
+					       unsigned int mA)
+{
+}
+
+static inline void usb_phy_get_charger_current(struct usb_phy *usb_phy,
+					       unsigned int *min,
+					       unsigned int *max)
+{
+}
+
+static inline void usb_phy_set_charger_state(struct usb_phy *usb_phy,
+					     enum usb_charger_state state)
+{
+}
 #endif
 
 static inline int
 usb_phy_set_power(struct usb_phy *x, unsigned mA)
 {
+	usb_phy_set_charger_current(x, mA);
+
 	if (x && x->set_power)
 		return x->set_power(x, mA);
 	return 0;
-- 
1.7.9.5
