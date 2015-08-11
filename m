From: Javi Merino <javi.merino@arm.com>
Subject: [PATCH v2 4/4] thermal: power_allocator: exit early if there are no cooling devices
Date: Tue, 11 Aug 2015 11:21:33 +0100
Message-ID: <1439288493-19740-5-git-send-email-javi.merino@arm.com>
References: <1439222692-3535-1-git-send-email-javi.merino@arm.com>
 <1439288493-19740-1-git-send-email-javi.merino@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1439288493-19740-1-git-send-email-javi.merino@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, cywang@chromium.org, linux-kernel@vger.kernel.org, punit.agrawal@arm.com, Javi Merino <javi.merino@arm.com>
List-Id: linux-pm@vger.kernel.org

Don't waste cycles in the power allocator governor's throttle function
if there are no cooling devices and exit early.

This commit doesn't change any functionality, but should provide better
performance for the odd case of a thermal zone with trip points but
without cooling devices.
---
 drivers/thermal/power_allocator.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/thermal/power_allocator.c b/drivers/thermal/power_allocator.c
index 38beea721e18..05a3c2f21fa6 100644
--- a/drivers/thermal/power_allocator.c
+++ b/drivers/thermal/power_allocator.c
@@ -291,6 +291,11 @@ static int allocate_power(struct thermal_zone_device *tz,
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
