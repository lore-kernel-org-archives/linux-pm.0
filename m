Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7192B29B20A
	for <linux-pm@vger.kernel.org>; Tue, 28 Apr 2026 08:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777364809; cv=none; b=NUGY+tgRYhLiVNw9dbk4HodNh0u2A9AdVcyBaMkscaSsop0mpGNxPzrIhSU3mMq0TQ3F/0jVJgeDg2TxCpIITbuA4tVZchD2+OM5uMA/S1kCXmChMdLhkAjV8PsItT+4t/44nd9QN6ddXBewNp9lEPHjzGMOLxv/GgMNlFXh9ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777364809; c=relaxed/simple;
	bh=wrLGlLnRnuHNeLR/XJRx6AUTo4j9X+V4rjRWujMtMUs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PwrK/gqCqa0d0ze0I8WvviqzY5Sh6EqqvLY7wur90qpHRTYgsZvIb9KD4NAAKwXrkJfTTXywaUXtkX4TphY5i3UASTbiLJOmfTGvZi9g3rpA9ozT+UGfTmcZB2FLXlA3AFGjDd2ABtEfaKneRQfQhaFi+SUt1znGXYpRG4gvq+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ndOVl9kA; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ndOVl9kA"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777364806;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=DXKeliB+XhMjzKveQR7TBPCM8hGDZOG662zKo4luP/E=;
	b=ndOVl9kA9mGYQK4NmafBuRRjiS8JFa3UfqcJAdk75hZvgurx2LH4TcyH3+hSIto9K5c/7/
	dKwzxEPOimavx8QJvxxTdwWxBo3jbm7J2DsK7ooEIINXpGGoOljFILScnDq3gGlecx/Hku
	ahkQoY8g/l8COGPaUkhzpm0SevfMIp8=
From: Fushuai Wang <fushuai.wang@linux.dev>
To: srinivas.pandruvada@linux.intel.com,
	lenb@kernel.org,
	rafael@kernel.org,
	viresh.kumar@linaro.org,
	currojerez@riseup.net
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	wangfushuai@baidu.com
Subject: [PATCH] cpufreq: intel_pstate: Sync policy->cur when setting min pstate during CPU offline
Date: Tue, 28 Apr 2026 16:26:20 +0800
Message-Id: <20260428082620.26583-1-fushuai.wang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Fushuai Wang <wangfushuai@baidu.com>

When a CPU goes offline with HWP disabled, intel_pstate_set_min_pstate()
sets the MSR_IA32_PERF_CTL to minimum frequency to prevent SMT siblings
from being restricted. However, the policy->cur value was not updated,
leaving it at the previous value.

When the CPU comes back online, governor->limits() checks if target_freq
equals policy->cur and skips the frequency adjustment if they match. Since
policy->cur still holds the previous value, the governor does not call
cpufreq_driver->target to update MSR_IA32_PERF_CTL.

Fix this by synchronizing policy->cur with the hardware state when setting
minimum pstate during CPU offline.

Fixes: f6ebbcf08f37 ("cpufreq: intel_pstate: Implement passive mode with HWP enabled")
Signed-off-by: Fushuai Wang <wangfushuai@baidu.com>
---
 drivers/cpufreq/intel_pstate.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 1292da53e5fc..0bd6388caa9d 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -2986,8 +2986,10 @@ static int intel_cpufreq_cpu_offline(struct cpufreq_policy *policy)
 	 */
 	if (hwp_active)
 		intel_pstate_hwp_offline(cpu);
-	else
+	else {
 		intel_pstate_set_min_pstate(cpu);
+		policy->cur = cpu->pstate.min_freq;
+	}
 
 	intel_pstate_exit_perf_limits(policy);
 
-- 
2.36.1

