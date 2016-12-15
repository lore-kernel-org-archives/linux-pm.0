From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH 3/7] PM / devfreq: exynos-bus: Print the real clock rate of bus
Date: Thu, 15 Dec 2016 18:30:39 +0900
Message-ID: <1481794243-5046-4-git-send-email-cw00.choi@samsung.com>
References: <1481794243-5046-1-git-send-email-cw00.choi@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1481794243-5046-1-git-send-email-cw00.choi@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: myungjoo.ham@samsung.com, kyungmin.park@samsung.com
Cc: rjw@rjwysocki.net, chanwoo@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Javier Martinez Canillas <javier@osg.samsung.com>, linux-samsung-soc@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

This patch shows the real clock rate after calling clk_set_rate()
to debug it.

Cc: Kukjin Kim <kgene@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Javier Martinez Canillas <javier@osg.samsung.com>
Cc: linux-samsung-soc@vger.kernel.org
Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 drivers/devfreq/exynos-bus.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/devfreq/exynos-bus.c b/drivers/devfreq/exynos-bus.c
index 9af86f46fbec..e0d1f4ac1740 100644
--- a/drivers/devfreq/exynos-bus.c
+++ b/drivers/devfreq/exynos-bus.c
@@ -147,8 +147,8 @@ static int exynos_bus_target(struct device *dev, unsigned long *freq, u32 flags)
 	}
 	bus->curr_freq = new_freq;
 
-	dev_dbg(dev, "Set the frequency of bus (%lukHz -> %lukHz)\n",
-			old_freq/1000, new_freq/1000);
+	dev_dbg(dev, "Set the frequency of bus (%luHz -> %luHz, %luHz)\n",
+			old_freq, new_freq, clk_get_rate(bus->clk));
 out:
 	mutex_unlock(&bus->lock);
 
@@ -241,8 +241,8 @@ static int exynos_bus_passive_target(struct device *dev, unsigned long *freq,
 	*freq = new_freq;
 	bus->curr_freq = new_freq;
 
-	dev_dbg(dev, "Set the frequency of bus (%lukHz -> %lukHz)\n",
-			old_freq/1000, new_freq/1000);
+	dev_dbg(dev, "Set the frequency of bus (%luHz -> %luHz, %luHz)\n",
+			old_freq, new_freq, clk_get_rate(bus->clk));
 out:
 	mutex_unlock(&bus->lock);
 
-- 
1.9.1
