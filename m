From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [PATCH 8/8] MAINTAINERS: add at91 power and memory entries
Date: Tue, 21 Oct 2014 23:55:40 +0200
Message-ID: <1413928540-27099-9-git-send-email-alexandre.belloni@free-electrons.com>
References: <1413928540-27099-1-git-send-email-alexandre.belloni@free-electrons.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1413928540-27099-1-git-send-email-alexandre.belloni@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolas Ferre <nicolas.ferre@atmel.com>, Sebastian Reichel <sre@kernel.org>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Alexandre Belloni <alexandre.belloni@free-electrons.com>
List-Id: linux-pm@vger.kernel.org

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 MAINTAINERS | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index a20df9bf8ab0..e325c81ee2fa 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -871,6 +871,25 @@ M:	Boris Brezillon <boris.brezillon@free-electrons.com>
 S:	Maintained
 F:	drivers/clk/at91
 
+ARM/ATMEL AT91 Poweroff driver
+M:	Alexandre Belloni <alexandre.belloni@free-electrons.com>
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
+S:	Maintained
+F:	drivers/power/reset/at91-poweroff.c
+
+ARM/ATMEL AT91 Reset driver
+M:	Alexandre Belloni <alexandre.belloni@free-electrons.com>
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
+S:	Maintained
+F:	drivers/power/reset/at91-reset.c
+
+ARM/ATMEL AT91 SDRAM Controlller driver
+M:	Alexandre Belloni <alexandre.belloni@free-electrons.com>
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
+S:	Maintained
+F:	drivers/memory/atmel-sdramc.c
+F:	include/soc/atmel/memory.h
+
 ARM/CALXEDA HIGHBANK ARCHITECTURE
 M:	Rob Herring <robh@kernel.org>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
-- 
1.9.1
