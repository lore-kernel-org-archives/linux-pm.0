From: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
Subject: [RFC 3/4] PM / devfreq: exynos-bus: add support for suspend OPP
Date: Wed, 23 Nov 2016 14:51:26 +0100
Message-ID: <1479909087-22659-4-git-send-email-tjakobi@math.uni-bielefeld.de>
References: <1479909087-22659-1-git-send-email-tjakobi@math.uni-bielefeld.de>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1479909087-22659-1-git-send-email-tjakobi@math.uni-bielefeld.de>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-samsung-soc@vger.kernel.org
Cc: linux-pm@vger.kernel.org, m.reichl@fivetechno.de, myungjoo.ham@gmail.com, cw00.choi@samsung.com, Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
List-Id: linux-pm@vger.kernel.org

TODO: write desc
Signed-off-by: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
---
 drivers/devfreq/exynos-bus.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/devfreq/exynos-bus.c b/drivers/devfreq/exynos-bus.c
index 29866f7..8a91970 100644
--- a/drivers/devfreq/exynos-bus.c
+++ b/drivers/devfreq/exynos-bus.c
@@ -335,6 +335,7 @@ static int exynos_bus_parse_of(struct device_node *np,
 			      struct exynos_bus *bus)
 {
 	struct device *dev = bus->dev;
+	struct dev_pm_opp *suspend_opp;
 	unsigned long rate;
 	int ret;
 
@@ -368,6 +369,13 @@ static int exynos_bus_parse_of(struct device_node *np,
 		ret = PTR_ERR(bus->curr_opp);
 		goto err_opp;
 	}
+
+	suspend_opp = dev_pm_opp_get_suspend_opp(dev);
+	if (suspend_opp) {
+		bus->devfreq->suspend_freq = dev_pm_opp_get_freq(suspend_opp);
+		printk("DEBUG: suspend opp found!\n");
+	}
+
 	rcu_read_unlock();
 
 	return 0;
-- 
2.7.3
