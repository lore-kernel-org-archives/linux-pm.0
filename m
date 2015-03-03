From: Javi Merino <javi.merino@arm.com>
Subject: [PATCH] thermal: x86_pkg_temp: drop const for thermal_zone_parameters
Date: Tue,  3 Mar 2015 15:30:50 +0000
Message-ID: <1425396650-14486-1-git-send-email-javi.merino@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Javi Merino <javi.merino@arm.com>, Jean Delvare <jdelvare@suse.de>
List-Id: linux-pm@vger.kernel.org

8754d5115693 ("thermal: introduce the Power Allocator governor") dropped
the const attribute in the struct thermal_zone_device.  That means that
the thermal_zone_params pointer passed to thermal_zone_device_register()
also lost the const qualifier.  Drop the const in x86_pkg_temp_thermal.c
as well to avoid the following warning as reported by the kbuild test
robot:

   drivers/thermal/x86_pkg_temp_thermal.c: In function 'pkg_temp_thermal_device_add':
>> drivers/thermal/x86_pkg_temp_thermal.c:450:31: warning: passing argument 6 of 'thermal_zone_device_register' discards 'const' qualifier from pointer target type
       phy_dev_entry, &tzone_ops, &pkg_temp_tz_params, 0, 0);
                                  ^
   In file included from drivers/thermal/x86_pkg_temp_thermal.c:30:0:
   include/linux/thermal.h:378:29: note: expected 'struct thermal_zone_params *' but argument is of type 'const struct thermal_zone_params *'
    struct thermal_zone_device *thermal_zone_device_register(const char *, int, int,
                                ^

Cc: Jean Delvare <jdelvare@suse.de>
Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Eduardo Valentin <edubezval@gmail.com>
Signed-off-by: Javi Merino <javi.merino@arm.com>
---

This patch fixes a compiler warning in the "linus" branch of Eduardo's
tree found by the kbuild test robot.

 drivers/thermal/x86_pkg_temp_thermal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/x86_pkg_temp_thermal.c b/drivers/thermal/x86_pkg_temp_thermal.c
index 9ea3d9d49ffc..50d1d2cb091a 100644
--- a/drivers/thermal/x86_pkg_temp_thermal.c
+++ b/drivers/thermal/x86_pkg_temp_thermal.c
@@ -68,7 +68,7 @@ struct phy_dev_entry {
 	struct thermal_zone_device *tzone;
 };
 
-static const struct thermal_zone_params pkg_temp_tz_params = {
+static struct thermal_zone_params pkg_temp_tz_params = {
 	.no_hwmon	= true,
 };
 
-- 
1.9.1
