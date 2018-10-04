From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH] PM / core: Clear the direct_complete flag on errors
Date: Thu, 04 Oct 2018 11:08:12 +0200
Message-ID: <61559514.Vym8FNvob2@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, LKML <linux-kernel@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Al Cooper <alcooperx@gmail.com>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

If __device_suspend() returns early on an error or pending wakeup
and the power.direct_complete flag has been set for the device
already, the subsequent device_resume() will be confused by it
and it will call pm_runtime_enable() incorrectly, as runtime PM
has not been disabled for the device by __device_suspend().

To avoid that, clear power.direct_complete if __device_suspend()
is not going to disable runtime PM for the device before returning.

Fixes: aae4518b3124 (PM / sleep: Mechanism to avoid resuming runtime-suspended devices unnecessarily)
Reported-by: Al Cooper <alcooperx@gmail.com>
Cc: 3.16+ <stable@vger.kernel.org> # 3.16+
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/base/power/main.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

Index: linux-pm/drivers/base/power/main.c
===================================================================
--- linux-pm.orig/drivers/base/power/main.c
+++ linux-pm/drivers/base/power/main.c
@@ -1713,8 +1713,10 @@ static int __device_suspend(struct devic
 
 	dpm_wait_for_subordinate(dev, async);
 
-	if (async_error)
+	if (async_error) {
+		dev->power.direct_complete = false;
 		goto Complete;
+	}
 
 	/*
 	 * If a device configured to wake up the system from sleep states
@@ -1726,6 +1728,7 @@ static int __device_suspend(struct devic
 		pm_wakeup_event(dev, 0);
 
 	if (pm_wakeup_pending()) {
+		dev->power.direct_complete = false;
 		async_error = -EBUSY;
 		goto Complete;
 	}
