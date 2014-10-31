From: Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH 1/5] regulator: add function to determine if 2 regulators are the same
Date: Thu, 30 Oct 2014 21:27:07 -0700
Message-ID: <1414729631-11005-2-git-send-email-tharvey@gateworks.com>
References: <1414729631-11005-1-git-send-email-tharvey@gateworks.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1414729631-11005-1-git-send-email-tharvey@gateworks.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Philipp Zabel <p.zabel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Shawn Guo <shawn.guo@freescale.com>, Lucas Stach <l.stach@pengutronix.de>, Silvio F <silvio.fricke@gmail.com>, Christian Hemp <c.hemp@phytec.de>, Russell King <rmk+kernel@arm.linux.org.uk>, Iain Paton <ipaton0@gmail.com>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Regulator structures can point to the same internal regulator dev's but as
that information is private we need to expose a function to determine if
two regulators do so.

Cc: linux-pm@vger.kernel.org
Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
 drivers/regulator/core.c           | 17 +++++++++++++++++
 include/linux/regulator/consumer.h |  8 ++++++++
 2 files changed, 25 insertions(+)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index cd87c0c..6d4a627 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -2184,6 +2184,23 @@ int regulator_is_enabled(struct regulator *regulator)
 EXPORT_SYMBOL_GPL(regulator_is_enabled);
 
 /**
+ * regulator_is_same - are two regulators the same
+ * @regulator1: regulator source
+ * @regulator2: regulator source
+ *
+ * Returns positive if both regulators point to the same regulator_dev.
+ */
+int regulator_is_same(struct regulator *regulator1,
+		      struct regulator *regulator2)
+{
+	if (!regulator1 || !regulator2)
+		return -EINVAL;
+
+	return (regulator1->rdev == regulator2->rdev) ? 1 : 0;
+}
+EXPORT_SYMBOL_GPL(regulator_is_same);
+
+/**
  * regulator_can_change_voltage - check if regulator can change voltage
  * @regulator: regulator source
  *
diff --git a/include/linux/regulator/consumer.h b/include/linux/regulator/consumer.h
index d347c80..972090a 100644
--- a/include/linux/regulator/consumer.h
+++ b/include/linux/regulator/consumer.h
@@ -200,6 +200,8 @@ int __must_check regulator_enable(struct regulator *regulator);
 int regulator_disable(struct regulator *regulator);
 int regulator_force_disable(struct regulator *regulator);
 int regulator_is_enabled(struct regulator *regulator);
+int regulator_is_same(struct regulator *regulator1,
+		      struct regulator *regulator2);
 int regulator_disable_deferred(struct regulator *regulator, int ms);
 
 int __must_check regulator_bulk_get(struct device *dev, int num_consumers,
@@ -387,6 +389,12 @@ static inline int regulator_is_enabled(struct regulator *regulator)
 	return 1;
 }
 
+static inline int regulator_is_same(struct regulator *regulator1,
+				    struct regulator *regulator2)
+{
+	return 0;
+}
+
 static inline int regulator_bulk_get(struct device *dev,
 				     int num_consumers,
 				     struct regulator_bulk_data *consumers)
-- 
1.8.3.2
