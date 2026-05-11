Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97CD13FA5D5;
	Mon, 11 May 2026 13:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778507764; cv=none; b=QFnZLLzI6pw6tri0Oh5GGyAfDbcbE/vzk3+KNS4+XJ7Z4jko1j7EtihUWJ2rIz6jrk7pc4w4epKADrTZ6JKhZO5jIV7NWvtAO4mwad2WexEBhq8uRMgjlISYaJ6+6QH7F9BmzoNtamZN5wGxctdMZ9EezDT/K3DHMHy4rrgvlgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778507764; c=relaxed/simple;
	bh=pfMG+6nrdRg/qQu3NYZ8eC9hb/yMgPsNH2EdyMELK4o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T2ElKnMCxk6Feg38THdic5UhbGU+CYolq3aBbHUNMPqmfl1X+IjKSrh3+CZvY0zpSBNfR2MCCb6Bk2wLALSy4pJIb9DotsTIfWueVYmTSHcOvEUYfzdOUXQ5r+F/mS89VWSKnk/zOI0dKKUErd/P2buDzgLYc3W7sBo0qzQVUTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=VXA/+WDO; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="VXA/+WDO"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8609E263D;
	Mon, 11 May 2026 06:55:55 -0700 (PDT)
Received: from e135073.arm.com (unknown [10.57.34.159])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C460B3F85F;
	Mon, 11 May 2026 06:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1778507760; bh=pfMG+6nrdRg/qQu3NYZ8eC9hb/yMgPsNH2EdyMELK4o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VXA/+WDOxZM8WKWL4QVGZv18LGLGarfok8IAC+CmczyR895qpC/5G4KjHOsnLM3rn
	 MVsHD6CSbNL4zvIFIw2y7i66m1w2etykd2pl0DTiDkXQp0zVCntptdgsK3odub7Enk
	 H6UIEp267OBk1ZY+hu3cOvpgc6mVI4ZxEaQcgMO0=
From: Pierre Gondois <pierre.gondois@arm.com>
To: linux-kernel@vger.kernel.org
Cc: Jie Zhan <zhanjie9@hisilicon.com>,
	Lifeng Zheng <zhenglifeng1@huawei.com>,
	Ionela Voinescu <ionela.voinescu@arm.com>,
	Sumit Gupta <sumitg@nvidia.com>,
	Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>,
	Pierre Gondois <pierre.gondois@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Huang Rui <ray.huang@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Perry Yuan <perry.yuan@amd.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Len Brown <lenb@kernel.org>,
	Saravana Kannan <saravanak@kernel.org>,
	linux-pm@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH v2 1/4] cpufreq: Extract cpufreq_policy_init_qos() function
Date: Mon, 11 May 2026 15:55:28 +0200
Message-ID: <20260511135538.522653-2-pierre.gondois@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260511135538.522653-1-pierre.gondois@arm.com>
References: <20260511135538.522653-1-pierre.gondois@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extract the QoS related logic from cpufreq_policy_online()
to make the function shorter/simpler.

The logic is placed in cpufreq_policy_init_qos() and is
now executed right after the following calls:
- cpufreq_driver->init()
- cpufreq_table_validate_and_sort()

This helps preparing following patches that will,
in cpufreq_policy_init_qos():
- treat the policy->min/max values set by drivers as QoS requests.
- set a default policy->min/max value to all policies.

No functional change.

Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
---
 drivers/cpufreq/cpufreq.c | 53 +++++++++++++++++++++++----------------
 1 file changed, 32 insertions(+), 21 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 44eb1b7e7fc1b..034603c2af325 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1397,6 +1397,32 @@ static void cpufreq_policy_free(struct cpufreq_policy *policy)
 	kfree(policy);
 }
 
+static int cpufreq_policy_init_qos(struct cpufreq_policy *policy)
+{
+	int ret;
+
+	if (policy->boost_supported) {
+		ret = freq_qos_add_request(&policy->constraints,
+						&policy->boost_freq_req,
+						FREQ_QOS_MAX,
+						policy->cpuinfo.max_freq);
+		if (ret < 0)
+			return ret;
+	}
+
+	ret = freq_qos_add_request(&policy->constraints, &policy->min_freq_req,
+				   FREQ_QOS_MIN, FREQ_QOS_MIN_DEFAULT_VALUE);
+	if (ret < 0)
+		return ret;
+
+	ret = freq_qos_add_request(&policy->constraints, &policy->max_freq_req,
+				   FREQ_QOS_MAX, FREQ_QOS_MAX_DEFAULT_VALUE);
+	if (ret < 0)
+		return ret;
+
+	return ret;
+}
+
 static int cpufreq_policy_online(struct cpufreq_policy *policy,
 				 unsigned int cpu, bool new_policy)
 {
@@ -1442,6 +1468,12 @@ static int cpufreq_policy_online(struct cpufreq_policy *policy,
 		if (ret)
 			goto out_offline_policy;
 
+		if (new_policy) {
+			ret = cpufreq_policy_init_qos(policy);
+			if (ret < 0)
+				goto out_offline_policy;
+		}
+
 		/* related_cpus should at least include policy->cpus. */
 		cpumask_copy(policy->related_cpus, policy->cpus);
 	}
@@ -1458,27 +1490,6 @@ static int cpufreq_policy_online(struct cpufreq_policy *policy,
 			add_cpu_dev_symlink(policy, j, get_cpu_device(j));
 		}
 
-		if (policy->boost_supported) {
-			ret = freq_qos_add_request(&policy->constraints,
-						   &policy->boost_freq_req,
-						   FREQ_QOS_MAX,
-						   policy->cpuinfo.max_freq);
-			if (ret < 0)
-				goto out_destroy_policy;
-		}
-
-		ret = freq_qos_add_request(&policy->constraints,
-					   &policy->min_freq_req, FREQ_QOS_MIN,
-					   FREQ_QOS_MIN_DEFAULT_VALUE);
-		if (ret < 0)
-			goto out_destroy_policy;
-
-		ret = freq_qos_add_request(&policy->constraints,
-					   &policy->max_freq_req, FREQ_QOS_MAX,
-					   FREQ_QOS_MAX_DEFAULT_VALUE);
-		if (ret < 0)
-			goto out_destroy_policy;
-
 		blocking_notifier_call_chain(&cpufreq_policy_notifier_list,
 				CPUFREQ_CREATE_POLICY, policy);
 	}
-- 
2.43.0

