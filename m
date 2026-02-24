Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A7F03A9634;
	Tue, 24 Feb 2026 17:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771952929; cv=none; b=NrY9qOuKOi7inaZQbQNZZCK3eQsYBUt+3P0wwNPrNfUsAz7g4LzU0oq0hlffTL7ZtWPjm/8V+AxlkPownFjspyaTZCkmEOEjkgXKU8PDgyawAPe/50K7g0iK5amoe7/DM2FqU7G6jtiviIU19BlUJHFIkeZkuu4A7lzn9S9NLaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771952929; c=relaxed/simple;
	bh=3TDpLxuAI+iLVilyrJ2JN5n+M4yXgMqB2+F2nuTrT+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MwH6c4kqYq/vkGAdIQFty2Q0HAi7H0+e2o1HEL31jYhqhuQQXQP+ZdvOstWF0+oR23Ahd9UkAqx9qskqOUqc49a8SAemSPeXXMflkLIaUz44MsP8aE1qSY9sBTGWVm+ObO18+ul+CIdM0PuGkdEaqi/eVplknMG2vwSxYC6DPbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 13BC51595;
	Tue, 24 Feb 2026 09:08:41 -0800 (PST)
Received: from e135073.arm.com (unknown [10.57.71.162])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9E74A3F59E;
	Tue, 24 Feb 2026 09:08:43 -0800 (PST)
From: Pierre Gondois <pierre.gondois@arm.com>
To: linux-kernel@vger.kernel.org
Cc: Jie Zhan <zhanjie9@hisilicon.com>,
	Lifeng Zheng <zhenglifeng1@huawei.com>,
	Ionela Voinescu <ionela.voinescu@arm.com>,
	Sumit Gupta <sumitg@nvidia.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Pierre Gondois <pierre.gondois@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Huang Rui <ray.huang@amd.com>,
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Perry Yuan <perry.yuan@amd.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Len Brown <lenb@kernel.org>,
	Saravana Kannan <saravanak@kernel.org>,
	linux-pm@vger.kernel.org
Subject: [PATCH v4 2/6] cpufreq: Add boost_freq_req QoS request
Date: Tue, 24 Feb 2026 18:08:17 +0100
Message-ID: <20260224170828.1635135-3-pierre.gondois@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260224170828.1635135-1-pierre.gondois@arm.com>
References: <20260224170828.1635135-1-pierre.gondois@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Power Management Quality of Service (PM QoS) allows to
aggregate constraints from multiple entities. It is currently
used to manage the min/max frequency of a given policy.

Frequency constraints can come for instance from:
- Thermal framework: acpi_thermal_cpufreq_init()
- Firmware: _PPC objects: acpi_processor_ppc_init()
- User: by setting policyX/scaling_[min|max]_freq
The minimum of the max frequency constraints is used to compute
the resulting maximum allowed frequency.

When enabling boost frequencies, the same frequency request object
(policy->max_freq_req) as to handle requests from users is used.
As a result, when setting:
- scaling_max_freq
- boost
The last sysfs file used overwrites the request from the other
sysfs file.

To avoid this, create a per-policy boost_freq_req to save the boost
constraints instead of overwriting the last scaling_max_freq
constraint.

Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
---
 drivers/cpufreq/cpufreq.c | 41 ++++++++++++++++++++++++++++++++++-----
 include/linux/cpufreq.h   |  1 +
 2 files changed, 37 insertions(+), 5 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index db414c052658b..52efa4805afee 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1359,17 +1359,25 @@ static void cpufreq_policy_free(struct cpufreq_policy *policy)
 	/* Cancel any pending policy->update work before freeing the policy. */
 	cancel_work_sync(&policy->update);
 
-	if (policy->max_freq_req) {
+	if (policy->max_freq_req || policy->boost_freq_req) {
 		/*
-		 * Remove max_freq_req after sending CPUFREQ_REMOVE_POLICY
-		 * notification, since CPUFREQ_CREATE_POLICY notification was
-		 * sent after adding max_freq_req earlier.
+		 * Remove max/boost _freq_req after sending CPUFREQ_REMOVE_POLICY
+		 * notification, since CPUFREQ_CREATE_POLICY notification was sent
+		 * after adding max/boost _freq_req earlier.
 		 */
 		blocking_notifier_call_chain(&cpufreq_policy_notifier_list,
 					     CPUFREQ_REMOVE_POLICY, policy);
-		freq_qos_remove_request(policy->max_freq_req);
 	}
 
+	if ((policy->max_freq_req && !policy->boost_supported) ||
+	    policy->boost_freq_req) {
+		freq_qos_remove_request(policy->boost_freq_req);
+		kfree(policy->boost_freq_req);
+	}
+
+	if (policy->max_freq_req)
+		freq_qos_remove_request(policy->max_freq_req);
+
 	freq_qos_remove_request(policy->min_freq_req);
 	kfree(policy->min_freq_req);
 
@@ -1479,6 +1487,29 @@ static int cpufreq_policy_online(struct cpufreq_policy *policy,
 			goto out_destroy_policy;
 		}
 
+		if (policy->boost_supported) {
+			policy->boost_freq_req = kzalloc(sizeof(*policy->boost_freq_req),
+							 GFP_KERNEL);
+			if (!policy->boost_freq_req) {
+				ret = -ENOMEM;
+				goto out_destroy_policy;
+			}
+
+			ret = freq_qos_add_request(&policy->constraints,
+						   policy->boost_freq_req,
+						   FREQ_QOS_MAX,
+						   FREQ_QOS_MAX_DEFAULT_VALUE);
+			if (ret < 0) {
+				/*
+				 * So we don't call freq_qos_remove_request() for an
+				 * uninitialized request.
+				 */
+				kfree(policy->boost_freq_req);
+				policy->boost_freq_req = NULL;
+				goto out_destroy_policy;
+			}
+		}
+
 		blocking_notifier_call_chain(&cpufreq_policy_notifier_list,
 				CPUFREQ_CREATE_POLICY, policy);
 	}
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 0465d1e6f72ac..c292a6a19e4f5 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -81,6 +81,7 @@ struct cpufreq_policy {
 	struct freq_constraints	constraints;
 	struct freq_qos_request	*min_freq_req;
 	struct freq_qos_request	*max_freq_req;
+	struct freq_qos_request *boost_freq_req;
 
 	struct cpufreq_frequency_table	*freq_table;
 	enum cpufreq_table_sorting freq_table_sorted;
-- 
2.43.0

