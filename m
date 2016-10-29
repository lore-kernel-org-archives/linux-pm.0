From: Julia Lawall <Julia.Lawall@lip6.fr>
Subject: [PATCH 07/15] thermal: hwmon: use permission-specific DEVICE_ATTR variants
Date: Sat, 29 Oct 2016 21:37:01 +0200
Message-ID: <1477769829-22230-8-git-send-email-Julia.Lawall@lip6.fr>
References: <1477769829-22230-1-git-send-email-Julia.Lawall@lip6.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1477769829-22230-1-git-send-email-Julia.Lawall@lip6.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: kernel-janitors@vger.kernel.org, Eduardo Valentin <edubezval@gmail.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Use DEVICE_ATTR_RO for read only attributes.  This simplifies the
source code, improves readbility, and reduces the chance of
inconsistencies.

The semantic patch that makes this change is as follows:
(http://coccinelle.lip6.fr/)

// <smpl>
@ro@
declarer name DEVICE_ATTR;
identifier x,x_show;
@@

DEVICE_ATTR(x, \(0444\|S_IRUGO\), x_show, NULL);

@script:ocaml@
x << ro.x;
x_show << ro.x_show;
@@

if not (x^"_show" = x_show) then Coccilib.include_match false

@@
declarer name DEVICE_ATTR_RO;
identifier ro.x,ro.x_show;
@@

- DEVICE_ATTR(x, \(0444\|S_IRUGO\), x_show, NULL);
+ DEVICE_ATTR_RO(x);
// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 drivers/thermal/thermal_hwmon.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/thermal_hwmon.c b/drivers/thermal/thermal_hwmon.c
index c41c774..8c45de6 100644
--- a/drivers/thermal/thermal_hwmon.c
+++ b/drivers/thermal/thermal_hwmon.c
@@ -64,7 +64,7 @@ struct thermal_hwmon_temp {
 	struct thermal_hwmon_device *hwmon = dev_get_drvdata(dev);
 	return sprintf(buf, "%s\n", hwmon->type);
 }
-static DEVICE_ATTR(name, 0444, name_show, NULL);
+static DEVICE_ATTR_RO(name);
 
 static ssize_t
 temp_input_show(struct device *dev, struct device_attribute *attr, char *buf)
