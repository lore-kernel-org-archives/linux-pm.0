From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH] devfreq: exynos-ppmu: Staticize event list
Date: Wed,  7 Jun 2017 20:12:28 +0200
Message-ID: <20170607181228.32102-1-krzk@kernel.org>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Chanwoo Choi <cw00.choi@samsung.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

The ppmu_events array is accessed only in this compilation unit so it
can be made static.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/devfreq/event/exynos-ppmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/devfreq/event/exynos-ppmu.c b/drivers/devfreq/event/exynos-ppmu.c
index 9b7350935b73..c68f3b5a10b5 100644
--- a/drivers/devfreq/event/exynos-ppmu.c
+++ b/drivers/devfreq/event/exynos-ppmu.c
@@ -44,7 +44,7 @@ struct exynos_ppmu {
 	{ "ppmu-event2-"#name, PPMU_PMNCNT2 },	\
 	{ "ppmu-event3-"#name, PPMU_PMNCNT3 }
 
-struct __exynos_ppmu_events {
+static struct __exynos_ppmu_events {
 	char *name;
 	int id;
 } ppmu_events[] = {
-- 
2.9.3
