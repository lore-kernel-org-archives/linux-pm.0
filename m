From: David Lechner <david@lechnology.com>
Subject: [PATCH] power_supply: sysfs: ratelimit property read error message
Date: Wed, 12 Sep 2018 19:48:30 -0500
Message-ID: <20180913004830.1265-1-david@lechnology.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, David Lechner <david@lechnology.com>
List-Id: linux-pm@vger.kernel.org

This adds ratelimiting to the message that is printed when reading a
power supply property via sysfs returns an error. This will prevent
userspace applications from unintentionally dDOSing the system by
continuosuly reading a property that returns an error.

Signed-off-by: David Lechner <david@lechnology.com>
---
 drivers/power/supply/power_supply_sysfs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
index 6170ed8b6854..dce24f596160 100644
--- a/drivers/power/supply/power_supply_sysfs.c
+++ b/drivers/power/supply/power_supply_sysfs.c
@@ -131,7 +131,8 @@ static ssize_t power_supply_show_property(struct device *dev,
 				dev_dbg(dev, "driver has no data for `%s' property\n",
 					attr->attr.name);
 			else if (ret != -ENODEV && ret != -EAGAIN)
-				dev_err(dev, "driver failed to report `%s' property: %zd\n",
+				dev_err_ratelimited(dev,
+					"driver failed to report `%s' property: %zd\n",
 					attr->attr.name, ret);
 			return ret;
 		}
-- 
2.17.1
