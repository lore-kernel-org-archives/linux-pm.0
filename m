From: Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v5 39/48] m68k: Register with kernel power-off handler
Date: Thu,  6 Nov 2014 08:43:23 -0800
Message-ID: <1415292213-28652-40-git-send-email-linux@roeck-us.net>
References: <1415292213-28652-1-git-send-email-linux@roeck-us.net>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:56494 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752347AbaKFQpS (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 6 Nov 2014 11:45:18 -0500
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
	(envelope-from <linux@roeck-us.net>)
	id 1XmQBS-000Vyd-24
	for linux-pm@vger.kernel.org; Thu, 06 Nov 2014 16:45:18 +0000
In-Reply-To: <1415292213-28652-1-git-send-email-linux@roeck-us.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, Geert Uytterhoeven <geert@linux-m68k.org>, Joshua Thompson <funaho@jurai.org>, linux-m68k@lists.linux-m68k.org

Register with kernel power-off handler instead of setting pm_power_off
directly.

Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Joshua Thompson <funaho@jurai.org>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
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
- Use defines to specify poweroff handler priorities

 arch/m68k/emu/natfeat.c | 3 ++-
 arch/m68k/mac/config.c  | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/m68k/emu/natfeat.c b/arch/m68k/emu/natfeat.c
index 91e2ae7..38fec50 100644
--- a/arch/m68k/emu/natfeat.c
+++ b/arch/m68k/emu/natfeat.c
@@ -91,5 +91,6 @@ void __init nf_init(void)
 	pr_info("NatFeats found (%s, %lu.%lu)\n", buf, version >> 16,
 		version & 0xffff);
 
-	pm_power_off = nf_poweroff;
+	register_power_off_handler_simple(nf_poweroff,
+					  POWER_OFF_PRIORITY_DEFAULT);
 }
diff --git a/arch/m68k/mac/config.c b/arch/m68k/mac/config.c
index 677913ff..14fd981 100644
--- a/arch/m68k/mac/config.c
+++ b/arch/m68k/mac/config.c
@@ -160,7 +160,8 @@ void __init config_mac(void)
 	mach_set_clock_mmss = mac_set_clock_mmss;
 	mach_reset = mac_reset;
 	mach_halt = mac_poweroff;
-	pm_power_off = mac_poweroff;
+	register_power_off_handler_simple(mac_poweroff,
+					  POWER_OFF_PRIORITY_DEFAULT);
 	mach_max_dma_address = 0xffffffff;
 #if defined(CONFIG_INPUT_M68K_BEEP) || defined(CONFIG_INPUT_M68K_BEEP_MODULE)
 	mach_beep = mac_mksound;
-- 
1.9.1

