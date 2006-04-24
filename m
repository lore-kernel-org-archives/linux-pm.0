From: David Brownell <david-b@pacbell.net>
Subject: [patch/rft 2.6.17-rc2] swsusp resume must not device_suspend()
Date: Mon, 24 Apr 2006 14:29:51 -0700
Message-ID: <200604241429.52022.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_QNUTEajrGhXjjBz"
Return-path: <linux-usb-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Sender: linux-usb-devel-admin@lists.sourceforge.net
Errors-To: linux-usb-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:linux-usb-devel@lists.sourceforge.net>
List-Help: <mailto:linux-usb-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-usb-devel>
To: linux-pm@lists.osdl.org, linux-usb-devel@lists.sourceforge.net
Cc: Andrew Morton <akpm@osdl.org>
List-Id: linux-pm@vger.kernel.org

--Boundary-00=_QNUTEajrGhXjjBz
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I've noticed a bunch of problem reports that go like this:

 - boot system with some USB devices attached
 - echo disk > /sys/power/state
 - ... later resume ...
 - now those USB devices don't work right
 - unplug them/replug them, all is OK

I recently observed this myself and tracked down one problem.  The solution
involves what kexec() does in much the same situation:  before starting a
new kernel, most hardware needs to be reset.  Today, swsusp will suspend it
instead, which is the root cause of the problem.

This seems like something that might need to sit in the MM tree for
a while, as it's a longstanding bug and the fix could shake loose driver
goofs.  Luckily there's a partial workaround already in wide use:  link
drivers as modules if they use true suspend states (like all USB HCDs),
don't link them statically into the kernel image.

That workaround is partial because when BIOS takes over a controller, the
resume() method has to handle that nasty case too!  Last I checked, all
the USB HCDs do handle that case; and few drivers other than those HCDs
would ever need to worry about such issues.

- Dave



--Boundary-00=_QNUTEajrGhXjjBz
Content-Type: text/x-diff;
  charset="us-ascii";
  name="swsusp.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="swsusp.patch"

Currently the swsusp resume path puts devices into a bogus suspend state
before switching to the new kernel.  It's neither the suspend state that
the driver left the device in, nor a "device lost power" reset state.

Instead, it's a semi-functional state from the kernel which loaded the
snapshot.  There's no way that a driver can properly resume from that.
Some drivers issue resets in their resume methods, but that's wrong for
every driver which uses more power states than just "on" and "reset".

This patch shuts down (resets) the devices, just like kexec() does, so
that non-modular drivers will know they must fully re-initialize even
when they wouldn't ordinarily do so during resume().


--- linux.orig/kernel/power/swsusp.c	2006-04-23 08:41:22.000000000 -0700
+++ linux/kernel/power/swsusp.c	2006-04-24 13:20:17.000000000 -0700
@@ -49,6 +49,7 @@
 #include <linux/bootmem.h>
 #include <linux/syscalls.h>
 #include <linux/highmem.h>
+#include <linux/reboot.h>
 
 #include "power.h"
 
@@ -249,10 +250,16 @@
 int swsusp_resume(void)
 {
 	int error;
-	local_irq_disable();
-	if (device_power_down(PMSG_FREEZE))
-		printk(KERN_ERR "Some devices failed to power down, very bad\n");
+
+	/* We need to shutdown/reset devices so that drivers which use
+	 * non-powerdown suspend() states will see sane states in their
+	 * resume() methods.  At this point "reset" is the only option,
+	 * since we clobbered any valid suspend state a long time ago.
+	 */
+	kernel_restart_prepare(NULL);
+
 	/* We'll ignore saved state, but this gets preempt count (etc) right */
+	local_irq_disable();
 	save_processor_state();
 	error = swsusp_arch_resume();
 	/* Code below is only ever reached in case of failure. Otherwise

--Boundary-00=_QNUTEajrGhXjjBz--


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
linux-usb-devel@lists.sourceforge.net
To unsubscribe, use the last form field at:
https://lists.sourceforge.net/lists/listinfo/linux-usb-devel
