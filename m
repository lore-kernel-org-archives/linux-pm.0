From: Nishanth Menon <nm@ti.com>
Subject: [PATCH 5/5] firmware: ti_sci: Add support for reboot core service
Date: Fri, 19 Aug 2016 17:51:59 -0500
Message-ID: <20160819225159.10758-6-nm@ti.com>
References: <20160819225159.10758-1-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160819225159.10758-1-nm@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King <rmk+kernel@armlinux.org.uk>, Sudeep Holla <sudeep.holla@arm.com>, Santosh Shilimkar <ssantosh@kernel.org>
Cc: Russ Dill <Russ.Dill@ti.com>, Dave Gerlach <d-gerlach@ti.com>, Lokesh Vutla <lokeshvutla@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, "Andrew F . Davis" <afd@ti.com>, Suman Anna <s-anna@ti.com>, Tero Kristo <t-kristo@ti.com>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, Nishanth Menon <nm@ti.com>
List-Id: linux-pm@vger.kernel.org

Since system controller now has control over SoC power management, it
needs to be explicitly requested to reboot the SoC. Add support for
it.

In some systems however, SoC needs to toggle a GPIO or send event to an
external entity (like a PMIC) for a system reboot to take place. To
facilitate that, we allow for a DT property to determine if the reboot
handler will be registered and further, the service is also made
available to other drivers (such as PMIC driver) to sequence the
additional operation and trigger the SoC reboot as the last step.

Tested-by: Lokesh Vutla <lokeshvutla@ti.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
---
 .../devicetree/bindings/arm/keystone/ti,sci.txt    |  1 +
 drivers/firmware/ti_sci.c                          | 85 ++++++++++++++++++++++
 drivers/firmware/ti_sci.h                          | 12 +++
 include/linux/soc/ti/ti_sci_protocol.h             | 11 +++
 4 files changed, 109 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/keystone/ti,sci.txt b/Documentation/devicetree/bindings/arm/keystone/ti,sci.txt
index 965d45e313b1..ed5b8fc185f1 100644
--- a/Documentation/devicetree/bindings/arm/keystone/ti,sci.txt
+++ b/Documentation/devicetree/bindings/arm/keystone/ti,sci.txt
@@ -38,6 +38,7 @@ Optional Properties:
 - reg-names:
 	debug_messages - Map the Debug message region
 - reg:  register space corresponding to the debug_messages
+- ti,system-reboot-controller: If system reboot can be triggered by SoC reboot
 
 Example (K2G):
 --------
diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
index 97b2f2af827e..8771c330b73c 100644
--- a/drivers/firmware/ti_sci.c
+++ b/drivers/firmware/ti_sci.c
@@ -28,6 +28,7 @@
 #include <linux/slab.h>
 #include <linux/soc/ti/ti-msgmgr.h>
 #include <linux/soc/ti/ti_sci_protocol.h>
+#include <linux/reboot.h>
 
 #include "ti_sci.h"
 
@@ -90,6 +91,7 @@ struct ti_sci_desc {
  * struct ti_sci_info - Structure representing a TI SCI instance
  * @dev:	Device pointer
  * @desc:	SoC description for this instance
+ * @nb:	Reboot Notifier block
  * @d:		Debugfs file entry
  * @debug_region: Memory region where the debug message are available
  * @debug_region_size: Debug region size
@@ -104,6 +106,7 @@ struct ti_sci_desc {
  */
 struct ti_sci_info {
 	struct device *dev;
+	struct notifier_block nb;
 	const struct ti_sci_desc *desc;
 	struct dentry *d;
 	void __iomem *debug_region;
@@ -117,11 +120,15 @@ struct ti_sci_info {
 	struct list_head node;
 	/* protected by ti_sci_list_mutex */
 	int users;
+
 };
 
 #define cl_to_ti_sci_info(cl)	container_of(cl, struct ti_sci_info, cl)
 #define handle_to_ti_sci_info(handle) container_of(handle, struct ti_sci_info,\
 						   handle)
+#define reboot_to_ti_sci_info(nb) container_of(nb,\
+						      struct ti_sci_info,\
+						      nb)
 #ifdef CONFIG_DEBUG_FS
 
 /**
@@ -1572,6 +1579,52 @@ fail:
 	return ret;
 }
 
+static int ti_sci_cmd_core_reboot(const struct ti_sci_handle *handle)
+{
+	struct ti_sci_info *info;
+	struct ti_sci_msg_req_reboot *req;
+	struct ti_sci_msg_hdr *resp;
+	struct ti_sci_xfer *xfer;
+	struct device *dev;
+	int ret = 0;
+
+	if (IS_ERR(handle))
+		return PTR_ERR(handle);
+	if (!handle)
+		return -EINVAL;
+
+	info = handle_to_ti_sci_info(handle);
+	dev = info->dev;
+
+	xfer = ti_sci_get_one_xfer(info, TI_SCI_MSG_SYS_RESET,
+				   TI_SCI_FLAG_REQ_ACK_ON_PROCESSED,
+				   sizeof(*req), sizeof(*resp));
+	if (IS_ERR(xfer)) {
+		ret = PTR_ERR(xfer);
+		dev_err(dev, "Message alloc failed(%d)\n", ret);
+		return ret;
+	}
+	req = (struct ti_sci_msg_req_reboot *)xfer->xfer_buf;
+
+	ret = ti_sci_do_xfer(info, xfer);
+	if (ret) {
+		dev_err(dev, "Mbox send fail %d\n", ret);
+		goto fail;
+	}
+
+	resp = (struct ti_sci_msg_hdr *)xfer->xfer_buf;
+
+	if (!tis_sci_is_response_ack(resp))
+		ret = -ENODEV;
+	else
+		ret = 0;
+
+fail:
+	ti_sci_put_one_xfer(&info->minfo, xfer);
+
+	return ret;
+}
+
 /*
  * ti_sci_setup_ops() - Setup the operations structures
  * @info:	pointer to TISCI pointer
@@ -1579,9 +1632,12 @@ fail:
 static void ti_sci_setup_ops(struct ti_sci_info *info)
 {
 	struct ti_sci_ops *ops = &info->handle.ops;
+	struct ti_sci_core_ops *core_ops = &ops->core_ops;
 	struct ti_sci_dev_ops *dops = &ops->dev_ops;
 	struct ti_sci_clk_ops *cops = &ops->clk_ops;
 
+	core_ops->reboot_device = ti_sci_cmd_core_reboot;
+
 	dops->get_device = ti_sci_cmd_get_device;
 	dops->idle_device = ti_sci_cmd_idle_device;
 	dops->put_device = ti_sci_cmd_put_device;
@@ -1740,6 +1796,18 @@ const struct ti_sci_handle *devm_ti_sci_get_handle(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(devm_ti_sci_get_handle);
 
+static int tisci_reboot_handler(struct notifier_block *nb, unsigned long mode,
+				void *cmd)
+{
+	struct ti_sci_info *info = reboot_to_ti_sci_info(nb);
+	const struct ti_sci_handle *handle = &info->handle;
+
+	ti_sci_cmd_core_reboot(handle);
+
+	/* call fail OR pass, we should not be here in the first place */
+	return NOTIFY_BAD;
+}
+
 /* Description for K2G */
 static const struct ti_sci_desc ti_sci_pmmc_k2g_desc = {
 	.host_id = 2,
@@ -1767,6 +1835,7 @@ static int ti_sci_probe(struct platform_device *pdev)
 	struct mbox_client *cl;
 	int ret = -EINVAL;
 	int i;
+	int reboot = 0;
 
 	of_id = of_match_device(ti_sci_of_match, dev);
 	if (!of_id) {
@@ -1781,6 +1850,8 @@ static int ti_sci_probe(struct platform_device *pdev)
 
 	info->dev = dev;
 	info->desc = desc;
+	reboot = of_property_read_bool(dev->of_node,
+				       "ti,system-reboot-controller");
 	INIT_LIST_HEAD(&info->node);
 	minfo = &info->minfo;
 
@@ -1853,6 +1924,17 @@ static int ti_sci_probe(struct platform_device *pdev)
 
 	ti_sci_setup_ops(info);
 
+	if (reboot) {
+		info->nb.notifier_call = tisci_reboot_handler;
+		info->nb.priority = 128;
+
+		ret = register_restart_handler(&info->nb);
+		if (ret) {
+			dev_err(dev, "reboot registration fail(%d)\n", ret);
+			return ret;
+		}
+	}
+
 	dev_info(dev, "ABI: %d.%d (firmware rev 0x%04x '%s')\n",
 		 info->handle.version.abi_major, info->handle.version.abi_minor,
 		 info->handle.version.firmware_revision,
@@ -1879,6 +1961,9 @@ static int ti_sci_remove(struct platform_device *pdev)
 
 	info = platform_get_drvdata(pdev);
 
+	if (info->nb.notifier_call)
+		unregister_restart_handler(&info->nb);
+
 	mutex_lock(&ti_sci_list_mutex);
 	if (info->users)
 		ret = -EBUSY;
diff --git a/drivers/firmware/ti_sci.h b/drivers/firmware/ti_sci.h
index f69907cfc128..9b611e9e6f6d 100644
--- a/drivers/firmware/ti_sci.h
+++ b/drivers/firmware/ti_sci.h
@@ -46,6 +46,7 @@
 #define TI_SCI_MSG_VERSION	0x0002
 #define TI_SCI_MSG_WAKE_REASON	0x0003
 #define TI_SCI_MSG_GOODBYE	0x0004
+#define TI_SCI_MSG_SYS_RESET	0x0005
 
 /* Device requests */
 #define TI_SCI_MSG_SET_DEVICE_STATE	0x0200
@@ -106,6 +107,17 @@ struct ti_sci_msg_resp_version {
 } __packed;
 
 /**
+ * struct ti_sci_msg_req_reboot - Reboot the SoC
+ * @hdr:	Generic Header
+ *
+ * Request type is TI_SCI_MSG_SYS_RESET, responded with a generic
+ * ACK/NACK message.
+ */
+struct ti_sci_msg_req_reboot {
+	struct ti_sci_msg_hdr hdr;
+} __packed;
+
+/**
  * struct ti_sci_msg_req_set_device_state - Set the desired state of the device
  * @hdr:		Generic header
  * @id:	Indicates which device to modify
diff --git a/include/linux/soc/ti/ti_sci_protocol.h b/include/linux/soc/ti/ti_sci_protocol.h
index 76378fddf609..0ccbc138c26a 100644
--- a/include/linux/soc/ti/ti_sci_protocol.h
+++ b/include/linux/soc/ti/ti_sci_protocol.h
@@ -36,6 +36,16 @@ struct ti_sci_version_info {
 struct ti_sci_handle;
 
 /**
+ * struct ti_sci_core_ops - SoC Core Operations
+ * @reboot_device: Reboot the SoC
+ *		Returns 0 for successful request(ideally should never return),
+ *		else returns corresponding error value.
+ */
+struct ti_sci_core_ops {
+	int (*reboot_device)(const struct ti_sci_handle *handle);
+};
+
+/**
  * struct ti_sci_dev_ops - Device control operations
  * @get_device: Command to request for device managed by TISCI
  *		Returns 0 for successful exclusive request, else returns
@@ -196,6 +206,7 @@ struct ti_sci_clk_ops {
  * @clk_ops:	Clock specific operations
  */
 struct ti_sci_ops {
+	struct ti_sci_core_ops core_ops;
 	struct ti_sci_dev_ops dev_ops;
 	struct ti_sci_clk_ops clk_ops;
 };
-- 
2.9.1.200.gb1ec08f
