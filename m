Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 218703E317C;
	Thu, 23 Jul 2026 21:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784843834; cv=none; b=Xy8N7uaO1YPhCULSqEYiVoit8gnYFzJwMiHZ+H8UVkhTyCAlY7ti82+H3ngLrVnyr+pdcoTMcO1k3eTNsJos9EJu+WVB1OuKpqgSW/X57LKho3BcYVHD9X9QWLw847IrFD9PRAQwQQMS/mE2uk+25UdzsyP/0hsnsvveS3Jgh68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784843834; c=relaxed/simple;
	bh=bmDII24EHezNTLC+Z/6meUveEkQG5DIX60RgUESjrOc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KjVGkY4ij5aDntEd6HEETDvvNicnCuJv96e6IYz9seEbG6WjHdcxWP//Z9psnaBVawKIuPDZlwAKsePMr0uX/mWhs+rgELHS2DNCRJs94Ld6DpuL78flqGWyKkByI1+sfwQLtKlIc922nGwwcP1dCk7YAUHnYfaw642KXX1p8yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=T3K7OqCw; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="T3K7OqCw"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CDF441477;
	Thu, 23 Jul 2026 14:57:06 -0700 (PDT)
Received: from e127648.arm.com (unknown [10.57.3.90])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 11A053F66F;
	Thu, 23 Jul 2026 14:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1784843831; bh=bmDII24EHezNTLC+Z/6meUveEkQG5DIX60RgUESjrOc=;
	h=From:To:Cc:Subject:Date:From;
	b=T3K7OqCwdVAgfaJXHRG7R5rsVVqOtIb0DsGWRxHmOAYTtcckdVhTjqk4pL8jI2biS
	 8aKmEICL5R9n8X+NQvQJsa635qB+Na3n10kR2myOhAGkdSysOzoMF4KOWEteUIdC9H
	 +l1Ozjs+rrPDW/MD3PbyNHXJ/6KOY3FikUNr/DgU=
From: Christian Loehle <christian.loehle@arm.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Len Brown <lenb@kernel.org>,
	Jie Zhan <zhanjie9@hisilicon.com>,
	Lifeng Zheng <zhenglifeng1@huawei.com>,
	Pierre Gondois <pierre.gondois@arm.com>,
	Sumit Gupta <sumitg@nvidia.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Ionela Voinescu <ionela.voinescu@arm.com>,
	Christian Loehle <christian.loehle@arm.com>
Subject: [PATCH] ACPI: CPPC: Skip writes to unsupported performance limits
Date: Thu, 23 Jul 2026 22:56:34 +0100
Message-Id: <20260723215634.1062264-1-christian.loehle@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

MIN_PERF and MAX_PERF are optional CPPC controls. The cppc-cpufreq
target callbacks nevertheless populate both values for every request
without checking whether the controls are implemented.

cppc_set_perf() consequently passes a NULL register descriptor to
cpc_write(). The write fails width validation and its return value is
ignored, so the failed access path is repeated on every target request.

Check that each optional limit control is supported before calling
cpc_write().

Fixes: ea3db45ae476 ("cpufreq: cppc: Update MIN_PERF/MAX_PERF in target callbacks")
Signed-off-by: Christian Loehle <christian.loehle@arm.com>
---
 drivers/acpi/cppc_acpi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 1d3a94100491..7bac6d5da24b 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -1970,9 +1970,9 @@ int cppc_set_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls)
 	 * value to min and max perf, but they don't mean to set the zero value,
 	 * they just don't want to write to those registers.
 	 */
-	if (perf_ctrls->min_perf)
+	if (perf_ctrls->min_perf && CPC_SUPPORTED(min_perf_reg))
 		cpc_write(cpu, min_perf_reg, perf_ctrls->min_perf);
-	if (perf_ctrls->max_perf)
+	if (perf_ctrls->max_perf && CPC_SUPPORTED(max_perf_reg))
 		cpc_write(cpu, max_perf_reg, perf_ctrls->max_perf);
 
 	if (CPC_IN_PCC(desired_reg) || CPC_IN_PCC(min_perf_reg) || CPC_IN_PCC(max_perf_reg))
-- 
2.34.1

