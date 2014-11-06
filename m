From: Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v5 38/48] ia64: Register with kernel power-off handler
Date: Thu,  6 Nov 2014 08:43:22 -0800
Message-ID: <1415292213-28652-39-git-send-email-linux@roeck-us.net>
References: <1415292213-28652-1-git-send-email-linux@roeck-us.net>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:56485 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752338AbaKFQpR (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 6 Nov 2014 11:45:17 -0500
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
	(envelope-from <linux@roeck-us.net>)
	id 1XmQBR-000Vfk-31
	for linux-pm@vger.kernel.org; Thu, 06 Nov 2014 16:45:17 +0000
In-Reply-To: <1415292213-28652-1-git-send-email-linux@roeck-us.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>, linux-ia64@vger.kernel.org

Register with kernel power-off handler instead of setting pm_power_off
directly. Register with low priority to reflect that the call is expected
to be replaced at some point in the future.

Cc: Tony Luck <tony.luck@intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v5:
- Rebase to v3.18-rc3
v4:
- No change
v3:
- Replace poweroff in all newly introduced variables and in text
  with power_off or power-off as appropriate
- Replace POWEROFF_PRIORITY_xxx with POWER_OFF_PRIORITY_xxx
v2:
- Use define to specify poweroff handler priority

 arch/ia64/sn/kernel/setup.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/ia64/sn/kernel/setup.c b/arch/ia64/sn/kernel/setup.c
index 5f6b6b4..fc9905e 100644
--- a/arch/ia64/sn/kernel/setup.c
+++ b/arch/ia64/sn/kernel/setup.c
@@ -488,12 +488,13 @@ void __init sn_setup(char **cmdline_p)
 	sn_timer_init();
 
 	/*
-	 * set pm_power_off to a SAL call to allow
+	 * set power-off handler to a SAL call to allow
 	 * sn machines to power off. The SAL call can be replaced
 	 * by an ACPI interface call when ACPI is fully implemented
 	 * for sn.
 	 */
-	pm_power_off = ia64_sn_power_down;
+	register_power_off_handler_simple(ia64_sn_power_down,
+					  POWER_OFF_PRIORITY_LOW);
 	current->thread.flags |= IA64_THREAD_MIGRATION;
 }
 
-- 
1.9.1

