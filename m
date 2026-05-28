Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A6CA3B9DAD;
	Thu, 28 May 2026 09:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779959405; cv=none; b=Dh5Ss9tcidp9FBAVv0UWl99rzGgfdHQP0pCxw3CWrb0MkGX7qgwIZcauzNjwpB12R9j6jR8JAYXuxomuwpwhKS5uCJC1UtrGZZs3jlAfz5WVhOWnlfsFhdNeXf7FVWblim/9yA5ICWTx/gsO3su7J+HxQR6mI9KLeGK1ydPQXCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779959405; c=relaxed/simple;
	bh=vgB+WvFX2P24NmpAuw+DDNfAp8EJaXmIPGpOeG6sTnE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f5gqDa1BcsTPm62sRqfzySLfM3mQpMHEl/j6d22Uq/Yrr/NfRhKHxX20weMF8RoPY/UtKuAGCyW/ynuqtxP6Yd0DY2+jvO++oQ+WDuha3pq1lZewMiHVQFWDpgSQaZApHeXLxUq1Ebsps+4duX9G3hn0jTBvQEMnh5ZQxS215NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=ngtq21Fz; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="ngtq21Fz"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6A7ED4403;
	Thu, 28 May 2026 02:09:57 -0700 (PDT)
Received: from e135073.arm.com (unknown [10.57.24.196])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 829813F632;
	Thu, 28 May 2026 02:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1779959402; bh=vgB+WvFX2P24NmpAuw+DDNfAp8EJaXmIPGpOeG6sTnE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ngtq21Fz36O5E0qtdyzxOk3+3HreR0rb+CwjClnPd2cuy51iqYM72w227vZkJehLw
	 o5jT9QvWVxzyoGy+CFNIOiVFRPR5ImT4+tFOMShRO7kTCoWT+vYIX5xa50P0uqW+aM
	 7ZZa5BHV039/MdprVXOmxhg5UaZQwjCdkK19rcMc=
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
Subject: [PATCH v3 2/4] cpufreq: Set default policy->min/max values for all drivers
Date: Thu, 28 May 2026 11:09:04 +0200
Message-ID: <20260528090913.2759118-3-pierre.gondois@arm.com>
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

Some drivers set policy->min/max in their .init() callback.
cpufreq_set_policy() will ultimately override them through:
cpufreq_policy_online()
\-cpufreq_init_policy()
  \-cpufreq_set_policy()
    \-/* Set policy->min/max */
Thus the policy min/max values provided are only temporary.

There is an exception if CPUFREQ_NEED_INITIAL_FREQ_CHECK is set and:
cpufreq_policy_online()
\-__cpufreq_driver_target()
  \-cpufreq_driver->target()

To prepare for a following patch that will remove all
policy->min/max initialization in the driver .init() callback
if the min/max value is equal to the cpuinfo.min/max_freq,
set a default policy->min/max value for all drivers.

Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
Reviewed-by: Jie Zhan <zhanjie9@hisilicon.com>
---
 drivers/cpufreq/cpufreq.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 50616cfebc617..d75c6739aa780 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1474,6 +1474,13 @@ static int cpufreq_policy_online(struct cpufreq_policy *policy,
 				goto out_offline_policy;
 		}
 
+		/*
+		 * If the driver didn't set policy->min/max, set them as
+		 * they are used to clamp frequency requests.
+		 */
+		policy->min = policy->min ? policy->min : policy->cpuinfo.min_freq;
+		policy->max = policy->max ? policy->max : policy->cpuinfo.max_freq;
+
 		/* related_cpus should at least include policy->cpus. */
 		cpumask_copy(policy->related_cpus, policy->cpus);
 	}
-- 
2.43.0

