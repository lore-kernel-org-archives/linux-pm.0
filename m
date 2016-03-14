From: Michael Turquette <mturquette@baylibre.com>
Subject: [PATCH 4/8] cpufreq/schedutil: sysfs capacity margin tunable
Date: Sun, 13 Mar 2016 22:22:08 -0700
Message-ID: <1457932932-28444-5-git-send-email-mturquette+renesas@baylibre.com>
References: <1457932932-28444-1-git-send-email-mturquette+renesas@baylibre.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:36308 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933422AbcCNF0W (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 14 Mar 2016 01:26:22 -0400
Received: by mail-pa0-f52.google.com with SMTP id tt10so149508076pab.3
        for <linux-pm@vger.kernel.org>; Sun, 13 Mar 2016 22:26:22 -0700 (PDT)
In-Reply-To: <1457932932-28444-1-git-send-email-mturquette+renesas@baylibre.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: peterz@infradead.org, rjw@rjwysocki.net
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Juri.Lelli@arm.com, steve.muckle@linaro.org, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, vincent.guittot@linaro.org, Michael Turquette <mturquette+renesas@baylibre.com>

With the addition of the global cfs capacity margin helpers in patch,
"sched/cpufreq: new cfs capacity margin helpers", we can now export
sysfs tunables from the schedutil governor. This allows privileged users
to tune the value more easily.

The margin value is global to cfs, not per-policy. As such schedutil
does not store any state about the margin. Schedutil restores the margin
value to its default value when exiting.

Signed-off-by: Michael Turquette <mturquette+renesas@baylibre.com>
---
 drivers/cpufreq/cpufreq_schedutil.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/cpufreq/cpufreq_schedutil.c b/drivers/cpufreq/cpufreq_schedutil.c
index 5aa26bf..12e49b9 100644
--- a/drivers/cpufreq/cpufreq_schedutil.c
+++ b/drivers/cpufreq/cpufreq_schedutil.c
@@ -246,8 +246,32 @@ static ssize_t rate_limit_us_store(struct gov_attr_set *attr_set, const char *bu
 
 static struct governor_attr rate_limit_us = __ATTR_RW(rate_limit_us);
 
+static ssize_t capacity_margin_show(struct gov_attr_set *not_used,
+					   char *buf)
+{
+	return sprintf(buf, "%lu\n", cpufreq_get_cfs_capacity_margin());
+}
+
+static ssize_t capacity_margin_store(struct gov_attr_set *attr_set,
+				  const char *buf, size_t count)
+{
+	unsigned long margin;
+	int ret;
+
+	ret = sscanf(buf, "%lu", &margin);
+	if (ret != 1)
+		return -EINVAL;
+
+	cpufreq_set_cfs_capacity_margin(margin);
+
+	return count;
+}
+
+static struct governor_attr capacity_margin = __ATTR_RW(capacity_margin);
+
 static struct attribute *sugov_attributes[] = {
 	&rate_limit_us.attr,
+	&capacity_margin.attr,
 	NULL
 };
 
@@ -381,6 +405,7 @@ static int sugov_exit(struct cpufreq_policy *policy)
 
 	mutex_lock(&global_tunables_lock);
 
+	cpufreq_reset_cfs_capacity_margin();
 	count = gov_attr_set_put(&tunables->attr_set, &sg_policy->tunables_hook);
 	policy->governor_data = NULL;
 	if (!count)
-- 
2.1.4

