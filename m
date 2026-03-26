Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1B4639E17D;
	Thu, 26 Mar 2026 20:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774557860; cv=none; b=EwZ5YD+XL4aGlIs4jkFBqFeUJeDABUAAGLzoR5PmdOPPuV5GXKdYfEscu6wPNA+y1epialAtPiLiGYyg94NFjUt0CnHsZwSxDovo1mKziQbL4VDhE13j66vAT8BWT+C4czZ6crhh+n9ohM9onuplyyiAdTgoEeJENSfaz40adLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774557860; c=relaxed/simple;
	bh=AMUQsfaGXp8dcD/oLlo/vJx8ZqljtdWdRDXTcXLIm9s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EaT+oFRuyzBzYu/8lnCoaZyuCqjhRmu0H74Eoomj0Yt6BQ39a+PDMP+OaUdLCK/00FDYFg8KzjhxCu83V5r5icaZQ9diiv7j9vOj2mzHp3TJTux6UvRSpD0sUl6hgyiAlmXp0410Keg2pxn2h1U823ZR0BotsXuVhxiFbA3C+Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=QPswWxSu; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="QPswWxSu"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5F4B02EC6;
	Thu, 26 Mar 2026 13:44:12 -0700 (PDT)
Received: from e135073.arm.com (unknown [10.57.84.88])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E91543F641;
	Thu, 26 Mar 2026 13:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1774557858; bh=AMUQsfaGXp8dcD/oLlo/vJx8ZqljtdWdRDXTcXLIm9s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QPswWxSuMdGmyGhEZqmxC+whKlSSnBYCc94XTI7F2Lp1HzCj7dflcGJFc74jijjXr
	 MltUms2LjmWtAmWM2aCFM4fgc10eTNwI8LC9cDbzUBExg6ETUmR2QwaY5RugjoMb4A
	 JkzirV6P2sG2MOkvS+ng53Eu7reIHtiEF1v2Zk2U=
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
Subject: [PATCH v8 1/2] cpufreq: Remove max_freq_req update for pre-existing policy
Date: Thu, 26 Mar 2026 21:44:00 +0100
Message-ID: <20260326204404.1401849-2-pierre.gondois@arm.com>
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

