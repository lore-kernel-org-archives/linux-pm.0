From: Adrian Bunk <bunk@stusta.de>
Subject: [2.6 patch] SOFTWARE_SUSPEND: fix a typo in the dependencies
Date: Sat, 14 Jan 2006 03:35:15 +0100
Message-ID: <20060114023515.GJ29663@stusta.de>
References: <20060110043627.GD3911@stusta.de> <20060106202948.GB2736@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1945984AbWANCfR@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20060106202948.GB2736@ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-pm@osdl.org, linux-kernel@vger.kernel.org, Jean-Luc Leger <reiga@dspnet.fr.eu.org>
List-Id: linux-pm@vger.kernel.org

This patch fixes a typo in the dependencies of SOFTWARE_SUSPEND.

This patch is based on a report by
Jean-Luc Leger <reiga@dspnet.fr.eu.org>.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.15-mm3-full/kernel/power/Kconfig.old	2006-01-14 03:25:54.000000000 +0100
+++ linux-2.6.15-mm3-full/kernel/power/Kconfig	2006-01-14 03:26:03.000000000 +0100
@@ -38,7 +38,7 @@
 
 config SOFTWARE_SUSPEND
 	bool "Software Suspend"
-	depends on PM && SWAP && (X86 && (!SMP || SUSPEND_SMP)) || ((FVR || PPC32) && !SMP)
+	depends on PM && SWAP && (X86 && (!SMP || SUSPEND_SMP)) || ((FRV || PPC32) && !SMP)
 	---help---
 	  Enable the possibility of suspending the machine.
 	  It doesn't need APM.
