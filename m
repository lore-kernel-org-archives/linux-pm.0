Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793276405;
	b=fICi3l72Ng5TtcBfbFTnOjoMVnOuO0VtXWGGvKFoglZWZ481PcEHDU1m1bFSRYRmzVlB
	 /mW0jpGFhVEe7nwCH21cqey/YM9MFVIjggbORENN6kqCNSRH/H5uh4T/vleDJBLlUUB2F
	 KHqzg5MsfuXaZNnLjsUr4eLnYDNEtUWvolkFRisf/+xWKfWjW7/m2v/MpMzHF2QWudCqS
	 LUGFt5drPMaYF1cicQGaiSSjIHIhHCmPCAa6xXoQl850F3TA7I8ExgvTEwFkVrPGT1jHc
	 Ry2UhAR6oAvvo/ErU5D1Q16wpl3eN0Q4oCS6lPvWkksng6T9PkEqRauU+GSSg4hboYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793276405;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ATt796cZxBkc7ShjonyRbSyhAi/Blm2Gq1rSHXA7prA=;
	b=WS+RN49CTUZXUoqrtGXY6WvREvgG5hIHwX4kxuLkcMKcXV/3VgFmDGsiOLsX5wIpPOAJ
	 R9RAfXdPrV6quwC20MRFyXzpXSJyHgMYHcFhvgS1rFOlWHOmtqwtAgtboazDMGFKWrm8p
	 TxdAAOiv5HgtEQwYJBZlTyWz9NdV+7QG9zYMJGBW+oRXTX3n119eACntU3li7dO8zfvrU
	 O+Dmk+G/npW6PduSMXNwit901SgPAtGxNW0JEPguZFI1a13i6G1LAcuH38O7x5Ngt14s2
	 JvfHBumfiqO8W1QlX/8b0phzGZrdipSb+5TGxy02l28JXCOgmufhw6ctJ+xAw7HZMow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=d+f6sBEY;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08489606A32A;
	Thu, 29 Oct 2026 12:20:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 08489606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=d+f6sBEY
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5EA5F1BB2;
	Thu, 29 Oct 2026 05:20:01 -0700 (PDT)
Received: from e127648.arm.com (unknown [10.57.65.47])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B4A693F673;
	Thu, 29 Oct 2026 05:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793276404; bh=oDf71kKr+RnbOFDskqLKbnFlEXoiTBgc2ZG7DRPD0oQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d+f6sBEYb9BLEkwbgSHHXeHgzBFfvZpkVoSwb2JJTbzokYDBtzaJg8XZ/M9sc/Ri4
	 CxH23hO79KP3G/rYe6D/Shspja0/ty2DOo7xYy7EVnHdghSijfWw92Hbds1peQ4glP
	 Cc9K6IcyJZilbGWMV/k30zQCBxxDYP8TxJA5AYjo=
From: Christian Loehle <christian.loehle@arm.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>
Cc: "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Perry Yuan <perry.yuan@amd.com>,
	Huang Rui <ray.huang@amd.com>,
	Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Christian Loehle <christian.loehle@arm.com>
Subject: [PATCH 2/2] cpufreq/amd-pstate: Clamp desired perf on resume
Date: Thu, 29 Oct 2026 12:19:45 +0000
Message-Id: <20261029121945.854675-3-christian.loehle@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261029121945.854675-1-christian.loehle@arm.com>
References: <20261029121945.854675-1-christian.loehle@arm.com>
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

amd_pstate_resume() converts policy->cur to a performance level and
writes it directly alongside the cached policy limits. Both
frequency/performance conversions round up, so the converted value
can exceed max_limit_perf even when the request before suspend was
within the policy limits.

On a Ryzen 5 7430U with a fixed 1.2 GHz policy, a request with
Desired=46 becomes policy->cur=1216621 kHz and converts back to
Desired=47. Resume then writes MIN=46, Desired=47, MAX=46.

Clamp the converted Desired to the cached minimum and maximum before
restoring the request.

Fixes: 608a76b65288 ("cpufreq/amd-pstate: Add support for the "Requested CPU Min frequency" BIOS option")
Signed-off-by: Christian Loehle <christian.loehle@arm.com>
---
 drivers/cpufreq/amd-pstate.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 28df8507d93f..0b1b0e263577 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -2211,6 +2211,7 @@ static int amd_pstate_resume(struct cpufreq_policy *policy)
 	int ret;
 
 	/* Set CPPC_REQ to last sane value until the governor updates it */
+	cur_perf = clamp(cur_perf, perf.min_limit_perf, perf.max_limit_perf);
 	ret = amd_pstate_update_perf(policy, perf.min_limit_perf, cur_perf, perf.max_limit_perf,
 				     0U, false);
 	if (ret)
-- 
2.34.1

