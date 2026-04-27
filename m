Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7862E37CD2D;
	Mon, 27 Apr 2026 03:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777262134; cv=none; b=iW/uiqDfAmOZjAWEhGPLrzBU23eUNb1QBjkCqhGLe+VpCTGfgKGqt7rVuorAELrIHNQ6unngz3s+wajzBAhQwSebhlS3WJhzvCnR4XjGYoZTEns+wn477268UhsttLVXQeb/c6s2pe9GsdkGJNu1QpM5inAbkGTaO8hPXtMP+0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777262134; c=relaxed/simple;
	bh=x8pB7A77clAsMKogifhO+k7BvxdrCx9He24M7s+iEEY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sdotBYMUDw/6W89wJ1DfIKkpjoADkWGNlCOJv8oDLCpeUioJVlzXidej/fjoc9ekSAJFM5tgfKrTEYjlGGmbPiQgNiugKW8meSfVFqC5ssLAyarYPtC4GPSPbXBvcJTb7Nn4uzMRJFpSgst5i+JxzEIaHbCAB+unC6WUOvZfJ+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fq2uExeU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fq2uExeU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67D06C2BCB9;
	Mon, 27 Apr 2026 03:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777262134;
	bh=x8pB7A77clAsMKogifhO+k7BvxdrCx9He24M7s+iEEY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fq2uExeUp9tWY8LujK5DlwHrM2CFpzEYFS7cNyg0qFBwiX01kfU31f3Hk8b8lI+wH
	 W5Hy7Qz+0Igl7YcwOgt7tfGZU7K4Qzv/gyuBo0O67ewineVUeq9DQbfFlSoSy3o15i
	 Vxv7IBk2rnNqml2LZwOLLI/XIWngQ5lHTnDOHb2Pqaj7bzntq+xgdMAzdpBhdBOkqL
	 UO0jYosL8Fr8Bd9w65pt5fvQ8oaeV+4PtlmlbAwOOcJEKcNrgOuNv3gxUZaikbxdgn
	 7Bxj4yGqSncJhtFxFkBP3wsOQpPXRIg/hm4lzNxrXJ2hXY/X5JNCCnv+iYoJUhceF5
	 MVSZHkOFFBMyw==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
To: =?UTF-8?q?Rafael=20J=20=2E=20Wysocki=20=E2=8F=8E?= <rafael@kernel.org>
Cc: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	x86@kernel.org,
	Mario Limonciello <superm1@kernel.org>
Subject: [PATCH 5/6] cpufreq/acpi-cpufreq: Use amd_get_boost_ratio()
Date: Sun, 26 Apr 2026 22:55:19 -0500
Message-ID: <20260427035520.1427080-6-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260427035520.1427080-1-superm1@kernel.org>
References: <20260427035520.1427080-1-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update get_max_boost_ratio() to use the new amd_get_boost_ratio()
helper function instead of calling amd_get_effective_highest_perf()
directly.

This ensures the boost ratio is calculated correctly on systems where
frequency values should be used instead of performance values.

Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
---
 drivers/cpufreq/acpi-cpufreq.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
index a1a005b29daba..6e80540311f60 100644
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
2.43.0

