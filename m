From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] thermal/drivers/hisi: Remove bogus const from function return type
Date: Sun, 19 Nov 2017 12:04:27 +0100
Message-ID: <1511089467-20525-1-git-send-email-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from andre.telenet-ops.be ([195.130.132.53]:56140 "EHLO
        andre.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750806AbdKSLEb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 19 Nov 2017 06:04:31 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Kevin Wangtao <kevin.wangtao@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>

With gcc-4.1.2:

    drivers/thermal/hisi_thermal.c: In function ‘hisi_thermal_probe’:
    drivers/thermal/hisi_thermal.c:530: warning: type qualifiers ignored on function return type

Remove the "const" keyword to fix this.

Fixes: a160a465297362c5 ("thermal/drivers/hisi: Prepare to add support for other hisi platforms")
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/thermal/hisi_thermal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/hisi_thermal.c b/drivers/thermal/hisi_thermal.c
index 2d855a96cdd9886c..761d0559c268b606 100644
--- a/drivers/thermal/hisi_thermal.c
+++ b/drivers/thermal/hisi_thermal.c
@@ -527,7 +527,7 @@ static void hisi_thermal_toggle_sensor(struct hisi_thermal_sensor *sensor,
 static int hisi_thermal_probe(struct platform_device *pdev)
 {
 	struct hisi_thermal_data *data;
-	int const (*platform_probe)(struct hisi_thermal_data *);
+	int (*platform_probe)(struct hisi_thermal_data *);
 	struct device *dev = &pdev->dev;
 	int ret;
 
-- 
2.7.4
