From: Bjorn Helgaas <helgaas@kernel.org>
Subject: [PATCH 3/3] PM / core: Use dev_printk() and symbols in
 suspend/resume diagnostics
Date: Thu, 26 Apr 2018 16:36:41 -0500
Message-ID: <152477860174.202432.2800635016575214132.stgit@bhelgaas-glaptop.roam.corp.google.com>
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

When we print diagnostic messages about suspend/resume, we have a device
pointer, so use dev_printk() to match other device-related things.  Add the
function name, similar to initcall_debug output.  E.g.,

  - calling  0000:01:00.0+ @ 998, parent: 0000:00:1c.0
  + pci 0000:01:00.0: calling <something> @ 998, parent: 0000:00:1c.0

I wondered if this would break scripts/bootgraph.pl, but I don't think it
will because bootgraph.pl doesn't add any timing information to $start{}
after it sees "Write protecting the" or "Freeing unused kernel memory".

But please let me know if it does break something that parses dmesg output.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/base/power/main.c |   22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index b32750d18b09..dceda0495abf 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -192,19 +192,19 @@ void device_pm_move_last(struct device *dev)
 	list_move_tail(&dev->power.entry, &dpm_list);
 }
 
-static ktime_t initcall_debug_start(struct device *dev)
+static ktime_t initcall_debug_start(struct device *dev, void *cb)
 {
 	if (!pm_print_times_enabled)
 		return 0;
 
-	pr_info("calling  %s+ @ %i, parent: %s\n",
-		dev_name(dev), task_pid_nr(current),
-		dev->parent ? dev_name(dev->parent) : "none");
+	dev_info(dev, "calling %pF @ %i, parent: %s\n", cb,
+		 task_pid_nr(current),
+		 dev->parent ? dev_name(dev->parent) : "none");
 	return ktime_get();
 }
 
 static void initcall_debug_report(struct device *dev, ktime_t calltime,
-				  int error)
+				  void *cb, int error)
 {
 	ktime_t rettime;
 	s64 nsecs;
@@ -215,8 +215,8 @@ static void initcall_debug_report(struct device *dev, ktime_t calltime,
 	rettime = ktime_get();
 	nsecs = (s64) ktime_to_ns(ktime_sub(rettime, calltime));
 
-	pr_info("call %s+ returned %d after %Ld usecs\n", dev_name(dev),
-		error, (unsigned long long)nsecs >> 10);
+	dev_info(dev, "%pF returned %d after %Ld usecs\n", cb, error,
+		 (unsigned long long)nsecs >> 10);
 }
 
 /**
@@ -443,7 +443,7 @@ static int dpm_run_callback(pm_callback_t cb, struct device *dev,
 	if (!cb)
 		return 0;
 
-	calltime = initcall_debug_start(dev);
+	calltime = initcall_debug_start(dev, cb);
 
 	pm_dev_dbg(dev, state, info);
 	trace_device_pm_callback_start(dev, info, state.event);
@@ -451,7 +451,7 @@ static int dpm_run_callback(pm_callback_t cb, struct device *dev,
 	trace_device_pm_callback_end(dev, error);
 	suspend_report_result(cb, error);
 
-	initcall_debug_report(dev, calltime, error);
+	initcall_debug_report(dev, calltime, cb, error);
 
 	return error;
 }
@@ -1661,14 +1661,14 @@ static int legacy_suspend(struct device *dev, pm_message_t state,
 	int error;
 	ktime_t calltime;
 
-	calltime = initcall_debug_start(dev);
+	calltime = initcall_debug_start(dev, cb);
 
 	trace_device_pm_callback_start(dev, info, state.event);
 	error = cb(dev, state);
 	trace_device_pm_callback_end(dev, error);
 	suspend_report_result(cb, error);
 
-	initcall_debug_report(dev, calltime, error);
+	initcall_debug_report(dev, calltime, cb, error);
 
 	return error;
 }
