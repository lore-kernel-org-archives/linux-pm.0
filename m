From: Bjorn Helgaas <helgaas@kernel.org>
Subject: [PATCH 1/3] PM / core: Remove unused initcall_debug_report()
 arguments
Date: Thu, 26 Apr 2018 16:36:27 -0500
Message-ID: <152477858774.202432.5890298203115237959.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <152477804633.202432.12678470890830085798.stgit@bhelgaas-glaptop.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <152477804633.202432.12678470890830085798.stgit@bhelgaas-glaptop.roam.corp.google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

e8bca479c3f2 ("PM / sleep: trace events for device PM callbacks") removed
the only uses of "state" and "info" from initcall_debug_report().

Remove the now-unused arguments completely.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/base/power/main.c |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index 02a497e7c785..85ef2af6dc92 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -207,8 +207,7 @@ static ktime_t initcall_debug_start(struct device *dev)
 }
 
 static void initcall_debug_report(struct device *dev, ktime_t calltime,
-				  int error, pm_message_t state,
-				  const char *info)
+				  int error)
 {
 	ktime_t rettime;
 	s64 nsecs;
@@ -454,7 +453,7 @@ static int dpm_run_callback(pm_callback_t cb, struct device *dev,
 	trace_device_pm_callback_end(dev, error);
 	suspend_report_result(cb, error);
 
-	initcall_debug_report(dev, calltime, error, state, info);
+	initcall_debug_report(dev, calltime, error);
 
 	return error;
 }
@@ -1671,7 +1670,7 @@ static int legacy_suspend(struct device *dev, pm_message_t state,
 	trace_device_pm_callback_end(dev, error);
 	suspend_report_result(cb, error);
 
-	initcall_debug_report(dev, calltime, error, state, info);
+	initcall_debug_report(dev, calltime, error);
 
 	return error;
 }
