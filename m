From: Leonard Crestez <leonard.crestez@nxp.com>
Subject: [PATCH v2 2/5] nvmem: core: Add nvmem_cell_read_u32
Date: Fri, 14 Jul 2017 17:11:07 +0300
Message-ID: <eedf98ecb5d9d47f3c8b9ffbf58e03c7a2fb8db4.1500041281.git.leonard.crestez@nxp.com>
References: <cover.1500041281.git.leonard.crestez@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1500041281.git.leonard.crestez@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh+dt@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Mark Rutland <mark.rutland@arm.com>, =?UTF-8?q?Lothar=20Wa=C3=9Fmann?= <LW@KARO-electronics.de>
Cc: Dong Aisheng <aisheng.dong@nxp.com>, Bai Ping <ping.bai@nxp.com>, Anson Huang <Anson.Huang@nxp.com>, Octavian Purdila <octavian.purdila@nxp.com>, Fabio Estevam <fabio.estevam@nxp.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

This function does a quick and easy read of an u32 value without any
kind of resource management code on the consumer side.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
---
 drivers/nvmem/core.c           | 37 +++++++++++++++++++++++++++++++++++++
 include/linux/nvmem-consumer.h |  8 ++++++++
 2 files changed, 45 insertions(+)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 4c49285..cf2d645 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -1111,6 +1111,43 @@ int nvmem_cell_write(struct nvmem_cell *cell, void *buf, size_t len)
 EXPORT_SYMBOL_GPL(nvmem_cell_write);
 
 /**
+ * nvmem_cell_read_u32() - Read a cell value as an u32
+ *
+ * @dev: Device that requests the nvmem cell.
+ * @cell_id: Name of nvmem cell to read.
+ * @val: pointer to output value.
+ *
+ * Return: 0 on success or negative errno.
+ */
+int nvmem_cell_read_u32(struct device* dev, const char *cell_id, u32 *val)
+{
+	struct nvmem_cell *cell;
+	void *buf;
+	size_t len;
+
+	cell = nvmem_cell_get(dev, cell_id);
+	if (IS_ERR(cell))
+		return PTR_ERR(cell);
+
+	buf = nvmem_cell_read(cell, &len);
+	if (IS_ERR(buf)) {
+		nvmem_cell_put(cell);
+		return PTR_ERR(buf);
+	}
+	if (len != sizeof(*val)) {
+		kfree(buf);
+		nvmem_cell_put(cell);
+		return -EINVAL;
+	}
+	memcpy(val, buf, sizeof(*val));
+
+	kfree(buf);
+	nvmem_cell_put(cell);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(nvmem_cell_read_u32);
+
+/**
  * nvmem_device_cell_read() - Read a given nvmem device and cell
  *
  * @nvmem: nvmem device to read from.
diff --git a/include/linux/nvmem-consumer.h b/include/linux/nvmem-consumer.h
index c2256d7..a402522 100644
--- a/include/linux/nvmem-consumer.h
+++ b/include/linux/nvmem-consumer.h
@@ -36,6 +36,8 @@ void devm_nvmem_cell_put(struct device *dev, struct nvmem_cell *cell);
 void *nvmem_cell_read(struct nvmem_cell *cell, size_t *len);
 int nvmem_cell_write(struct nvmem_cell *cell, void *buf, size_t len);
 
+int nvmem_cell_read_u32(struct device* dev, const char *cell_id, u32 *val);
+
 /* direct nvmem device read/write interface */
 struct nvmem_device *nvmem_device_get(struct device *dev, const char *name);
 struct nvmem_device *devm_nvmem_device_get(struct device *dev,
@@ -85,6 +87,12 @@ static inline int nvmem_cell_write(struct nvmem_cell *cell,
 	return -ENOSYS;
 }
 
+static inline int nvmem_cell_read_u32(struct device* dev,
+				      const char *cell_id, u32 *val)
+{
+	return -ENOSYS;
+}
+
 static inline struct nvmem_device *nvmem_device_get(struct device *dev,
 						    const char *name)
 {
-- 
2.7.4
