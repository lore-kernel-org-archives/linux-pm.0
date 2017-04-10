From: Johan Hovold <johan@kernel.org>
Subject: [PATCH 2/2] PM / Runtime: document autosuspend-helper side effects
Date: Mon, 10 Apr 2017 13:38:25 +0200
Message-ID: <20170410113825.17399-2-johan@kernel.org>
References: <20170410113825.17399-1-johan@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170410113825.17399-1-johan@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Alan Stern <stern@rowland.harvard.edu>, Kevin Hilman <khilman@baylibre.com>, Tony Lindgren <tony@atomide.com>, Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
List-Id: linux-pm@vger.kernel.org

Document the fact that the autosuspend delay and enable helpers may
change the power.usage_count and resume or suspend a device depending on
the values of power.autosuspend_delay and power.use_autosuspend.

Note that this means that a driver must disable autosuspend before
disabling runtime pm on probe errors and on driver unbind if the device
is to be suspended upon return (as a negative delay may otherwise keep
the device resumed).

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 Documentation/power/runtime_pm.txt | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/Documentation/power/runtime_pm.txt b/Documentation/power/runtime_pm.txt
index 56a13b865927..ee69d7532172 100644
--- a/Documentation/power/runtime_pm.txt
+++ b/Documentation/power/runtime_pm.txt
@@ -478,15 +478,23 @@ drivers/base/power/runtime.c and include/linux/pm_runtime.h:
     - set the power.last_busy field to the current time
 
   void pm_runtime_use_autosuspend(struct device *dev);
-    - set the power.use_autosuspend flag, enabling autosuspend delays
+    - set the power.use_autosuspend flag, enabling autosuspend delays; call
+      pm_runtime_get_sync if the flag was previously cleared and
+      power.autosuspend_delay is negative
 
   void pm_runtime_dont_use_autosuspend(struct device *dev);
-    - clear the power.use_autosuspend flag, disabling autosuspend delays
+    - clear the power.use_autosuspend flag, disabling autosuspend delays;
+      decrement the device's usage counter if the flag was previously set and
+      power.autosuspend_delay is negative; call pm_runtime_idle
 
   void pm_runtime_set_autosuspend_delay(struct device *dev, int delay);
     - set the power.autosuspend_delay value to 'delay' (expressed in
       milliseconds); if 'delay' is negative then runtime suspends are
-      prevented
+      prevented; if power.use_autosuspend is set, pm_runtime_get_sync may be
+      called or the device's usage counter may be decremented and
+      pm_runtime_idle called depending on if power.autosuspend_delay is
+      changed to or from a negative value; if power.use_autosuspend is clear,
+      pm_runtime_idle is called
 
   unsigned long pm_runtime_autosuspend_expiration(struct device *dev);
     - calculate the time when the current autosuspend delay period will expire,
-- 
2.12.2
