From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 1/3] thermal: tegra: Combine two function calls into one in
 regs_show()
Date: Sun, 7 May 2017 11:51:47 +0200
Message-ID: <4623bb17-1dd8-2038-e465-5fe3309e22ba@users.sourceforge.net>
References: <b0795133-ebb9-56b3-567d-b3773f298789@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.15.4]:52324 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751342AbdEGXZh (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 7 May 2017 19:25:37 -0400
In-Reply-To: <b0795133-ebb9-56b3-567d-b3773f298789@users.sourceforge.net>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Eduardo Valentin <edubezval@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Mikko Perttunen <mperttunen@nvidia.com>, Thierry Reding <thierry.reding@gmail.com>, Wei Ni <wni@nvidia.com>, Zhang Rui <rui.zhang@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 7 May 2017 10:50:35 +0200

A bit of data was put into a sequence by two separate function calls
at two places. Print the same data by single function calls instead.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/thermal/tegra/soctherm.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/tegra/soctherm.c b/drivers/thermal/tegra/soctherm.c
index 7d2db23d71a3..c5871f9b6596 100644
--- a/drivers/thermal/tegra/soctherm.c
+++ b/drivers/thermal/tegra/soctherm.c
@@ -706,9 +706,7 @@ static int regs_show(struct seq_file *s, void *data)
 	seq_printf(s, "PDIV: 0x%x\n", r);
 
 	r = readl(ts->regs + SENSOR_HOTSPOT_OFF);
-	seq_printf(s, "HOTSPOT: 0x%x\n", r);
-
-	seq_puts(s, "\n");
+	seq_printf(s, "HOTSPOT: 0x%x\n\n", r);
 	seq_puts(s, "-----SOC_THERM-----\n");
 
 	r = readl(ts->regs + SENSOR_TEMP1);
@@ -809,9 +807,7 @@ static int regs_show(struct seq_file *s, void *data)
 	}
 
 	r = readl(ts->regs + THROT_GLOBAL_CFG);
-	seq_puts(s, "\n");
-	seq_printf(s, "GLOBAL THROTTLE CONFIG: 0x%08x\n", r);
-
+	seq_printf(s, "\nGLOBAL THROTTLE CONFIG: 0x%08x\n", r);
 	seq_puts(s, "---------------------------------------------------\n");
 	r = readl(ts->regs + THROT_STATUS);
 	state = REG_GET_MASK(r, THROT_STATUS_BREACH_MASK);
-- 
2.12.2
