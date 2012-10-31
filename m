From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH] cpufreq: remove the unnecessary initialization of a local
 variable
Date: Wed, 31 Oct 2012 14:49:13 +0900
Message-ID: <000901cdb72b$74a6af10$5df40d30$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:49749 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752517Ab2JaFtP (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 31 Oct 2012 01:49:15 -0400
Content-language: ko
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "'Rafael J. Wysocki'" <rafael.j.wysocki@intel.com>
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 'Jingoo Han' <jg1.han@samsung.com>

This patch removes unnecessary initializer for the 'ret' variable.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/cpufreq/cpufreq.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 261ef65..4e9fcc5 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -404,7 +404,7 @@ static int __cpufreq_set_policy(struct cpufreq_policy *data,
 static ssize_t store_##file_name					\
 (struct cpufreq_policy *policy, const char *buf, size_t count)		\
 {									\
-	unsigned int ret = -EINVAL;					\
+	unsigned int ret;						\
 	struct cpufreq_policy new_policy;				\
 									\
 	ret = cpufreq_get_policy(&new_policy, policy->cpu);		\
@@ -459,7 +459,7 @@ static ssize_t show_scaling_governor(struct cpufreq_policy *policy, char *buf)
 static ssize_t store_scaling_governor(struct cpufreq_policy *policy,
 					const char *buf, size_t count)
 {
-	unsigned int ret = -EINVAL;
+	unsigned int ret;
 	char	str_governor[16];
 	struct cpufreq_policy new_policy;
 
-- 
1.7.1


