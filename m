From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH] PM: Avoid compiler warning in pm_noirq_op()
Date: Mon, 13 Dec 2010 01:23:29 +0100
Message-ID: <201012130123.29305.rjw__10637.1461799883$1292199987$gmane$org@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

The compiler complains that calltime may be uninitialized in
pm_noirq_op(), so add extra initialization for that variable to
avoid the warning.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/base/power/main.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6/drivers/base/power/main.c
===================================================================
--- linux-2.6.orig/drivers/base/power/main.c
+++ linux-2.6/drivers/base/power/main.c
@@ -304,7 +304,7 @@ static int pm_noirq_op(struct device *de
 			pm_message_t state)
 {
 	int error = 0;
-	ktime_t calltime, delta, rettime;
+	ktime_t calltime = ktime_set(0, 0), delta, rettime;
 
 	if (initcall_debug) {
 		pr_info("calling  %s+ @ %i, parent: %s\n",
