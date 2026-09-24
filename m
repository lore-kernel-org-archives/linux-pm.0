Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395D54503E4;
	Thu, 24 Sep 2026 16:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790265664; cv=none; b=APrMPEcPAgqTAuaMlyUbna/aPkNIYeL8wvW9RupqS4LxSNQNaYTq3rKWK4HiMdREYGUShEt6LCrTnKaRrKAqoCSLvCENw6Ed3BbTrLMdPGR8ekgpbKe/wD/N/QOFK73hDVsyFYYyZE3gGoI/tFddT9e8IyVNXlZrUaNOWO/+Hsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790265664; c=relaxed/simple;
	bh=1plywIJLDji44OSYLVz0L2MqZabW2EVBru1OGAZ49Qs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ny2duUNA6eX/h1BWUkQ3ZCTEzhJJy9q/LQcAQFQFtmm1kWTLTg7AAwsvnYxuaaFGd1sOMAs3VkwdBFHXzHg39yPtFPIIFRC45kM/6iJI9IL1wGmwy6Xb10T5sQVMjX9zVtHopNWHboL7GJ3ri3XGGhuhwQA4FsYRvYQRHiijRVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DJSlrWs6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DJSlrWs6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D3CF1F00898;
	Thu, 24 Sep 2026 16:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790265662;
	bh=x6VZ4NYHxdF5KHVkhld7yVnQ4i6s62tsYc74Rk2w+0A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DJSlrWs6efigY9tkR+ER9NoPCBGUCZMMfuPDy/j0zcy7h005qrruEZsUjhCmYUOVf
	 twXRWKac026gsyzvTE/5R7qVdt173tvbc6Um68TGwYLsXF9F1AyrbD+xU26EA78zjL
	 bfREOKEGLETNzOxDVhF//4MNKMi46G9cUgaxz4X2usLl5wAX9PJPCtpXVvvgLsk33d
	 rHKpKOC38hcG2AV9Q3akPqYyDgf1vdY6x5wIrH9B68xYpSPYbd/h7JlwNDiWHd8c/p
	 cdRKhJ9WmhJibWLECBTsStlRwuQjjLpjhoxNjZZgum+JE848Avzc541fEHmJzrru7q
	 QjM+Ymavxo0HQ==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
To: =?UTF-8?q?Rafael=20J=20=2E=20Wysocki=20=E2=8F=8E?= <rafael@kernel.org>
Cc: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	x86@kernel.org,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v3 2/3] cpufreq/acpi-cpufreq: Use amd_get_boost_ratio()
Date: Thu, 24 Sep 2026 11:00:51 -0500
Message-ID: <20260924160052.2858456-3-superm1@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260924160052.2858456-1-superm1@kernel.org>
References: <20260924160052.2858456-1-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

Update get_max_boost_ratio() to use the new amd_get_boost_ratio()
helper function instead of calling amd_get_effective_highest_perf()
directly.

This ensures the boost ratio is calculated correctly on systems where
frequency values should be used instead of performance values.

Reviewed-by: K Prateek Nayak <kprateek.nayak@amd.com>
Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/cpufreq/acpi-cpufreq.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
index 523ee1a06ef8a..2e74a000cdc74 100644
--- a/drivers/cpufreq/acpi-cpufreq.c
+++ b/drivers/cpufreq/acpi-cpufreq.c
@@ -626,7 +626,7 @@ static int acpi_cpufreq_blacklist(struct cpuinfo_x86 *c)
 static u64 get_max_boost_ratio(unsigned int cpu, u64 *nominal_freq)
 {
 	struct cppc_perf_caps perf_caps;
-	u64 highest_perf, nominal_perf;
+	u64 numerator, denominator;
 	int ret;
 
 	if (acpi_pstate_strict)
@@ -640,33 +640,31 @@ static u64 get_max_boost_ratio(unsigned int cpu, u64 *nominal_freq)
 	}
 
 	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD) {
-		ret = amd_get_effective_highest_perf(cpu);
-		if (ret < 0) {
-			pr_debug("CPU%d: Unable to get boost ratio numerator (%d)\n",
+		ret = amd_get_boost_ratio(cpu, &numerator, &denominator);
+		if (ret) {
+			pr_debug("CPU%d: Unable to get boost ratio (%d)\n",
 				 cpu, ret);
 			return 0;
 		}
-		highest_perf = ret;
 	} else {
-		highest_perf = perf_caps.highest_perf;
+		numerator = perf_caps.highest_perf;
+		denominator = perf_caps.nominal_perf;
 	}
 
-	nominal_perf = perf_caps.nominal_perf;
-
 	if (nominal_freq)
 		*nominal_freq = perf_caps.nominal_freq * 1000;
 
-	if (!highest_perf || !nominal_perf) {
+	if (!numerator || !denominator) {
 		pr_debug("CPU%d: highest or nominal performance missing\n", cpu);
 		return 0;
 	}
 
-	if (highest_perf < nominal_perf) {
+	if (numerator < denominator) {
 		pr_debug("CPU%d: nominal performance above highest\n", cpu);
 		return 0;
 	}
 
-	return div_u64(highest_perf << SCHED_CAPACITY_SHIFT, nominal_perf);
+	return div_u64(numerator << SCHED_CAPACITY_SHIFT, denominator);
 }
 
 #else
-- 
2.53.0

