From: Javi Merino <javi.merino@arm.com>
Subject: [PATCH v6 5/5] thermal: power_allocator: exit early if there are no cooling devices
Date: Mon, 14 Sep 2015 14:23:54 +0100
Message-ID: <1442237034-14817-6-git-send-email-javi.merino@arm.com>
References: <1441631969-3272-1-git-send-email-javi.merino@arm.com>
 <1442237034-14817-1-git-send-email-javi.merino@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1442237034-14817-1-git-send-email-javi.merino@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, cywang@chromium.org, linux-kernel@vger.kernel.org, punit.agrawal@arm.com, djkurtz@chromium.org, edubezval@gmail.com, Javi Merino <javi.merino@arm.com>, Zhang Rui <rui.zhang@intel.com>
List-Id: linux-pm@vger.kernel.org

Don't waste cycles in the power allocator governor's throttle function
if there are no cooling devices and exit early.

This commit doesn't change any functionality, but should provide better
performance for the odd case of a thermal zone with trip points but
without cooling devices.

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Eduardo Valentin <edubezval@gmail.com>
Reviewed-by: Daniel Kurtz <djkurtz@chromium.org>
Signed-off-by: Javi Merino <javi.merino@arm.com>
---
 drivers/thermal/power_allocator.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/thermal/power_allocator.c b/drivers/thermal/power_allocator.c
index 718363f5be40..7ff96270c933 100644
--- a/drivers/thermal/power_allocator.c
+++ b/drivers/thermal/power_allocator.c
@@ -346,6 +346,11 @@ static int allocate_power(struct thermal_zone_device *tz,
 		}
 	}
 
+	if (!num_actors) {
+		ret = -ENODEV;
+		goto unlock;
+	}
+
 	/*
 	 * We need to allocate five arrays of the same size:
 	 * req_power, max_power, granted_power, extra_actor_power and
-- 
1.9.1
