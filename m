Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794483140;
	b=d0H/AH3iRtbRXSzhFW3/b6NcIM+He20eegSt4emX6u5a/v73pzdtsF67EDit4mOmaflR
	 y3EzA+jrqq70vsLPhkdD3ZaCfnAavl8yHD5WobMIR+BpnbJkn0HAXfIyU6mSCC8AqTraD
	 w9g9JlkigSxIi3bbOBXvOvabUWlORXtuDRsSEwZD6BJpd5BnjHShIkQI4XF5REoVMQAcd
	 xSaAq/xzr0tCeUFTF/YQcPTF4odPwcDUTChLb+b1Jhli5wlFGNJXNG62ZenGjnwbVbSGo
	 47GYy/wYcOvxeH4IIUCOHmdC1NO7vYw2CDZOi0qFDtPnWTwfdyn8J13bfDJbKWslThQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794483140;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=oVVhe0CcwYsh26sRbUGAFXELiPdmcYARYiDIsm/ESwM=;
	b=NgYeqIV1wJ/MAjTnxn4ZeI8ijcQ5mmKxSUL/3g8xgfyKYinry5O+qOTzXeSlVSfbJSyw
	 TMITWlo3IYRWTq1cCwMyoGvjL/esHopygSu1yOU2NWAfE34Iwtk72VPxcP3kQc43lFRP0
	 71XXvgg5koCSMB7f8fUlYIjozf8P/mbfh2kk683zXwrF9eb4ZUKbTfWs5NglEw5t3ld3Y
	 CfHGsP9HAAImbR5NeI/aIcNw8weJcf64gZ52xqXItGYRg29KBKTEX3OnziIhSvAubtWUq
	 Z0wKhSIQdapEdr2Zw0Cp9lgsIfl3vYoBaL/MVC1p6+D+EhMxtCbpmjTpBi+uRyXL8Dg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=XYfg0c19;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4258606A330;
	Thu, 12 Nov 2026 11:32:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E4258606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=XYfg0c19
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 49198153B;
	Thu, 12 Nov 2026 03:32:16 -0800 (PST)
Received: from e127648.cambridge.arm.com (e127648.arm.com [10.0.130.226])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 493E03F632;
	Thu, 12 Nov 2026 03:32:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794483139; bh=KRsTSirdGDIuNU6C2SAhAHBsx8rK7wqFVbQpwUQ8dXk=;
	h=From:To:Cc:Subject:Date:From;
	b=XYfg0c19MpFXDRLdxkG3gVF8rUQ6yujUhK/HFeJWTf3J8aF8hTT5QxyLTWvc5Py8X
	 XiO4pm5X/8J3MwZEqrGChWZSxpfiUQJWjbyTRrRnQW1xI5eLNiOw0QzD1G+S0aj9Rv
	 IRDBJnvkxtLKt5EWuj4MS1AX6MnP2DIJ4pGPO5+0=
From: Christian Loehle <christian.loehle@arm.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sumitg@nvidia.com,
	zhanjie9@hisilicon.com,
	zhangpengjie2@huawei.com,
	Christian Loehle <christian.loehle@arm.com>,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH] cpufreq: CPPC: Program policy limits during initialization
Date: Thu, 12 Nov 2026 11:32:04 +0000
Message-Id: <20261112113204.778904-1-christian.loehle@arm.com>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cppc_cpufreq_cpu_init() keeps valid firmware MIN/MAX limits and relies on
the governor to update them. If its first target equals policy->cur, the
core can skip the driver callback, allowing autonomous selection below
scaling_min_freq.

Program MIN from Lowest Nonlinear and MAX from Nominal or Highest according
to the boost state before starting the governor. Set Desired to MAX and
publish policy->cur only after the write succeeds. Leave policy->max unset
so the initial maximum QoS request does not restrict later boost use.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://sashiko.dev/#/patchset/20261106193304.3347374-1-sumitg@nvidia.com
Fixes: ea3db45ae476 ("cpufreq: cppc: Update MIN_PERF/MAX_PERF in target callbacks")
Link: https://lore.kernel.org/all/CAJZ5v0jQVRQhJzLoAy3btKovHGYkqGKJAP_5VfENM_WAREQnyQ@mail.gmail.com/
Signed-off-by: Christian Loehle <christian.loehle@arm.com>
---
 drivers/cpufreq/cppc_cpufreq.c | 34 +++++++++++++---------------------
 1 file changed, 13 insertions(+), 21 deletions(-)

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index a62589c0674f..92a5bb28571c 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -1018,29 +1018,20 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
 		policy->boost_supported = true;
 
 	/*
-	 * The request starts from the live limits, which may be unusable.
-	 * Firmware may leave them zeroed. An interrupted earlier update may
-	 * have left MIN above MAX. cppc_set_perf() would reject either, so
-	 * request the full range instead.
-	 */
-	if (!cpu_data->perf_ctrls.max_perf ||
-	    cpu_data->perf_ctrls.min_perf > cpu_data->perf_ctrls.max_perf) {
-		cpu_data->perf_ctrls.min_perf = caps->lowest_perf;
-		cpu_data->perf_ctrls.min_perf_valid = true;
-		cpu_data->perf_ctrls.max_perf = caps->highest_perf;
-	}
-
-	/*
-	 * Keep the initial request within controls left by an earlier driver
-	 * instance or firmware. The governor will update the full tuple later.
+	 * Program the initial policy bounds before starting the governor. Its
+	 * first target request may be skipped if it already matches policy->cur.
+	 * cppc_set_perf() orders the writes against the live firmware limits.
+	 *
+	 * New policies start with boost disabled, so this matches the initial
+	 * cpuinfo.max_freq. The core applies global boost after governor startup
+	 * and handles any resulting limit change through QoS.
 	 */
-	desired_perf = caps->highest_perf;
-	if (cpu_data->perf_ctrls.max_perf)
-		desired_perf = min(desired_perf, cpu_data->perf_ctrls.max_perf);
-	if (cpu_data->perf_ctrls.min_perf_valid)
-		desired_perf = max(desired_perf, cpu_data->perf_ctrls.min_perf);
+	cpu_data->perf_ctrls.min_perf = caps->lowest_nonlinear_perf;
+	cpu_data->perf_ctrls.min_perf_valid = true;
+	cpu_data->perf_ctrls.max_perf = policy->boost_enabled ?
+					caps->highest_perf : caps->nominal_perf;
 
-	policy->cur = cppc_perf_to_khz(caps, desired_perf);
+	desired_perf = cpu_data->perf_ctrls.max_perf;
 	cpu_data->perf_ctrls.desired_perf = desired_perf;
 
 	cppc_cpufreq_policy_state(policy)->suspend_regs_handled = false;
@@ -1057,6 +1048,7 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
 		goto out;
 	}
 	cpu_data->perf_limits_valid = true;
+	policy->cur = cppc_perf_to_khz(caps, desired_perf);
 
 	cppc_cpufreq_cpu_fie_init(policy);
 	return 0;
-- 
2.34.1

