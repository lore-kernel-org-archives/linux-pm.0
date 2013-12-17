From: Andrew Lunn <andrew@lunn.ch>
Subject: [RFC PATCH v5 2/4] mvebu: Dove: Indicate the architecture supports cpufreq.
Date: Tue, 17 Dec 2013 22:41:11 +0100
Message-ID: <1387316473-3250-3-git-send-email-andrew@lunn.ch>
References: <20131204145413.GD29200@e106331-lin.cambridge.arm.com>
 <1387316473-3250-1-git-send-email-andrew@lunn.ch>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from vps0.lunn.ch ([178.209.37.122]:34998 "EHLO vps0.lunn.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751942Ab3LQVl7 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 17 Dec 2013 16:41:59 -0500
In-Reply-To: <1387316473-3250-1-git-send-email-andrew@lunn.ch>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: mark.rutland@arm.com
Cc: rjw@rjwysocki.net, Jason Cooper <jason@lakedaemon.net>, linux ARM <linux-arm-kernel@lists.infradead.org>, linux-pm@vger.kernel.org, Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>, Andrew Lunn <andrew@lunn.ch>

Enable ARCH_HAS_CPUFREQ so allowing the cpufreq framework to be
enabled.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Tested-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
 arch/arm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index c1f1a7eee953..908b02f8d901 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -500,6 +500,7 @@ config ARCH_IXP4XX
 
 config ARCH_DOVE
 	bool "Marvell Dove"
+	select ARCH_HAS_CPUFREQ
 	select ARCH_REQUIRE_GPIOLIB
 	select CPU_PJ4
 	select GENERIC_CLOCKEVENTS
-- 
1.8.5.1

