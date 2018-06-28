From: Daniel Mack <daniel@zonque.org>
Subject: [PATCH v2 3/4] w1: ds2760: add devicetree matching glue
Date: Thu, 28 Jun 2018 09:55:39 +0200
Message-ID: <20180628075540.1757-4-daniel@zonque.org>
References: <20180628075540.1757-1-daniel@zonque.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180628075540.1757-1-daniel@zonque.org>
Sender: linux-kernel-owner@vger.kernel.org
To: zbr@ioremap.net, robh+dt@kernel.org, mark.rutland@arm.com, szabolcs.gyurko@tlt.hu
Cc: sre@kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, robert.jarzmik@free.fr, Daniel Mack <daniel@zonque.org>
List-Id: linux-pm@vger.kernel.org

Add an id table for ds2760 so it can be matched by the core.

Signed-off-by: Daniel Mack <daniel@zonque.org>
---
 drivers/w1/slaves/w1_ds2760.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/w1/slaves/w1_ds2760.c b/drivers/w1/slaves/w1_ds2760.c
index 26168abfb8b8..e1726a4e4b1d 100644
--- a/drivers/w1/slaves/w1_ds2760.c
+++ b/drivers/w1/slaves/w1_ds2760.c
@@ -17,6 +17,7 @@
 #include <linux/mutex.h>
 #include <linux/idr.h>
 #include <linux/gfp.h>
+#include <linux/of.h>
 
 #include <linux/w1.h>
 
@@ -157,6 +158,13 @@ static void w1_ds2760_remove_slave(struct w1_slave *sl)
 	platform_device_unregister(pdev);
 }
 
+#ifdef CONFIG_OF
+static const struct of_device_id w1_ds2760_of_ids[] = {
+	{ .compatible = "maxim,ds2760" },
+	{}
+};
+#endif
+
 static struct w1_family_ops w1_ds2760_fops = {
 	.add_slave    = w1_ds2760_add_slave,
 	.remove_slave = w1_ds2760_remove_slave,
@@ -166,6 +174,7 @@ static struct w1_family_ops w1_ds2760_fops = {
 static struct w1_family w1_ds2760_family = {
 	.fid = W1_FAMILY_DS2760,
 	.fops = &w1_ds2760_fops,
+	.of_match_table = of_match_ptr(w1_ds2760_of_ids),
 };
 module_w1_family(w1_ds2760_family);
 
-- 
2.17.1
