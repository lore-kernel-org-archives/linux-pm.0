From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH/RFC v6 6/7] PM / Domains: Retrieve PM QoS device latencies from DT
Date: Mon, 27 Apr 2015 14:43:41 +0200
Message-ID: <1430138622-14029-7-git-send-email-geert+renesas@glider.be>
References: <1430138622-14029-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1430138622-14029-1-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Axel Haslam <ahaslam@baylibre.com>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-pm@vger.kernel.org

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v6:
  - Rebased on top of v4.1-rc1 for new RFC,

v4:
  - Drop save/restore state latencies, as they're Linux driver-specific,
  - Change state to RFC, as this is put on hold,

v3:
  - No changes,

v2:
  - New.
---
 drivers/base/power/domain.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index d20caa2c92b57edf..da0b9f69919988bb 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -2193,6 +2193,8 @@ int genpd_dev_pm_attach(struct device *dev)
 	struct device_node *np = dev->of_node;
 	struct of_phandle_args pd_args;
 	struct generic_pm_domain *pd;
+	struct gpd_timing_data td;
+	u32 latency;
 	int ret;
 
 	if (!np)
@@ -2225,10 +2227,16 @@ int genpd_dev_pm_attach(struct device *dev)
 		return PTR_ERR(pd);
 	}
 
+	memset(&td, 0, sizeof(td));
+	if (!of_property_read_u32(np, "stop-latency", &latency))
+		td.stop_latency_ns = latency;
+	if (!of_property_read_u32(np, "start-latency", &latency))
+		td.start_latency_ns = latency;
+
 	dev_dbg(dev, "adding to PM domain %s\n", pd->name);
 
 	while (1) {
-		ret = pm_genpd_add_device(pd, dev);
+		ret = __pm_genpd_add_device(pd, dev, &td);
 		if (ret != -EAGAIN)
 			break;
 		cond_resched();
-- 
1.9.1

