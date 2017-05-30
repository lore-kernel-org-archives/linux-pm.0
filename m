From: "Alex A. Mihaylov" <minimumlaw@rambler.ru>
Subject: [PATCH 1/3] regmap: Add 1-Wire bus support
Date: Tue, 30 May 2017 20:57:33 +0300
Message-ID: <20170530175735.3481-2-minimumlaw@rambler.ru>
References: <20170530175735.3481-1-minimumlaw@rambler.ru>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170530175735.3481-1-minimumlaw@rambler.ru>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>, Evgeniy Polyakov <zbr@ioremap.net>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: "Alex A. Mihaylov" <minimumlaw@rambler.ru>
List-Id: linux-pm@vger.kernel.org

Add basic support regmap (register map access) API for 1-Wire bus

Signed-off-by: Alex A. Mihaylov <minimumlaw@rambler.ru>
---
 drivers/base/regmap/Kconfig     |   6 +-
 drivers/base/regmap/Makefile    |   1 +
 drivers/base/regmap/regmap-w1.c | 239 ++++++++++++++++++++++++++++++++++++++++
 include/linux/regmap.h          |  34 ++++++
 4 files changed, 279 insertions(+), 1 deletion(-)
 create mode 100644 drivers/base/regmap/regmap-w1.c

diff --git a/drivers/base/regmap/Kconfig b/drivers/base/regmap/Kconfig
index db9d00c..413af5f 100644
--- a/drivers/base/regmap/Kconfig
+++ b/drivers/base/regmap/Kconfig
@@ -3,7 +3,7 @@
 # subsystems should select the appropriate symbols.
 
 config REGMAP
-	default y if (REGMAP_I2C || REGMAP_SPI || REGMAP_SPMI || REGMAP_AC97 || REGMAP_MMIO || REGMAP_IRQ)
+	default y if (REGMAP_I2C || REGMAP_SPI || REGMAP_SPMI || REGMAP_W1 || REGMAP_AC97 || REGMAP_MMIO || REGMAP_IRQ)
 	select LZO_COMPRESS
 	select LZO_DECOMPRESS
 	select IRQ_DOMAIN if REGMAP_IRQ
@@ -24,6 +24,10 @@ config REGMAP_SPMI
 	tristate
 	depends on SPMI
 
+config REGMAP_W1
+	tristate
+	depends on W1
+
 config REGMAP_MMIO
 	tristate
 
diff --git a/drivers/base/regmap/Makefile b/drivers/base/regmap/Makefile
index 609e4c8..17741ae 100644
--- a/drivers/base/regmap/Makefile
+++ b/drivers/base/regmap/Makefile
@@ -10,3 +10,4 @@ obj-$(CONFIG_REGMAP_SPI) += regmap-spi.o
 obj-$(CONFIG_REGMAP_SPMI) += regmap-spmi.o
 obj-$(CONFIG_REGMAP_MMIO) += regmap-mmio.o
 obj-$(CONFIG_REGMAP_IRQ) += regmap-irq.o
+obj-$(CONFIG_REGMAP_W1) += regmap-w1.o
diff --git a/drivers/base/regmap/regmap-w1.c b/drivers/base/regmap/regmap-w1.c
new file mode 100644
index 0000000..84abe13
--- /dev/null
+++ b/drivers/base/regmap/regmap-w1.c
@@ -0,0 +1,239 @@
+/*
+ * Register map access API - W1 (1-Wire) support
+ *
+ * Copyright (C) 2017 OAO Radioavionica
+ * Author: Alex A. Mihaylov <minimumlaw@rambler.ru>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation
+ */
+
+#include <linux/regmap.h>
+#include <linux/module.h>
+#include "../../w1/w1.h"
+
+#include "internal.h"
+
+#define W1_CMD_READ_DATA	0x69
+#define W1_CMD_WRITE_DATA	0x6C
+
+/*
+ * 1-Wire slaves registers with addess 8 bit and data 8 bit
+ */
+
+static int w1_reg_a8_v8_read(void *context, unsigned int reg, unsigned int *val)
+{
+	struct device *dev = context;
+	struct w1_slave *sl = container_of(dev, struct w1_slave, dev);
+	int ret = 0;
+
+	if (reg > 255)
+		return -EINVAL;
+
+	mutex_lock(&sl->master->bus_mutex);
+	if (!w1_reset_select_slave(sl)) {
+		w1_write_8(sl->master, W1_CMD_READ_DATA);
+		w1_write_8(sl->master, reg);
+		*val = w1_read_8(sl->master);
+	} else
+		ret = -ENODEV;
+	mutex_unlock(&sl->master->bus_mutex);
+
+	return ret;
+}
+
+static int w1_reg_a8_v8_write(void *context, unsigned int reg, unsigned int val)
+{
+	struct device *dev = context;
+	struct w1_slave *sl = container_of(dev, struct w1_slave, dev);
+	int ret=0;
+
+	if (reg > 255)
+		return -EINVAL;
+
+	mutex_lock(&sl->master->bus_mutex);
+	if (!w1_reset_select_slave(sl)) {
+		w1_write_8(sl->master, W1_CMD_WRITE_DATA);
+		w1_write_8(sl->master, reg);
+		w1_write_8(sl->master, val);
+	} else
+		ret = -ENODEV;
+	mutex_unlock(&sl->master->bus_mutex);
+
+	return ret;
+}
+
+/*
+ * 1-Wire slaves registers with addess 8 bit and data 16 bit
+ */
+
+static int w1_reg_a8_v16_read(void *context, unsigned int reg,
+				unsigned int *val)
+{
+	struct device *dev = context;
+	struct w1_slave *sl = container_of(dev, struct w1_slave, dev);
+	int ret = 0;
+
+	if (reg > 255)
+		return -EINVAL;
+
+	mutex_lock(&sl->master->bus_mutex);
+	if (!w1_reset_select_slave(sl)) {
+		w1_write_8(sl->master, W1_CMD_READ_DATA);
+		w1_write_8(sl->master, reg);
+		*val = w1_read_8(sl->master);
+		*val |= w1_read_8(sl->master)<<8;
+	} else
+		ret = -ENODEV;
+	mutex_unlock(&sl->master->bus_mutex);
+
+	return ret;
+}
+
+static int w1_reg_a8_v16_write(void *context, unsigned int reg,
+				unsigned int val)
+{
+	struct device *dev = context;
+	struct w1_slave *sl = container_of(dev, struct w1_slave, dev);
+	int ret = 0;
+
+	if (reg > 255)
+		return -EINVAL;
+
+	mutex_lock(&sl->master->bus_mutex);
+	if (!w1_reset_select_slave(sl)) {
+		w1_write_8(sl->master, W1_CMD_WRITE_DATA);
+		w1_write_8(sl->master, reg);
+		w1_write_8(sl->master, val & 0x00FF);
+		w1_write_8(sl->master, val>>8 & 0x00FF);
+	} else
+		ret = -ENODEV;
+	mutex_unlock(&sl->master->bus_mutex);
+
+	return ret;
+}
+
+/*
+ * 1-Wire slaves registers with addess 16 bit and data 16 bit
+ */
+
+static int w1_reg_a16_v16_read(void *context, unsigned int reg,
+				unsigned int *val)
+{
+	struct device *dev = context;
+	struct w1_slave *sl = container_of(dev, struct w1_slave, dev);
+	int ret = 0;
+
+	if (reg > 65535)
+		return -EINVAL;
+
+	mutex_lock(&sl->master->bus_mutex);
+	if (!w1_reset_select_slave(sl)) {
+		w1_write_8(sl->master, W1_CMD_READ_DATA);
+		w1_write_8(sl->master, reg & 0x00FF);
+		w1_write_8(sl->master, reg>>8 & 0x00FF);
+		*val = w1_read_8(sl->master);
+		*val |= w1_read_8(sl->master)<<8;
+	} else
+		ret = -ENODEV;
+	mutex_unlock(&sl->master->bus_mutex);
+
+	return ret;
+}
+
+static int w1_reg_a16_v16_write(void *context, unsigned int reg,
+				unsigned int val)
+{
+	struct device *dev = context;
+	struct w1_slave *sl = container_of(dev, struct w1_slave, dev);
+	int ret = 0;
+
+	if (reg > 65535)
+		return -EINVAL;
+
+	mutex_lock(&sl->master->bus_mutex);
+	if (!w1_reset_select_slave(sl)) {
+		w1_write_8(sl->master, W1_CMD_WRITE_DATA);
+		w1_write_8(sl->master, reg & 0x00FF);
+		w1_write_8(sl->master, reg>>8 & 0x00FF);
+		w1_write_8(sl->master, val & 0x00FF);
+		w1_write_8(sl->master, val>>8 & 0x00FF);
+	} else
+		ret = -ENODEV;
+	mutex_unlock(&sl->master->bus_mutex);
+
+	return ret;
+}
+
+/*
+ * Various types of supported bus addressing types
+ */
+
+static struct regmap_bus regmap_w1_bus_a8_v8 = {
+	.reg_read = w1_reg_a8_v8_read,
+	.reg_write = w1_reg_a8_v8_write,
+};
+
+static struct regmap_bus regmap_w1_bus_a8_v16 = {
+	.reg_read = w1_reg_a8_v16_read,
+	.reg_write = w1_reg_a8_v16_write,
+};
+
+static struct regmap_bus regmap_w1_bus_a16_v16 = {
+	.reg_read = w1_reg_a16_v16_read,
+	.reg_write = w1_reg_a16_v16_write,
+};
+
+static const struct regmap_bus *regmap_get_w1_bus(struct device *w1_dev,
+					const struct regmap_config *config)
+{
+	if (config->reg_bits == 8 && config->val_bits == 8)
+		return &regmap_w1_bus_a8_v8;
+
+	if (config->reg_bits == 8 && config->val_bits == 16)
+		return &regmap_w1_bus_a8_v16;
+
+	if (config->reg_bits == 16 && config->val_bits == 16)
+		return &regmap_w1_bus_a16_v16;
+
+	return ERR_PTR(-ENOTSUPP);
+}
+
+struct regmap *__regmap_init_w1(struct device *w1_dev,
+				 const struct regmap_config *config,
+				 struct lock_class_key *lock_key,
+				 const char *lock_name)
+{
+
+	const struct regmap_bus *bus = regmap_get_w1_bus(w1_dev, config);
+
+	if (IS_ERR(bus))
+		return ERR_CAST(bus);
+
+	return __regmap_init(w1_dev, bus, w1_dev, config,
+			 lock_key, lock_name);
+
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(__regmap_init_w1);
+
+struct regmap *__devm_regmap_init_w1(struct device *w1_dev,
+				 const struct regmap_config *config,
+				 struct lock_class_key *lock_key,
+				 const char *lock_name)
+{
+
+	const struct regmap_bus *bus = regmap_get_w1_bus(w1_dev, config);
+
+	if (IS_ERR(bus))
+		return ERR_CAST(bus);
+
+	return __devm_regmap_init(w1_dev, bus, w1_dev, config,
+				 lock_key, lock_name);
+
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(__devm_regmap_init_w1);
+
+MODULE_LICENSE("GPL");
diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index e886492..86eeacc 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -461,6 +461,10 @@ struct regmap *__regmap_init_spmi_ext(struct spmi_device *dev,
 				      const struct regmap_config *config,
 				      struct lock_class_key *lock_key,
 				      const char *lock_name);
+struct regmap *__regmap_init_w1(struct device *w1_dev,
+				 const struct regmap_config *config,
+				 struct lock_class_key *lock_key,
+				 const char *lock_name);
 struct regmap *__regmap_init_mmio_clk(struct device *dev, const char *clk_id,
 				      void __iomem *regs,
 				      const struct regmap_config *config,
@@ -493,6 +497,10 @@ struct regmap *__devm_regmap_init_spmi_ext(struct spmi_device *dev,
 					   const struct regmap_config *config,
 					   struct lock_class_key *lock_key,
 					   const char *lock_name);
+struct regmap *__devm_regmap_init_w1(struct device *w1_dev,
+				      const struct regmap_config *config,
+				      struct lock_class_key *lock_key,
+				      const char *lock_name);
 struct regmap *__devm_regmap_init_mmio_clk(struct device *dev,
 					   const char *clk_id,
 					   void __iomem *regs,
@@ -597,6 +605,19 @@ int regmap_attach_dev(struct device *dev, struct regmap *map,
 				dev, config)
 
 /**
+ * regmap_init_w1() - Initialise register map
+ *
+ * @w1_dev: Device that will be interacted with
+ * @config: Configuration for register map
+ *
+ * The return value will be an ERR_PTR() on error or a valid pointer to
+ * a struct regmap.
+ */
+#define regmap_init_w1(w1_dev, config)					\
+	__regmap_lockdep_wrapper(__regmap_init_w1, #config,		\
+				w1_dev, config)
+
+/**
  * regmap_init_mmio_clk() - Initialise register map with register clock
  *
  * @dev: Device that will be interacted with
@@ -712,6 +733,19 @@ bool regmap_ac97_default_volatile(struct device *dev, unsigned int reg);
 				dev, config)
 
 /**
+ * devm_regmap_init_w1() - Initialise managed register map
+ *
+ * @w1_dev: Device that will be interacted with
+ * @config: Configuration for register map
+ *
+ * The return value will be an ERR_PTR() on error or a valid pointer
+ * to a struct regmap.  The regmap will be automatically freed by the
+ * device management code.
+ */
+#define devm_regmap_init_w1(w1_dev, config)				\
+	__regmap_lockdep_wrapper(__devm_regmap_init_w1, #config,	\
+				w1_dev, config)
+/**
  * devm_regmap_init_mmio_clk() - Initialise managed register map with clock
  *
  * @dev: Device that will be interacted with
-- 
2.8.4 (Apple Git-73)
