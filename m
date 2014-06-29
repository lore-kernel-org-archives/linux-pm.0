From: Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH 07/13] thermal: Replace ARCH_KIRKWOOD and ARCH_DOVE dependency
Date: Sun, 29 Jun 2014 22:59:56 +0200
Message-ID: <1404075603-31838-10-git-send-email-andrew@lunn.ch>
References: <1404075603-31838-1-git-send-email-andrew@lunn.ch>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from vps0.lunn.ch ([178.209.37.122]:38797 "EHLO vps0.lunn.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752940AbaF2VEn (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sun, 29 Jun 2014 17:04:43 -0400
In-Reply-To: <1404075603-31838-1-git-send-email-andrew@lunn.ch>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jason Cooper <jason@lakedaemon.net>, Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>
Cc: Gregory Clement <gregory.clement@free-electrons.com>, rmk+kernel@arm.linux.org.uk, Andrew Lunn <andrew@lunn.ch>, Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org

Both mach-kirkwood and mach-dove has been removed, now that these SoCs
live in mach-mvebu. Depend on MACH_KIRKWOOD and MACH_DOVE, which will
be set when these SoCs are built as part of ARCH_MVEBU.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Cc: Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm@vger.kernel.org
---
 drivers/thermal/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index f9a13867cb70..a0f1371517ee 100644
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
@@ -151,7 +151,7 @@ config KIRKWOOD_THERMAL
 
 config DOVE_THERMAL
 	tristate "Temperature sensor on Marvell Dove SoCs"
-	depends on ARCH_DOVE
+	depends on MACH_DOVE
 	depends on OF
 	help
 	  Support for the Dove thermal sensor driver in the Linux thermal
-- 
2.0.0

