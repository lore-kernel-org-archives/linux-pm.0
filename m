From: Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v2 37/47] avr32: atngw100: Register with kernel poweroff handler
Date: Mon, 20 Oct 2014 21:12:53 -0700
Message-ID: <1413864783-3271-38-git-send-email-linux@roeck-us.net>
References: <1413864783-3271-1-git-send-email-linux@roeck-us.net>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:33940 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754595AbaJUEOp (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 21 Oct 2014 00:14:45 -0400
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
	(envelope-from <linux@roeck-us.net>)
	id 1XgQqK-002emB-JS
	for linux-pm@vger.kernel.org; Tue, 21 Oct 2014 04:14:44 +0000
In-Reply-To: <1413864783-3271-1-git-send-email-linux@roeck-us.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, Haavard Skinnemoen <hskinnemoen@gmail.com>, Hans-Christian Egtvedt <egtvedt@samfundet.no>

Register with kernel poweroff handler instead of setting pm_power_off
directly.

Cc: Haavard Skinnemoen <hskinnemoen@gmail.com>
Cc: Hans-Christian Egtvedt <egtvedt@samfundet.no>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
- Use define to specify poweroff handler priority

 arch/avr32/boards/atngw100/mrmt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/avr32/boards/atngw100/mrmt.c b/arch/avr32/boards/atngw100/mrmt.c
index 91146b4..833212e 100644
--- a/arch/avr32/boards/atngw100/mrmt.c
+++ b/arch/avr32/boards/atngw100/mrmt.c
@@ -274,7 +274,8 @@ static int __init mrmt1_init(void)
 {
 	gpio_set_value( PIN_PWR_ON, 1 );	/* Ensure PWR_ON is enabled */
 
-	pm_power_off = mrmt_power_off;
+	register_power_off_handler_simple(mrmt_power_off,
+					  POWEROFF_PRIORITY_DEFAULT);
 
 	/* Setup USARTS (other than console) */
 	at32_map_usart(2, 1, 0);	/* USART 2: /dev/ttyS1, RMT1:DB9M */
-- 
1.9.1

