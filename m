Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D95793FAE1C;
	Wed, 25 Mar 2026 16:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774457617; cv=none; b=o1DcpfIWaI/39pVPxfiKDQ13xTK4KEO77v5b9+xbYAe5Ne4j7LP4TR+SYx9N24iZAmnKyChw0EqbuInInYOVZDyBRTQzcNjMoNTLbhKgwJ6u/ri1TsP9K+uqI7EmZMBWjQyjwhI+y8iAPZjUZH4Env6rUlPlmSalMHP2OP91o2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774457617; c=relaxed/simple;
	bh=AMUQsfaGXp8dcD/oLlo/vJx8ZqljtdWdRDXTcXLIm9s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GfUJLpgZ+ZcYkoZCXxhSbWSZ7c8Gvt8QPzNN88f91Ov5WqDlYkj0vy16lwGJgk5bd+COFPXi0tlIDuRhu5fpMayTG6Y0Ou4qifByG3oaKr600LGbuSCLQpRLBQfFZlXMIgv9B0geKwxlvAfvvNlQMfTmW3TOxEoQJj5aF9CsMUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=gWIO0Ur5; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="gWIO0Ur5"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0BBB32576;
	Wed, 25 Mar 2026 09:53:27 -0700 (PDT)
Received: from e135073.arm.com (unknown [10.57.76.144])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id BD9D73F915;
	Wed, 25 Mar 2026 09:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1774457613; bh=AMUQsfaGXp8dcD/oLlo/vJx8ZqljtdWdRDXTcXLIm9s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gWIO0Ur5lnFZzkdmXydyy8gGYI3ce8FLbi5zImknVhhAyw9pkaQJPIhwspD93hyop
	 Fe4qhOeVRO0xtU/+nJ+8QPqSpwJ3MLV/9dM3T5WmjaFlyEFKyDq46VXo3l/orORH1e
	 HdzX7Gev1cxxfLQ5G6lFfC0wfmBIdCGzEB68FZiA=
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
Subject: [PATCH v7 1/2] cpufreq: Remove per-CPU QoS constraint
Date: Wed, 25 Mar 2026 17:52:52 +0100
Message-ID: <20260325165255.386576-2-pierre.gondois@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260325165255.386576-1-pierre.gondois@arm.com>
References: <20260325165255.386576-1-pierre.gondois@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

policy->max_freq_req QoS constraint represents the maximal allowed
frequency than can be requested. It is set by:
- writing to policyX/scaling_max sysfs file
- toggling the cpufreq/boost sysfs file

Upon calling freq_qos_update_request(), a successful update
of the max_freq_req value triggers cpufreq_notifier_max(),
followed by cpufreq_set_policy() which update the requested
frequency for the policy.
If the new max_freq_req value is not different from the
original value, no frequency update is triggered.

In a specific sequence of toggling:
- cpufreq/boost sysfs file
- CPU hot-plugging
a CPU could end up with boost enabled but running at the
maximal non-boost frequency, cpufreq_notifier_max() not being
triggered. The following fixed that:
commit 1608f0230510 ("cpufreq: Fix re-boost issue after hotplugging
a CPU")

The following:
commit dd016f379ebc ("cpufreq: Introduce a more generic way to
set default per-policy boost flag")
also fixed the issue by correctly setting the max_freq_req
constraint of a policy that is re-activated. This makes the
first fix unnecessary.

As the original issue is fixed by another method,
this patch reverts:
commit 1608f0230510 ("cpufreq: Fix re-boost issue after hotplugging
a CPU")

Reviewed-by: Lifeng Zheng <zhenglifeng1@huawei.com>
Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
---
 drivers/cpufreq/cpufreq.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 277884d91913c..5757f12633d16 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1487,10 +1487,6 @@ static int cpufreq_policy_online(struct cpufreq_policy *policy,
 
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

