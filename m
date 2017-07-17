From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH 2/2] thermal: int340x_thermal: Constify attribute_group structures.
Date: Mon, 17 Jul 2017 16:04:39 +0530
Message-ID: <fce5e6469325c6034ad71102f2a57aa0369ced41.1500287619.git.arvind.yadav.cs@gmail.com>
References: <3b42983a016cbb0d1fb3b6bab625b78abf843474.1500287619.git.arvind.yadav.cs@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3b42983a016cbb0d1fb3b6bab625b78abf843474.1500287619.git.arvind.yadav.cs@gmail.com>
In-Reply-To: <3b42983a016cbb0d1fb3b6bab625b78abf843474.1500287619.git.arvind.yadav.cs@gmail.com>
References: <3b42983a016cbb0d1fb3b6bab625b78abf843474.1500287619.git.arvind.yadav.cs@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: rui.zhang@intel.com, edubezval@gmail.com, andriy.shevchenko@linux.intel.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

attribute_groups are not supposed to change at runtime. All functions
working with attribute_groups provided by <linux/sysfs.h> work
with const attribute_group. So mark the non-const structs as const.

File size before:
   text	   data	    bss	    dec	    hex	filename
   3152	   1096	      8	   4256	   10a0	processor_thermal_device.o

File size After adding 'const':
   text	   data	    bss	    dec	    hex	filename
   3216	   1032	      8	   4256	   10a0	processor_thermal_device.o

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/thermal/int340x_thermal/processor_thermal_device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/int340x_thermal/processor_thermal_device.c b/drivers/thermal/int340x_thermal/processor_thermal_device.c
index ff3b36f..f02341f 100644
--- a/drivers/thermal/int340x_thermal/processor_thermal_device.c
+++ b/drivers/thermal/int340x_thermal/processor_thermal_device.c
@@ -127,7 +127,7 @@ enum proc_thermal_emum_mode_type {
 	NULL
 };
 
-static struct attribute_group power_limit_attribute_group = {
+static const struct attribute_group power_limit_attribute_group = {
 	.attrs = power_limit_attrs,
 	.name = "power_limits"
 };
-- 
1.9.1
