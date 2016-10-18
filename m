From: Nishanth Menon <nm@ti.com>
Subject: [PATCH V4 5/5] firmware: ti_sci: Add support for reboot core service
Date: Tue, 18 Oct 2016 18:08:37 -0500
Message-ID: <20161018230837.6515-6-nm@ti.com>
References: <20161018230837.6515-1-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20161018230837.6515-1-nm@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tero Kristo <t-kristo@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>
Cc: Nishanth Menon <nm@ti.com>, devicetree@vger.kernel.org, Dave Gerlach <d-gerlach@ti.com>, Lokesh Vutla <lokeshvutla@ti.com>, Kevin Hilman <khilman@baylibre.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Andrew Davis <afd@ti.com>, Russell King <rmk+kernel@armlinux.org.uk>, Russ Dill <Russ.Dill@ti.com>, Sudeep Holla <sudeep.holla@arm.com>, linux-arm-kernel@lists.infradead.org
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
Changes since V3:
	- checkpatch fixes for macro after checkpatch.pl update in v4.9-rc1

V3: https://patchwork.kernel.org/patch/9317837/

 drivers/firmware/ti_sci.c              | 83 ++++++++++++++++++++++++++++++++++
 drivers/firmware/ti_sci.h              | 12 +++++
 include/linux/soc/ti/ti_sci_protocol.h | 11 +++++
 3 files changed, 106 insertions(+)

diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
index 496a007e5c69..874ff32db366 100644
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
@@ -117,10 +120,12 @@ struct ti_sci_info {
 	struct list_head node;
 	/* protected by ti_sci_list_mutex */
 	int users;
+
 };
 
 #define cl_to_ti_sci_info(c)	container_of(c, struct ti_sci_info, cl)
 #define handle_to_ti_sci_info(h) container_of(h, struct ti_sci_info, handle)
+#define reboot_to_ti_sci_info(n) container_of(n, struct ti_sci_info, nb)
 
 #ifdef CONFIG_DEBUG_FS
 
@@ -1571,6 +1576,52 @@ static int ti_sci_cmd_clk_get_freq(const struct ti_sci_handle *handle,
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
+	if (!ti_sci_is_response_ack(resp))
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
@@ -1578,9 +1629,12 @@ static int ti_sci_cmd_clk_get_freq(const struct ti_sci_handle *handle,
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
@@ -1732,6 +1786,18 @@ const struct ti_sci_handle *devm_ti_sci_get_handle(struct device *dev)
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
@@ -1759,6 +1825,7 @@ static int ti_sci_probe(struct platform_device *pdev)
 	struct mbox_client *cl;
 	int ret = -EINVAL;
 	int i;
+	int reboot = 0;
 
 	of_id = of_match_device(ti_sci_of_match, dev);
 	if (!of_id) {
@@ -1773,6 +1840,8 @@ static int ti_sci_probe(struct platform_device *pdev)
 
 	info->dev = dev;
 	info->desc = desc;
+	reboot = of_property_read_bool(dev->of_node,
+				       "ti,system-reboot-controller");
 	INIT_LIST_HEAD(&info->node);
 	minfo = &info->minfo;
 
@@ -1845,6 +1914,17 @@ static int ti_sci_probe(struct platform_device *pdev)
 
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
@@ -1874,6 +1954,9 @@ static int ti_sci_remove(struct platform_device *pdev)
 
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
2.10.0
