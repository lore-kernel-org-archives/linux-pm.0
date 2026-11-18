Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.164.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794992248;
	b=q65WvYvRI1xQXKUvtnZQ/Mf4aJ5bNjbmeTm8wveg1S8XOl3aGYf/N/iHE2za5I/mEJrf
	 AAsmXl1XNTXhXKZcA3Ewi3IilsVPPpYmq6QXAnpO5bsoc2HPFaZVyYmgScLJpvjFLLpO1
	 DZORrD7lTTo7NJP7ouPQQTqalzuB9Yj3O+/3Z8jpUbCt2Lu8UmRsYbU9P9ZK17mO1zN3O
	 HY5MvSmb/jaKypPshCgHyf65gj1l3XKpjm4pft2Qfw+UJNcb+2xxsMZZw4hB/MEtEtQVR
	 WMop7ywiFUM2a7Y6crRrxbZq0F+ywrmH7eyItNiDSbzKXD9a4VMyyJobvYFmLGz8uyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794992248;
	h=DMARC-Filter:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-CM-SenderInfo:
	 X-Coremail-Antispam;
	bh=iAZMN7Pm9oQ7VRQuVrvaccvJkUSc0wcBOiaK+lOgYns=;
	b=B9+iOXA08wXVKhEI0dYDW/ut2cZM6GP3ULs/rsox1MaJTyM0Uh4FLp5Ja5rWkJE/up9C
	 lMg3wMRTxmur3p/ntYmE1eCinpTeipfuITg/rsea/lxNyxe9wlTN2igNEwWNN4p119SJa
	 sfSHvHyta0pyI1tAwBxQt5WqO1U1bsWM8vZ7gm0ej2LeFv0ZRXXjROEmZvSXhJavhgN0O
	 q5VYsPpO84J5zOfWwuCDUSRTBztsl2aI/DwV1wW0J1ck3oJq/jdDV4GJ5M1THSfldL99M
	 qLz5aJJll43SrLy4HKaA9ej/dLneGvGiGraQlaaA2De3r946rzL+0un9D3YJfikRmPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=phytium.com.cn;
	spf=pass smtp.mailfrom=phytium.com.cn;
	arc=none smtp.remote-ip=162.243.164.118
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 930A9606A325;
	Wed, 18 Nov 2026 08:57:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 930A9606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytium.com.cn
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
	by hzbj-icmmx-6 (Coremail) with UTF8SMTP id AQAAfwC3Dd10aP1qFegPAg--.59293S2;
	Wed, 18 Nov 2026 16:57:24 +0800 (CST)
Received: from phytium.com.cn (unknown [218.76.62.144])
	by mail (Coremail) with SMTP id AQAAf8DwSHVtaP1qEDv8AA--.37704S4;
	Wed, 18 Nov 2026 16:57:19 +0800 (CST)
From: Li Mingzhe <limingzhe1839@phytium.com.cn>
To: myungjoo.ham@samsung.com,
	kyungmin.park@samsung.com,
	cw00.choi@samsung.com
Cc: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Li Mingzhe <limingzhe1839@phytium.com.cn>
Subject: [PATCH 1/1] PM / devfreq: add SCMI performance protocol bridge
Date: Wed, 18 Nov 2026 16:57:15 +0800
Message-ID: <20261118085715.27400-2-limingzhe1839@phytium.com.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261118085715.27400-1-limingzhe1839@phytium.com.cn>
References: <20261118085715.27400-1-limingzhe1839@phytium.com.cn>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8DwSHVtaP1qEDv8AA--.37704S4
X-CM-SenderInfo: polpx05j2kviaytzq15k1wx33pof0zgofq/1tbiAQAODWrwzdwA4wAIsi
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=limingzhe1
	839@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW3Aw1fGFWUCw1DZFykWr17Wrg_yoWDZFWfpF
	y3Ga4rJrZ8Gw1DJw4UAw43Xr15CFs29ay5K3yjg34FvwnavF98tw1DAFyUAr1YyrWkCFy2
	qr48XayxGr18JFJanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
	DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
	UUUUU

Add a bridge that binds the SCMI performance protocol scmi_device and
exposes a devfreq-side API in include/linux/scmi-devfreq.h:

  scmi_devfreq_ready()         bound check for early probe deferral
  scmi_devfreq_domain_id()     DT clocks phandle -> perf domain id
  scmi_devfreq_opps_add()      import PERFORMANCE_DESCRIBE_LEVELS
                               into the device OPP table
  scmi_devfreq_freq_get/set()  PERFORMANCE_LEVEL_GET/SET wrappers

All functions return -EPROBE_DEFER until the bridge is bound, so
consumers (DMU/NOC devfreq, GPU and other modules) are retried
automatically. The API is generic and public so that out-of-tree
devfreq consumers can use it.

Signed-off-by: Li Mingzhe <limingzhe1839@phytium.com.cn>
---
 drivers/devfreq/Kconfig        |   9 ++
 drivers/devfreq/Makefile       |   1 +
 drivers/devfreq/scmi_devfreq.c | 205 +++++++++++++++++++++++++++++++++
 include/linux/scmi-devfreq.h   |  30 +++++
 4 files changed, 245 insertions(+)
 create mode 100644 drivers/devfreq/scmi_devfreq.c
 create mode 100644 include/linux/scmi-devfreq.h

diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
index 043ec397de52..19cd6e01561e 100644
--- a/drivers/devfreq/Kconfig
+++ b/drivers/devfreq/Kconfig
@@ -150,6 +150,15 @@ config ARM_SUN8I_A33_MBUS_DEVFREQ
 	  This adds the DEVFREQ driver for the MBUS controller in some
 	  Allwinner sun8i (A33 through H3) and sun50i (A64 and H5) SoCs.
 
+config ARM_SCMI_DEVFREQ
+	bool "SCMI performance protocol bridge for devfreq"
+	depends on ARM_SCMI_PROTOCOL
+	help
+	  Bridge owning the SCMI performance-protocol scmi_device binding
+	  on behalf of devfreq drivers whose devices are managed by SCMI
+	  performance domains.The bridge must be built-in: a devfreq device
+	  polling the bridge cannot survive the bridge being removed.
+
 config ARM_PHYTIUM_NOC_DEVFREQ
 	tristate "ARM PHYTIUM NOC DEVFREQ Driver"
 	depends on ARCH_PHYTIUM
diff --git a/drivers/devfreq/Makefile b/drivers/devfreq/Makefile
index c57455f9b481..6dd048ac6530 100644
--- a/drivers/devfreq/Makefile
+++ b/drivers/devfreq/Makefile
@@ -12,6 +12,7 @@ obj-$(CONFIG_ARM_EXYNOS_BUS_DEVFREQ)	+= exynos-bus.o
 obj-$(CONFIG_ARM_IMX_BUS_DEVFREQ)	+= imx-bus.o
 obj-$(CONFIG_ARM_IMX8M_DDRC_DEVFREQ)	+= imx8m-ddrc.o
 obj-$(CONFIG_ARM_MEDIATEK_CCI_DEVFREQ)	+= mtk-cci-devfreq.o
+obj-$(CONFIG_ARM_SCMI_DEVFREQ)	+= scmi_devfreq.o
 obj-$(CONFIG_ARM_PHYTIUM_DMU_DEVFREQ)	+= phytium_dmu.o
 obj-$(CONFIG_ARM_PHYTIUM_NOC_DEVFREQ)	+= phytium_noc.o
 obj-$(CONFIG_ARM_RK3399_DMC_DEVFREQ)	+= rk3399_dmc.o
diff --git a/drivers/devfreq/scmi_devfreq.c b/drivers/devfreq/scmi_devfreq.c
new file mode 100644
index 000000000000..147668850a7c
--- /dev/null
+++ b/drivers/devfreq/scmi_devfreq.c
@@ -0,0 +1,205 @@
+// SPDX-License-Identifier: GPL-1.0
+/*
+ * Phytium SCMI devfreq bridge
+ *
+ * Single owner of the SCMI performance-device binding for the Phytium
+ * devfreq drivers (NOC/DMU), mirroring the drivers/cpufreq/scmi-cpufreq.c
+ * pattern: bind the perf-protocol scmi_device, import its ops/handle,
+ * register the dummy clock provider required by devices whose DT
+ * "clocks" phandle points at the perf protocol node, and expose a small
+ * devfreq-side API to the platform drivers.
+ *
+ * NOTE: the devfreq users must be built-in; unbinding/rebinding the
+ * scmi_device while a devfreq device is polling is not supported.
+ */
+#include <linux/module.h>
+#include <linux/device.h>
+#include <linux/atomic.h>
+#include <linux/clk-provider.h>
+#include <linux/of.h>
+#include <linux/property.h>
+#include <linux/pm_opp.h>
+#include <linux/scmi_protocol.h>
+
+static const struct scmi_perf_proto_ops *perf_ops;
+static struct scmi_protocol_handle *scmi_ph;
+static atomic_t bridge_ready = ATOMIC_INIT(0);
+
+/*
+ * The devfreq nodes carry "clocks = <&scmi_perf id>" solely so that
+ * scmi_dev_domain_id() can parse the perf-domain id. The OPP core,
+ * however, treats any "clocks" phandle as a real clock reference and
+ * calls clk_get(dev, NULL) when creating the OPP table via
+ * dev_pm_opp_add() inside SCMI's device_opps_add(). Since protocol@13
+ * is never registered as a clock provider, that lookup would return
+ * -EPROBE_DEFER and brick the DT perf path.
+ *
+ * Mirror drivers/cpufreq/scmi-cpufreq.c:311-315: register a dummy
+ * clock provider on the sdev whose of_node IS the protocol@13 node so
+ * the clkspec lookup matches and clk_get() succeeds. clk_get()
+ * resolves to NULL (of_clk_hw_simple_get() just hands back the data
+ * pointer), which the OPP core treats as success. The perf path never
+ * uses clk_set_rate()/clk_get_rate(), so the placeholder clk is never
+ * touched afterwards.
+ */
+static void scmi_devfreq_setup_dummy_clk_provider(struct scmi_device *sdev)
+{
+	struct device *dev = &sdev->dev;
+	int ret;
+
+	if (!of_property_present(dev->of_node, "#clock-cells"))
+		return;
+
+	ret = devm_of_clk_add_hw_provider(dev, of_clk_hw_simple_get, NULL);
+	if (ret) {
+		dev_warn(dev, "devfreq bridge: failed to add dummy clk provider: %d\n",
+			 ret);
+		return;
+	}
+
+	dev_info(dev, "devfreq bridge: dummy clk provider registered on perf protocol node\n");
+}
+
+static int scmi_devfreq_scmi_probe(struct scmi_device *sdev)
+{
+	const void *ops;
+	struct scmi_protocol_handle *ph;
+
+	ops = sdev->handle->devm_protocol_get(sdev, SCMI_PROTOCOL_PERF, &ph);
+	if (IS_ERR(ops)) {
+		dev_err(&sdev->dev, "devfreq bridge: devm_protocol_get failed: %ld\n",
+			PTR_ERR(ops));
+		return PTR_ERR(ops);
+	}
+
+	perf_ops = ops;
+	scmi_ph = ph;
+
+	scmi_devfreq_setup_dummy_clk_provider(sdev);
+
+	atomic_set(&bridge_ready, 1);
+	dev_info(&sdev->dev, "devfreq bridge: SCMI perf protocol acquired, ready=%d\n",
+		 atomic_read(&bridge_ready));
+	return 0;
+}
+
+static void scmi_devfreq_scmi_remove(struct scmi_device *sdev)
+{
+	atomic_set(&bridge_ready, 0);
+	dev_warn(&sdev->dev, "devfreq bridge: SCMI perf protocol released, devfreq users will defer\n");
+}
+
+static const struct scmi_device_id scmi_devfreq_id_table[] = {
+	{ SCMI_PROTOCOL_PERF, "devfreq" },
+	/*
+	 * Claim remaining protocol@13 instances (e.g. the "cpufreq"
+	 * scmi_device after a failed cpufreq registration): an unbound
+	 * scmi_device on this of_node keeps fw_devlink holding the
+	 * devfreq nodes in deferred probe with "supplier not ready".
+	 */
+	{ SCMI_PROTOCOL_PERF, NULL },
+	{ },
+};
+MODULE_DEVICE_TABLE(scmi, scmi_devfreq_id_table);
+
+static struct scmi_driver scmi_devfreq_scmi_driver = {
+	.name		= "phytium_devfreq_scmi",
+	.probe		= scmi_devfreq_scmi_probe,
+	.remove		= scmi_devfreq_scmi_remove,
+	.id_table	= scmi_devfreq_id_table,
+};
+
+int scmi_devfreq_ready(void)
+{
+	return atomic_read(&bridge_ready);
+}
+EXPORT_SYMBOL_GPL(scmi_devfreq_ready);
+
+int scmi_devfreq_domain_id(struct device *dev)
+{
+	int ret;
+
+	if (!atomic_read(&bridge_ready))
+		return -EPROBE_DEFER;
+
+	ret = perf_ops->device_domain_id(dev);
+	dev_dbg(dev, "devfreq bridge: device_domain_id = %d\n", ret);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(scmi_devfreq_domain_id);
+
+int scmi_devfreq_opps_add(struct device *dev)
+{
+	int err, count;
+
+	if (!atomic_read(&bridge_ready))
+		return -EPROBE_DEFER;
+
+	err = perf_ops->device_opps_add(scmi_ph, dev);
+	count = dev_pm_opp_get_opp_count(dev);
+
+	if (err || count <= 0) {
+		dev_warn(dev, "devfreq bridge: device_opps_add ret = %d, opp_count = %d\n",
+			 err, count);
+		dev_pm_opp_remove_all_dynamic(dev);
+		return err ? err : -EINVAL;
+	}
+
+	dev_info(dev, "devfreq bridge: device_opps_add ret = %d, opp_count = %d\n",
+		 err, count);
+	return count;
+}
+EXPORT_SYMBOL_GPL(scmi_devfreq_opps_add);
+
+int scmi_devfreq_freq_get(u32 domain_id, unsigned long *rate)
+{
+	int err;
+
+	if (!atomic_read(&bridge_ready))
+		return -EPROBE_DEFER;
+
+	err = perf_ops->freq_get(scmi_ph, domain_id, rate, false);
+	if (err) {
+		pr_debug("devfreq bridge: freq_get failed domain=%u err=%d\n",
+			 domain_id, err);
+	}
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(scmi_devfreq_freq_get);
+
+int scmi_devfreq_freq_set(u32 domain_id, unsigned long rate)
+{
+	int err;
+
+	if (!atomic_read(&bridge_ready))
+		return -EPROBE_DEFER;
+
+	err = perf_ops->freq_set(scmi_ph, domain_id, rate, false);
+	if (err) {
+		pr_warn("devfreq bridge: freq_set FAILED domain=%u rate=%lu err=%d\n",
+			domain_id, rate, err);
+		return err;
+	}
+
+	pr_info("devfreq bridge: freq_set OK domain=%u rate=%lu Hz (%lu kHz)\n",
+		domain_id, rate, rate / 1000);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(scmi_devfreq_freq_set);
+
+static int __init scmi_devfreq_init(void)
+{
+	return scmi_register(&scmi_devfreq_scmi_driver);
+}
+
+static void __exit scmi_devfreq_exit(void)
+{
+	scmi_unregister(&scmi_devfreq_scmi_driver);
+}
+module_init(scmi_devfreq_init);
+module_exit(scmi_devfreq_exit);
+
+MODULE_DESCRIPTION("Phytium SCMI devfreq bridge (NOC/DMU perf protocol owner)");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/scmi-devfreq.h b/include/linux/scmi-devfreq.h
new file mode 100644
index 000000000000..37ef417b2bc1
--- /dev/null
+++ b/include/linux/scmi-devfreq.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_SCMI_DEVFREQ_H
+#define _LINUX_SCMI_DEVFREQ_H
+
+#include <linux/device.h>
+
+/*
+ * Phytium SCMI devfreq bridge (drivers/devfreq/scmi_devfreq.c).
+ * Single owner of the perf-protocol scmi_device for the NOC/DMU
+ * devfreq drivers. All functions return -EPROBE_DEFER until the
+ * bridge's scmi_device is bound.
+ */
+
+/* Bridge readiness check (cheap, for early defer decisions). */
+int scmi_devfreq_ready(void);
+
+/* Parse the device's clocks phandle -> perf domain id. */
+int scmi_devfreq_domain_id(struct device *dev);
+
+/* Add the domain's OPP table from PERFORMANCE_DESCRIBE_LEVELS.
+ * Returns the OPP count (> 0), or a negative errno. Cleans up its own
+ * partial OPPs on failure.
+ */
+int scmi_devfreq_opps_add(struct device *dev);
+
+/* PERFORMANCE_LEVEL_GET / PERFORMANCE_LEVEL_SET wrappers. */
+int scmi_devfreq_freq_get(u32 domain_id, unsigned long *rate);
+int scmi_devfreq_freq_set(u32 domain_id, unsigned long rate);
+
+#endif /* _LINUX_SCMI_DEVFREQ_H */
-- 
2.43.0

