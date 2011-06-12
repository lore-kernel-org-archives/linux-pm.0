From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH] PM: Update documentation regarding sysdevs
Date: Sun, 12 Jun 2011 12:18:14 +0200
Message-ID: <201106121218.14848.rjw__46934.4328660101$1307873928$gmane$org@sisk.pl>
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
To: Linux PM mailing list <linux-pm@lists.linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

The part of Documentation/power/devices.txt regarding sysdevs is not
valid any more after commit 2e711c04dbbf7a7732a3f7073b1fc285d12b369d
(PM: Remove sysdev suspend, resume and shutdown operations), so
remove it.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 Documentation/power/devices.txt |   26 --------------------------
 1 file changed, 26 deletions(-)

Index: linux-2.6/Documentation/power/devices.txt
===================================================================
--- linux-2.6.orig/Documentation/power/devices.txt
+++ linux-2.6/Documentation/power/devices.txt
@@ -549,32 +549,6 @@ callbacks.  The other platforms need not
 in any way.
 
 
-System Devices
---------------
-System devices (sysdevs) follow a slightly different API, which can be found in
-
-	include/linux/sysdev.h
-	drivers/base/sys.c
-
-System devices will be suspended with interrupts disabled, and after all other
-devices have been suspended.  On resume, they will be resumed before any other
-devices, and also with interrupts disabled.  These things occur in special
-"sysdev_driver" phases, which affect only system devices.
-
-Thus, after the suspend_noirq (or freeze_noirq or poweroff_noirq) phase, when
-the non-boot CPUs are all offline and IRQs are disabled on the remaining online
-CPU, then a sysdev_driver.suspend phase is carried out, and the system enters a
-sleep state (or a system image is created).  During resume (or after the image
-has been created or loaded) a sysdev_driver.resume phase is carried out, IRQs
-are enabled on the only online CPU, the non-boot CPUs are enabled, and the
-resume_noirq (or thaw_noirq or restore_noirq) phase begins.
-
-Code to actually enter and exit the system-wide low power state sometimes
-involves hardware details that are only known to the boot firmware, and
-may leave a CPU running software (from SRAM or flash memory) that monitors
-the system and manages its wakeup sequence.
-
-
 Device Low Power (suspend) States
 ---------------------------------
 Device low-power states aren't standard.  One device might only handle
