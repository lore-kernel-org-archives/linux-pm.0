From: Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v2 43/47] x86: ce4100: Register with kernel poweroff handler
Date: Mon, 20 Oct 2014 21:12:59 -0700
Message-ID: <1413864783-3271-44-git-send-email-linux@roeck-us.net>
References: <1413864783-3271-1-git-send-email-linux@roeck-us.net>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:33995 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754622AbaJUEO5 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 21 Oct 2014 00:14:57 -0400
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
	(envelope-from <linux@roeck-us.net>)
	id 1XgQqX-002fBG-4F
	for linux-pm@vger.kernel.org; Tue, 21 Oct 2014 04:14:57 +0000
In-Reply-To: <1413864783-3271-1-git-send-email-linux@roeck-us.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org

Register with kernel poweroff handler instead of setting pm_power_off
directly.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
- Use define to specify poweroff handler priority

 arch/x86/platform/ce4100/ce4100.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/platform/ce4100/ce4100.c b/arch/x86/platform/ce4100/ce4100.c
index 701fd58..379260e 100644
--- a/arch/x86/platform/ce4100/ce4100.c
+++ b/arch/x86/platform/ce4100/ce4100.c
@@ -164,5 +164,6 @@ void __init x86_ce4100_early_setup(void)
 	 */
 	reboot_type = BOOT_KBD;
 
-	pm_power_off = ce4100_power_off;
+	register_power_off_handler_simple(ce4100_power_off,
+					  POWEROFF_PRIORITY_DEFAULT);
 }
-- 
1.9.1

