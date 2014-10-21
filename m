From: Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v2 39/47] m68k: Register with kernel poweroff handler
Date: Mon, 20 Oct 2014 21:12:55 -0700
Message-ID: <1413864783-3271-40-git-send-email-linux@roeck-us.net>
References: <1413864783-3271-1-git-send-email-linux@roeck-us.net>
Return-path: <linux-m68k-owner@vger.kernel.org>
In-Reply-To: <1413864783-3271-1-git-send-email-linux@roeck-us.net>
Sender: linux-m68k-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, Geert Uytterhoeven <geert@linux-m68k.org>, Joshua Thompson <funaho@jurai.org>, linux-m68k@lists.linux-m68k.org
List-Id: linux-pm@vger.kernel.org

Register with kernel poweroff handler instead of setting pm_power_off
directly.

Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Joshua Thompson <funaho@jurai.org>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
- Use defines to specify poweroff handler priorities

 arch/m68k/emu/natfeat.c | 3 ++-
 arch/m68k/mac/config.c  | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/m68k/emu/natfeat.c b/arch/m68k/emu/natfeat.c
index 91e2ae7..b105681 100644
--- a/arch/m68k/emu/natfeat.c
+++ b/arch/m68k/emu/natfeat.c
@@ -91,5 +91,6 @@ void __init nf_init(void)
 	pr_info("NatFeats found (%s, %lu.%lu)\n", buf, version >> 16,
 		version & 0xffff);
 
-	pm_power_off = nf_poweroff;
+	register_power_off_handler_simple(nf_poweroff,
+					  POWEROFF_PRIORITY_DEFAULT);
 }
diff --git a/arch/m68k/mac/config.c b/arch/m68k/mac/config.c
index 677913ff..07e853e 100644
--- a/arch/m68k/mac/config.c
+++ b/arch/m68k/mac/config.c
@@ -160,7 +160,8 @@ void __init config_mac(void)
 	mach_set_clock_mmss = mac_set_clock_mmss;
 	mach_reset = mac_reset;
 	mach_halt = mac_poweroff;
-	pm_power_off = mac_poweroff;
+	register_power_off_handler_simple(mac_poweroff,
+					  POWEROFF_PRIORITY_DEFAULT);
 	mach_max_dma_address = 0xffffffff;
 #if defined(CONFIG_INPUT_M68K_BEEP) || defined(CONFIG_INPUT_M68K_BEEP_MODULE)
 	mach_beep = mac_mksound;
-- 
1.9.1
