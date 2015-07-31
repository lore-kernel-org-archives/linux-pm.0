From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 03/15] drivers: devfreq: Drop unlikely before IS_ERR(_OR_NULL)
Date: Fri, 31 Jul 2015 14:08:23 +0530
Message-ID: <f5b5229d0c8de64d9afb8663280c7b661d681438.1438331416.git.viresh.kumar@linaro.org>
References: <cover.1438331416.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1438331416.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1438331416.git.viresh.kumar@linaro.org>
References: <cover.1438331416.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: akpm@linux-foundation.org
Cc: linaro-kernel@lists.linaro.org, linux-kernel@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, Kyungmin Park <kyungmin.park@samsung.com>, "open list:DEVICE FREQUENCY DEVFREQ" <linux-pm@vger.kernel.org>, MyungJoo Ham <myungjoo.ham@samsung.com>
List-Id: linux-pm@vger.kernel.org

IS_ERR(_OR_NULL) already contain an 'unlikely' compiler flag and there
is no need to do that again from its callers. Drop it.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/devfreq/devfreq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index ca1b362d77e2..f28a1fae5691 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -53,7 +53,7 @@ static struct devfreq *find_device_devfreq(struct device *dev)
 {
 	struct devfreq *tmp_devfreq;
 
-	if (unlikely(IS_ERR_OR_NULL(dev))) {
+	if (IS_ERR_OR_NULL(dev)) {
 		pr_err("DEVFREQ: %s: Invalid parameters\n", __func__);
 		return ERR_PTR(-EINVAL);
 	}
@@ -133,7 +133,7 @@ static struct devfreq_governor *find_devfreq_governor(const char *name)
 {
 	struct devfreq_governor *tmp_governor;
 
-	if (unlikely(IS_ERR_OR_NULL(name))) {
+	if (IS_ERR_OR_NULL(name)) {
 		pr_err("DEVFREQ: %s: Invalid parameters\n", __func__);
 		return ERR_PTR(-EINVAL);
 	}
-- 
2.4.0
