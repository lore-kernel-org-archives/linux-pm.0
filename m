From: Willy Wolff <willy.mh.wolff.ml@gmail.com>
Subject: [PATCH] thermal: power_allocator: remove early break
Date: Fri, 21 Sep 2018 14:06:09 +0100
Message-ID: <20180921130609.j3esni6xwhi2ew7d@inc028000032.lancs.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

If a trip of type critical is defined before any trip of passive
or active type, power_allocator governor will not switch on.

Signed-off-by: Willy Wolff <willy.mh.wolff.ml@gmail.com>
---
 drivers/thermal/power_allocator.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/thermal/power_allocator.c b/drivers/thermal/power_allocator.c
index 3055f9a12a17..6544b68e3ebf 100644
--- a/drivers/thermal/power_allocator.c
+++ b/drivers/thermal/power_allocator.c
@@ -496,8 +496,6 @@ static void get_governor_trips(struct thermal_zone_device *tz,
 			}
 		} else if (type == THERMAL_TRIP_ACTIVE) {
 			last_active = i;
-		} else {
-			break;
 		}
 	}
 
-- 
2.11.0
