From: Adrian Bunk <bunk@stusta.de>
Subject: [2.6 patch] simplify SOFTWARE_SUSPEND dependencies
Date: Sat, 20 Aug 2005 06:07:23 +0200
Message-ID: <20050820040723.GN3615@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1030204AbVHTEHb@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: pavel@suse.cz
Cc: linux-pm@osdl.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

This patch expresses the same dependencies in a more simple way.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.13-rc6-mm1-full/kernel/power/Kconfig.old	2005-08-20 06:02:49.000000000 +0200
+++ linux-2.6.13-rc6-mm1-full/kernel/power/Kconfig	2005-08-20 06:03:13.000000000 +0200
@@ -28,7 +28,7 @@
 
 config SOFTWARE_SUSPEND
 	bool "Software Suspend"
-	depends on EXPERIMENTAL && PM && SWAP && ((X86 && SMP) || ((FVR || PPC32 || X86) && !SMP))
+	depends on EXPERIMENTAL && PM && SWAP && (X86 || ((FVR || PPC32) && !SMP))
 	---help---
 	  Enable the possibility of suspending the machine.
 	  It doesn't need APM.
