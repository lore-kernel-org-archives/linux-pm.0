Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D569A3FB05B;
	Mon, 11 May 2026 13:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778507771; cv=none; b=cQRcvviT85OSLZ0PxUUxAnUeA7zgYFzVpGDraTj1B+RraFvTwufMKM0p1NxaQazqiPt9FqZEfKnPr+nLDdetOmjs1iFSt5qE+kdjljE9SXm4I3dMV63uveK8GxA0ZqXfx5Dkxe7I1JiCaK4c1u7U4QsWfGgUDLvVnCSrWSjPq1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778507771; c=relaxed/simple;
	bh=XGFkxW/H5ch6O1XPqwAMdvG9y0NkBvRdmTzXlnKHEPs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cfS1rHEs7IU/xY7t5YxTVPqfrQklEFYCrQs9ei1gwD2iMkoNCf8/ufCWqJgqtGxS6JPYNFyVVws8sTjrolOYVGsLfxHB0r8gdw6A2f/bnaImOVVXzhIfa5N/axUpFpvHwyO4Dgy1WeFfB6A+EuT4gg8EG6ShLJ5+tUJ6ybbd3hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Ycf2EGJz; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Ycf2EGJz"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1585916F3;
	Mon, 11 May 2026 06:56:01 -0700 (PDT)
Received: from e135073.arm.com (unknown [10.57.34.159])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6A87C3F85F;
	Mon, 11 May 2026 06:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1778507766; bh=XGFkxW/H5ch6O1XPqwAMdvG9y0NkBvRdmTzXlnKHEPs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ycf2EGJzfvN105nE/egXgsx1NHIW5wBVuKaSh2P2WVFq6vnhEBMW1mDi+eIolDL8Z
	 W5hVJi6G75Qg1yC7Mz/Oyl/NnFMIxeZHE04Dn8uVBy4dvNqSE8dNcToa7t2i++pXiB
	 BUKAMDk3/jqgmzrkqH/TXgRnyHzg9ORgncsTo4Dk=
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
Subject: [PATCH v2 2/4] cpufreq: Set default policy->min/max values for all drivers
Date: Mon, 11 May 2026 15:55:29 +0200
Message-ID: <20260511135538.522653-3-pierre.gondois@arm.com>
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
---
 drivers/cpufreq/cpufreq.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 034603c2af325..9e2d9d3fc5351 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1401,6 +1401,13 @@ static int cpufreq_policy_init_qos(struct cpufreq_policy *policy)
 {
 	int ret;
 
+	/*
+	 * If the driver didn't set policy->min/max, set them as
+	 * they are used to clamp frequency requests.
+	 */
+	policy->min = policy->min ? policy->min : policy->cpuinfo.min_freq;
+	policy->max = policy->max ? policy->max : policy->cpuinfo.max_freq;
+
 	if (policy->boost_supported) {
 		ret = freq_qos_add_request(&policy->constraints,
 						&policy->boost_freq_req,
-- 
2.43.0

