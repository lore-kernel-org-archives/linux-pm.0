From: Helge Deller <deller@gmx.de>
Subject: [PATCH 07/14] power/avs: Use %pS printk format for direct addresses
Date: Wed,  6 Sep 2017 22:27:54 +0200
Message-ID: <1504729681-3504-8-git-send-email-deller@gmx.de>
References: <1504729681-3504-1-git-send-email-deller@gmx.de>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.15]:60458 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753082AbdIFU2r (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 6 Sep 2017 16:28:47 -0400
In-Reply-To: <1504729681-3504-1-git-send-email-deller@gmx.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Petr Mladek <pmladek@suse.com>, Andrew Morton <akpm@linux-foundation.org>, Kevin Hilman <khilman@kernel.org>, Nishanth Menon <nm@ti.com>, linux-pm@vger.kernel.org

Use the %pS instead of the %pF printk format specifier for printing symbols
from direct addresses. This is needed for the ia64, ppc64 and parisc64
architectures.

Signed-off-by: Helge Deller <deller@gmx.de>
Cc: Kevin Hilman <khilman@kernel.org>
Cc: Nishanth Menon <nm@ti.com>
Cc: linux-pm@vger.kernel.org
---
 drivers/power/avs/smartreflex.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/power/avs/smartreflex.c b/drivers/power/avs/smartreflex.c
index 974fd68..89bf4d6 100644
--- a/drivers/power/avs/smartreflex.c
+++ b/drivers/power/avs/smartreflex.c
@@ -355,7 +355,7 @@ int sr_configure_errgen(struct omap_sr *sr)
 	u8 senp_shift, senn_shift;
 
 	if (!sr) {
-		pr_warn("%s: NULL omap_sr from %pF\n",
+		pr_warn("%s: NULL omap_sr from %pS\n",
 			__func__, (void *)_RET_IP_);
 		return -EINVAL;
 	}
@@ -422,7 +422,7 @@ int sr_disable_errgen(struct omap_sr *sr)
 	u32 vpboundint_en, vpboundint_st;
 
 	if (!sr) {
-		pr_warn("%s: NULL omap_sr from %pF\n",
+		pr_warn("%s: NULL omap_sr from %pS\n",
 			__func__, (void *)_RET_IP_);
 		return -EINVAL;
 	}
@@ -477,7 +477,7 @@ int sr_configure_minmax(struct omap_sr *sr)
 	u8 senp_shift, senn_shift;
 
 	if (!sr) {
-		pr_warn("%s: NULL omap_sr from %pF\n",
+		pr_warn("%s: NULL omap_sr from %pS\n",
 			__func__, (void *)_RET_IP_);
 		return -EINVAL;
 	}
@@ -562,7 +562,7 @@ int sr_enable(struct omap_sr *sr, unsigned long volt)
 	int ret;
 
 	if (!sr) {
-		pr_warn("%s: NULL omap_sr from %pF\n",
+		pr_warn("%s: NULL omap_sr from %pS\n",
 			__func__, (void *)_RET_IP_);
 		return -EINVAL;
 	}
@@ -614,7 +614,7 @@ int sr_enable(struct omap_sr *sr, unsigned long volt)
 void sr_disable(struct omap_sr *sr)
 {
 	if (!sr) {
-		pr_warn("%s: NULL omap_sr from %pF\n",
+		pr_warn("%s: NULL omap_sr from %pS\n",
 			__func__, (void *)_RET_IP_);
 		return;
 	}
-- 
2.1.0
