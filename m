From: Antti P Miettinen <amiettinen@nvidia.com>
Subject: [PATCH 6/6] input: CPU frequency booster
Date: Fri,  6 Jan 2012 02:36:26 +0200
Message-ID: <1325810186-28986-7-git-send-email-amiettinen@nvidia.com>
References: <1325810186-28986-1-git-send-email-amiettinen@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1325810186-28986-1-git-send-email-amiettinen@nvidia.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org
Cc: Antti P Miettinen <amiettinen@nvidia.com>
List-Id: linux-pm@vger.kernel.org

Inspired by cpufreq ondemand governor changes at
git://codeaurora.org/kernel/msm.git tree in commits:

    2a6181bc76c6ce46ca0fa8e547be42acd534cf0e
    1cca8861d8fda4e05f6b0c59c60003345c15454d
    96a9aeb02bf5b3fbbef47e44460750eb275e9f1b
    b600449501cf15928440f87eff86b1f32d14214e
    88a65c7ae04632ffee11f9fc628d7ab017c06b83

Signed-off-by: Antti P Miettinen <amiettinen@nvidia.com>
---
 drivers/input/Kconfig         |    9 ++
 drivers/input/Makefile        |    1 +
 drivers/input/input-cfboost.c |  174 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 184 insertions(+), 0 deletions(-)
 create mode 100644 drivers/input/input-cfboost.c

diff --git a/drivers/input/Kconfig b/drivers/input/Kconfig
index 001b147..3859f78 100644
--- a/drivers/input/Kconfig
+++ b/drivers/input/Kconfig
@@ -161,6 +161,15 @@ config INPUT_APMPOWER
 	  To compile this driver as a module, choose M here: the
 	  module will be called apm-power.
 
+config INPUT_CFBOOST
+	tristate "CPU frequency booster"
+	depends on INPUT && CPU_FREQ
+	help
+	  Say Y here if you want to boost frequency upon input events;
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called input-cfboost.
+
 comment "Input Device Drivers"
 
 source "drivers/input/keyboard/Kconfig"
diff --git a/drivers/input/Makefile b/drivers/input/Makefile
index 0c78949..6cad177 100644
--- a/drivers/input/Makefile
+++ b/drivers/input/Makefile
@@ -24,3 +24,4 @@ obj-$(CONFIG_INPUT_TOUCHSCREEN)	+= touchscreen/
 obj-$(CONFIG_INPUT_MISC)	+= misc/
 
 obj-$(CONFIG_INPUT_APMPOWER)	+= apm-power.o
+obj-$(CONFIG_INPUT_CFBOOST)	+= input-cfboost.o
diff --git a/drivers/input/input-cfboost.c b/drivers/input/input-cfboost.c
new file mode 100644
index 0000000..bef3ec5
--- /dev/null
+++ b/drivers/input/input-cfboost.c
@@ -0,0 +1,174 @@
+/*
+ * drivers/input/input-cfboost.c
+ *
+ * Copyright (C) 2012 NVIDIA Corporation
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; version 2 of the License.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
+ *
+ */
+
+#include <linux/slab.h>
+#include <linux/jiffies.h>
+#include <linux/printk.h>
+#include <linux/workqueue.h>
+#include <linux/input.h>
+#include <linux/module.h>
+#include <linux/pm_qos.h>
+
+/* This module listens to input events and sets a temporary frequency
+ * floor upon input event detection. This is based on changes to
+ * cpufreq ondemand governor by:
+ *
+ * Tero Kristo <tero.kristo@nokia.com>
+ * Brian Steuer <bsteuer@codeaurora.org>
+ * David Ng <dave@codeaurora.org>
+ *
+ * at git://codeaurora.org/kernel/msm.git tree, commits:
+ *
+ * 2a6181bc76c6ce46ca0fa8e547be42acd534cf0e
+ * 1cca8861d8fda4e05f6b0c59c60003345c15454d
+ * 96a9aeb02bf5b3fbbef47e44460750eb275e9f1b
+ * b600449501cf15928440f87eff86b1f32d14214e
+ * 88a65c7ae04632ffee11f9fc628d7ab017c06b83
+ */
+
+MODULE_AUTHOR("Antti P Miettinen <amiettinen@nvidia.com>");
+MODULE_DESCRIPTION("Input event CPU frequency booster");
+MODULE_LICENSE("GPL v2");
+
+
+static struct pm_qos_request qos_req;
+static struct work_struct boost;
+static struct delayed_work unboost;
+static unsigned int boost_freq; /* kHz */
+module_param(boost_freq, uint, 0644);
+static unsigned long boost_time = 500; /* ms */
+module_param(boost_time, ulong, 0644);
+static struct workqueue_struct *cfb_wq;
+
+static void cfb_boost(struct work_struct *w)
+{
+	cancel_delayed_work_sync(&unboost);
+	pm_qos_update_request(&qos_req, boost_freq);
+	queue_delayed_work(cfb_wq, &unboost, msecs_to_jiffies(boost_time));
+}
+
+static void cfb_unboost(struct work_struct *w)
+{
+	pm_qos_update_request(&qos_req, PM_QOS_DEFAULT_VALUE);
+}
+
+static void cfb_input_event(struct input_handle *handle, unsigned int type,
+			    unsigned int code, int value)
+{
+	if (!work_pending(&boost))
+		queue_work(cfb_wq, &boost);
+}
+
+static int cfb_input_connect(struct input_handler *handler,
+			     struct input_dev *dev,
+			     const struct input_device_id *id)
+{
+	struct input_handle *handle;
+	int error;
+
+	handle = kzalloc(sizeof(struct input_handle), GFP_KERNEL);
+	if (!handle)
+		return -ENOMEM;
+
+	handle->dev = dev;
+	handle->handler = handler;
+	handle->name = "icfboost";
+
+	error = input_register_handle(handle);
+	if (error)
+		goto err2;
+
+	error = input_open_device(handle);
+	if (error)
+		goto err1;
+
+	return 0;
+err1:
+	input_unregister_handle(handle);
+err2:
+	kfree(handle);
+	return error;
+}
+
+static void cfb_input_disconnect(struct input_handle *handle)
+{
+	input_close_device(handle);
+	input_unregister_handle(handle);
+	kfree(handle);
+}
+
+/* XXX make configurable */
+static const struct input_device_id cfb_ids[] = {
+	{ /* touch screen */
+		.flags = INPUT_DEVICE_ID_MATCH_EVBIT |
+				INPUT_DEVICE_ID_MATCH_KEYBIT,
+		.evbit = { BIT_MASK(EV_ABS) },
+		.keybit = {[BIT_WORD(BTN_TOUCH)] = BIT_MASK(BTN_TOUCH) },
+	},
+	{ /* mouse */
+		.flags = INPUT_DEVICE_ID_MATCH_EVBIT |
+				INPUT_DEVICE_ID_MATCH_KEYBIT,
+		.evbit = { BIT_MASK(EV_REL) },
+		.keybit = {[BIT_WORD(BTN_MOUSE)] = BIT_MASK(BTN_MOUSE) },
+	},
+	{ },
+};
+
+static struct input_handler cfb_input_handler = {
+	.event		= cfb_input_event,
+	.connect	= cfb_input_connect,
+	.disconnect	= cfb_input_disconnect,
+	.name		= "icfboost",
+	.id_table	= cfb_ids,
+};
+
+static int __init cfboost_init(void)
+{
+	int ret;
+
+	cfb_wq = create_workqueue("icfb-wq");
+	if (!cfb_wq)
+		return -ENOMEM;
+	INIT_WORK(&boost, cfb_boost);
+	INIT_DELAYED_WORK(&unboost, cfb_unboost);
+	ret = input_register_handler(&cfb_input_handler);
+	if (ret) {
+		destroy_workqueue(cfb_wq);
+		return ret;
+	}
+	pm_qos_add_request(&qos_req, PM_QOS_CPU_FREQ_MIN,
+			   PM_QOS_DEFAULT_VALUE);
+	return 0;
+}
+
+static void __exit cfboost_exit(void)
+{
+	/* stop input events */
+	input_unregister_handler(&cfb_input_handler);
+	/* cancel pending work requests */
+	cancel_work_sync(&boost);
+	cancel_delayed_work_sync(&unboost);
+	/* clean up */
+	destroy_workqueue(cfb_wq);
+	pm_qos_remove_request(&qos_req);
+}
+
+module_init(cfboost_init);
+module_exit(cfboost_exit);
-- 
1.7.4.1
