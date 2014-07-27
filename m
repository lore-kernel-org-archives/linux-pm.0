From: Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] PM: fix kernel-doc warnings in drivers/base/power/main.c
Date: Sun, 27 Jul 2014 16:17:15 -0700
Message-ID: <53D5887B.80000@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:56292 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750785AbaG0XRV (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 27 Jul 2014 19:17:21 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>
Cc: Linux PM list <linux-pm@vger.kernel.org>

From: Randy Dunlap <rdunlap@infradead.org>

Fix kernel-doc warnings in drivers/base/power/main.c:

Warning(..//drivers/base/power/main.c:473): No description found for parameter 'async'
Warning(..//drivers/base/power/main.c:601): No description found for parameter 'async'
Warning(..//drivers/base/power/main.c:1012): No description found for parameter 'async'
Warning(..//drivers/base/power/main.c:1151): No description found for parameter 'async'
Warning(..//drivers/base/power/main.c:1305): No description found for parameter 'info'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc:	"Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:	Len Brown <len.brown@intel.com>
Cc:	Pavel Machek <pavel@ucw.cz>
Cc:	linux-pm@vger.kernel.org
---
 drivers/base/power/main.c |    5 +++++
 1 file changed, 5 insertions(+)

Index: lnx-316-rc7/drivers/base/power/main.c
===================================================================
--- lnx-316-rc7.orig/drivers/base/power/main.c
+++ lnx-316-rc7/drivers/base/power/main.c
@@ -465,6 +465,7 @@ static void dpm_watchdog_clear(struct dp
  * device_resume_noirq - Execute an "early resume" callback for given device.
  * @dev: Device to handle.
  * @state: PM transition of the system being carried out.
+ * @async: If true, the device is being resumed asynchronously.
  *
  * The driver of @dev will not receive interrupts while this function is being
  * executed.
@@ -594,6 +595,7 @@ static void dpm_resume_noirq(pm_message_
  * device_resume_early - Execute an "early resume" callback for given device.
  * @dev: Device to handle.
  * @state: PM transition of the system being carried out.
+ * @async: If true, the device is being resumed asynchronously.
  *
  * Runtime PM is disabled for @dev while this function is being executed.
  */
@@ -1004,6 +1006,7 @@ static pm_message_t resume_event(pm_mess
  * device_suspend_noirq - Execute a "late suspend" callback for given device.
  * @dev: Device to handle.
  * @state: PM transition of the system being carried out.
+ * @async: If true, the device is being suspended asynchronously.
  *
  * The driver of @dev will not receive interrupts while this function is being
  * executed.
@@ -1144,6 +1147,7 @@ static int dpm_suspend_noirq(pm_message_
  * device_suspend_late - Execute a "late suspend" callback for given device.
  * @dev: Device to handle.
  * @state: PM transition of the system being carried out.
+ * @async: If true, the device is being suspended asynchronously.
  *
  * Runtime PM is disabled for @dev while this function is being executed.
  */
@@ -1298,6 +1302,7 @@ EXPORT_SYMBOL_GPL(dpm_suspend_end);
  * @dev: Device to suspend.
  * @state: PM transition of the system being carried out.
  * @cb: Suspend callback to execute.
+ * @info: string description of caller.
  */
 static int legacy_suspend(struct device *dev, pm_message_t state,
 			  int (*cb)(struct device *dev, pm_message_t state),
