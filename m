From: Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH RFC 06/11] thermal: Remove ARCH_KIRKWOOD dependency
Date: Thu, 15 May 2014 16:23:51 +0200
Message-ID: <1400163836-9831-11-git-send-email-andrew@lunn.ch>
References: <1400163836-9831-1-git-send-email-andrew@lunn.ch>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from vps0.lunn.ch ([178.209.37.122]:44672 "EHLO vps0.lunn.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751174AbaEOO1O (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 15 May 2014 10:27:14 -0400
In-Reply-To: <1400163836-9831-1-git-send-email-andrew@lunn.ch>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux ARM <linux-arm-kernel@lists.infradead.org>, Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>, Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org

mach-kirkwood has been removed, now that kirkwood lives in mach-mvebu.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Cc: Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm@vger.kernel.org
---
 drivers/thermal/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index 2d51912a6e40..14d15043b6f2 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -143,7 +143,7 @@ config RCAR_THERMAL
 
 config KIRKWOOD_THERMAL
 	tristate "Temperature sensor on Marvell Kirkwood SoCs"
-	depends on ARCH_KIRKWOOD || MACH_KIRKWOOD
+	depends on MACH_KIRKWOOD
 	depends on OF
 	help
 	  Support for the Kirkwood thermal sensor driver into the Linux thermal
-- 
2.0.0.rc2

