Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43CB832B131
	for <linux-pm@vger.kernel.org>; Tue, 19 May 2026 11:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779189943; cv=none; b=KJm7Q7zTZsm9z2vVRQsjaFgcXuuG09rJgNMeuUVW74exR5xkPFOVmEbDyZ8xYcxwV1WVU5jYeKTSyxAX6qHv3w/rcjuVd+XE8unKI7Com1KUIVs1NV848KT1Hronq80bNrlc0VnG7Jj9xVGjkYKhNiVtPqTaNVnNejFCwx78ccc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779189943; c=relaxed/simple;
	bh=wrLGlLnRnuHNeLR/XJRx6AUTo4j9X+V4rjRWujMtMUs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VUYNukhES06OCsTXdedyk/7dGIoJnJ33olYP3OQ7U639MMGtFfNZM3JtKxFMtYM+oOjoreXo/O1ltpcvyjR6r4kZxijLfww4RJX7YmzAPQz+RGTQyckZst4IirXQqpLuGGjkmNAf8ts1j8Rq5WMsC4TNCESbKcKS8gmdTXtEtWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Ogk6Ss8M; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Ogk6Ss8M"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779189930;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=DXKeliB+XhMjzKveQR7TBPCM8hGDZOG662zKo4luP/E=;
	b=Ogk6Ss8Mj/Ndp6dqnNrxqub0q3j3ZZ5Qgh0JUZVZqkhHCdzyMmMDqN3C+GGyKa15nax5Y+
	EhKJ9KUgBXox25fJ+pwDFPPIWWHVw/NyXL2o/ycbFNOfqLozxied6UZ4IXab1wP9k4P0d4
	LRmO6jmLXeVj9rzDGzTIicSlANFHBJU=
From: Fushuai Wang <fushuai.wang@linux.dev>
To: srinivas.pandruvada@linux.intel.com,
	lenb@kernel.org,
	rafael@kernel.org,
	viresh.kumar@linaro.org,
	currojerez@riseup.net
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	wangfushuai@baidu.com
Subject: [PATCH RESEND] cpufreq: intel_pstate: Sync policy->cur when setting min pstate during CPU offline
Date: Tue, 19 May 2026 19:24:45 +0800
Message-Id: <20260519112445.9986-1-fushuai.wang@linux.dev>
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

