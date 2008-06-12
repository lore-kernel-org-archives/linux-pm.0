From: Matt Helsley <matthltc@us.ibm.com>
Subject: [PATCH] PM: for-mm: Fix compile failure in boot time
	suspend	selftest
Date: Thu, 12 Jun 2008 16:24:36 -0700
Message-ID: <1213313076.7066.37.camel@localhost.localdomain>
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
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Linux Power Management <linux-pm@lists.linux-foundation.org>, David Brownell <dbrownell@users.sourceforge.net>
List-Id: linux-pm@vger.kernel.org

The following config revealed a compilation problem in the suspend
self test program included in 2.6.26-rc5-mm2:

kernel/power/main.c: In function 'test_suspend':
kernel/power/main.c:688: warning: passing argument 2 of 'class_find_device' from incompatible pointer type
kernel/power/main.c:688: error: too few arguments to function 'class_find_device'
make[2]: *** [kernel/power/main.o] Error 1

#
# Power management options
#
CONFIG_PM=y
CONFIG_PM_DEBUG=y
CONFIG_PM_VERBOSE=y
CONFIG_CAN_PM_TRACE=y
CONFIG_PM_TRACE=y
CONFIG_PM_TRACE_RTC=y
CONFIG_PM_SLEEP=y
CONFIG_SUSPEND=y
CONFIG_PM_TEST_SUSPEND=y
CONFIG_SUSPEND_FREEZER=y
# CONFIG_HIBERNATION is not set

Fix the compilation error by using NULL to tell
class_find_device() that we're initiating an iteration rather than
resuming a previously-initiated one.

Signed-off-by: Matt Helsley <matthltc@us.ibm.com>
---
Applies to 2.6.26-rc5-mm2
WARNING: Compiles (for me) but is otherwise untested. I'll be
	 booting with this soon when I start testing some other
	 work that's not in 2.6.26-rc5-mm2.

 kernel/power/main.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6.26-rc5-mm2/kernel/power/main.c
===================================================================
--- linux-2.6.26-rc5-mm2.orig/kernel/power/main.c
+++ linux-2.6.26-rc5-mm2/kernel/power/main.c
@@ -683,11 +683,11 @@ static int __init test_suspend(void)
 		printk(warn_bad_state, pm_states[test_state]);
 		goto done;
 	}
 
 	/* RTCs have initialized by now too ... can we use one? */
-	class_find_device(rtc_class, &pony, has_wakealarm);
+	class_find_device(rtc_class, NULL, &pony, has_wakealarm);
 	if (pony)
 		rtc = rtc_class_open(pony);
 	if (!rtc) {
 		printk(warn_no_rtc);
 		goto done;
