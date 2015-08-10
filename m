From: Javi Merino <javi.merino@arm.com>
Subject: [PATCH 3/3] thermal: power_allocator: exit early if there are no cooling devices
Date: Mon, 10 Aug 2015 17:04:52 +0100
Message-ID: <1439222692-3535-4-git-send-email-javi.merino@arm.com>
References: <20150806083045.GB2640@e104805>
 <1439222692-3535-1-git-send-email-javi.merino@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1439222692-3535-1-git-send-email-javi.merino@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, linux-kernel@vger.kernel.org, punit.agrawal@arm.com, Javi Merino <javi.merino@arm.com>
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
index cb3183ec364f..58128ce11ec9 100644
--- a/drivers/thermal/power_allocator.c
+++ b/drivers/thermal/power_allocator.c
@@ -287,6 +287,11 @@ static int allocate_power(struct thermal_zone_device *tz,
 		}
 	}
 
+	if (!num_actors) {
+		ret = -ENODEV;
+		goto unlock;
+	}
+
 	/*
 	 * We need to allocate three arrays of the same size:
 	 * req_power, max_power and granted_power.  They are going to
-- 
1.9.1
