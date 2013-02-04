From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 1/4] ACPI / idle: remove unused definition
Date: Mon,  4 Feb 2013 23:44:40 +0100
Message-ID: <1360017883-9544-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:47579 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755963Ab3BDWos (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 4 Feb 2013 17:44:48 -0500
Received: by mail-wi0-f173.google.com with SMTP id hq4so3523879wib.12
        for <linux-pm@vger.kernel.org>; Mon, 04 Feb 2013 14:44:46 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl
Cc: linaro-dev@lists.linaro.org, patches@linaro.org, lenb@kernel.org, linux-pm@vger.kernel.org

The different definitions are not used anywhere in the code.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/acpi/processor_idle.c |    5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index e606e36..5cb5f24 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -64,11 +64,6 @@
 #define ACPI_PROCESSOR_CLASS            "processor"
 #define _COMPONENT              ACPI_PROCESSOR_COMPONENT
 ACPI_MODULE_NAME("processor_idle");
-#define PM_TIMER_TICK_NS		(1000000000ULL/ACPI_PM_TIMER_FREQUENCY)
-#define C2_OVERHEAD			1	/* 1us */
-#define C3_OVERHEAD			1	/* 1us */
-#define PM_TIMER_TICKS_TO_US(p)		\
-	(((p) * 1000)/(ACPI_PM_TIMER_FREQUENCY/1000))
 
 static unsigned int max_cstate __read_mostly = ACPI_PROCESSOR_MAX_POWER;
 module_param(max_cstate, uint, 0000);
-- 
1.7.9.5

