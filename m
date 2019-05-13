From: Len Brown <lenb@kernel.org>
Subject: [PATCH 10/19] hwmon/coretemp: Support multi-die/package
Date: Mon, 13 May 2019 13:58:54 -0400
Message-ID: <ec2868f35113a01ff72d9041e0b97fc6a1c7df84.1557769318.git.len.brown@intel.com>
References: <7b23d2d26d717b8e14ba137c94b70943f1ae4b5c.1557769318.git.len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <7b23d2d26d717b8e14ba137c94b70943f1ae4b5c.1557769318.git.len.brown@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org, linux-hwmon@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

From: Zhang Rui <rui.zhang@intel.com>

Package temperature sensors are actually implemented in hardware per-die.

Update coretemp to be "die-aware", so it can expose mulitple sensors
per package, instead of just one.  No change to single-die/package
systems.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
Acked-by: Guenter Roeck <linux@roeck-us.net>
Cc: linux-pm@vger.kernel.org
Cc: linux-hwmon@vger.kernel.org
---
 drivers/hwmon/coretemp.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
index 5d34f7271e67..c64ce32d3214 100644
--- a/drivers/hwmon/coretemp.c
+++ b/drivers/hwmon/coretemp.c
@@ -435,7 +435,7 @@ static int chk_ucode_version(unsigned int cpu)
 
 static struct platform_device *coretemp_get_pdev(unsigned int cpu)
 {
-	int pkgid = topology_logical_package_id(cpu);
+	int pkgid = topology_logical_die_id(cpu);
 
 	if (pkgid >= 0 && pkgid < max_packages)
 		return pkg_devices[pkgid];
@@ -579,7 +579,7 @@ static struct platform_driver coretemp_driver = {
 
 static struct platform_device *coretemp_device_add(unsigned int cpu)
 {
-	int err, pkgid = topology_logical_package_id(cpu);
+	int err, pkgid = topology_logical_die_id(cpu);
 	struct platform_device *pdev;
 
 	if (pkgid < 0)
@@ -703,7 +703,7 @@ static int coretemp_cpu_offline(unsigned int cpu)
 	 * the rest.
 	 */
 	if (cpumask_empty(&pd->cpumask)) {
-		pkg_devices[topology_logical_package_id(cpu)] = NULL;
+		pkg_devices[topology_logical_die_id(cpu)] = NULL;
 		platform_device_unregister(pdev);
 		return 0;
 	}
@@ -741,7 +741,7 @@ static int __init coretemp_init(void)
 	if (!x86_match_cpu(coretemp_ids))
 		return -ENODEV;
 
-	max_packages = topology_max_packages();
+	max_packages = topology_max_packages() * topology_max_die_per_package();
 	pkg_devices = kcalloc(max_packages, sizeof(struct platform_device *),
 			      GFP_KERNEL);
 	if (!pkg_devices)
-- 
2.18.0-rc0
