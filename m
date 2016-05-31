From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCHv4 38/48] thermal: core: add a comment describing the power actor section
Date: Mon, 30 May 2016 23:18:45 -0700
Message-ID: <1464675535-2433-39-git-send-email-edubezval@gmail.com>
References: <1464675535-2433-1-git-send-email-edubezval@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1464675535-2433-1-git-send-email-edubezval@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rui Zhang <rui.zhang@intel.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Keerthy <a0393675@ti.com>, Eduardo Valentin <edubezval@gmail.com>
List-Id: linux-pm@vger.kernel.org

Simply marking the power actor section and adding a
comment describing it.

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
---
 drivers/thermal/thermal_core.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 063fb15..5ce6504 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -456,6 +456,13 @@ static void thermal_zone_device_check(struct work_struct *work)
 	thermal_zone_device_update(tz);
 }
 
+/*
+ * Power actor section: interface to power actors to estimate power
+ *
+ * Set of functions used to interact to cooling devices that know
+ * how to estimate their devices power consumption.
+ */
+
 /**
  * power_actor_get_max_power() - get the maximum power that a cdev can consume
  * @cdev:	pointer to &thermal_cooling_device
-- 
2.1.4
