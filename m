From: David Brownell <david-b@pacbell.net>
Subject: Re: [patch 2.6.26-rc4-git] PM: boot time suspend selftest
Date: Sun, 6 Jul 2008 21:12:38 -0700
Message-ID: <200807062112.38209.david-b__46068.6765182347$1215404303$gmane$org@pacbell.net>
References: <200805291333.42057.david-b@pacbell.net>
	<20080529162257.03426e48.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080529162257.03426e48.akpm@linux-foundation.org>
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
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-pm@lists.linux-foundation.org, mingo@elte.hu, linux-kernel@vger.kernel.org, pavel@suse.cz
List-Id: linux-pm@vger.kernel.org

Address some of Andrew's comments on the patch now in
MMOTM with name "pm-boot-time-suspend-selftest.patch".

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
---
 kernel/power/main.c |   21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

--- a/kernel/power/main.c	2008-07-06 21:06:35.000000000 -0700
+++ b/kernel/power/main.c	2008-07-06 21:06:35.000000000 -0700
@@ -160,10 +160,19 @@ static void suspend_test_finish(const ch
 	long nj = jiffies - suspend_test_start_time;
 	unsigned msec;
 
-	msec = jiffies_to_msecs((nj >= 0) ? nj : -nj);
+	msec = jiffies_to_msecs(abs(nj));
 	pr_info("PM: %s took %d.%03d seconds\n", label,
 			msec / 1000, msec % 1000);
-	WARN_ON_ONCE(msec > (TEST_SUSPEND_SECONDS * 1000));
+
+	/* Warning on suspend means the RTC alarm period needs to be
+	 * larger -- the system was sooo slooowwww to suspend that the
+	 * alarm (should have) fired before the system went to sleep!
+	 *
+	 * Warning on either suspend or resume also means the system
+	 * has some performance issues.  The stack dump of a WARN_ON
+	 * is more likely to get the right attention than a printk...
+	 */
+	WARN_ON(msec > (TEST_SUSPEND_SECONDS * 1000));
 }
 
 #else
@@ -579,13 +588,13 @@ core_initcall(pm_init);
 
 static void __init test_wakealarm(struct rtc_device *rtc, suspend_state_t state)
 {
-	static char		err_readtime [] __initdata =
+	static char err_readtime[] __initdata =
 		KERN_ERR "PM: can't read %s time, err %d\n";
-	static char		err_wakealarm [] __initdata =
+	static char err_wakealarm [] __initdata =
 		KERN_ERR "PM: can't set %s wakealarm, err %d\n";
-	static char		err_suspend [] __initdata =
+	static char err_suspend[] __initdata =
 		KERN_ERR "PM: suspend test failed, error %d\n";
-	static char		info_test [] __initdata =
+	static char info_test[] __initdata =
 		KERN_INFO "PM: test RTC wakeup from '%s' suspend\n";
 
 	unsigned long		now;
