From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH] cpufreq: cpufreq_stats: constify attribute_group structures.
Date: Mon,  3 Jul 2017 13:29:04 +0530
Message-ID: <8211aa191c9b5924a804e4a3304cfb7534b77a13.1499068637.git.arvind.yadav.cs@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

attribute_groups are not supposed to change at runtime. All functions
working with attribute_groups provided by <linux/sysfs.h> work with const
attribute_group. So mark the non-const structs as const.

File size before:
   text	   data	    bss	    dec	    hex	filename
   1655	    256	      4	   1915	    77b	drivers/cpufreq/cpufreq_stats.o

File size After adding 'const':
   text	   data	    bss	    dec	    hex	filename
   1695	    192	      4	   1891	    763	drivers/cpufreq/cpufreq_stats.o

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/cpufreq/cpufreq_stats.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq_stats.c b/drivers/cpufreq/cpufreq_stats.c
index f570ead..d362739 100644
--- a/drivers/cpufreq/cpufreq_stats.c
+++ b/drivers/cpufreq/cpufreq_stats.c
@@ -135,7 +135,7 @@ static ssize_t show_trans_table(struct cpufreq_policy *policy, char *buf)
 	&trans_table.attr,
 	NULL
 };
-static struct attribute_group stats_attr_group = {
+static const struct attribute_group stats_attr_group = {
 	.attrs = default_attrs,
 	.name = "stats"
 };
-- 
1.9.1
