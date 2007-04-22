From: David Brownell <david-b@pacbell.net>
Subject: [patch 2.6.21-rc7] kconfig mentioneds 'hibernation' not
	just swsusp
Date: Sat, 21 Apr 2007 20:02:59 -0700
Message-ID: <200704212002.59554.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
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
To: linux-pm@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>
Cc: Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

Clarify that "software suspend" is what's called "hibernation" in most
user interfaces, shrinking a terminology gap.  (Examples include Gnome
and MS-Windows.)

Also provide a more succinct description of what it does, so you won't
have to read the whole novel in Kconfig; and highlights just why the
lack of BIOS requirements for swsusp are a big deal.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
---
 kernel/power/Kconfig |   11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

--- g26.orig/kernel/power/Kconfig	2007-04-21 10:07:18.000000000 -0700
+++ g26/kernel/power/Kconfig	2007-04-21 10:23:24.000000000 -0700
@@ -78,17 +78,22 @@ config PM_SYSFS_DEPRECATED
 	  are likely to be bus or driver specific.
 
 config SOFTWARE_SUSPEND
-	bool "Software Suspend"
+	bool "Software Suspend (Hibernation)"
 	depends on PM && SWAP && ((X86 && (!SMP || SUSPEND_SMP)) || ((FRV || PPC32) && !SMP))
 	---help---
-	  Enable the suspend to disk (STD) functionality.
+	  Enable the suspend to disk (STD) functionality, which is usually
+	  called "hibernation" in user interfaces.  STD checkpoints the
+	  system and powers it off; and restores that checkpoint on reboot.
 
 	  You can suspend your machine with 'echo disk > /sys/power/state'.
 	  Alternatively, you can use the additional userland tools available
 	  from <http://suspend.sf.net>.
 
 	  In principle it does not require ACPI or APM, although for example
-	  ACPI will be used if available.
+	  ACPI will be used for the final steps when it is available.  One
+	  of the reasons to use software suspend is that the firmware hooks
+	  for suspend states like suspend-to-RAM (STR) often don't work very
+	  well with Linux.
 
 	  It creates an image which is saved in your active swap. Upon the next
 	  boot, pass the 'resume=/dev/swappartition' argument to the kernel to
