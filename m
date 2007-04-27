From: Pekka J Enberg <penberg@cs.helsinki.fi>
Subject: [RFC/PATCH 1/2] freezer: add include guards to header
Date: Fri, 27 Apr 2007 16:29:13 +0300 (EEST)
Message-ID: <Pine.LNX.4.64.0704271627540.15297@sbz-30.cs.Helsinki.FI>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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
To: linux-pm@lists.osdl.org
Cc: nigel@nigel.suspend2.net, pavel@ucw.cz
List-Id: linux-pm@vger.kernel.org

From: Pekka Enberg <penberg@cs.helsinki.fi>

Add include guards to <linux/freezer.h>.

Cc: Pavel Machek <pavel@ucw.cz>
Cc: Rafael J. Wysocki <rjw@sisk.pl>
Cc: Nigel Cunningham <nigel@nigel.suspend2.net>
Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>
---
 include/linux/freezer.h |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

Index: 2.6/include/linux/freezer.h
===================================================================
--- 2.6.orig/include/linux/freezer.h	2007-04-27 16:18:28.000000000 +0300
+++ 2.6/include/linux/freezer.h	2007-04-27 16:19:17.000000000 +0300
@@ -1,7 +1,10 @@
-/* Freezer declarations */
+#ifndef LINUX_FREEZER_H
+#define LINUX_FREEZER_H
 
 #include <linux/sched.h>
 
+/* Freezer declarations */
+
 #ifdef CONFIG_PM
 /*
  * Check if a process has been frozen
@@ -88,3 +91,4 @@ static inline int try_to_freeze(void) { 
 
 
 #endif
+#endif /* LINUX_FREEZER_H */
