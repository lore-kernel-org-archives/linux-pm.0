From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH] PM: Make warning in suspend_test_finish() less
	likely to happen
Date: Tue, 20 Oct 2009 06:45:02 +0200
Message-ID: <200910200645.02384.rjw__1869.98508074812$1256013901$gmane$org@sisk.pl>
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
To: pm list <linux-pm@lists.linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

Increase TEST_SUSPEND_SECONDS to 10 so the warning in
suspend_test_finish() doesn't annoy the users of slower systems so
much.

Also, make the warning print the suspend-resume cycle time, so
that we know why the warning actually triggered.

Patch prepared during the hacking session at the Kernel Summit in
Tokyo.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 kernel/power/suspend_test.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

Index: linux-2.6/kernel/power/suspend_test.c
===================================================================
--- linux-2.6.orig/kernel/power/suspend_test.c
+++ linux-2.6/kernel/power/suspend_test.c
@@ -19,7 +19,7 @@
  * The time it takes is system-specific though, so when we test this
  * during system bootup we allow a LOT of time.
  */
-#define TEST_SUSPEND_SECONDS	5
+#define TEST_SUSPEND_SECONDS	10
 
 static unsigned long suspend_test_start_time;
 
@@ -49,7 +49,8 @@ void suspend_test_finish(const char *lab
 	 * has some performance issues.  The stack dump of a WARN_ON
 	 * is more likely to get the right attention than a printk...
 	 */
-	WARN(msec > (TEST_SUSPEND_SECONDS * 1000), "Component: %s\n", label);
+	WARN(msec > (TEST_SUSPEND_SECONDS * 1000),
+	     "Component: %s, time: %u\n", label, msec);
 }
 
 /*
