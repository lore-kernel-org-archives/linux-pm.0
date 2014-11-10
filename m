From: Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v6 37/48] avr32: atngw100: Register with kernel power-off handler
Date: Sun,  9 Nov 2014 17:42:54 -0800
Message-ID: <1415583785-6980-38-git-send-email-linux@roeck-us.net>
References: <1415583785-6980-1-git-send-email-linux@roeck-us.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1415583785-6980-1-git-send-email-linux@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, Haavard Skinnemoen <hskinnemoen@gmail.com>, Hans-Christian Egtvedt <egtvedt@samfundet.no>
List-Id: linux-pm@vger.kernel.org

Register with kernel power-off handler instead of setting pm_power_off
directly.

Cc: Haavard Skinnemoen <hskinnemoen@gmail.com>
Cc: Hans-Christian Egtvedt <egtvedt@samfundet.no>
Acked-by: Hans-Christian Egtvedt <egtvedt@samfundet.no>
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

 arch/avr32/boards/atngw100/mrmt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/avr32/boards/atngw100/mrmt.c b/arch/avr32/boards/atngw100/mrmt.c
index 91146b4..166c2e1 100644
--- a/arch/avr32/boards/atngw100/mrmt.c
+++ b/arch/avr32/boards/atngw100/mrmt.c
@@ -274,7 +274,8 @@ static int __init mrmt1_init(void)
 {
 	gpio_set_value( PIN_PWR_ON, 1 );	/* Ensure PWR_ON is enabled */
 
-	pm_power_off = mrmt_power_off;
+	register_power_off_handler_simple(mrmt_power_off,
+					  POWER_OFF_PRIORITY_DEFAULT);
 
 	/* Setup USARTS (other than console) */
 	at32_map_usart(2, 1, 0);	/* USART 2: /dev/ttyS1, RMT1:DB9M */
-- 
1.9.1
