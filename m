From: Julia Lawall <Julia.Lawall@lip6.fr>
Subject: [PATCH] PowerCap: constify powercap_zone_ops and powercap_zone_constraint_ops structures
Date: Wed, 23 Dec 2015 22:59:55 +0100
Message-ID: <1450907995-825-1-git-send-email-Julia.Lawall@lip6.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: kernel-janitors@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

The powercap_zone_ops and powercap_zone_constraint_ops structures are never
modified, so declare them as const.

Most of the actual changes adjust indentation to accomodate the const
keyword.

Done with the help of Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 drivers/powercap/intel_rapl.c   |    4 ++--
 drivers/powercap/powercap_sys.c |   18 +++++++++---------
 include/linux/powercap.h        |    4 ++--
 3 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/powercap/intel_rapl.c b/drivers/powercap/intel_rapl.c
index 4099159..6c592dc 100644
--- a/drivers/powercap/intel_rapl.c
+++ b/drivers/powercap/intel_rapl.c
@@ -388,7 +388,7 @@ static int get_domain_enable(struct powercap_zone *power_zone, bool *mode)
 }
 
 /* per RAPL domain ops, in the order of rapl_domain_type */
-static struct powercap_zone_ops zone_ops[] = {
+static const struct powercap_zone_ops zone_ops[] = {
 	/* RAPL_DOMAIN_PACKAGE */
 	{
 		.get_energy_uj = get_energy_counter,
@@ -584,7 +584,7 @@ static int get_max_power(struct powercap_zone *power_zone, int id,
 	return ret;
 }
 
-static struct powercap_zone_constraint_ops constraint_ops = {
+static const struct powercap_zone_constraint_ops constraint_ops = {
 	.set_power_limit_uw = set_power_limit,
 	.get_power_limit_uw = get_current_power_limit,
 	.set_time_window_us = set_time_window,
diff --git a/drivers/powercap/powercap_sys.c b/drivers/powercap/powercap_sys.c
index 84419af..14bde0d 100644
--- a/drivers/powercap/powercap_sys.c
+++ b/drivers/powercap/powercap_sys.c
@@ -293,8 +293,8 @@ err_alloc:
 }
 
 static int create_constraints(struct powercap_zone *power_zone,
-				int nr_constraints,
-				struct powercap_zone_constraint_ops *const_ops)
+			int nr_constraints,
+			const struct powercap_zone_constraint_ops *const_ops)
 {
 	int i;
 	int ret = 0;
@@ -492,13 +492,13 @@ static struct class powercap_class = {
 };
 
 struct powercap_zone *powercap_register_zone(
-				struct powercap_zone *power_zone,
-				struct powercap_control_type *control_type,
-				const char *name,
-				struct powercap_zone *parent,
-				const struct powercap_zone_ops *ops,
-				int nr_constraints,
-				struct powercap_zone_constraint_ops *const_ops)
+			struct powercap_zone *power_zone,
+			struct powercap_control_type *control_type,
+			const char *name,
+			struct powercap_zone *parent,
+			const struct powercap_zone_ops *ops,
+			int nr_constraints,
+			const struct powercap_zone_constraint_ops *const_ops)
 {
 	int result;
 	int nr_attrs;
diff --git a/include/linux/powercap.h b/include/linux/powercap.h
index 4e25041..f0a4e62 100644
--- a/include/linux/powercap.h
+++ b/include/linux/powercap.h
@@ -208,7 +208,7 @@ struct powercap_zone_constraint_ops {
 struct powercap_zone_constraint {
 	int id;
 	struct powercap_zone *power_zone;
-	struct powercap_zone_constraint_ops *ops;
+	const struct powercap_zone_constraint_ops *ops;
 };
 
 
@@ -309,7 +309,7 @@ struct powercap_zone *powercap_register_zone(
 			struct powercap_zone *parent,
 			const struct powercap_zone_ops *ops,
 			int nr_constraints,
-			struct powercap_zone_constraint_ops *const_ops);
+			const struct powercap_zone_constraint_ops *const_ops);
 
 /**
 * powercap_unregister_zone() - Unregister a zone device
