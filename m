From: Gregory CLEMENT <gregory.clement@bootlin.com>
Subject: [PATCH 1/2] cpufreq: armada-37xx: fix clock parenting
Date: Fri,  8 Mar 2019 17:47:09 +0100
Message-ID: <20190308164710.10597-2-gregory.clement@bootlin.com>
References: <20190308164710.10597-1-gregory.clement@bootlin.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20190308164710.10597-1-gregory.clement@bootlin.com>
Sender: stable-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org
Cc: Christian Neubert <christian.neubert.86@gmail.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory CLEMENT <gregory.clement@bootlin.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, linux-arm-kernel@lists.infradead.org, Antoine Tenart <antoine.tenart@bootlin.com>, =?UTF-8?q?Miqu=C3=A8l=20Raynal?= <miquel.raynal@bootlin.com>, Maxime Chevallier <maxime.chevallier@bootlin.com>, stable@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

From: Christian Neubert <christian.neubert.86@gmail.com>

The clock parenting was not setup properly when DVFS was enabled. It was
expected that the same clock source was used with and without DVFS which
was not the case.

This patch fixes this issue, allowing to make the cpufreq support work
when the CPU clock source are not the default ones.

Fixes: 92ce45fb875d ("cpufreq: Add DVFS support for Armada 37xx")
Cc: <stable@vger.kernel.org>
[gregory: extract from a larger patch, modify comments and commit log]
Signed-off-by: Christian Neubert <christian.neubert.86@gmail.com>
Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
---
 drivers/cpufreq/armada-37xx-cpufreq.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/armada-37xx-cpufreq.c b/drivers/cpufreq/armada-37xx-cpufreq.c
index 75491fc841a6..ad4463e4266e 100644
--- a/drivers/cpufreq/armada-37xx-cpufreq.c
+++ b/drivers/cpufreq/armada-37xx-cpufreq.c
@@ -162,11 +162,25 @@ static void __init armada37xx_cpufreq_dvfs_setup(struct regmap *base,
 	}
 
 	/*
-	 * Set cpu clock source, for all the level we keep the same
-	 * clock source that the one already configured. For this one
-	 * we need to use the clock framework
+	 * Set CPU clock source, for all the level we keep the same
+	 * clock source that the one already configured with DVS
+	 * disabled. For this one we need to use the clock framework
 	 */
 	parent = clk_get_parent(clk);
+
+	/*
+	 * Unset parent clock to force the clock framework setting again
+	 * the clock parent
+	 */
+	clk_set_parent(clk, NULL);
+
+	/*
+	 * For the Armada 37xx CPU clocks, setting the parent will
+	 * actually configure the parent when DVFS is enabled. At
+	 * hardware level it will be a different register from the one
+	 * read when doing clk_get_parent that will be set with
+	 * clk_set_parent.
+	 */
 	clk_set_parent(clk, parent);
 }
 
-- 
2.20.1
