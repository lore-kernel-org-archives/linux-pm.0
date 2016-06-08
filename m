From: Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH] power/reset: make syscon_poweroff() static
Date: Wed,  8 Jun 2016 19:28:54 +0100
Message-ID: <1465410534-29694-1-git-send-email-ben.dooks@codethink.co.uk>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from 82-70-136-246.dsl.in-addr.zen.co.uk ([82.70.136.246]:53790 "EHLO
	rainbowdash.ducie.codethink.co.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753815AbcFHS3F (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 8 Jun 2016 14:29:05 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@lists.codethink.co.uk
Cc: Ben Dooks <ben.dooks@codethink.co.uk>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org

The syscon_poweroff() function is not exported or declared for
usage elsewhere, so make it static to avoid the folloiwing warning:

drivers/power/reset/syscon-poweroff.c:33:6: warning: symbol 'syscon_poweroff' was not declared. Should it be static?

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
Cc: Sebastian Reichel <sre@kernel.org>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: linux-pm@vger.kernel.org
---
 drivers/power/reset/syscon-poweroff.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/reset/syscon-poweroff.c b/drivers/power/reset/syscon-poweroff.c
index 5560b0d..b683383 100644
--- a/drivers/power/reset/syscon-poweroff.c
+++ b/drivers/power/reset/syscon-poweroff.c
@@ -30,7 +30,7 @@ static struct regmap *map;
 static u32 offset;
 static u32 mask;
 
-void syscon_poweroff(void)
+static void syscon_poweroff(void)
 {
 	/* Issue the poweroff */
 	regmap_write(map, offset, mask);
-- 
2.8.1

