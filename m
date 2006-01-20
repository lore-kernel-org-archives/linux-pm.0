From: Adrian Bunk <bunk@stusta.de>
Subject: [2.6 patch] help text: SOFTWARE_SUSPEND doesn't need ACPI
Date: Fri, 20 Jan 2006 01:20:02 +0100
Message-ID: <20060120002002.GH19398@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1422696AbWATAUE@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: pavel@suse.cz
Cc: linux-pm@osdl.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

The note that SOFTWARE_SUSPEND doesn't need APM is helpful, but nowadays 
the information that it doesn't need ACPI, too, is even more helpful.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.16-rc1-mm1-full/kernel/power/Kconfig.old	2006-01-20 01:14:09.000000000 +0100
+++ linux-2.6.16-rc1-mm1-full/kernel/power/Kconfig	2006-01-20 01:14:19.000000000 +0100
@@ -39,11 +39,11 @@
 config SOFTWARE_SUSPEND
 	bool "Software Suspend"
 	depends on PM && SWAP && (X86 && (!SMP || SUSPEND_SMP)) || ((FRV || PPC32) && !SMP)
 	---help---
 	  Enable the possibility of suspending the machine.
-	  It doesn't need APM.
+	  It doesn't need ACPI or APM.
 	  You may suspend your machine by 'swsusp' or 'shutdown -z <time>' 
 	  (patch for sysvinit needed). 
 
 	  It creates an image which is saved in your active swap. Upon next
 	  boot, pass the 'resume=/dev/swappartition' argument to the kernel to
