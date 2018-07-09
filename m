From: Georgi Djakov <georgi.djakov@linaro.org>
Subject: [PATCH v6 4/8] interconnect: qcom: Add RPM communication
Date: Mon,  9 Jul 2018 18:51:00 +0300
Message-ID: <20180709155104.25528-5-georgi.djakov@linaro.org>
References: <20180709155104.25528-1-georgi.djakov@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180709155104.25528-1-georgi.djakov@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-pm@vger.kernel.org, gregkh@linuxfoundation.org
Cc: mark.rutland@arm.com, evgreen@chromium.org, vincent.guittot@linaro.org, daidavid1@codeaurora.org, seansw@qti.qualcomm.com, khilman@baylibre.com, mturquette@baylibre.com, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, amit.kucheria@linaro.org, bjorn.andersson@linaro.org, robh+dt@kernel.org, skannan@codeaurora.org, abailon@baylibre.com, linux-arm-msm@vger.kernel.org, lorenzo.pieralisi@arm.com, mka@chromium.org, linux-arm-kernel@lists.infradead.org, georgi.djakov@linaro.org
List-Id: linux-pm@vger.kernel.org

On some Qualcomm SoCs, there is a remote processor, which controls some of
the Network-On-Chip interconnect resources. Other CPUs express their needs
by communicating with this processor. Add a driver to handle communication
with this remote processor.

Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 .../bindings/interconnect/qcom-smd.txt        | 32 +++++++
 drivers/interconnect/qcom/Kconfig             | 11 +++
 drivers/interconnect/qcom/Makefile            |  2 +
 drivers/interconnect/qcom/smd-rpm.c           | 91 +++++++++++++++++++
 drivers/interconnect/qcom/smd-rpm.h           | 15 +++
 5 files changed, 151 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom-smd.txt
 create mode 100644 drivers/interconnect/qcom/Kconfig
 create mode 100644 drivers/interconnect/qcom/Makefile
 create mode 100644 drivers/interconnect/qcom/smd-rpm.c
 create mode 100644 drivers/interconnect/qcom/smd-rpm.h

diff --git a/Documentation/devicetree/bindings/interconnect/qcom-smd.txt b/Documentation/devicetree/bindings/interconnect/qcom-smd.txt
new file mode 100644
index 000000000000..88a5aeb50935
--- /dev/null
+++ b/Documentation/devicetree/bindings/interconnect/qcom-smd.txt
@@ -0,0 +1,32 @@
+Qualcomm SMD-RPM interconnect driver binding
+------------------------------------------------
+The RPM (Resource Power Manager) is a dedicated hardware engine
+for managing the shared SoC resources in order to keep the lowest
+power profile. It communicates with other hardware subsystems via
+the shared memory driver (SMD) back-end and accepts requests for
+various resources.
+
+Required properties :
+- compatible : shall contain only one of the following:
+			"qcom,interconnect-smd-rpm"
+
+Example:
+	smd {
+		compatible = "qcom,smd";
+
+		rpm {
+			interrupts = <0 168 1>;
+			qcom,ipc = <&apcs 8 0>;
+			qcom,smd-edge = <15>;
+
+			rpm_requests {
+				compatible = "qcom,rpm-msm8916";
+				qcom,smd-channels = "rpm_requests";
+
+				interconnect-smd-rpm {
+					compatible = "qcom,interconnect-smd-rpm";
+				};
+
+			};
+		};
+	};
diff --git a/drivers/interconnect/qcom/Kconfig b/drivers/interconnect/qcom/Kconfig
new file mode 100644
index 000000000000..b0c2ff928d88
--- /dev/null
+++ b/drivers/interconnect/qcom/Kconfig
@@ -0,0 +1,11 @@
+config INTERCONNECT_QCOM
+	bool "Qualcomm Network-on-Chip interconnect drivers"
+	depends on INTERCONNECT
+	depends on ARCH_QCOM || COMPILE_TEST
+
+config INTERCONNECT_QCOM_SMD_RPM
+	tristate "Qualcomm SMD RPM interconnect driver"
+	depends on INTERCONNECT_QCOM
+	help
+	  This is a driver for communicating interconnect related configuration
+	  details with a remote processor (RPM) on Qualcomm platforms.
diff --git a/drivers/interconnect/qcom/Makefile b/drivers/interconnect/qcom/Makefile
new file mode 100644
index 000000000000..5b65e4011b59
--- /dev/null
+++ b/drivers/interconnect/qcom/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_INTERCONNECT_QCOM_SMD_RPM) += smd-rpm.o
diff --git a/drivers/interconnect/qcom/smd-rpm.c b/drivers/interconnect/qcom/smd-rpm.c
new file mode 100644
index 000000000000..48b7a2a6eb84
--- /dev/null
+++ b/drivers/interconnect/qcom/smd-rpm.c
@@ -0,0 +1,91 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * RPM over SMD communication wrapper for interconnects
+ *
+ * Copyright (C) 2018 Linaro Ltd
+ * Author: Georgi Djakov <georgi.djakov@linaro.org>
+ */
+
+#include <linux/interconnect-provider.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/soc/qcom/smd-rpm.h>
+#include "smd-rpm.h"
+
+#define	RPM_KEY_BW	0x00007762
+
+static struct qcom_icc_rpm {
+	struct qcom_smd_rpm *rpm;
+} icc_rpm_smd;
+
+struct icc_rpm_smd_req {
+	__le32 key;
+	__le32 nbytes;
+	__le32 value;
+};
+
+bool qcom_icc_rpm_smd_available(void)
+{
+	if (!icc_rpm_smd.rpm)
+		return false;
+
+	return true;
+}
+EXPORT_SYMBOL_GPL(qcom_icc_rpm_smd_available);
+
+int qcom_icc_rpm_smd_send(int ctx, int rsc_type, int id, u32 val)
+{
+	struct icc_rpm_smd_req req = {
+		.key = cpu_to_le32(RPM_KEY_BW),
+		.nbytes = cpu_to_le32(sizeof(u32)),
+		.value = cpu_to_le32(val),
+	};
+
+	return qcom_rpm_smd_write(icc_rpm_smd.rpm, ctx, rsc_type, id, &req,
+				  sizeof(req));
+}
+EXPORT_SYMBOL_GPL(qcom_icc_rpm_smd_send);
+
+static int qcom_icc_rpm_smd_probe(struct platform_device *pdev)
+{
+	icc_rpm_smd.rpm = dev_get_drvdata(pdev->dev.parent);
+	if (!icc_rpm_smd.rpm) {
+		dev_err(&pdev->dev, "unable to retrieve handle to RPM\n");
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+static const struct of_device_id qcom_icc_rpm_smd_dt_match[] = {
+	{ .compatible = "qcom,interconnect-smd-rpm", },
+	{ },
+};
+
+MODULE_DEVICE_TABLE(of, qcom_icc_rpm_smd_dt_match);
+
+static struct platform_driver qcom_interconnect_rpm_smd_driver = {
+	.driver = {
+		.name		= "qcom-interconnect-smd-rpm",
+		.of_match_table	= qcom_icc_rpm_smd_dt_match,
+	},
+	.probe = qcom_icc_rpm_smd_probe,
+};
+
+static int __init rpm_smd_interconnect_init(void)
+{
+	return platform_driver_register(&qcom_interconnect_rpm_smd_driver);
+}
+subsys_initcall(rpm_smd_interconnect_init);
+
+static void __exit rpm_smd_interconnect_exit(void)
+{
+	platform_driver_unregister(&qcom_interconnect_rpm_smd_driver);
+}
+module_exit(rpm_smd_interconnect_exit)
+
+MODULE_AUTHOR("Georgi Djakov <georgi.djakov@linaro.org>");
+MODULE_DESCRIPTION("Qualcomm SMD RPM interconnect driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/interconnect/qcom/smd-rpm.h b/drivers/interconnect/qcom/smd-rpm.h
new file mode 100644
index 000000000000..c33b91a3dd51
--- /dev/null
+++ b/drivers/interconnect/qcom/smd-rpm.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2018, Linaro Ltd.
+ * Author: Georgi Djakov <georgi.djakov@linaro.org>
+ */
+
+#ifndef __DRIVERS_INTERCONNECT_QCOM_RPM_H
+#define __DRIVERS_INTERCONNECT_QCOM_RPM_H
+
+#include <linux/soc/qcom/smd-rpm.h>
+
+bool qcom_icc_rpm_smd_available(void);
+int qcom_icc_rpm_smd_send(int ctx, int rsc_type, int id, u32 val);
+
+#endif
