From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH] devfreq: event: Add 'const' keyword for devfreq_event_ops
 structure
Date: Tue, 10 Mar 2015 09:27:35 +0900
Message-ID: <1425947255-375-1-git-send-email-cw00.choi@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: myungjoo.ham@samsung.com
Cc: kyungmin.park@samsung.com, rafael.j.wysocki@intel.com, kgene.kim@samsung.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Chanwoo Choi <cw00.choi@samsung.com>
List-Id: linux-pm@vger.kernel.org

This patch adds the 'const' keyword for devfreq_event_ops structure
because the ops of devfreq_event_desc structure shold not be changed
after initialization.

Cc: Myungjoo Ham <myungjoo.ham@samsung.com>
Cc: Kyungmin Park <kyungmin.park@samsung.com>
Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 drivers/devfreq/event/exynos-ppmu.c | 2 +-
 include/linux/devfreq-event.h       | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/devfreq/event/exynos-ppmu.c b/drivers/devfreq/event/exynos-ppmu.c
index ad83473..7d99d13 100644
--- a/drivers/devfreq/event/exynos-ppmu.c
+++ b/drivers/devfreq/event/exynos-ppmu.c
@@ -194,7 +194,7 @@ static int exynos_ppmu_get_event(struct devfreq_event_dev *edev,
 	return 0;
 }
 
-static struct devfreq_event_ops exynos_ppmu_ops = {
+static const struct devfreq_event_ops exynos_ppmu_ops = {
 	.disable = exynos_ppmu_disable,
 	.set_event = exynos_ppmu_set_event,
 	.get_event = exynos_ppmu_get_event,
diff --git a/include/linux/devfreq-event.h b/include/linux/devfreq-event.h
index 602fbbf..0a83a1e 100644
--- a/include/linux/devfreq-event.h
+++ b/include/linux/devfreq-event.h
@@ -91,7 +91,7 @@ struct devfreq_event_desc {
 	const char *name;
 	void *driver_data;
 
-	struct devfreq_event_ops *ops;
+	const struct devfreq_event_ops *ops;
 };
 
 #if defined(CONFIG_PM_DEVFREQ_EVENT)
-- 
1.8.5.5
