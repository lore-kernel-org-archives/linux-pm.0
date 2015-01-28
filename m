From: Lukasz Majewski <l.majewski@samsung.com>
Subject: [PATCH] thermal: exynos: Correct sanity check at
 exynos_report_trigger() function
Date: Wed, 28 Jan 2015 16:25:22 +0100
Message-ID: <1422458722-23213-1-git-send-email-l.majewski@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:30397 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754202AbbA2Bgo (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 28 Jan 2015 20:36:44 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>, Dan Carpenter <dan.carpenter@oracle.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Linux PM list <linux-pm@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Lukasz Majewski <l.majewski@majess.pl>, Kukjin Kim <kgene.kim@samsung.com>, Amit Daniel Kachhap <amit.daniel@samsung.com>, Abhilash Kesavan <kesavan.abhilash@gmail.com>, Abhilash Kesavan <a.kesavan@samsung.com>, Kukjin Kim <kgene@kernel.org>, Chanwoo Choi <cw00.choi@samsung.com>, Lukasz Majewski <l.majewski@samsung.com>

Up till now, by mistake, wrong variable was tested against being NULL.
Since exynos_report_trigger() is always called with valid p pointer,
it is only necessary to check if a valid thermal zone device is passed.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
---
 drivers/thermal/samsung/exynos_tmu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index 852e622..178de03 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -172,8 +172,8 @@ static void exynos_report_trigger(struct exynos_tmu_data *p)
 	unsigned long temp;
 	unsigned int i;
 
-	if (!p) {
-		pr_err("Wrong temperature configuration data\n");
+	if (!tz) {
+		pr_err("No thermal zone device defined\n");
 		return;
 	}
 
-- 
2.0.0.rc2

