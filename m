From: Daniel Mack <daniel@zonque.org>
Subject: [PATCH v3 2/4] w1: core: match sub-nodes of bus masters in devicetree
Date: Fri, 29 Jun 2018 19:31:35 +0200
Message-ID: <20180629173137.12690-3-daniel@zonque.org>
References: <20180629173137.12690-1-daniel@zonque.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180629173137.12690-1-daniel@zonque.org>
Sender: linux-kernel-owner@vger.kernel.org
To: zbr@ioremap.net, robh+dt@kernel.org, mark.rutland@arm.com, szabolcs.gyurko@tlt.hu
Cc: sre@kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, robert.jarzmik@free.fr, Daniel Mack <daniel@zonque.org>
List-Id: linux-pm@vger.kernel.org

Once a new slave device is detected, match it against all sub-nodes of the
master bus controller. If a match is found, set the slave device's of_node
pointer.

Signed-off-by: Daniel Mack <daniel@zonque.org>
---
 drivers/w1/w1.c    | 3 +++
 include/linux/w1.h | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/drivers/w1/w1.c b/drivers/w1/w1.c
index caef0e0fd817..890c038c25f8 100644
--- a/drivers/w1/w1.c
+++ b/drivers/w1/w1.c
@@ -26,6 +26,7 @@
 #include <linux/kthread.h>
 #include <linux/freezer.h>
 #include <linux/hwmon.h>
+#include <linux/of.h>
 
 #include <linux/atomic.h>
 
@@ -686,6 +687,8 @@ static int __w1_attach_slave_device(struct w1_slave *sl)
 	sl->dev.bus = &w1_bus_type;
 	sl->dev.release = &w1_slave_release;
 	sl->dev.groups = w1_slave_groups;
+	sl->dev.of_node = of_find_matching_node(sl->master->dev.of_node,
+						sl->family->of_match_table);
 
 	dev_set_name(&sl->dev, "%02x-%012llx",
 		 (unsigned int) sl->reg_num.family,
diff --git a/include/linux/w1.h b/include/linux/w1.h
index 694101f744c7..3111585c371f 100644
--- a/include/linux/w1.h
+++ b/include/linux/w1.h
@@ -274,6 +274,8 @@ struct w1_family {
 
 	struct w1_family_ops	*fops;
 
+	const struct of_device_id *of_match_table;
+
 	atomic_t		refcnt;
 };
 
-- 
2.17.1
