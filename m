From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH] CPUFREQ: Loongson2: constify platform_device_id
Date: Sun, 13 Aug 2017 15:10:06 +0530
Message-ID: <38726390c030dc256d7dd169a416bc4a9814cbf7.1502617113.git.arvind.yadav.cs@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:36819 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750955AbdHMJkU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 13 Aug 2017 05:40:20 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

platform_device_id are not supposed to change at runtime. All functions
working with platform_device_id provided by <linux/platform_device.h>
work with const platform_device_id. So mark the non-const structs as
const.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/cpufreq/loongson2_cpufreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/loongson2_cpufreq.c b/drivers/cpufreq/loongson2_cpufreq.c
index 9ac27b2..da34469 100644
--- a/drivers/cpufreq/loongson2_cpufreq.c
+++ b/drivers/cpufreq/loongson2_cpufreq.c
@@ -114,7 +114,7 @@ static struct cpufreq_driver loongson2_cpufreq_driver = {
 	.attr = cpufreq_generic_attr,
 };
 
-static struct platform_device_id platform_device_ids[] = {
+static const struct platform_device_id platform_device_ids[] = {
 	{
 		.name = "loongson2_cpufreq",
 	},
-- 
2.7.4
