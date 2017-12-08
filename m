From: Andrew-sh Cheng <andrew-sh.cheng@mediatek.com>
Subject: [PATCH v1 2/4] cpufreq: mediatek: Add mediatek related projects into blacklist
Date: Fri, 8 Dec 2017 14:07:56 +0800
Message-ID: <1512713278-17807-3-git-send-email-andrew-sh.cheng@mediatek.com>
References: <1512713278-17807-1-git-send-email-andrew-sh.cheng@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1512713278-17807-1-git-send-email-andrew-sh.cheng@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net, viresh.kumar@linaro.org, matthias.bgg@gmail.com, mark.rutland@arm.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com, robh+dt@kernel.org, devicetree@vger.kernel.org, Andrew-sh Cheng <andrew-sh.cheng@mediatek.com>
List-Id: linux-pm@vger.kernel.org

mediatek projects will use mediate-cpufreq.c as cpufreq driver,
instead of using cpufreq_dt.c
Add mediatek related projects into cpufreq-dt blacklist

Signed-off-by: Andrew-sh Cheng <andrew-sh.cheng@mediatek.com>
---
 drivers/cpufreq/cpufreq-dt-platdev.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
index ecc56e2..3b585e4 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -108,6 +108,14 @@ static const struct of_device_id blacklist[] __initconst = {
 
 	{ .compatible = "marvell,armadaxp", },
 
+	{ .compatible = "mediatek,mt2701", },
+	{ .compatible = "mediatek,mt2712", },
+	{ .compatible = "mediatek,mt7622", },
+	{ .compatible = "mediatek,mt7623", },
+	{ .compatible = "mediatek,mt817x", },
+	{ .compatible = "mediatek,mt8173", },
+	{ .compatible = "mediatek,mt8176", },
+
 	{ .compatible = "nvidia,tegra124", },
 
 	{ .compatible = "st,stih407", },
-- 
2.6.4
