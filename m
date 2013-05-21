From: Len Brown <lenb@kernel.org>
Subject: [PATCH 1/2] x86 thermal: Delete power-limit-notification console messages
Date: Tue, 21 May 2013 15:35:16 -0400
Message-ID: <f0a8f9faefa8da662d5450ea90db7e8e4d943e25.1368740425.git.len.brown@intel.com>
References: <1368741246-3998-1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qa0-f50.google.com ([209.85.216.50]:58719 "EHLO
	mail-qa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752068Ab3EUTfa (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 21 May 2013 15:35:30 -0400
Received: by mail-qa0-f50.google.com with SMTP id bn16so618696qab.9
        for <linux-pm@vger.kernel.org>; Tue, 21 May 2013 12:35:29 -0700 (PDT)
In-Reply-To: <1368741246-3998-1-git-send-email-lenb@kernel.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rui.zhang@intel.com
Cc: linux-pm@vger.kernel.org, Fenghua Yu <fenghua.yu@intel.com>

From: Fenghua Yu <fenghua.yu@intel.com>

Package power limits are common on some systems under some conditions --
so printing console messages when limits are reached
causes unnecessary customer concern and support calls.

Note that even with these console messages gone,
the events can still be observed via system counters:

$ grep TRM /proc/interrupts

Shows total thermal interrupts, which includes both power
limit notifications and thermal throttling interrupts.

$ grep . /sys/devices/system/cpu/cpu*/thermal_throttle/*

Will show what caused those interrupts, core and package
throttling and power limit notifications.

https://bugzilla.kernel.org/show_bug.cgi?id=36182

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 arch/x86/kernel/cpu/mcheck/therm_throt.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/arch/x86/kernel/cpu/mcheck/therm_throt.c b/arch/x86/kernel/cpu/mcheck/therm_throt.c
index 47a1870..68fa890 100644
--- a/arch/x86/kernel/cpu/mcheck/therm_throt.c
+++ b/arch/x86/kernel/cpu/mcheck/therm_throt.c
@@ -181,11 +181,6 @@ static int therm_throt_process(bool new_event, int event, int level)
 				this_cpu,
 				level == CORE_LEVEL ? "Core" : "Package",
 				state->count);
-		else
-			printk(KERN_CRIT "CPU%d: %s power limit notification (total events = %lu)\n",
-				this_cpu,
-				level == CORE_LEVEL ? "Core" : "Package",
-				state->count);
 		return 1;
 	}
 	if (old_event) {
@@ -193,10 +188,6 @@ static int therm_throt_process(bool new_event, int event, int level)
 			printk(KERN_INFO "CPU%d: %s temperature/speed normal\n",
 				this_cpu,
 				level == CORE_LEVEL ? "Core" : "Package");
-		else
-			printk(KERN_INFO "CPU%d: %s power limit normal\n",
-				this_cpu,
-				level == CORE_LEVEL ? "Core" : "Package");
 		return 1;
 	}
 
-- 
1.8.3.rc2

