From: Nicolas Boichat <drinkcat@chromium.org>
Subject: [PATCHv2 3/3] regmap: Use different lockdep class for each regmap init call
Date: Wed,  8 Jul 2015 14:30:18 +0800
Message-ID: <1436337018-32464-4-git-send-email-drinkcat@chromium.org>
References: <1436337018-32464-1-git-send-email-drinkcat@chromium.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f172.google.com ([209.85.192.172]:34828 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752705AbbGHGbf (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 8 Jul 2015 02:31:35 -0400
Received: by pdrg1 with SMTP id g1so8490260pdr.2
        for <linux-pm@vger.kernel.org>; Tue, 07 Jul 2015 23:31:35 -0700 (PDT)
In-Reply-To: <1436337018-32464-1-git-send-email-drinkcat@chromium.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Antti Palosaari <crope@iki.fi>, Ingo Molnar <mingo@redhat.com>, Arjan van de Ven <arjan@linux.intel.com>, Lars-Peter Clausen <lars@metafoo.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Anatol Pomozov <anatol.pomozov@gmail.com>, Liviu Dudau <liviu.dudau@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Nicolas Boichat <drinkcat@chromium.org>, linux-arm-kernel@lists.infradead.org, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Lee Jones <lee.jones@linaro.org>, Maxime Coquelin <maxime.coquelin@st.com>, Ajit

Lockdep validator complains about recursive locking and deadlock
when two different regmap instances are called in a nested order.
That happens anytime a regmap read/write call needs to access
another regmap.

This is because, for performance reason, lockdep groups all locks
initialized by the same mutex_init() in the same lock class.
Therefore all regmap mutexes are in the same lock class, leading
to lockdep "nested locking" warnings if a regmap accesses another
regmap.

In general, it is impossible to establish in advance the hierarchy
of regmaps, so we make sure that each regmap init call initializes
its own static lock_class_key. This is done by wrapping all
regmap_init calls into macros.

This also allows us to give meaningful names to the lock_class_key.
For example, in rt5677 case, we have in /proc/lockdep_chains:
irq_context: 0
[ffffffc0018d2198] &dev->mutex
[ffffffc0018d2198] &dev->mutex
[ffffffc001bd7f60] rt5677:5104:(&rt5677_regmap)->_lock
[ffffffc001bd7f58] rt5677:5096:(&rt5677_regmap_physical)->_lock
[ffffffc001b95448] &(&base->lock)->rlock

The above would have resulted in a lockdep recursive warning
previously. This is not the case anymore as the lockdep validator
now clearly identifies the 2 regmaps as separate.

Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
---
 drivers/base/regmap/regmap-ac97.c |  22 +++--
 drivers/base/regmap/regmap-i2c.c  |  22 +++--
 drivers/base/regmap/regmap-mmio.c |  27 ++++--
 drivers/base/regmap/regmap-spi.c  |  22 +++--
 drivers/base/regmap/regmap-spmi.c |  44 +++++----
 drivers/base/regmap/regmap.c      |  31 +++---
 include/linux/regmap.h            | 192 ++++++++++++++++++++++++++++----------
 7 files changed, 250 insertions(+), 110 deletions(-)

diff --git a/drivers/base/regmap/regmap-ac97.c b/drivers/base/regmap/regmap-ac97.c
index 8d304e2..aa631be 100644
--- a/drivers/base/regmap/regmap-ac97.c
+++ b/drivers/base/regmap/regmap-ac97.c
@@ -87,12 +87,15 @@ static const struct regmap_bus ac97_regmap_bus = {
  * The return value will be an ERR_PTR() on error or a valid pointer to
  * a struct regmap.
  */
-struct regmap *regmap_init_ac97(struct snd_ac97 *ac97,
-				const struct regmap_config *config)
+struct regmap *__regmap_init_ac97(struct snd_ac97 *ac97,
+				  const struct regmap_config *config,
+				  struct lock_class_key *lock_key,
+				  const char *lock_name)
 {
-	return regmap_init(&ac97->dev, &ac97_regmap_bus, ac97, config);
+	return __regmap_init(&ac97->dev, &ac97_regmap_bus, ac97, config,
+			     lock_key, lock_name);
 }
-EXPORT_SYMBOL_GPL(regmap_init_ac97);
+EXPORT_SYMBOL_GPL(__regmap_init_ac97);
 
 /**
  * devm_regmap_init_ac97(): Initialise AC'97 register map
@@ -104,11 +107,14 @@ EXPORT_SYMBOL_GPL(regmap_init_ac97);
  * to a struct regmap.  The regmap will be automatically freed by the
  * device management code.
  */
-struct regmap *devm_regmap_init_ac97(struct snd_ac97 *ac97,
-				     const struct regmap_config *config)
+struct regmap *__devm_regmap_init_ac97(struct snd_ac97 *ac97,
+				       const struct regmap_config *config,
+				       struct lock_class_key *lock_key,
+				       const char *lock_name)
 {
-	return devm_regmap_init(&ac97->dev, &ac97_regmap_bus, ac97, config);
+	return __devm_regmap_init(&ac97->dev, &ac97_regmap_bus, ac97, config,
+				  lock_key, lock_name);
 }
-EXPORT_SYMBOL_GPL(devm_regmap_init_ac97);
+EXPORT_SYMBOL_GPL(__devm_regmap_init_ac97);
 
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/base/regmap/regmap-i2c.c b/drivers/base/regmap/regmap-i2c.c
index 4b76e33..3163b22 100644
--- a/drivers/base/regmap/regmap-i2c.c
+++ b/drivers/base/regmap/regmap-i2c.c
@@ -242,17 +242,20 @@ static const struct regmap_bus *regmap_get_i2c_bus(struct i2c_client *i2c,
  * The return value will be an ERR_PTR() on error or a valid pointer to
  * a struct regmap.
  */
-struct regmap *regmap_init_i2c(struct i2c_client *i2c,
-			       const struct regmap_config *config)
+struct regmap *__regmap_init_i2c(struct i2c_client *i2c,
+				 const struct regmap_config *config,
+				 struct lock_class_key *lock_key,
+				 const char *lock_name)
 {
 	const struct regmap_bus *bus = regmap_get_i2c_bus(i2c, config);
 
 	if (IS_ERR(bus))
 		return ERR_CAST(bus);
 
-	return regmap_init(&i2c->dev, bus, &i2c->dev, config);
+	return __regmap_init(&i2c->dev, bus, &i2c->dev, config,
+			     lock_key, lock_name);
 }
-EXPORT_SYMBOL_GPL(regmap_init_i2c);
+EXPORT_SYMBOL_GPL(__regmap_init_i2c);
 
 /**
  * devm_regmap_init_i2c(): Initialise managed register map
@@ -264,16 +267,19 @@ EXPORT_SYMBOL_GPL(regmap_init_i2c);
  * to a struct regmap.  The regmap will be automatically freed by the
  * device management code.
  */
-struct regmap *devm_regmap_init_i2c(struct i2c_client *i2c,
-				    const struct regmap_config *config)
+struct regmap *__devm_regmap_init_i2c(struct i2c_client *i2c,
+				      const struct regmap_config *config,
+				      struct lock_class_key *lock_key,
+				      const char *lock_name)
 {
 	const struct regmap_bus *bus = regmap_get_i2c_bus(i2c, config);
 
 	if (IS_ERR(bus))
 		return ERR_CAST(bus);
 
-	return devm_regmap_init(&i2c->dev, bus, &i2c->dev, config);
+	return __devm_regmap_init(&i2c->dev, bus, &i2c->dev, config,
+				  lock_key, lock_name);
 }
-EXPORT_SYMBOL_GPL(devm_regmap_init_i2c);
+EXPORT_SYMBOL_GPL(__devm_regmap_init_i2c);
 
 MODULE_LICENSE("GPL");
diff --git a/drivers/base/regmap/regmap-mmio.c b/drivers/base/regmap/regmap-mmio.c
index 04a329a..a1b2b27 100644
--- a/drivers/base/regmap/regmap-mmio.c
+++ b/drivers/base/regmap/regmap-mmio.c
@@ -307,9 +307,11 @@ err_free:
  * The return value will be an ERR_PTR() on error or a valid pointer to
  * a struct regmap.
  */
-struct regmap *regmap_init_mmio_clk(struct device *dev, const char *clk_id,
-				    void __iomem *regs,
-				    const struct regmap_config *config)
+struct regmap *__regmap_init_mmio_clk(struct device *dev, const char *clk_id,
+				      void __iomem *regs,
+				      const struct regmap_config *config,
+				      struct lock_class_key *lock_key,
+				      const char *lock_name)
 {
 	struct regmap_mmio_context *ctx;
 
@@ -317,9 +319,10 @@ struct regmap *regmap_init_mmio_clk(struct device *dev, const char *clk_id,
 	if (IS_ERR(ctx))
 		return ERR_CAST(ctx);
 
-	return regmap_init(dev, &regmap_mmio, ctx, config);
+	return __regmap_init(dev, &regmap_mmio, ctx, config,
+			     lock_key, lock_name);
 }
-EXPORT_SYMBOL_GPL(regmap_init_mmio_clk);
+EXPORT_SYMBOL_GPL(__regmap_init_mmio_clk);
 
 /**
  * devm_regmap_init_mmio_clk(): Initialise managed register map with clock
@@ -333,9 +336,12 @@ EXPORT_SYMBOL_GPL(regmap_init_mmio_clk);
  * to a struct regmap.  The regmap will be automatically freed by the
  * device management code.
  */
-struct regmap *devm_regmap_init_mmio_clk(struct device *dev, const char *clk_id,
-					 void __iomem *regs,
-					 const struct regmap_config *config)
+struct regmap *__devm_regmap_init_mmio_clk(struct device *dev,
+					   const char *clk_id,
+					   void __iomem *regs,
+					   const struct regmap_config *config,
+					   struct lock_class_key *lock_key,
+					   const char *lock_name)
 {
 	struct regmap_mmio_context *ctx;
 
@@ -343,8 +349,9 @@ struct regmap *devm_regmap_init_mmio_clk(struct device *dev, const char *clk_id,
 	if (IS_ERR(ctx))
 		return ERR_CAST(ctx);
 
-	return devm_regmap_init(dev, &regmap_mmio, ctx, config);
+	return __devm_regmap_init(dev, &regmap_mmio, ctx, config,
+				  lock_key, lock_name);
 }
-EXPORT_SYMBOL_GPL(devm_regmap_init_mmio_clk);
+EXPORT_SYMBOL_GPL(__devm_regmap_init_mmio_clk);
 
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/base/regmap/regmap-spi.c b/drivers/base/regmap/regmap-spi.c
index 53d1148..4c7850d 100644
--- a/drivers/base/regmap/regmap-spi.c
+++ b/drivers/base/regmap/regmap-spi.c
@@ -122,12 +122,15 @@ static struct regmap_bus regmap_spi = {
  * The return value will be an ERR_PTR() on error or a valid pointer to
  * a struct regmap.
  */
-struct regmap *regmap_init_spi(struct spi_device *spi,
-			       const struct regmap_config *config)
+struct regmap *__regmap_init_spi(struct spi_device *spi,
+				 const struct regmap_config *config,
+				 struct lock_class_key *lock_key,
+				 const char *lock_name)
 {
-	return regmap_init(&spi->dev, &regmap_spi, &spi->dev, config);
+	return __regmap_init(&spi->dev, &regmap_spi, &spi->dev, config,
+			     lock_key, lock_name);
 }
-EXPORT_SYMBOL_GPL(regmap_init_spi);
+EXPORT_SYMBOL_GPL(__regmap_init_spi);
 
 /**
  * devm_regmap_init_spi(): Initialise register map
@@ -139,11 +142,14 @@ EXPORT_SYMBOL_GPL(regmap_init_spi);
  * to a struct regmap.  The map will be automatically freed by the
  * device management code.
  */
-struct regmap *devm_regmap_init_spi(struct spi_device *spi,
-				    const struct regmap_config *config)
+struct regmap *__devm_regmap_init_spi(struct spi_device *spi,
+				      const struct regmap_config *config,
+				      struct lock_class_key *lock_key,
+				      const char *lock_name)
 {
-	return devm_regmap_init(&spi->dev, &regmap_spi, &spi->dev, config);
+	return __devm_regmap_init(&spi->dev, &regmap_spi, &spi->dev, config,
+				  lock_key, lock_name);
 }
-EXPORT_SYMBOL_GPL(devm_regmap_init_spi);
+EXPORT_SYMBOL_GPL(__devm_regmap_init_spi);
 
 MODULE_LICENSE("GPL");
diff --git a/drivers/base/regmap/regmap-spmi.c b/drivers/base/regmap/regmap-spmi.c
index d7026dc..7f50f58 100644
--- a/drivers/base/regmap/regmap-spmi.c
+++ b/drivers/base/regmap/regmap-spmi.c
@@ -99,12 +99,15 @@ static struct regmap_bus regmap_spmi_base = {
  * The return value will be an ERR_PTR() on error or a valid pointer to
  * a struct regmap.
  */
-struct regmap *regmap_init_spmi_base(struct spmi_device *sdev,
-				     const struct regmap_config *config)
+struct regmap *__regmap_init_spmi_base(struct spmi_device *sdev,
+				       const struct regmap_config *config,
+				       struct lock_class_key *lock_key,
+				       const char *lock_name)
 {
-	return regmap_init(&sdev->dev, &regmap_spmi_base, sdev, config);
+	return __regmap_init(&sdev->dev, &regmap_spmi_base, sdev, config,
+			     lock_key, lock_name);
 }
-EXPORT_SYMBOL_GPL(regmap_init_spmi_base);
+EXPORT_SYMBOL_GPL(__regmap_init_spmi_base);
 
 /**
  * devm_regmap_init_spmi_base(): Create managed regmap for Base register space
@@ -115,12 +118,15 @@ EXPORT_SYMBOL_GPL(regmap_init_spmi_base);
  * to a struct regmap.  The regmap will be automatically freed by the
  * device management code.
  */
-struct regmap *devm_regmap_init_spmi_base(struct spmi_device *sdev,
-					  const struct regmap_config *config)
+struct regmap *__devm_regmap_init_spmi_base(struct spmi_device *sdev,
+					    const struct regmap_config *config,
+					    struct lock_class_key *lock_key,
+					    const char *lock_name)
 {
-	return devm_regmap_init(&sdev->dev, &regmap_spmi_base, sdev, config);
+	return __devm_regmap_init(&sdev->dev, &regmap_spmi_base, sdev, config,
+				  lock_key, lock_name);
 }
-EXPORT_SYMBOL_GPL(devm_regmap_init_spmi_base);
+EXPORT_SYMBOL_GPL(__devm_regmap_init_spmi_base);
 
 static int regmap_spmi_ext_read(void *context,
 				const void *reg, size_t reg_size,
@@ -230,12 +236,15 @@ static struct regmap_bus regmap_spmi_ext = {
  * The return value will be an ERR_PTR() on error or a valid pointer to
  * a struct regmap.
  */
-struct regmap *regmap_init_spmi_ext(struct spmi_device *sdev,
-				    const struct regmap_config *config)
+struct regmap *__regmap_init_spmi_ext(struct spmi_device *sdev,
+				      const struct regmap_config *config,
+				      struct lock_class_key *lock_key,
+				      const char *lock_name)
 {
-	return regmap_init(&sdev->dev, &regmap_spmi_ext, sdev, config);
+	return __regmap_init(&sdev->dev, &regmap_spmi_ext, sdev, config,
+			     lock_key, lock_name);
 }
-EXPORT_SYMBOL_GPL(regmap_init_spmi_ext);
+EXPORT_SYMBOL_GPL(__regmap_init_spmi_ext);
 
 /**
  * devm_regmap_init_spmi_ext(): Create managed regmap for Ext register space
@@ -246,11 +255,14 @@ EXPORT_SYMBOL_GPL(regmap_init_spmi_ext);
  * to a struct regmap.  The regmap will be automatically freed by the
  * device management code.
  */
-struct regmap *devm_regmap_init_spmi_ext(struct spmi_device *sdev,
-				     const struct regmap_config *config)
+struct regmap *__devm_regmap_init_spmi_ext(struct spmi_device *sdev,
+					   const struct regmap_config *config,
+					   struct lock_class_key *lock_key,
+					   const char *lock_name)
 {
-	return devm_regmap_init(&sdev->dev, &regmap_spmi_ext, sdev, config);
+	return __devm_regmap_init(&sdev->dev, &regmap_spmi_ext, sdev, config,
+				  lock_key, lock_name);
 }
-EXPORT_SYMBOL_GPL(devm_regmap_init_spmi_ext);
+EXPORT_SYMBOL_GPL(__devm_regmap_init_spmi_ext);
 
 MODULE_LICENSE("GPL");
diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index 7111d04..b9fddcc 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -527,10 +527,12 @@ EXPORT_SYMBOL_GPL(regmap_get_val_endian);
  * a struct regmap.  This function should generally not be called
  * directly, it should be called by bus-specific init functions.
  */
-struct regmap *regmap_init(struct device *dev,
-			   const struct regmap_bus *bus,
-			   void *bus_context,
-			   const struct regmap_config *config)
+struct regmap *__regmap_init(struct device *dev,
+			     const struct regmap_bus *bus,
+			     void *bus_context,
+			     const struct regmap_config *config,
+			     struct lock_class_key *lock_key,
+			     const char *lock_name)
 {
 	struct regmap *map;
 	int ret = -EINVAL;
@@ -556,10 +558,14 @@ struct regmap *regmap_init(struct device *dev,
 			spin_lock_init(&map->spinlock);
 			map->lock = regmap_lock_spinlock;
 			map->unlock = regmap_unlock_spinlock;
+			lockdep_set_class_and_name(&map->spinlock,
+						   lock_key, lock_name);
 		} else {
 			mutex_init(&map->mutex);
 			map->lock = regmap_lock_mutex;
 			map->unlock = regmap_unlock_mutex;
+			lockdep_set_class_and_name(&map->mutex,
+						   lock_key, lock_name);
 		}
 		map->lock_arg = map;
 	}
@@ -899,7 +905,7 @@ err_map:
 err:
 	return ERR_PTR(ret);
 }
-EXPORT_SYMBOL_GPL(regmap_init);
+EXPORT_SYMBOL_GPL(__regmap_init);
 
 static void devm_regmap_release(struct device *dev, void *res)
 {
@@ -919,10 +925,12 @@ static void devm_regmap_release(struct device *dev, void *res)
  * directly, it should be called by bus-specific init functions.  The
  * map will be automatically freed by the device management code.
  */
-struct regmap *devm_regmap_init(struct device *dev,
-				const struct regmap_bus *bus,
-				void *bus_context,
-				const struct regmap_config *config)
+struct regmap *__devm_regmap_init(struct device *dev,
+				  const struct regmap_bus *bus,
+				  void *bus_context,
+				  const struct regmap_config *config,
+				  struct lock_class_key *lock_key,
+				  const char *lock_name)
 {
 	struct regmap **ptr, *regmap;
 
@@ -930,7 +938,8 @@ struct regmap *devm_regmap_init(struct device *dev,
 	if (!ptr)
 		return ERR_PTR(-ENOMEM);
 
-	regmap = regmap_init(dev, bus, bus_context, config);
+	regmap = __regmap_init(dev, bus, bus_context, config,
+			       lock_key, lock_name);
 	if (!IS_ERR(regmap)) {
 		*ptr = regmap;
 		devres_add(dev, ptr);
@@ -940,7 +949,7 @@ struct regmap *devm_regmap_init(struct device *dev,
 
 	return regmap;
 }
-EXPORT_SYMBOL_GPL(devm_regmap_init);
+EXPORT_SYMBOL_GPL(__devm_regmap_init);
 
 static void regmap_field_init(struct regmap_field *rm_field,
 	struct regmap *regmap, struct reg_field reg_field)
diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index 59c55ea..5d70272 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -17,6 +17,7 @@
 #include <linux/rbtree.h>
 #include <linux/err.h>
 #include <linux/bug.h>
+#include <linux/lockdep.h>
 
 struct module;
 struct device;
@@ -324,46 +325,147 @@ struct regmap_bus {
 	enum regmap_endian val_format_endian_default;
 };
 
-struct regmap *regmap_init(struct device *dev,
-			   const struct regmap_bus *bus,
-			   void *bus_context,
-			   const struct regmap_config *config);
-int regmap_attach_dev(struct device *dev, struct regmap *map,
-				 const struct regmap_config *config);
-struct regmap *regmap_init_i2c(struct i2c_client *i2c,
-			       const struct regmap_config *config);
-struct regmap *regmap_init_spi(struct spi_device *dev,
-			       const struct regmap_config *config);
-struct regmap *regmap_init_spmi_base(struct spmi_device *dev,
-				     const struct regmap_config *config);
-struct regmap *regmap_init_spmi_ext(struct spmi_device *dev,
-				    const struct regmap_config *config);
-struct regmap *regmap_init_mmio_clk(struct device *dev, const char *clk_id,
-				    void __iomem *regs,
-				    const struct regmap_config *config);
-struct regmap *regmap_init_ac97(struct snd_ac97 *ac97,
-				const struct regmap_config *config);
-
-struct regmap *devm_regmap_init(struct device *dev,
-				const struct regmap_bus *bus,
-				void *bus_context,
-				const struct regmap_config *config);
-struct regmap *devm_regmap_init_i2c(struct i2c_client *i2c,
-				    const struct regmap_config *config);
-struct regmap *devm_regmap_init_spi(struct spi_device *dev,
-				    const struct regmap_config *config);
-struct regmap *devm_regmap_init_spmi_base(struct spmi_device *dev,
-					  const struct regmap_config *config);
-struct regmap *devm_regmap_init_spmi_ext(struct spmi_device *dev,
-					 const struct regmap_config *config);
-struct regmap *devm_regmap_init_mmio_clk(struct device *dev, const char *clk_id,
-					 void __iomem *regs,
-					 const struct regmap_config *config);
-struct regmap *devm_regmap_init_ac97(struct snd_ac97 *ac97,
-				     const struct regmap_config *config);
+/*
+ * __regmap_init functions.
+ *
+ * These functions take a lock key and name parameter, and should not be called
+ * directly. Instead, use the regmap_init macros that generate a key and name
+ * for each call.
+ */
+struct regmap *__regmap_init(struct device *dev,
+			     const struct regmap_bus *bus,
+			     void *bus_context,
+			     const struct regmap_config *config,
+			     struct lock_class_key *lock_key,
+			     const char *lock_name);
+struct regmap *__regmap_init_i2c(struct i2c_client *i2c,
+				 const struct regmap_config *config,
+				 struct lock_class_key *lock_key,
+				 const char *lock_name);
+struct regmap *__regmap_init_spi(struct spi_device *dev,
+				 const struct regmap_config *config,
+				 struct lock_class_key *lock_key,
+				 const char *lock_name);
+struct regmap *__regmap_init_spmi_base(struct spmi_device *dev,
+				       const struct regmap_config *config,
+				       struct lock_class_key *lock_key,
+				       const char *lock_name);
+struct regmap *__regmap_init_spmi_ext(struct spmi_device *dev,
+				      const struct regmap_config *config,
+				      struct lock_class_key *lock_key,
+				      const char *lock_name);
+struct regmap *__regmap_init_mmio_clk(struct device *dev, const char *clk_id,
+				      void __iomem *regs,
+				      const struct regmap_config *config,
+				      struct lock_class_key *lock_key,
+				      const char *lock_name);
+struct regmap *__regmap_init_ac97(struct snd_ac97 *ac97,
+				  const struct regmap_config *config,
+				  struct lock_class_key *lock_key,
+				  const char *lock_name);
+
+struct regmap *__devm_regmap_init(struct device *dev,
+				  const struct regmap_bus *bus,
+				  void *bus_context,
+				  const struct regmap_config *config,
+				  struct lock_class_key *lock_key,
+				  const char *lock_name);
+struct regmap *__devm_regmap_init_i2c(struct i2c_client *i2c,
+				      const struct regmap_config *config,
+				      struct lock_class_key *lock_key,
+				      const char *lock_name);
+struct regmap *__devm_regmap_init_spi(struct spi_device *dev,
+				      const struct regmap_config *config,
+				      struct lock_class_key *lock_key,
+				      const char *lock_name);
+struct regmap *__devm_regmap_init_spmi_base(struct spmi_device *dev,
+					    const struct regmap_config *config,
+					    struct lock_class_key *lock_key,
+					    const char *lock_name);
+struct regmap *__devm_regmap_init_spmi_ext(struct spmi_device *dev,
+					   const struct regmap_config *config,
+					   struct lock_class_key *lock_key,
+					   const char *lock_name);
+struct regmap *__devm_regmap_init_mmio_clk(struct device *dev,
+					   const char *clk_id,
+					   void __iomem *regs,
+					   const struct regmap_config *config,
+					   struct lock_class_key *lock_key,
+					   const char *lock_name);
+struct regmap *__devm_regmap_init_ac97(struct snd_ac97 *ac97,
+				       const struct regmap_config *config,
+				       struct lock_class_key *lock_key,
+				       const char *lock_name);
 
+/*
+ * Wrapper for regmap_init macros to include a unique lockdep key and name
+ * for each call. No-op if CONFIG_LOCKDEP is not set.
+ *
+ * @fn: Real function to call (in the form __[*_]regmap_init[_*])
+ * @name: Config variable name (#config in the calling macro)
+ **/
+#ifdef CONFIG_LOCKDEP
+#define __regmap_lockdep_wrapper(fn, name, ...)				\
+(									\
+	({								\
+		static struct lock_class_key _key;			\
+		fn(__VA_ARGS__, &_key,					\
+			KBUILD_BASENAME ":"				\
+			__stringify(__LINE__) ":"			\
+			"(" name ")->lock");				\
+	})								\
+)
+#else
+#define __regmap_lockdep_wrapper(fn, name, ...) fn(__VA_ARGS__, NULL, NULL)
+#endif
+
+#define regmap_init(dev, bus, bus_context, config)			\
+	__regmap_lockdep_wrapper(__regmap_init, #config,		\
+				dev, bus, bus_context, config)
+int regmap_attach_dev(struct device *dev, struct regmap *map,
+		      const struct regmap_config *config);
+#define regmap_init_i2c(i2c, config)					\
+	__regmap_lockdep_wrapper(__regmap_init_i2c, #config,		\
+				i2c, config)
+#define regmap_init_spi(dev, config)					\
+	__regmap_lockdep_wrapper(__regmap_init_spi, #config,		\
+				dev, config)
+#define regmap_init_spmi_base(dev, config)				\
+	__regmap_lockdep_wrapper(__regmap_init_spmi_base, #config,	\
+				dev, config)
+#define regmap_init_spmi_ext(dev, config)				\
+	__regmap_lockdep_wrapper(__regmap_init_spmi_ext, #config,	\
+				dev, config)
+#define regmap_init_mmio_clk(dev, clk_id, regs, config)			\
+	__regmap_lockdep_wrapper(__regmap_init_mmio_clk, #config,	\
+				dev, clk_id, regs, config)
+#define regmap_init_ac97(ac97, config)					\
+	__regmap_lockdep_wrapper(__regmap_init_ac97, #config,		\
+				ac97, config)
 bool regmap_ac97_default_volatile(struct device *dev, unsigned int reg);
 
+#define devm_regmap_init(dev, bus, bus_context, config)			\
+	__regmap_lockdep_wrapper(__devm_regmap_init, #config,		\
+				dev, bus, bus_context, config)
+#define devm_regmap_init_i2c(i2c, config)				\
+	__regmap_lockdep_wrapper(__devm_regmap_init_i2c, #config,	\
+				i2c, config)
+#define devm_regmap_init_spi(dev, config)				\
+	__regmap_lockdep_wrapper(__devm_regmap_init_spi, #config,	\
+				dev, config)
+#define devm_regmap_init_spmi_base(dev, config)				\
+	__regmap_lockdep_wrapper(__devm_regmap_init_spmi_base, #config,	\
+				dev, config)
+#define devm_regmap_init_spmi_ext(dev, config)				\
+	__regmap_lockdep_wrapper(__devm_regmap_init_spmi_ext, #config,	\
+				dev, config)
+#define devm_regmap_init_mmio_clk(dev, clk_id, regs, config)		\
+	__regmap_lockdep_wrapper(__devm_regmap_init_mmio_clk, #config,	\
+				dev, clk_id, regs, config)
+#define devm_regmap_init_ac97(ac97, config)				\
+	__regmap_lockdep_wrapper(__devm_regmap_init_ac97, #config,	\
+				ac97, config)
+
 /**
  * regmap_init_mmio(): Initialise register map
  *
@@ -374,12 +476,8 @@ bool regmap_ac97_default_volatile(struct device *dev, unsigned int reg);
  * The return value will be an ERR_PTR() on error or a valid pointer to
  * a struct regmap.
  */
-static inline struct regmap *regmap_init_mmio(struct device *dev,
-					void __iomem *regs,
-					const struct regmap_config *config)
-{
-	return regmap_init_mmio_clk(dev, NULL, regs, config);
-}
+#define regmap_init_mmio(dev, regs, config)		\
+	regmap_init_mmio_clk(dev, NULL, regs, config)
 
 /**
  * devm_regmap_init_mmio(): Initialise managed register map
@@ -392,12 +490,8 @@ static inline struct regmap *regmap_init_mmio(struct device *dev,
  * to a struct regmap.  The regmap will be automatically freed by the
  * device management code.
  */
-static inline struct regmap *devm_regmap_init_mmio(struct device *dev,
-					void __iomem *regs,
-					const struct regmap_config *config)
-{
-	return devm_regmap_init_mmio_clk(dev, NULL, regs, config);
-}
+#define devm_regmap_init_mmio(dev, regs, config)		\
+	devm_regmap_init_mmio_clk(dev, NULL, regs, config)
 
 void regmap_exit(struct regmap *map);
 int regmap_reinit_cache(struct regmap *map,
-- 
2.4.3.573.g4eafbef

