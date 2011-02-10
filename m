From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [Updated][PATCH 5/5] PM: Clean up PM_TRACE dependencies
	and drop unnecessary Kconfig option
Date: Fri, 11 Feb 2011 00:32:48 +0100
Message-ID: <201102110032.48810.rjw__5746.47577382183$1297380932$gmane$org@sisk.pl>
References: <1297081335-13631-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<201102082218.28015.rjw@sisk.pl> <201102082223.37975.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201102082223.37975.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org
Cc: Len Brown <len.brown@intel.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, linux-embedded@vger.kernel.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Tuesday, February 08, 2011, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> CONFIG_PM_SLEEP_ADVANCED_DEBUG should depend on CONFIG_PM_SLEEP
> and CONFIG_CAN_PM_TRACE need not depend on EXPERIMENTAL.  Modify
> kernel/power/Kconfig along those lines.

It turns out that CONFIG_PM_SLEEP_ADVANCED_DEBUG is not used any more, so we
can simply get rid of it.

Thanks,
Rafael

---
From: Rafael J. Wysocki <rjw@sisk.pl>
Subject: PM: Clean up PM_TRACE dependencies and drop unnecessary Kconfig option

CONFIG_PM_SLEEP_ADVANCED_DEBUG is not used any more, so drop it
and CONFIG_CAN_PM_TRACE need not depend on EXPERIMENTAL, so remove
that dependency.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 kernel/power/Kconfig |    7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

Index: linux-2.6/kernel/power/Kconfig
===================================================================
--- linux-2.6.orig/kernel/power/Kconfig
+++ linux-2.6/kernel/power/Kconfig
@@ -140,11 +140,6 @@ config PM_ADVANCED_DEBUG
 	fields of device objects from user space.  If you are not a kernel
 	developer interested in debugging/testing Power Management, say "no".
 
-config PM_SLEEP_ADVANCED_DEBUG
-	bool
-	depends on PM_ADVANCED_DEBUG
-	default n
-
 config PM_TEST_SUSPEND
 	bool "Test suspend/resume and wakealarm during bootup"
 	depends on SUSPEND && PM_DEBUG && RTC_CLASS=y
@@ -158,7 +153,7 @@ config PM_TEST_SUSPEND
 
 config CAN_PM_TRACE
 	def_bool y
-	depends on PM_DEBUG && PM_SLEEP && EXPERIMENTAL
+	depends on PM_DEBUG && PM_SLEEP
 
 config PM_TRACE
 	bool
