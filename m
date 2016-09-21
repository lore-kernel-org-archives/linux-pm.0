From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] PM / devfreq: exynos-ppmu: ppmu_events array should not be NULL terminated
Date: Wed, 21 Sep 2016 08:30:40 +0800
Message-ID: <1474417840-7999-1-git-send-email-axel.lin@ingics.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Cc: Chanwoo Choi <cw00.choi@samsung.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
List-Id: linux-pm@vger.kernel.org

The rest of the code uses ARRAY_SIZE to count the number of entries in
ppmu_events array. The NULL terminated entry makes ARRAY_SIZE return
off-by-one value.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/devfreq/event/exynos-ppmu.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/devfreq/event/exynos-ppmu.c b/drivers/devfreq/event/exynos-ppmu.c
index f55cf0e..c9ffaf0 100644
--- a/drivers/devfreq/event/exynos-ppmu.c
+++ b/drivers/devfreq/event/exynos-ppmu.c
@@ -90,8 +90,6 @@ struct __exynos_ppmu_events {
 	PPMU_EVENT(d1-cpu),
 	PPMU_EVENT(d1-general),
 	PPMU_EVENT(d1-rt),
-
-	{ /* sentinel */ },
 };
 
 static int exynos_ppmu_find_ppmu_id(struct devfreq_event_dev *edev)
-- 
2.7.4
