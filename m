Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26CC846AEEA;
	Wed,  3 Jun 2026 12:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780488100; cv=none; b=S2pDQA7qUSts+hQdASCxeNSc29X5OdO3R5t9KQWWdXNjZlkjRrQxvRzH4emhGTnZQKNgOS1/zp+jSbOD4NNIV227uI3clzTUSejsqgn++xgPMKFgpLIX1fva/Zy49uI0Gv+yThuUB5S+zlZGqTtsE098zf6YBYB9NO78qnTum+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780488100; c=relaxed/simple;
	bh=wblGCJrCm/VgNeNEH8FYabjvGp1gDOUsjasETsshYbs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mpJTWxwiDe7Wwd6oub4Pl5Me1mKdZoudjUEOrJQz8SJgJXrU2EoYKVbjkPi1QpfmwfPxVedQl5Q/5zeFP4cgx/yl4JRua0PMm2ytPTZ9XCcQI4RNYx75uFzQHMDlEYvY2mq/8IThqed4EfV1jxvtAnbIuAKhQCbMhO/sZZTg7Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=WBj2Imz3; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="WBj2Imz3"
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id C048D27117;
	Wed,  3 Jun 2026 14:01:36 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fk7GTP6CTn4L; Wed,  3 Jun 2026 14:01:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1780488096; bh=wblGCJrCm/VgNeNEH8FYabjvGp1gDOUsjasETsshYbs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WBj2Imz3e/usopwYAbbMa4o6yTs+uG9aqDzmD+u1M3nk+JTxvBnvFYCakNx81as/m
	 iyn1KVANe+/1Rw/1WpuuRlBU7eYtkP3/24Mk3PzcxgXCl7/vQZTLiTDBnoWKNNqilb
	 xHXW83AHyU0pn4kN/6ZmL/ns3DNHSExqm0Zns/IxCUJ/PvTsYLfbLBfWALYevA+Bsz
	 AQfrob2MRpxoGqZhJU3WVIbJgjwfEBNcn5vwXU+4sqnLKj2VB7+BuJiM2Ms/jeYISE
	 +r1/KsFPEMqvrHj+UjZIVm0SlyNEE56Xslt+OCsJrQDY0BqK5Ex4qNB5qwoDqiWPdo
	 mbPpDzfURpjjQ==
From: Marco Scardovi <scardracs@disroot.org>
To: kprateek.nayak@amd.com
Cc: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	mario.limonciello@amd.com,
	perry.yuan@amd.com,
	rafael@kernel.org,
	ray.huang@amd.com,
	scardracs@disroot.org,
	stuartmeckle@gmail.com,
	viresh.kumar@linaro.org,
	wyes.karny@amd.com
Subject: [PATCH v2 2/2] cpufreq/amd-pstate: Prevent active mode on systems without EPP support
Date: Wed,  3 Jun 2026 13:56:35 +0200
Message-ID: <20260603120121.25772-3-scardracs@disroot.org>
In-Reply-To: <20260603120121.25772-1-scardracs@disroot.org>
References: <4cb9459c-f471-478a-9670-58d898619f45@amd.com>
 <20260603120121.25772-1-scardracs@disroot.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some AMD processors or firmware configurations do not support Collaborative
Processor Performance Control (CPPC) Energy Performance Preference (EPP).
When loading the amd-pstate driver in EPP-reliant "active" mode on these
systems, the driver fails to function correctly.

Unconditionally probe EPP support during driver initialization via a new
amd_pstate_epp_supported() helper, which queries cppc_get_epp_perf() on
the first online CPU. EPP capability is uniform across all CPUs on x86,
making a single CPU query sufficient.

Treat EPP support as a tri-state during probing:
- Success: EPP is supported.
- -EOPNOTSUPP: EPP is definitively unsupported.
- Unknown error: Warn about the unexpected failure, but default to assuming
  EPP is supported to avoid false negatives.

Cache the capability in a static global `epp_supported` boolean to avoid
redundant capability checks during runtime mode switches.

If EPP is unsupported:
- Fall back to passive mode at boot to keep the driver functional rather
  than failing to load entirely.
- Reject runtime switches to active mode via sysfs with -ENODEV and print
  a warning.

Fixes: ffa5096a7c33 ("cpufreq: amd-pstate: implement Pstate EPP support for the AMD processors")
Link: https://bugzilla.kernel.org/show_bug.cgi?id=221473
Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Marco Scardovi <scardracs@disroot.org>
---
 drivers/cpufreq/amd-pstate.c | 44 ++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index e8057f3dfb1e..cd052880ecb3 100644
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
@@ -1772,6 +1775,11 @@ int amd_pstate_update_status(const char *buf, size_t size)
 	if (mode_idx < 0)
 		return mode_idx;
 
+	if (mode_idx == AMD_PSTATE_ACTIVE && !epp_supported) {
+		pr_warn("EPP is not supported by this processor, active mode rejected\n");
+		return -ENODEV;
+	}
+
 	if (mode_state_machine[cppc_state][mode_idx]) {
 		guard(mutex)(&amd_pstate_driver_lock);
 		return mode_state_machine[cppc_state][mode_idx](mode_idx);
@@ -2229,6 +2237,36 @@ static bool amd_cppc_supported(void)
 	return true;
 }
 
+static bool amd_pstate_epp_supported(void)
+{
+	unsigned int cpu = cpumask_first(cpu_online_mask);
+	u64 epp;
+	int ret;
+
+	/*
+	 * On symmetric x86 systems, CPPC EPP support is uniform across all
+	 * CPUs. Probing the first online CPU is sufficient to determine
+	 * system-wide capability.
+	 */
+	ret = cppc_get_epp_perf(cpu, &epp);
+	if (!ret)
+		return true;
+
+	/*
+	 * We treat EPP support as a tri-state:
+	 * - Success (0): EPP is supported.
+	 * - Unsupported (-EOPNOTSUPP): EPP is definitively unsupported.
+	 * - Unknown error (others): Warn about the unexpected failure, but
+	 *   default to assuming support to avoid false negatives (this may
+	 *   be revisited if transient errors cause driver instability).
+	 */
+	if (ret == -EOPNOTSUPP)
+		return false;
+
+	pr_warn("Unable to determine EPP capability: %d\n", ret);
+	return true;
+}
+
 static int __init amd_pstate_init(void)
 {
 	struct device *dev_root;
@@ -2251,6 +2289,12 @@ static int __init amd_pstate_init(void)
 	if (cpufreq_get_current_driver())
 		return -EEXIST;
 
+	epp_supported = amd_pstate_epp_supported();
+	if (cppc_state == AMD_PSTATE_ACTIVE && !epp_supported) {
+		pr_warn("EPP not supported, falling back to passive mode\n");
+		cppc_state = AMD_PSTATE_PASSIVE;
+	}
+
 	quirks = NULL;
 
 	/* check if this machine need CPPC quirks */
-- 
2.54.0

