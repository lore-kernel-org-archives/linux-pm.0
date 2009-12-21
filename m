From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 3/5] PM: Use pm_runtime_put_sync in system resume
Date: Mon, 21 Dec 2009 22:05:12 +0100
Message-ID: <200912212205.12343.rjw__27772.2616716803$1261429889$gmane$org@sisk.pl>
References: <200912212201.47920.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200912212201.47920.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: pm list <linux-pm@lists.linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

From: Alan Stern <stern@rowland.harvard.edu>

This patch (as1317) fixes a bug in the PM core.  When a device is
resumed following a system sleep, the core decrements the device's
runtime PM usage counter but doesn't issue an idle notification if the
counter reaches 0.  This could prevent an otherwise unused device from
being runtime-suspended again after the system sleep.

The fix is to call pm_runtime_put_sync() instead of
pm_runtime_put_noidle().

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/base/power/main.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: linux-2.6/drivers/base/power/main.c
===================================================================
--- linux-2.6.orig/drivers/base/power/main.c
+++ linux-2.6/drivers/base/power/main.c
@@ -607,7 +607,7 @@ static void dpm_complete(pm_message_t st
 			mutex_unlock(&dpm_list_mtx);
 
 			device_complete(dev, state);
-			pm_runtime_put_noidle(dev);
+			pm_runtime_put_sync(dev);
 
 			mutex_lock(&dpm_list_mtx);
 		}
@@ -880,7 +880,7 @@ static int dpm_prepare(pm_message_t stat
 		pm_runtime_get_noresume(dev);
 		if (pm_runtime_barrier(dev) && device_may_wakeup(dev)) {
 			/* Wake-up requested during system sleep transition. */
-			pm_runtime_put_noidle(dev);
+			pm_runtime_put_sync(dev);
 			error = -EBUSY;
 		} else {
 			error = device_prepare(dev, state);
