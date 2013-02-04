From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 2/4] ACPI / idle : remove pointless headers
Date: Mon,  4 Feb 2013 23:44:41 +0100
Message-ID: <1360017883-9544-2-git-send-email-daniel.lezcano@linaro.org>
References: <1360017883-9544-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:52306 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755963Ab3BDWot (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 4 Feb 2013 17:44:49 -0500
Received: by mail-wi0-f171.google.com with SMTP id hn17so2251933wib.16
        for <linux-pm@vger.kernel.org>; Mon, 04 Feb 2013 14:44:48 -0800 (PST)
In-Reply-To: <1360017883-9544-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl
Cc: linaro-dev@lists.linaro.org, patches@linaro.org, lenb@kernel.org, linux-pm@vger.kernel.org

These different headers are not needed.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/acpi/processor_idle.c |   13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 5cb5f24..82626e9 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -28,19 +28,12 @@
  * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  */
 
-#include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/init.h>
-#include <linux/cpufreq.h>
-#include <linux/slab.h>
 #include <linux/acpi.h>
 #include <linux/dmi.h>
-#include <linux/moduleparam.h>
-#include <linux/sched.h>	/* need_resched() */
-#include <linux/pm_qos.h>
+#include <linux/sched.h>       /* need_resched() */
 #include <linux/clockchips.h>
 #include <linux/cpuidle.h>
-#include <linux/irqflags.h>
 
 /*
  * Include the apic definitions for x86 to have the APIC timer related defines
@@ -52,12 +45,8 @@
 #include <asm/apic.h>
 #endif
 
-#include <asm/io.h>
-#include <asm/uaccess.h>
-
 #include <acpi/acpi_bus.h>
 #include <acpi/processor.h>
-#include <asm/processor.h>
 
 #define PREFIX "ACPI: "
 
-- 
1.7.9.5

