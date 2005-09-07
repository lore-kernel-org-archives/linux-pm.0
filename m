From: Pierre Ossman <drzeus-list@drzeus.cx>
Subject: swsusp doesn't suspend devices
Date: Wed, 07 Sep 2005 13:20:03 +0200
Message-ID: <431ECCE3.8080408@drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932113AbVIGLUA@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>, LKML <linux-kernel@vger.kernel.org>, linux-pm@osdl.org
List-Id: linux-pm@vger.kernel.org

It would seem that swsusp doesn't properly suspend devices, or more
precisely it wakes them up again before suspending the machine.

The problem is in swsusp_suspend(). It is designed as if
swsusp_arch_suspend() would suspend the hardware, when in fact all it
does is prepare for a suspend. The effect is that devices are brought
back up because swsusp_suspend() believes it is resuming.

Below is a patch that uses the same system as kernel/power/disk.c to
determine if it's suspending or resuming. The patch brings up a new
problem though, disk writes generate a huge amount of "scheduling while
atomic".

---

Index: linux-wbsd/kernel/power/swsusp.c
===================================================================
--- linux-wbsd/kernel/power/swsusp.c    (revision 165)
+++ linux-wbsd/kernel/power/swsusp.c    (working copy)
@@ -84,6 +84,8 @@
 /* Local variables that should not be affected by save */
 static unsigned int nr_copy_pages __nosavedata = 0;

+static int in_suspend __nosavedata = 0;
+
 /* Suspend pagedir is allocated before final copy, therefore it
    must be freed after resume

@@ -897,15 +899,18 @@
                return error;
        }

+       in_suspend = 1;
        save_processor_state();
        if ((error = swsusp_arch_suspend()))
                printk("Error %d suspending\n", error);
-       /* Restore control flow magically appears here */
-       restore_processor_state();
-       BUG_ON (nr_copy_pages_check != nr_copy_pages);
-       restore_highmem();
-       device_power_up();
-       local_irq_enable();
+       if (!in_suspend || error) {
+               /* Restore control flow magically appears here */
+               restore_processor_state();
+               BUG_ON (nr_copy_pages_check != nr_copy_pages);
+               restore_highmem();
+               device_power_up();
+               local_irq_enable();
+       }
        return error;
 }
