From: Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH] power/reset: at91: big endian fixes for atsama5d3x
Date: Thu, 26 Mar 2015 14:16:22 +0000
Message-ID: <1427379382-25328-1-git-send-email-ben.dooks@codethink.co.uk>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from ducie-dc1.codethink.co.uk ([185.25.241.215]:36289 "EHLO
	ducie-dc1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752348AbbCZOQ2 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 26 Mar 2015 10:16:28 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@lists.codethink.co.uk
Cc: Ben Dooks <ben.dooks@codethink.co.uk>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, Guenter Roeck <linux@roeck-us.net>, "open list:POWER SUPPLY CLAS..." <linux-pm@vger.kernel.org>

Fix the passing of big endian data to routines that will be writing
it to the bus in the wrong order.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
--
CC: Sebastian Reichel <sre@kernel.org> (maintainer:POWER SUPPLY CLAS...,commit_signer:2/5=40%)
CC: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com> (maintainer:POWER SUPPLY CLAS...)
CC: David Woodhouse <dwmw2@infradead.org> (maintainer:POWER SUPPLY CLAS...)
CC: Nicolas Ferre <nicolas.ferre@atmel.com> (commit_signer:3/5=60%)
CC: Alexandre Belloni <alexandre.belloni@free-electrons.com> (commit_signer:3/5=60%,authored:2/5=40%,removed_lines:4/18=22%)
CC: Maxime Ripard <maxime.ripard@free-electrons.com> (commit_signer:1/5=20%,authored:1/5=20%,added_lines:252/278=91%)
CC: Guenter Roeck <linux@roeck-us.net> (commit_signer:1/5=20%,authored:1/5=20%,added_lines:18/278=6%,removed_lines:10/18=56%)
CC: linux-pm@vger.kernel.org (open list:POWER SUPPLY CLAS...)
---
 drivers/power/reset/at91-reset.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/power/reset/at91-reset.c b/drivers/power/reset/at91-reset.c
index 13584e2..723fd2a 100644
--- a/drivers/power/reset/at91-reset.c
+++ b/drivers/power/reset/at91-reset.c
@@ -73,8 +73,8 @@ static int at91sam9260_restart(struct notifier_block *this, unsigned long mode,
 		: "r" (at91_ramc_base[0]),
 		  "r" (at91_rstc_base),
 		  "r" (1),
-		  "r" (AT91_SDRAMC_LPCB_POWER_DOWN),
-		  "r" (AT91_RSTC_KEY | AT91_RSTC_PERRST | AT91_RSTC_PROCRST));
+		  "r" cpu_to_le32(AT91_SDRAMC_LPCB_POWER_DOWN),
+		  "r" cpu_to_le32(AT91_RSTC_KEY | AT91_RSTC_PERRST | AT91_RSTC_PROCRST));
 
 	return NOTIFY_DONE;
 }
@@ -116,8 +116,8 @@ static int at91sam9g45_restart(struct notifier_block *this, unsigned long mode,
 		  "r" (at91_ramc_base[1]),
 		  "r" (at91_rstc_base),
 		  "r" (1),
-		  "r" (AT91_DDRSDRC_LPCB_POWER_DOWN),
-		  "r" (AT91_RSTC_KEY | AT91_RSTC_PERRST | AT91_RSTC_PROCRST)
+		  "r" cpu_to_le32(AT91_DDRSDRC_LPCB_POWER_DOWN),
+		  "r" cpu_to_le32(AT91_RSTC_KEY | AT91_RSTC_PERRST | AT91_RSTC_PROCRST)
 		: "r0");
 
 	return NOTIFY_DONE;
-- 
2.1.4

