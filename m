From: "Jan Beulich" <JBeulich@novell.com>
Subject: [PATCH] simplify kernel/power/Kconfig
Date: Thu, 17 Feb 2011 13:34:11 +0000
Message-ID: <4D5D31E3020000780003263F__40918.0121882402$1297949761$gmane$org@vpn.id2.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
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
To: "Rafael J. Wysocki" <rjw@sisk.pl>, pavel@ucw.cz
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, linux-kbuild@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

'n' defaults are pretty pointless and actually bogus when used with
prompt-less config options.

The "bool"/"default y" pair with no prompt can be expressed more
compactly using def_bool.

Signed-off-by: Jan Beulich <jbeulich@novell.com>

---
 kernel/power/Kconfig |   13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

--- 2.6.38-rc5/kernel/power/Kconfig
+++ 2.6.38-rc5-kconfig-power/kernel/power/Kconfig
@@ -30,7 +30,6 @@ config PM_DEBUG
 config PM_ADVANCED_DEBUG
 	bool "Extra PM attributes in sysfs for low-level debugging/testing"
 	depends on PM_DEBUG
-	default n
 	---help---
 	Add extra sysfs attributes allowing one to access some Power Management
 	fields of device objects from user space.  If you are not a kernel
@@ -39,7 +38,6 @@ config PM_ADVANCED_DEBUG
 config PM_VERBOSE
 	bool "Verbose Power Management debugging"
 	depends on PM_DEBUG
-	default n
 	---help---
 	This option enables verbose messages from the Power Management code.
 
@@ -67,7 +65,6 @@ config PM_TRACE_RTC
 	depends on CAN_PM_TRACE
 	depends on X86
 	select PM_TRACE
-	default n
 	---help---
 	This enables some cheesy code to save the last PM event point in the
 	RTC across reboots, so that you can debug a machine that just hangs
@@ -82,23 +79,20 @@ config PM_TRACE_RTC
 	set to an invalid time after a resume.
 
 config PM_SLEEP_SMP
-	bool
+	def_bool y
 	depends on SMP
 	depends on ARCH_SUSPEND_POSSIBLE || ARCH_HIBERNATION_POSSIBLE
 	depends on PM_SLEEP
 	select HOTPLUG
 	select HOTPLUG_CPU
-	default y
 
 config PM_SLEEP
-	bool
+	def_bool y
 	depends on SUSPEND || HIBERNATION || XEN_SAVE_RESTORE
-	default y
 
 config PM_SLEEP_ADVANCED_DEBUG
 	bool
 	depends on PM_ADVANCED_DEBUG
-	default n
 
 config SUSPEND
 	bool "Suspend to RAM and standby"
@@ -237,9 +231,8 @@ config PM_RUNTIME
 	  wake-up events.
 
 config PM_OPS
-	bool
+	def_bool y
 	depends on PM_SLEEP || PM_RUNTIME
-	default y
 
 config ARCH_HAS_OPP
 	bool
