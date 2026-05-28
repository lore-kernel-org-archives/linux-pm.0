Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD7853B47D7;
	Thu, 28 May 2026 09:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779959400; cv=none; b=BDq9POak8UyG7BePOew9/ySz1FMrMjiGqm+FmD18wK3Om/fE4vRoFrwn0Ylp17M8MvdF6K2Vg8TpG21q9BEMUbzxkrg9vF0I8eM7mIx+ojbkvn+pibJuSRu9rC3m/12liu7YK0gqomGHkxA8XMGAssW3qxwT0eJWS4Pr3WEZv6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779959400; c=relaxed/simple;
	bh=OrIbLK4EvKzZg2CobVMv3AVJGKbR0lNlgy5pTXO+xRI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XHXxSR5CND3R0sttWQZbAbv2pW6gLFB4jtTpgkNLJZU1z1H59WKVr6OHnBYYHQ8LLcgnVaX7IGiXZ4HWKPQFhLPWVt8ztAiTaoaRdpt5PL7d3vCZ4uFXixE7W8dUHip3ufNFthpAvmSzMnSbXEOKrT1xipQGPkrkJLGa5j/ITeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=VZNjgRY7; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="VZNjgRY7"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1D3404402;
	Thu, 28 May 2026 02:09:52 -0700 (PDT)
Received: from e135073.arm.com (unknown [10.57.24.196])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B96FD3F632;
	Thu, 28 May 2026 02:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1779959397; bh=OrIbLK4EvKzZg2CobVMv3AVJGKbR0lNlgy5pTXO+xRI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VZNjgRY7SGSkq95nHN0iz9nMQV05DAXBGFJDq5LRKX3YYHo9jWlpekB02ia5aDiqM
	 g3FjKoFSHCOAFrhD7oAXX5kCpkk0wEqKTF196M+iCbaMvsLJFIXOdTUJNhgkyHT+Yh
	 gO1PBQDdz4VkyLi3i0ZbdTpADPCdtv5UqI6Lgn38=
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
Subject: [PATCH v3 1/4] cpufreq: Extract cpufreq_policy_init_qos() function
Date: Thu, 28 May 2026 11:09:03 +0200
Message-ID: <20260528090913.2759118-2-pierre.gondois@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260528090913.2759118-1-pierre.gondois@arm.com>
References: <20260528090913.2759118-1-pierre.gondois@arm.com>
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
Reviewed-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
Reviewed-by: Jie Zhan <zhanjie9@hisilicon.com>
---
 drivers/cpufreq/cpufreq.c | 53 +++++++++++++++++++++++----------------
 1 file changed, 32 insertions(+), 21 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 44eb1b7e7fc1b..50616cfebc617 100644
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
+	return 0;
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

