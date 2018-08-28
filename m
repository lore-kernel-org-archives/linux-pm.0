From: Rob Herring <robh@kernel.org>
Subject: [PATCH] devfreq: Convert to using %pOFn instead of device_node.name
Date: Mon, 27 Aug 2018 20:52:16 -0500
Message-ID: <20180828015252.28511-15-robh@kernel.org>
References: <20180828015252.28511-1-robh@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180828015252.28511-1-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Chanwoo Choi <cw00.choi@samsung.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

In preparation to remove the node name pointer from struct device_node,
convert printf users to use the %pOFn format specifier.

Cc: Chanwoo Choi <cw00.choi@samsung.com>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>
Cc: Kyungmin Park <kyungmin.park@samsung.com>
Cc: Kukjin Kim <kgene@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-pm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-samsung-soc@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/devfreq/event/exynos-ppmu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/devfreq/event/exynos-ppmu.c b/drivers/devfreq/event/exynos-ppmu.c
index a9c64f0d3284..c61de0bdf053 100644
--- a/drivers/devfreq/event/exynos-ppmu.c
+++ b/drivers/devfreq/event/exynos-ppmu.c
@@ -535,8 +535,8 @@ static int of_get_devfreq_events(struct device_node *np,
 
 		if (i == ARRAY_SIZE(ppmu_events)) {
 			dev_warn(dev,
-				"don't know how to configure events : %s\n",
-				node->name);
+				"don't know how to configure events : %pOFn\n",
+				node);
 			continue;
 		}
 
-- 
2.17.1
