From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 1/9] Suspend: Fix compilation warning for
	CONFIG_SUSPEND unset
Date: Sat, 8 Dec 2007 02:03:26 +0100
Message-ID: <200712080203.26752.rjw__10162.1159505614$1197075448$gmane$org@sisk.pl>
References: <200712080201.40661.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200712080201.40661.rjw@sisk.pl>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Len Brown <lenb@kernel.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Pavel Machek <pavel@suse.cz>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Suspend: Make debug facility depend on CONFIG_SUSPEND

Make the new suspend debug facility code depend on CONFIG_SUSPEND,
as appropriate, to remove the compiler warning printed when CONFIG_PM is set
and CONFIG_SUSPEND is not set.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Acked-by: Pavel Machek <pavel@ucw.cz>
---
 kernel/power/main.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

Index: linux-2.6/kernel/power/main.c
===================================================================
--- linux-2.6.orig/kernel/power/main.c
+++ linux-2.6/kernel/power/main.c
@@ -52,6 +52,8 @@ int pm_notifier_call_chain(unsigned long
 
 #endif /* CONFIG_PM_SLEEP */
 
+#ifdef CONFIG_SUSPEND
+
 #ifdef CONFIG_PM_DEBUG
 int pm_test_level = TEST_NONE;
 
@@ -125,9 +127,6 @@ power_attr(pm_test);
 static inline int suspend_test(int level) { return 0; }
 #endif /* !CONFIG_PM_DEBUG */
 
-
-#ifdef CONFIG_SUSPEND
-
 /* This is just an arbitrary number */
 #define FREE_PAGE_NUMBER (100)
 
