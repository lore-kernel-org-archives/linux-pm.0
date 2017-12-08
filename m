From: Andrew-sh Cheng <andrew-sh.cheng@mediatek.com>
Subject: [PATCH v1 1/4] cpufreq: mediatek: add mt2712 into compatible list
Date: Fri, 8 Dec 2017 14:07:55 +0800
Message-ID: <1512713278-17807-2-git-send-email-andrew-sh.cheng@mediatek.com>
References: <1512713278-17807-1-git-send-email-andrew-sh.cheng@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailgw01.mediatek.com ([210.61.82.183]:60326 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750930AbdLHGI0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 8 Dec 2017 01:08:26 -0500
In-Reply-To: <1512713278-17807-1-git-send-email-andrew-sh.cheng@mediatek.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net, viresh.kumar@linaro.org, matthias.bgg@gmail.com, mark.rutland@arm.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com, robh+dt@kernel.org, devicetree@vger.kernel.org, Andrew-sh Cheng <andrew-sh.cheng@mediatek.com>

Support mt2712 in mediatek-cpufreq.c

Signed-off-by: Andrew-sh Cheng <andrew-sh.cheng@mediatek.com>
---
 drivers/cpufreq/mediatek-cpufreq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/mediatek-cpufreq.c b/drivers/cpufreq/mediatek-cpufreq.c
index 18c4bd9..62aec5c 100644
--- a/drivers/cpufreq/mediatek-cpufreq.c
+++ b/drivers/cpufreq/mediatek-cpufreq.c
@@ -574,6 +574,7 @@ static struct platform_driver mtk_cpufreq_platdrv = {
 /* List of machines supported by this driver */
 static const struct of_device_id mtk_cpufreq_machines[] __initconst = {
 	{ .compatible = "mediatek,mt2701", },
+	{ .compatible = "mediatek,mt2712", },
 	{ .compatible = "mediatek,mt7622", },
 	{ .compatible = "mediatek,mt7623", },
 	{ .compatible = "mediatek,mt817x", },
-- 
2.6.4
