From: Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v6 44/48] x86: ce4100: Register with kernel power-off handler
Date: Sun,  9 Nov 2014 17:43:01 -0800
Message-ID: <1415583785-6980-45-git-send-email-linux@roeck-us.net>
References: <1415583785-6980-1-git-send-email-linux@roeck-us.net>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:39277 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752728AbaKJBpO (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 9 Nov 2014 20:45:14 -0500
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
	(envelope-from <linux@roeck-us.net>)
	id 1Xne2b-000XEA-Od
	for linux-pm@vger.kernel.org; Mon, 10 Nov 2014 01:45:13 +0000
In-Reply-To: <1415583785-6980-1-git-send-email-linux@roeck-us.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org

Register with kernel power-off handler instead of setting pm_power_off
directly.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v6:
- This patch: No change.
  Global: Replaced priority defines with enum.
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

 arch/x86/platform/ce4100/ce4100.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/platform/ce4100/ce4100.c b/arch/x86/platform/ce4100/ce4100.c
index 701fd58..1816bc1 100644
--- a/arch/x86/platform/ce4100/ce4100.c
+++ b/arch/x86/platform/ce4100/ce4100.c
@@ -164,5 +164,6 @@ void __init x86_ce4100_early_setup(void)
 	 */
 	reboot_type = BOOT_KBD;
 
-	pm_power_off = ce4100_power_off;
+	register_power_off_handler_simple(ce4100_power_off,
+					  POWER_OFF_PRIORITY_DEFAULT);
 }
-- 
1.9.1

