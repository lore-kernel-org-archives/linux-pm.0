Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B4E742CAFB;
	Mon,  3 Aug 2026 18:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785780926; cv=none; b=JWINgS8RuIraeIl/gJlxIQylMIorUBLLe0Jve0IGFUCBul9wYxnxyJidligIWMIWOfjpGvZ2ZeUgUjxYEqOsuMArCRDm4w2qFvouU+hpiZyZJ8ZEJfj2N77EBFGlSnFlYOAnWihA3wLiKj6phG9P1TrX8CQbOKUARgV7PadKt9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785780926; c=relaxed/simple;
	bh=2qVG8Suh4pze18kxHfUWgu99q/R2KATrHXJS4P+Oluc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tYUlCPQZ91MYxdlfcIARweekQX5yulWzvFLm0tQwOWUfqhrjpjPsOr3Fq4rN3Ri3VMCUsoWDovE13/alnxzdjfJX0ZUlZBXDnAWf/MnnCeTCcNzLCB07+5SY4ZA6SKLXFYN44arHy2Cq/OW0XZLt1k3lS7eBkYut9DSK/N3rhaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nb9UTTvt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nb9UTTvt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DF7C1F000E9;
	Mon,  3 Aug 2026 18:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785780924;
	bh=fQEP/9FYn2SX1clI/0mxxJkxFXMyoCyvFtT6uAITpFc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Nb9UTTvt6zujI0nDDC5nhokO8kBVIfJWQghMSuChiTI56rqTcA/gGKf9cxiO3+p6R
	 Y1KGyWq3FSEc/2W7YuTu8iiTma8kW42JQQhwHP5qVLE3ADzSwCg6iHlY/jOt8a3htn
	 NXjslJ8erdtdinm7Ns8wiBCEwz+bt4XAM3FNmoMdyZ9egvAviwNoL2qcTuRmVG5oWY
	 BC7uYFqWYiWx2sOK+sksyA3riJqRNhdllylCKiNpZNJOCjAO/ZolUEbxzhmBamSgBU
	 jUWmLyWQEBf4y40khfA3EZ4ZFZilwY/c3XuUUBoOFzUttGP70g+6GAspNrHEoqtr82
	 HC6Y/lssx+0Vw==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Doug Smythies <dsmythies@telus.net>, linux-kernel@vger.kernel.org
Subject:
 [PATCH v1] cpufreq: intel_pstate: Avoid using DESIRED_PERF when DEC is
 enabled
Date: Mon, 03 Aug 2026 20:15:20 +0200
Message-ID: <5091298.GXAFRqVoOG@rafael.j.wysocki>
Organization: Linux Kernel Development - Intel
In-Reply-To:
 <20260729-bug-intel-pstate-policy-cur-v1-1-51f61e5cbd74@gmail.com>
References: <20260729-bug-intel-pstate-policy-cur-v1-1-51f61e5cbd74@gmail.com>
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
---

Applies on top of linux-next.

---
 drivers/cpufreq/intel_pstate.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

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
 



