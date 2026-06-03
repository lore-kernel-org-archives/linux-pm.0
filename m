Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC45C436352;
	Wed,  3 Jun 2026 08:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780474923; cv=none; b=U/RkkDeFatopDjNPfuul9H1oRnZ6zqn8yj3kpcHd+GU/Cieq921zgqlKstVd8WgVZkVajfwmppEEUBCBrirMrxGPFe+8M0vFnlt947/kKLFYd1XDbFn+2gz4A2dooHYYUyPsSMUNO/VMLzdu0ybZdghFosWOfoln5N5S1WPaMcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780474923; c=relaxed/simple;
	bh=1cz1Zt5lBMkeN9SGzq7Xdo0H9z83kWDpI1nwDhTBVro=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kMSgdRC+zqrA1qi6VgsMx0PTS0rYzw/HA17qAvE5wzz6yx0KFNGC9refa3C+4qPwZOJXUh+Vmpvt7vOeg5COSkVFCGwdtg2bgkDg1bNIq0mQ+aurmbgSYlh06sev99tEPqNEc5v8JvqZTT4ycQF0wcRvFwrsXJz/6Dyh7UxMT5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=lWx9hISH; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="lWx9hISH"
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 7321127138;
	Wed,  3 Jun 2026 10:21:59 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UxHIKg1d0gqQ; Wed,  3 Jun 2026 10:21:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1780474918; bh=1cz1Zt5lBMkeN9SGzq7Xdo0H9z83kWDpI1nwDhTBVro=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lWx9hISHJ5xiRlLlt6kBxIaChDi8fzpJBmOgo6dJ/pLVoZBjkBFyKIQxaJ08yX1Mq
	 ogywTLlOYuspqnMVWEG6lYS8uhiw5LjXtO7TfKbJBPmKdGjBq7rIGYZ6x8/Naw+uOv
	 vEUwVtkqk4MptRhFJJK/mxlINR/FYnRrQCAdoNSOPrxpNZpuETxldDGvcutAT4l+I0
	 6e37BE4UIxOy0oGZOKURXl3ql0D8DqR4Tt5zT9GOYXhchDrspYcLWDNmqyD2FIxTY0
	 FD8KDora4T5gghqs70EOWTQjnld3GS6E6FD7FlDWODSfi4Mm0EAMN/YsmLpTj8Vx2B
	 wz/M/TqAQiL/A==
From: Marco Scardovi <scardracs@disroot.org>
To: viresh.kumar@linaro.org,
	rafael@kernel.org,
	ray.huang@amd.com,
	mario.limonciello@amd.com
Cc: perry.yuan@amd.com,
	kprateek.nayak@amd.com,
	wyes.karny@amd.com,
	stuartmeckle@gmail.com,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] cpufreq/amd-pstate: Prevent active mode on systems without EPP support
Date: Wed,  3 Jun 2026 10:19:57 +0200
Message-ID: <20260603082143.11215-2-scardracs@disroot.org>
In-Reply-To: <20260603082143.11215-1-scardracs@disroot.org>
References: <20260603082143.11215-1-scardracs@disroot.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Zen 2 and older AMD processors do not support Collaborative Processor
Performance Control (CPPC) Energy Performance Preference (EPP). Loading
the amd-pstate driver in EPP-reliant "active" mode on these systems
pins the CPU frequency to the lowest non-linear frequency (1.7GHz).

Unconditionally probe EPP support during driver initialization via a new
amd_pstate_epp_supported() helper, which queries cppc_get_epp_perf() on
the first online CPU. Lack of ENERGY_PERF support or any error from
cppc_get_epp_perf() causes EPP to be treated as unsupported, with
unexpected errors printing a warning.

Cache the capability in a static global `epp_supported` boolean to avoid
redundant register reads during runtime mode transitions.

If EPP is unsupported:
- Fall back to passive mode at boot to keep the system functional.
- Reject runtime switches to active mode with -ENODEV.

Fixes: ffa5096a7c33 ("cpufreq: amd-pstate: implement Pstate EPP support for the AMD processors")
Link: https://bugzilla.kernel.org/show_bug.cgi?id=221473
Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Marco Scardovi <scardracs@disroot.org>
---
 drivers/cpufreq/amd-pstate.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 8d55e2be825b..61b75e3999b5 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -27,6 +27,7 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/smp.h>
+#include <linux/cpumask.h>
 #include <linux/sched.h>
 #include <linux/cpufreq.h>
 #include <linux/compiler.h>
@@ -88,6 +89,8 @@ static struct cpufreq_driver amd_pstate_epp_driver;
 static int cppc_state = AMD_PSTATE_UNDEFINED;
 static bool amd_pstate_prefcore = true;
 static bool dynamic_epp;
+/* EPP support capability cached for driver mode switches. */
+static bool epp_supported;
 static struct quirk_entry *quirks;
 
 /*
@@ -1614,6 +1617,10 @@ static void amd_pstate_driver_cleanup(void)
 static int amd_pstate_set_driver(int mode_idx)
 {
 	if (mode_idx >= AMD_PSTATE_DISABLE && mode_idx < AMD_PSTATE_MAX) {
+		if (mode_idx == AMD_PSTATE_ACTIVE && !epp_supported) {
+			pr_debug("EPP is not supported by this processor\n");
+			return -ENODEV;
+		}
 		cppc_state = mode_idx;
 		if (cppc_state == AMD_PSTATE_DISABLE)
 			pr_info("driver is explicitly disabled\n");
@@ -2222,6 +2229,22 @@ static bool amd_cppc_supported(void)
 	return true;
 }
 
+static bool amd_pstate_epp_supported(void)
+{
+	unsigned int cpu = cpumask_first(cpu_online_mask);
+	u64 epp;
+	int ret;
+
+	ret = cppc_get_epp_perf(cpu, &epp);
+	if (!ret)
+		return true;
+
+	if (ret != -EOPNOTSUPP)
+		pr_warn("Unable to determine EPP capability: %d\n", ret);
+
+	return false;
+}
+
 static int __init amd_pstate_init(void)
 {
 	struct device *dev_root;
@@ -2274,6 +2297,12 @@ static int __init amd_pstate_init(void)
 		return -ENODEV;
 	}
 
+	epp_supported = amd_pstate_epp_supported();
+	if (cppc_state == AMD_PSTATE_ACTIVE && !epp_supported) {
+		pr_warn("EPP not supported, falling back to passive mode\n");
+		cppc_state = AMD_PSTATE_PASSIVE;
+	}
+
 	/* capability check */
 	if (cpu_feature_enabled(X86_FEATURE_CPPC)) {
 		pr_debug("AMD CPPC MSR based functionality is supported\n");
-- 
2.54.0

