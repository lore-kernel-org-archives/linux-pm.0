From: Andrey Smirnov <andrew.smirnov@gmail.com>
Subject: [PATCH] power: supply: sysfs: prevent endless uevent loop with CONFIG_POWER_SUPPLY_DEBUG
Date: Fri,  5 Apr 2019 00:30:20 -0700
Message-ID: <20190405073020.10361-1-andrew.smirnov@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>, Chris Healy <cphealy@gmail.com>, Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Fix a similar endless event loop as was done in commit 8dcf32175b4e
("i2c: prevent endless uevent loop with CONFIG_I2C_DEBUG_CORE"):

  The culprit is the dev_dbg printk in the i2c uevent handler. If
  this is activated (for instance by CONFIG_I2C_DEBUG_CORE) it results
  in an endless loop with systemd-journald.

  This happens if user-space scans the system log and reads the uevent
  file to get information about a newly created device, which seems
  fair use to me. Unfortunately reading the "uevent" file uses the
  same function that runs for creating the uevent for a new device,
  generating the next syslog entry

Both CONFIG_I2C_DEBUG_CORE and CONFIG_POWER_SUPPLY_DEBUG were reported
in https://bugs.freedesktop.org/show_bug.cgi?id=76886 but only former
seems to have been fixed. Change debug prints to use pr_debug insted
to resolve the issue.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/power/supply/power_supply_sysfs.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
index dce24f596160..5e91946731fd 100644
--- a/drivers/power/supply/power_supply_sysfs.c
+++ b/drivers/power/supply/power_supply_sysfs.c
@@ -383,14 +383,14 @@ int power_supply_uevent(struct device *dev, struct kobj_uevent_env *env)
 	char *prop_buf;
 	char *attrname;
 
-	dev_dbg(dev, "uevent\n");
+	pr_debug("%s: uevent\n", dev_name(dev));
 
 	if (!psy || !psy->desc) {
 		dev_dbg(dev, "No power supply yet\n");
 		return ret;
 	}
 
-	dev_dbg(dev, "POWER_SUPPLY_NAME=%s\n", psy->desc->name);
+	pr_debug("%s: POWER_SUPPLY_NAME=%s\n", dev_name(dev), psy->desc->name);
 
 	ret = add_uevent_var(env, "POWER_SUPPLY_NAME=%s", psy->desc->name);
 	if (ret)
@@ -427,7 +427,8 @@ int power_supply_uevent(struct device *dev, struct kobj_uevent_env *env)
 			goto out;
 		}
 
-		dev_dbg(dev, "prop %s=%s\n", attrname, prop_buf);
+		pr_debug("%s: prop %s=%s\n", dev_name(dev), attrname,
+			 prop_buf);
 
 		ret = add_uevent_var(env, "POWER_SUPPLY_%s=%s", attrname, prop_buf);
 		kfree(attrname);
-- 
2.20.1
