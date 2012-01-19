From: Antti P Miettinen <amiettinen@nvidia.com>
Subject: [PATCH] cpufreq: Export user_policy min/max
Date: Thu, 19 Jan 2012 14:51:01 +0200
Message-ID: <1326977461-4348-1-git-send-email-amiettinen@nvidia.com>
Return-path: <cpufreq-owner@vger.kernel.org>
Sender: cpufreq-owner@vger.kernel.org
To: davej@redhat.com, pavel@ucw.cz, rjw@sisk.pl, len.brown@intel.com, khilman@ti.com, j-pihet@ti.com, markgross@thegnar.org, cpufreq@vger.kernel.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Add read-only sysfs nodes for user_policy min and max settings.
This helps diagnosis in the presence of other constraints that
affect the currently enforced policy minimum and maximum that
can be viewed with scaling_{min,max}_freq.

Signed-off-by: Antti P Miettinen <amiettinen@nvidia.com>
---
Related to "RFC: CPU frequency min as PM QoS param" patchset.

 drivers/cpufreq/cpufreq.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index f2c7fc2..c2c1c62 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -364,6 +364,8 @@ show_one(cpuinfo_transition_latency, cpuinfo.transition_latency);
 show_one(scaling_min_freq, min);
 show_one(scaling_max_freq, max);
 show_one(scaling_cur_freq, cur);
+show_one(policy_min_freq, user_policy.min);
+show_one(policy_max_freq, user_policy.max);
 
 static int __cpufreq_set_policy(struct cpufreq_policy *data,
 				struct cpufreq_policy *policy);
@@ -582,6 +584,8 @@ cpufreq_freq_attr_rw(scaling_min_freq);
 cpufreq_freq_attr_rw(scaling_max_freq);
 cpufreq_freq_attr_rw(scaling_governor);
 cpufreq_freq_attr_rw(scaling_setspeed);
+cpufreq_freq_attr_ro(policy_min_freq);
+cpufreq_freq_attr_ro(policy_max_freq);
 
 static struct attribute *default_attrs[] = {
 	&cpuinfo_min_freq.attr,
@@ -595,6 +599,8 @@ static struct attribute *default_attrs[] = {
 	&scaling_driver.attr,
 	&scaling_available_governors.attr,
 	&scaling_setspeed.attr,
+	&policy_min_freq.attr,
+	&policy_max_freq.attr,
 	NULL
 };
 
-- 
1.7.4.1

