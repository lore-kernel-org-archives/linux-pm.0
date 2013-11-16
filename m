From: Lan Tianyu <tianyu.lan@intel.com>
Subject: [PATCH V2] Cpufreq: Make governor data on nonboot cpus across system suspend/resume
Date: Sat, 16 Nov 2013 23:36:24 +0800
Message-ID: <1384616184-6197-1-git-send-email-tianyu.lan@intel.com>
References: <9847309.KdKOG5y1Zx@vostro.rjw.lan>
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <9847309.KdKOG5y1Zx@vostro.rjw.lan>
Sender: cpufreq-owner@vger.kernel.org
To: rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc: Lan Tianyu <tianyu.lan@intel.com>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Currently, governor of nonboot cpus will be put to EXIT when system suspend.
Since all these cpus will be unplugged and the governor usage_count decreases
to zero. The governor data and its sysfs interfaces will be freed or released.
This makes user config of these governors loss during suspend and resume.

This doesn't happen on the governor covering boot cpu because it isn't
unplugged during system suspend.

To fix this issue, skipping governor exit during system suspend and check
policy governor data to determine whether the governor is really needed
to be initialized when do init. If not, return EALREADY to indicate the
governor has been initialized and should do nothing. __cpufreq_governor()
convert EALREADY to 0 as return value for INIT event since governor is
still under INIT state and can do START operation.

Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
---
Change since v1:
	Change coding style.

 drivers/cpufreq/cpufreq.c          | 10 +++++++---
 drivers/cpufreq/cpufreq_governor.c | 13 ++++++++++++-
 2 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 02d534d..73ad593 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1239,7 +1239,7 @@ static int __cpufreq_remove_dev_finish(struct device *dev,
 
 	/* If cpu is last user of policy, free policy */
 	if (cpus == 1) {
-		if (has_target()) {
+		if (has_target() && !frozen) {
 			ret = __cpufreq_governor(policy,
 					CPUFREQ_GOV_POLICY_EXIT);
 			if (ret) {
@@ -1818,9 +1818,13 @@ static int __cpufreq_governor(struct cpufreq_policy *policy,
 		mutex_unlock(&cpufreq_governor_lock);
 	}
 
-	if (((event == CPUFREQ_GOV_POLICY_INIT) && ret) ||
-			((event == CPUFREQ_GOV_POLICY_EXIT) && !ret))
+	if ((event == CPUFREQ_GOV_POLICY_INIT) && ret) {
+		module_put(policy->governor->owner);
+		if (ret == -EALREADY)
+			return 0;
+	} else if ((event == CPUFREQ_GOV_POLICY_EXIT) && !ret) {
 		module_put(policy->governor->owner);
+	}
 
 	return ret;
 }
diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
index 0806c31..ddb93af 100644
--- a/drivers/cpufreq/cpufreq_governor.c
+++ b/drivers/cpufreq/cpufreq_governor.c
@@ -204,9 +204,20 @@ int cpufreq_governor_dbs(struct cpufreq_policy *policy,
 
 	switch (event) {
 	case CPUFREQ_GOV_POLICY_INIT:
+		/*
+		 * In order to keep governor data across suspend/resume,
+		 * Governor doesn't exit when suspend and will be
+		 * reinitialized when resume. Here check policy governor
+		 * data to determine whether the governor has been exited.
+		 * If not, return EALREADY.
+		 */
 		if (have_governor_per_policy()) {
-			WARN_ON(dbs_data);
+			if (dbs_data)
+				return -EALREADY;
 		} else if (dbs_data) {
+			if (policy->governor_data == dbs_data)
+				return -EALREADY;
+
 			dbs_data->usage_count++;
 			policy->governor_data = dbs_data;
 			return 0;
-- 
1.8.2.1

