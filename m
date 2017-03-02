From: Daniel Kurtz <djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH 2/2 v2] cpufreq: mediatek: Add support for MT8176 and MT817x
Date: Thu,  2 Mar 2017 19:03:45 +0800
Message-ID: <20170302110345.184924-2-djkurtz@chromium.org>
References: <20170302110345.184924-1-djkurtz@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <20170302110345.184924-1-djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mediatek/>
List-Post: <mailto:linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-mediatek" <linux-mediatek-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: Nicolas Boichat <drinkcat-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, "open list:CPU FREQUENCY DRIVERS" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, open list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Yidi Lin <yidi.lin-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "moderated list:ARM/Mediatek SoC support" <linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "moderated list:ARM/Mediatek SoC support" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

The Mediatek MT8173 is just one of several SOCs from the same MT817x family,
including the 6-core (4-little/2-big) MT8176.

The mt8173-cpufreq driver supports all of these SOCs, however, machines
using them may use a different machine compatible.

Since this driver checks explicitly for the machine compatible string, add
support for the whole family.

Signed-off-by: Daniel Kurtz <djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
---
This patch is based on the compatibles added by the MT8176 series:

 https://patchwork.kernel.org/patch/9573209/
 https://patchwork.kernel.org/patch/9573213/

v2:
 - use of_match_node (Thanks, Viresh!)

 drivers/cpufreq/mt8173-cpufreq.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/mt8173-cpufreq.c b/drivers/cpufreq/mt8173-cpufreq.c
index 72bc1192bd30..fd1886faf33a 100644
--- a/drivers/cpufreq/mt8173-cpufreq.c
+++ b/drivers/cpufreq/mt8173-cpufreq.c
@@ -573,14 +573,33 @@ static struct platform_driver mt8173_cpufreq_platdrv = {
 	.probe		= mt8173_cpufreq_probe,
 };
 
+/* List of machines supported by this driver */
+static const struct of_device_id mt8173_cpufreq_machines[] __initconst = {
+	{ .compatible = "mediatek,mt817x", },
+	{ .compatible = "mediatek,mt8173", },
+	{ .compatible = "mediatek,mt8176", },
+
+	{ }
+};
+
 static int __init mt8173_cpufreq_driver_init(void)
 {
+	struct device_node *np;
+	const struct of_device_id *match;
 	struct platform_device *pdev;
 	int err;
 
-	if (!of_machine_is_compatible("mediatek,mt8173"))
+	np = of_find_node_by_path("/");
+	if (!np)
 		return -ENODEV;
 
+	match = of_match_node(mt8173_cpufreq_machines, np);
+	of_node_put(np);
+	if (!match) {
+		pr_warn("Machine is not compatible with mt8173-cpufreq\n");
+		return -ENODEV;
+	}
+
 	err = platform_driver_register(&mt8173_cpufreq_platdrv);
 	if (err)
 		return err;
-- 
2.12.0.rc1.440.g5b76565f74-goog
