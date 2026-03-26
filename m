Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 469F63A6F0F;
	Thu, 26 Mar 2026 20:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774557867; cv=none; b=KVTdngR2BhZzPVPYBHUrE63kHV0GUoHt+3qr5zplyvKKACsgqXGDKHFbHSZxoHAKQLC8jXI0drzaP3KMfv6dAExcYGKzEWPtjDgu4g69EFaYQMLv0cU5yrbnHnrm2YI1xLUUcnWZbYeBPMWkPz+dm9ifPlWZI46dRe6f9mcAc4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774557867; c=relaxed/simple;
	bh=QPNoHOc4zyKps4AWF2ksUbyGyC65HZlam4h3oWneHn4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SDiGwYcMXw//uffEBMqo8eO1GHDfOjkMUO6lR1wzcmPwclqmHxucv55KGD6o0oZJ4kKfcHWhkEXHztkOh+mlRPIkvo+BxpeHYdCGYHUSltMYDXMOgKWzBgrXIYSop6gt5uC6T/7g5du0sqhB+bVqEoEg9QVkuUvCbjpVzTkv0vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=rIBns0c3; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="rIBns0c3"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BC34332CF;
	Thu, 26 Mar 2026 13:44:15 -0700 (PDT)
Received: from e135073.arm.com (unknown [10.57.84.88])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 519773F641;
	Thu, 26 Mar 2026 13:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1774557861; bh=QPNoHOc4zyKps4AWF2ksUbyGyC65HZlam4h3oWneHn4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rIBns0c3jj967aKZjelDeiMRudq1J4Bf5NTSon3rHhnGjJVzDsyeU38wkHuqK01DA
	 liXDlsShjxQsBAaFicQsWm1Y9P5iuQlp4PZWVYmV+XD7355qCPLJtHwxzu13gSwqm3
	 Bw+VzJ1Wwy+Khe+Yo5h41s1wnHcfj7zIAPxQ10b4=
From: Pierre Gondois <pierre.gondois@arm.com>
To: linux-kernel@vger.kernel.org
Cc: Lifeng Zheng <zhenglifeng1@huawei.com>,
	Pierre Gondois <pierre.gondois@arm.com>,
	Huang Rui <ray.huang@amd.com>,
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Perry Yuan <perry.yuan@amd.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	linux-pm@vger.kernel.org
Subject: [PATCH v8 2/2] cpufreq: Add boost_freq_req QoS request
Date: Thu, 26 Mar 2026 21:44:01 +0100
Message-ID: <20260326204404.1401849-3-pierre.gondois@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260326204404.1401849-1-pierre.gondois@arm.com>
References: <20260326204404.1401849-1-pierre.gondois@arm.com>
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

policy_set_boost() calls the cpufreq set_boost callback.
Update the newly added boost_freq_req request from there:
- whenever boost is toggled
- to cover all possible paths

In the existing .set_boost() callbacks:
- Don't update policy->max as this is done through the qos notifier
  cpufreq_notifier_max() which calls cpufreq_set_policy().
- Remove freq_qos_update_request() calls as the qos request is now
  done in policy_set_boost() and updates the new boost_freq_req

$ ## Init state
scaling_max_freq:1000000
cpuinfo_max_freq:1000000

$ echo 700000 > scaling_max_freq
scaling_max_freq:700000
cpuinfo_max_freq:1000000

$ echo 1 > ../boost
scaling_max_freq:1200000
cpuinfo_max_freq:1200000

$ echo 800000 > scaling_max_freq
scaling_max_freq:800000
cpuinfo_max_freq:1200000

$ ## Final step:
$ ## Without the patches:
$ echo 0 > ../boost
scaling_max_freq:1000000
cpuinfo_max_freq:1000000

$ ## With the patches:
$ echo 0 > ../boost
scaling_max_freq:800000
cpuinfo_max_freq:1000000

Note:
cpufreq_frequency_table_cpuinfo() updates policy->min
and max from:
A.
cpufreq_boost_set_sw()
\-cpufreq_frequency_table_cpuinfo()
B.
cpufreq_policy_online()
\-cpufreq_table_validate_and_sort()
  \-cpufreq_frequency_table_cpuinfo()
Keep these updates as some drivers expect policy->min and
max to be set through B.

Reviewed-by: Lifeng Zheng <zhenglifeng1@huawei.com>
Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
---
 drivers/cpufreq/amd-pstate.c   |  2 --
 drivers/cpufreq/cppc_cpufreq.c | 10 ++------
 drivers/cpufreq/cpufreq.c      | 46 +++++++++++++++++++++++-----------
 include/linux/cpufreq.h        |  1 +
 4 files changed, 34 insertions(+), 25 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 5aa9fcd80cf51..d0675d6a19fe1 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -769,8 +769,6 @@ static int amd_pstate_cpu_boost_update(struct cpufreq_policy *policy, bool on)
 	else if (policy->cpuinfo.max_freq > nominal_freq)
 		policy->cpuinfo.max_freq = nominal_freq;
 
-	policy->max = policy->cpuinfo.max_freq;
-
 	if (cppc_state == AMD_PSTATE_PASSIVE) {
 		ret = freq_qos_update_request(&cpudata->req[1], policy->cpuinfo.max_freq);
 		if (ret < 0)
diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index 011f35cb47b94..f4f574fbe547b 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -807,17 +807,11 @@ static int cppc_cpufreq_set_boost(struct cpufreq_policy *policy, int state)
 {
 	struct cppc_cpudata *cpu_data = policy->driver_data;
 	struct cppc_perf_caps *caps = &cpu_data->perf_caps;
-	int ret;
 
 	if (state)
-		policy->max = cppc_perf_to_khz(caps, caps->highest_perf);
+		policy->cpuinfo.max_freq = cppc_perf_to_khz(caps, caps->highest_perf);
 	else
-		policy->max = cppc_perf_to_khz(caps, caps->nominal_perf);
-	policy->cpuinfo.max_freq = policy->max;
-
-	ret = freq_qos_update_request(policy->max_freq_req, policy->max);
-	if (ret < 0)
-		return ret;
+		policy->cpuinfo.max_freq = cppc_perf_to_khz(caps, caps->nominal_perf);
 
 	return 0;
 }
diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 5757f12633d16..d2f393d738a39 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -609,10 +609,19 @@ static int policy_set_boost(struct cpufreq_policy *policy, bool enable)
 	policy->boost_enabled = enable;
 
 	ret = cpufreq_driver->set_boost(policy, enable);
-	if (ret)
+	if (ret) {
 		policy->boost_enabled = !policy->boost_enabled;
+		return ret;
+	}
 
-	return ret;
+	ret = freq_qos_update_request(policy->boost_freq_req, policy->cpuinfo.max_freq);
+	if (ret < 0) {
+		policy->boost_enabled = !policy->boost_enabled;
+		cpufreq_driver->set_boost(policy, policy->boost_enabled);
+		return ret;
+	}
+
+	return 0;
 }
 
 static ssize_t store_local_boost(struct cpufreq_policy *policy,
@@ -1377,6 +1386,7 @@ static void cpufreq_policy_free(struct cpufreq_policy *policy)
 	}
 
 	freq_qos_remove_request(policy->min_freq_req);
+	freq_qos_remove_request(policy->boost_freq_req);
 	kfree(policy->min_freq_req);
 
 	cpufreq_policy_put_kobj(policy);
@@ -1445,26 +1455,38 @@ static int cpufreq_policy_online(struct cpufreq_policy *policy,
 	cpumask_and(policy->cpus, policy->cpus, cpu_online_mask);
 
 	if (new_policy) {
+		unsigned int count;
+
 		for_each_cpu(j, policy->related_cpus) {
 			per_cpu(cpufreq_cpu_data, j) = policy;
 			add_cpu_dev_symlink(policy, j, get_cpu_device(j));
 		}
 
-		policy->min_freq_req = kzalloc(2 * sizeof(*policy->min_freq_req),
+		count = policy->boost_supported ? 3 : 2;
+		policy->min_freq_req = kzalloc(count * sizeof(*policy->min_freq_req),
 					       GFP_KERNEL);
 		if (!policy->min_freq_req) {
 			ret = -ENOMEM;
 			goto out_destroy_policy;
 		}
 
+		if (policy->boost_supported) {
+			policy->boost_freq_req = policy->min_freq_req + 2;
+
+			ret = freq_qos_add_request(&policy->constraints,
+						   policy->boost_freq_req,
+						   FREQ_QOS_MAX,
+						   policy->cpuinfo.max_freq);
+			if (ret < 0) {
+				policy->boost_freq_req = NULL;
+				goto out_destroy_policy;
+			}
+		}
+
 		ret = freq_qos_add_request(&policy->constraints,
 					   policy->min_freq_req, FREQ_QOS_MIN,
 					   FREQ_QOS_MIN_DEFAULT_VALUE);
 		if (ret < 0) {
-			/*
-			 * So we don't call freq_qos_remove_request() for an
-			 * uninitialized request.
-			 */
 			kfree(policy->min_freq_req);
 			policy->min_freq_req = NULL;
 			goto out_destroy_policy;
@@ -2788,16 +2810,10 @@ int cpufreq_boost_set_sw(struct cpufreq_policy *policy, int state)
 		return -ENXIO;
 
 	ret = cpufreq_frequency_table_cpuinfo(policy);
-	if (ret) {
+	if (ret)
 		pr_err("%s: Policy frequency update failed\n", __func__);
-		return ret;
-	}
-
-	ret = freq_qos_update_request(policy->max_freq_req, policy->max);
-	if (ret < 0)
-		return ret;
 
-	return 0;
+	return ret;
 }
 EXPORT_SYMBOL_GPL(cpufreq_boost_set_sw);
 
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index cc894fc389710..89157e367eefa 100644
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

