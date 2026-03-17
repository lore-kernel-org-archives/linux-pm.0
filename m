Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C86B84039;
	Tue, 17 Mar 2026 10:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773742718; cv=none; b=LvzwOCkhyJ508xphy7CETzgNIaWlpVnBHfqBSeWhwe6tHc65nViqzAUamcNUEpX3Axqs2xp6sFK1W5NpIXZ52ef99ATwm8U98qVy22CYBkGZsTzApS5jQWeOSKW4Cyz1KyP6miwnnwIFHs841aM+NsfPS8x6448+NMV17XSIH28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773742718; c=relaxed/simple;
	bh=ToV5pdLzuH+qu4hb+UYqtEI15E1YuomlSuXSvI6Zzno=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NMqCFohBirIZ17dEFBGVqXSJaGn+1obfjEOLNi1oM9FDpvsU1bEm5J5/E0PaEPML7e8UWdAsy3zN1NB4lAAIgdgdf3XHzEV9QgH8Ico+Pz3xFSx/+QdZalZPPRaBCy5W3PxycrXJopjZ8FX0BJ6mGZ34Wbkt6zK1nnJqpWMmaE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 980121477;
	Tue, 17 Mar 2026 03:18:30 -0700 (PDT)
Received: from e135073.home (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E80883F7BD;
	Tue, 17 Mar 2026 03:18:32 -0700 (PDT)
From: Pierre Gondois <pierre.gondois@arm.com>
To: linux-kernel@vger.kernel.org
Cc: Jie Zhan <zhanjie9@hisilicon.com>,
	Lifeng Zheng <zhenglifeng1@huawei.com>,
	Ionela Voinescu <ionela.voinescu@arm.com>,
	Sumit Gupta <sumitg@nvidia.com>,
	Pierre Gondois <pierre.gondois@arm.com>,
	Huang Rui <ray.huang@amd.com>,
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Perry Yuan <perry.yuan@amd.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Len Brown <lenb@kernel.org>,
	Saravana Kannan <saravanak@kernel.org>,
	linux-pm@vger.kernel.org
Subject: [PATCH v6 1/4] cpufreq: Remove per-CPU QoS constraint
Date: Tue, 17 Mar 2026 11:17:42 +0100
Message-ID: <20260317101753.2284763-2-pierre.gondois@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260317101753.2284763-1-pierre.gondois@arm.com>
References: <20260317101753.2284763-1-pierre.gondois@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

policy->max_freq_req represents the maximum allowed frequency as
requested by the policyX/scaling_max_freq sysfs file. This request
applies to all CPUs of the policy. It is not possible to request
a per-CPU maximum frequency.

Thus, the interaction between the policy boost and scaling_max_freq
settings should be handled by adding a boost specific QoS constraint.
This will be handled in the following patches.

This patch reverts of:
commit 1608f0230510 ("cpufreq: Fix re-boost issue after hotplugging
a CPU")

Note:
I was unable to reproduce the issue initially reported.
So far it seems that was fixed in:
commit 121baab7b88e ("cpufreq: Force sync policy boost with
global boost on sysfs update")
Another point is that the initial patch states that the error
comes a max_freq_req request is repeated, but calls to
freq_qos_update_request() would return 0 and all calls are
checked against negative values.

Reviewed-by: Lifeng Zheng <zhenglifeng1@huawei.com>
Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
---
 drivers/cpufreq/cpufreq.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 4472bb1ec83c7..db414c052658b 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1481,10 +1481,6 @@ static int cpufreq_policy_online(struct cpufreq_policy *policy,
 
 		blocking_notifier_call_chain(&cpufreq_policy_notifier_list,
 				CPUFREQ_CREATE_POLICY, policy);
-	} else {
-		ret = freq_qos_update_request(policy->max_freq_req, policy->max);
-		if (ret < 0)
-			goto out_destroy_policy;
 	}
 
 	if (cpufreq_driver->get && has_target()) {
-- 
2.43.0

