From: Bjorn Helgaas <helgaas@kernel.org>
Subject: [PATCH 2/3] PM / core: Simplify initcall_debug_report() timing
Date: Thu, 26 Apr 2018 16:36:34 -0500
Message-ID: <152477859465.202432.3937821781754690411.stgit@bhelgaas-glaptop.roam.corp.google.com>
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

initcall_debug_report() always called ktime_get(), even if we didn't need
the result.

Change it so we only call it when we're going to use the result, and change
initcall_debug_start() to follow the same style.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/base/power/main.c |   24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index 85ef2af6dc92..b32750d18b09 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -194,16 +194,13 @@ void device_pm_move_last(struct device *dev)
 
 static ktime_t initcall_debug_start(struct device *dev)
 {
-	ktime_t calltime = 0;
-
-	if (pm_print_times_enabled) {
-		pr_info("calling  %s+ @ %i, parent: %s\n",
-			dev_name(dev), task_pid_nr(current),
-			dev->parent ? dev_name(dev->parent) : "none");
-		calltime = ktime_get();
-	}
+	if (!pm_print_times_enabled)
+		return 0;
 
-	return calltime;
+	pr_info("calling  %s+ @ %i, parent: %s\n",
+		dev_name(dev), task_pid_nr(current),
+		dev->parent ? dev_name(dev->parent) : "none");
+	return ktime_get();
 }
 
 static void initcall_debug_report(struct device *dev, ktime_t calltime,
@@ -212,13 +209,14 @@ static void initcall_debug_report(struct device *dev, ktime_t calltime,
 	ktime_t rettime;
 	s64 nsecs;
 
+	if (!pm_print_times_enabled)
+		return;
+
 	rettime = ktime_get();
 	nsecs = (s64) ktime_to_ns(ktime_sub(rettime, calltime));
 
-	if (pm_print_times_enabled) {
-		pr_info("call %s+ returned %d after %Ld usecs\n", dev_name(dev),
-			error, (unsigned long long)nsecs >> 10);
-	}
+	pr_info("call %s+ returned %d after %Ld usecs\n", dev_name(dev),
+		error, (unsigned long long)nsecs >> 10);
 }
 
 /**
