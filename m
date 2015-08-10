From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V1 Resend 03/11] drivers: devfreq: Drop unlikely before IS_ERR(_OR_NULL)
Date: Mon, 10 Aug 2015 11:42:25 +0530
Message-ID: <403e6fde2cf56bec5294884c56920880acd4d67f.1439187003.git.viresh.kumar@linaro.org>
References: <cover.1439187003.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:36027 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752657AbbHJGNq (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 10 Aug 2015 02:13:46 -0400
Received: by pacrr5 with SMTP id rr5so96359701pac.3
        for <linux-pm@vger.kernel.org>; Sun, 09 Aug 2015 23:13:45 -0700 (PDT)
In-Reply-To: <cover.1439187003.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1439187003.git.viresh.kumar@linaro.org>
References: <cover.1439187003.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: akpm@linux-foundation.org
Cc: linaro-kernel@lists.linaro.org, linux-kernel@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, Kyungmin Park <kyungmin.park@samsung.com>, "open list:DEVICE FREQUENCY DEVFREQ" <linux-pm@vger.kernel.org>, MyungJoo Ham <myungjoo.ham@samsung.com>

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

