Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C8734887C
	for <linux-pm@vger.kernel.org>; Wed, 20 May 2026 03:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779247367; cv=none; b=aTClpsJhxdZOLwZ64TSRAqqJtgDV7T0piMaLmIVRme4MZQY1JI858BPXzqLeBd+N6jhX4zgZ/dtRlIPTRg2EEoFIB/DawOpz8NBFMEZBXpXAzsMsr40XRDav+vowYcaIFbg8T3TYGzH2oBAVfMKtRfeAnyCVnp3geUydHmCfjv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779247367; c=relaxed/simple;
	bh=Cpu72zIKlP/5shzkvgl5+ibZqDu3fBT7lzprYTL58rM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Fexj0LI9w33eItLqz4eLXCgQjPpPx9qsgR9Oai2HVEfYnNILBZ4chpvVxLX9DlYR4QSL5U4td+wWdQRFqYPp6gw2YoxkmE7aJdPxcUA6lNhKjE7L64RVmKM3zCh/Q/0/RgtpY/vgQRzfOL/QRWbpmBHmZo2WVc4v0B1ew813/HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KV6qtBh2; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KV6qtBh2"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779247363;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ZqZmu0OqZXtv/PtHiYRsiCkX8ld0/Ake0qTSoL86xa8=;
	b=KV6qtBh2zR13CBHHP4AaZRqqlnwcpLwTrs/mQpoSeDlAyDV9dX3SRyl8G8gp/HKwy/1v3/
	B+09PLGFyRDmMdQNDUUUyj+fOiHTRAxhzviDuVinT1Hgc18kpKbxqyrUfyh+Hz+cAGUpP1
	ExS8+ykyX70hxwuRZdMqISANBtnbk44=
From: Fushuai Wang <fushuai.wang@linux.dev>
To: srinivas.pandruvada@linux.intel.com,
	lenb@kernel.org,
	rafael@kernel.org,
	viresh.kumar@linaro.org,
	currojerez@riseup.net
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	wangfushuai@baidu.com,
	stable@vger.kernel.org
Subject: [PATCH v2] cpufreq: intel_pstate: Sync policy->cur when setting min pstate during CPU offline
Date: Wed, 20 May 2026 11:21:19 +0800
Message-Id: <20260520032119.30615-1-fushuai.wang@linux.dev>
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

Fixes: bb18008f8086 ("intel_pstate: Set core to min P state during core offline")
Cc: stable@vger.kernel.org # 3.15+
Suggested-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Signed-off-by: Fushuai Wang <wangfushuai@baidu.com>
---
 drivers/cpufreq/intel_pstate.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 1292da53e5fc..11db1c887c80 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -2984,10 +2984,12 @@ static int intel_cpufreq_cpu_offline(struct cpufreq_policy *policy)
 	 * from getting to lower performance levels, so force the minimum
 	 * performance on CPU offline to prevent that from happening.
 	 */
-	if (hwp_active)
+	if (hwp_active) {
 		intel_pstate_hwp_offline(cpu);
-	else
+	} else {
 		intel_pstate_set_min_pstate(cpu);
+		policy->cur = cpu->pstate.min_freq;
+	}
 
 	intel_pstate_exit_perf_limits(policy);
 
-- 
2.36.1

