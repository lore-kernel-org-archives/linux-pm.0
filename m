From: Andrew Lunn <andrew@lunn.ch>
Subject: [Patch v3] 1/7] cpuidle: kirkwood: Remove ARCH_KIRKWOOD dependency
Date: Sat, 30 Aug 2014 18:46:06 +0200
Message-ID: <1409417172-6846-2-git-send-email-andrew@lunn.ch>
References: <1409417172-6846-1-git-send-email-andrew@lunn.ch>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from vps0.lunn.ch ([178.209.37.122]:41990 "EHLO vps0.lunn.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751640AbaH3Qw0 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sat, 30 Aug 2014 12:52:26 -0400
In-Reply-To: <1409417172-6846-1-git-send-email-andrew@lunn.ch>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jason Cooper <jason@lakedaemon.net>
Cc: linux ARM <linux-arm-kernel@lists.infradead.org>, Andrew Lunn <andrew@lunn.ch>, Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org

mach-kirkwood has been removed, now that kirkwood lives in mach-mvebu.
Use MACH_KIRKWOOD, which is set when kirkwood is built as part of
mach-mvebu.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: linux-pm@vger.kernel.org
---
 drivers/cpuidle/Kconfig.arm | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpuidle/Kconfig.arm b/drivers/cpuidle/Kconfig.arm
index 38cff69ffe06..58bcd0d166ec 100644
--- a/drivers/cpuidle/Kconfig.arm
+++ b/drivers/cpuidle/Kconfig.arm
@@ -28,7 +28,7 @@ config ARM_HIGHBANK_CPUIDLE
 
 config ARM_KIRKWOOD_CPUIDLE
 	bool "CPU Idle Driver for Marvell Kirkwood SoCs"
-	depends on ARCH_KIRKWOOD || MACH_KIRKWOOD
+	depends on MACH_KIRKWOOD
 	help
 	  This adds the CPU Idle driver for Marvell Kirkwood SoCs.
 
-- 
2.1.0

