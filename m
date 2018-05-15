From: Thomas Martitz <kugel@rockbox.org>
Subject: [PATCH] PM/ runtime: fix resume from suspend on newer hp zbook/elitebook
Date: Tue, 15 May 2018 15:35:08 +0200
Message-ID: <20180515133508.2913-1-kugel@rockbox.org>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Thomas Martitz <kugel@rockbox.org>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

In 08810a4119aaebf6318f209ec5dd9828e969cba4 setting
dev->power.direct_complete was made conditional on
pm_runtime_suspended().

The justification was:
    While at it, make the core check pm_runtime_suspended() when
    setting power.direct_complete so that it doesn't need to be
    checked by ->prepare callbacks.

However, this breaks resuming from suspend on those newer HP laptops
if the amdgpu driver is used (due to hybrid intel+radeon graphics). Given
the justification for the change, undoing it seems best as it
appears to have unintended side effects.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=199693
References: https://bugs.freedesktop.org/show_bug.cgi?id=106447
Signed-off-by: Thomas Martitz <kugel@rockbox.org>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Len Brown <len.brown@intel.com>
Cc: <linux-pm@vger.kernel.org>
Cc: <stable@vger.kernel.org> [4.15+]
Signed-off-by: Thomas Martitz <kugel@rockbox.org>
---
 drivers/base/power/main.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index 02a497e7c785..b2fb0974f832 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -1960,8 +1960,7 @@ static int device_prepare(struct device *dev, pm_message_t state)
 	 */
 	spin_lock_irq(&dev->power.lock);
 	dev->power.direct_complete = state.event == PM_EVENT_SUSPEND &&
-		pm_runtime_suspended(dev) && ret > 0 &&
-		!dev_pm_test_driver_flags(dev, DPM_FLAG_NEVER_SKIP);
+		ret > 0 && !dev_pm_test_driver_flags(dev, DPM_FLAG_NEVER_SKIP);
 	spin_unlock_irq(&dev->power.lock);
 	return 0;
 }
-- 
2.17.0
