From: Wei Wang <wvw@google.com>
Subject: [PATCH] thermal: core: skip update disabled thermal zones after suspend
Date: Tue, 16 Apr 2019 10:07:01 -0700
Message-ID: <20190416170701.50333-1-wvw@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Cc: wei.vince.wang@gmail.com, Wei Wang <wvw@google.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

It is unnecessary to update disabled thermal zones post suspend and
sometimes leads error/warning in bad behaved thermal drivers.

Signed-off-by: Wei Wang <wvw@google.com>
---
 drivers/thermal/thermal_core.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 6590bb5cb688..5baf5cfab999 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1494,6 +1494,7 @@ static int thermal_pm_notify(struct notifier_block *nb,
 			     unsigned long mode, void *_unused)
 {
 	struct thermal_zone_device *tz;
+	enum thermal_device_mode tz_mode;
 
 	switch (mode) {
 	case PM_HIBERNATION_PREPARE:
@@ -1506,6 +1507,13 @@ static int thermal_pm_notify(struct notifier_block *nb,
 	case PM_POST_SUSPEND:
 		atomic_set(&in_suspend, 0);
 		list_for_each_entry(tz, &thermal_tz_list, node) {
+			tz_mode = THERMAL_DEVICE_ENABLED;
+			if (tz->ops->get_mode)
+				tz->ops->get_mode(tz, &tz_mode);
+
+			if (tz_mode == THERMAL_DEVICE_DISABLED)
+				continue;
+
 			thermal_zone_device_init(tz);
 			thermal_zone_device_update(tz,
 						   THERMAL_EVENT_UNSPECIFIED);
-- 
2.21.0.392.gf8f6787159e-goog
