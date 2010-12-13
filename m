From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFC][PATCH 2/4] PM: Remove redundant checks from core
	device resume routines
Date: Mon, 13 Dec 2010 01:31:24 +0100
Message-ID: <201012130131.24970.rjw__210.602294146334$1292200787$gmane$org@sisk.pl>
References: <201012130128.31243.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201012130128.31243.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

Since a separate list of devices is used to link devices that have
completed each stage of suspend (or resume), it is not necessary to
check dev->power.status in the core device resume routines any more.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/base/power/main.c |   34 +++++++++++++---------------------
 1 file changed, 13 insertions(+), 21 deletions(-)

Index: linux-2.6/drivers/base/power/main.c
===================================================================
--- linux-2.6.orig/drivers/base/power/main.c
+++ linux-2.6/drivers/base/power/main.c
@@ -485,20 +485,17 @@ void dpm_resume_noirq(pm_message_t state
 	transition_started = false;
 	while (!list_empty(&dpm_noirq_list)) {
 		struct device *dev = to_device(dpm_noirq_list.next);
+		int error;
 
 		get_device(dev);
-		if (dev->power.status > DPM_OFF) {
-			int error;
-
-			dev->power.status = DPM_OFF;
-			mutex_unlock(&dpm_list_mtx);
+		dev->power.status = DPM_OFF;
+		mutex_unlock(&dpm_list_mtx);
 
-			error = device_resume_noirq(dev, state);
+		error = device_resume_noirq(dev, state);
 
-			mutex_lock(&dpm_list_mtx);
-			if (error)
-				pm_dev_err(dev, state, " early", error);
-		}
+		mutex_lock(&dpm_list_mtx);
+		if (error)
+			pm_dev_err(dev, state, " early", error);
 		if (!list_empty(&dev->power.entry))
 			list_move_tail(&dev->power.entry, &dpm_suspended_list);
 		put_device(dev);
@@ -619,9 +616,6 @@ static void dpm_resume(pm_message_t stat
 	async_error = 0;
 
 	list_for_each_entry(dev, &dpm_suspended_list, power.entry) {
-		if (dev->power.status < DPM_OFF)
-			continue;
-
 		INIT_COMPLETION(dev->power.completion);
 		if (is_async(dev)) {
 			get_device(dev);
@@ -632,7 +626,7 @@ static void dpm_resume(pm_message_t stat
 	while (!list_empty(&dpm_suspended_list)) {
 		dev = to_device(dpm_suspended_list.next);
 		get_device(dev);
-		if (dev->power.status >= DPM_OFF && !is_async(dev)) {
+		if (!is_async(dev)) {
 			int error;
 
 			mutex_unlock(&dpm_list_mtx);
@@ -697,15 +691,13 @@ static void dpm_complete(pm_message_t st
 		struct device *dev = to_device(dpm_prepared_list.prev);
 
 		get_device(dev);
-		if (dev->power.status > DPM_ON) {
-			dev->power.status = DPM_ON;
-			mutex_unlock(&dpm_list_mtx);
+		dev->power.status = DPM_ON;
+		mutex_unlock(&dpm_list_mtx);
 
-			device_complete(dev, state);
-			pm_runtime_put_sync(dev);
+		device_complete(dev, state);
+		pm_runtime_put_sync(dev);
 
-			mutex_lock(&dpm_list_mtx);
-		}
+		mutex_lock(&dpm_list_mtx);
 		if (!list_empty(&dev->power.entry))
 			list_move(&dev->power.entry, &list);
 		put_device(dev);
