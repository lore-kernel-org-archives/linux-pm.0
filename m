Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322E93C7DE1;
	Wed,  5 Aug 2026 12:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785932348; cv=none; b=jXWQCi5ydCqoxb2tBrKHYKvW5FSIAv1d7hB/cXfZ5InRw4nJ97mX6Ov3Cl4/XA+QjXOyDEW/SpXrmryO1XyC7vgV0r+2GnPqGiBBpRnWnrGSxRBG5tD82hOeQx7nDyRUMQaK6LRzb09EvqGwCUzyMGJaVHAFMJ4vkw50H9ob6Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785932348; c=relaxed/simple;
	bh=JmZ8M0SN4ih168r+YbC/9WNlIET0F+AKXWj1sRQUcvw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FyL5dHiMROW3A7SXiZ2P40P57fcsZhABh4lNa4pyDkWc/b2TLjrFmNm2fgNNBwhtKdtnYYdsTGJC0Ypy3g0JG1TNPBVx+EbWjPttNBQ12Oq6N/hEnpeCWsjzTsvNOta2xggIbPZHGUi7hPeCcC1nHyPfB/xa9llG76Dg/tYF+Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QmUMh/kE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QmUMh/kE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E094E1F000E9;
	Wed,  5 Aug 2026 12:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785932347;
	bh=ryUCT1I0NhGr3mY1hgYVq8pD7GX6p39nJnHv1df6CQE=;
	h=From:To:Cc:Subject:Date;
	b=QmUMh/kEcbhtxoly18U6rzo7s3tAPaONT9d6L0S3YxMs/YtDO42z1jjFZa7Bpjj2l
	 a1He17n+5lJ7W2YIprG7D7iKLvSWUIePUU8s17ba1hIv5Y5FYvHUO2ch85TZN13ts/
	 4hRTD7qpzQMwBeNPgJPuTBSo3UKXLVTDp03/AOkVr0IdJpk6nyFy5Yc1JKQyzyl1UH
	 0A/qE09265PtUEJlvCUMbGHNGCvtovrrwXsUAl5Z6gmNxXTsIkiwawMV6j3wH7PRQm
	 xnID9KiYGxrFPFUqypp7whENRJZkWoPjHudSWVhTtscYslBNDQtuJPVCx7NmY8znlN
	 25m28OT3UIq1w==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Doug Smythies <dsmythies@telus.net>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 LKML <linux-kernel@vger.kernel.org>
Subject:
 [PATCH v2] cpufreq: intel_pstate: Avoid using DESIRED_PERF when DEC is
 enabled
Date: Wed, 05 Aug 2026 14:18:11 +0200
Message-ID: <4758098.LvFx2qVVIh@rafael.j.wysocki>
Organization: Linux Kernel Development - Intel
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

In principle, the desired performance level can be set in MSR_HWP_REQUEST
to indicate to the processor what performance level the OS would like
the given CPU to run at, but if the Dynamic Efficiency Control (DEC)
feature is enabled in the processor, doing so may result in confusing
the processor firmware.  It is then better to let the processor firmware
figure out the most suitable performance level by itself.

Accordingly, make intel_pstate always set the desired performance level
to zero (which means "no preference") when running on a platform with
DEC enabled.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---

Applies to linux-next.

v1 -> v2:
   * Use rdmsrq_safe() in hwp_check_dec() (Sashiko)

---
 drivers/cpufreq/intel_pstate.c |   13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -303,6 +303,7 @@ static bool per_cpu_limits __ro_after_in
 static bool hwp_forced __ro_after_init;
 static bool hwp_boost __read_mostly;
 static bool hwp_is_hybrid;
+static u32 hwp_desired_mask __read_mostly = ~0U;
 
 static struct cpufreq_driver *intel_pstate_driver __read_mostly;
 
@@ -3150,7 +3151,7 @@ static void intel_cpufreq_hwp_update(str
 	value |= HWP_MAX_PERF(max);
 
 	value &= ~HWP_DESIRED_PERF(~0L);
-	value |= HWP_DESIRED_PERF(desired);
+	value |= HWP_DESIRED_PERF(desired & hwp_desired_mask);
 
 	if (value == prev)
 		return;
@@ -3760,9 +3761,9 @@ static bool hwp_check_epp(void)
 
 static bool hwp_check_dec(void)
 {
-	u64 power_ctl;
+	u64 power_ctl = 0;
 
-	rdmsrq(MSR_IA32_POWER_CTL, power_ctl);
+	rdmsrq_safe(MSR_IA32_POWER_CTL, &power_ctl);
 	return !!(power_ctl & BIT(POWER_CTL_DEC_ENABLE));
 }
 
@@ -3787,6 +3788,7 @@ static int __init intel_pstate_init(void
 	id = x86_match_cpu(hwp_support_ids);
 	if (id) {
 		bool epp_present = hwp_check_epp();
+		bool dec_present = hwp_check_dec();
 
 		/*
 		 * If HWP is enabled already, there is no choice but to deal
@@ -3798,7 +3800,7 @@ static int __init intel_pstate_init(void
 			no_hwp = 0;
 		} else if (no_load) {
 			return -ENODEV;
-		} else if (!epp_present && !hwp_check_dec()) {
+		} else if (!epp_present && !dec_present) {
 			/*
 			 * Avoid enabling HWP for processors without EPP support
 			 * unless the Dynamic Efficiency Control (DEC) enable
@@ -3820,6 +3822,9 @@ static int __init intel_pstate_init(void
 			if (!default_driver)
 				default_driver = &intel_pstate;
 
+			if (dec_present)
+				hwp_desired_mask = 0;
+
 			if (!id->driver_data)
 				pstate_funcs.get_cpu_scaling = hwp_get_cpu_scaling;
 



