Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D0B63A452D;
	Tue, 17 Mar 2026 10:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773742733; cv=none; b=ot2Noscg2GtS5Nd608La4e8dy2T8IG78b8fCJUiH7VdUlWyjtrh7NnuRGl14A54928F7p1SbXUDntgdXV2fVVVvN8W/y8etRwEQVl0UqTsXcLV1EFBor/1FYOy0XO9Q2HtzFqwIzgVydCFSIxVUJeop4tpTCCbTbTMMczIEVmwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773742733; c=relaxed/simple;
	bh=dsB++htWglnJo1qJa8OcgIx7Ri+H3o9ijvfmCEjgPvw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f+eDcicXWHzJb4ifGRo1fw+QUO00+1lEQrCIUygPPckTMA46Em0lem8a+FO5gZ25IQIswqtLRtDq4HKwYbJ7fk5/a9uwvp8dC/zlitE6y4U4UMtcWeh2fmnRTmaWsBYo0/E2lDWaWXOy2PzfFp5uDb145NJUwf7g3urqOlRsBrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F20A71477;
	Tue, 17 Mar 2026 03:18:45 -0700 (PDT)
Received: from e135073.home (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8D8043F7BD;
	Tue, 17 Mar 2026 03:18:48 -0700 (PDT)
From: Pierre Gondois <pierre.gondois@arm.com>
To: linux-kernel@vger.kernel.org
Cc: Jie Zhan <zhanjie9@hisilicon.com>,
	Lifeng Zheng <zhenglifeng1@huawei.com>,
	Ionela Voinescu <ionela.voinescu@arm.com>,
	Sumit Gupta <sumitg@nvidia.com>,
	Pierre Gondois <pierre.gondois@arm.com>,
	Huang Rui <ray.huang@amd.com>,
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Perry Yuan <perry.yuan@amd.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Len Brown <lenb@kernel.org>,
	Saravana Kannan <saravanak@kernel.org>,
	linux-pm@vger.kernel.org
Subject: [RFC PATCH v6 4/4] cpufreq/freq_table: Allow decreasing cpuinfo.max_freq
Date: Tue, 17 Mar 2026 11:17:45 +0100
Message-ID: <20260317101753.2284763-5-pierre.gondois@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260317101753.2284763-1-pierre.gondois@arm.com>
References: <20260317101753.2284763-1-pierre.gondois@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Drivers not using freq. tables update cpuinfo.max_freq in their
.set_boost() callback. E.g. amd-pstate, cppc_cpufreq.
Drivers relying on freq. tables and supporting boost frequencies
rely on cpufreq_frequency_table_cpuinfo(). cpuinfo.max_freq is
only updated if the new maximal value is higher than the previous
one.

Using the scmi-cpufreq driver which relies on freq. tables, enabling
boost will permanently increases the cpuinfo.max_freq value.
This patch allows to lower cpuinfo.max_freq.

Note:
commit 538b0188da46 ("cpufreq: ACPI: Set cpuinfo.max_freq directly
if max boost is known")
favored having cpuinfo.max_freq reporting the maximal boosted
frequency of a CPU instead of the maximal reachable frequency
due to regressions in the frequency reported by cpuinfo.max
and scaling_cur_freq.
As stated above, this is not what most of the other cpufreq driver
do. I assume that the following patch:
commit 3c55e94c0ade ("cpufreq: ACPI: Extend frequency tables to
cover boost frequencies")
was correct, but might not have tagged the boosted frequency with
the CPUFREQ_BOOST_FREQ flag in the freq. table.

Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
---
 drivers/cpufreq/freq_table.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/cpufreq/freq_table.c b/drivers/cpufreq/freq_table.c
index 9b37f37c36389..bd08cbe9e9ba3 100644
--- a/drivers/cpufreq/freq_table.c
+++ b/drivers/cpufreq/freq_table.c
@@ -50,12 +50,7 @@ int cpufreq_frequency_table_cpuinfo(struct cpufreq_policy *policy)
 	}

 	policy->cpuinfo.min_freq = min_freq;
-	/*
-	 * If the driver has set its own cpuinfo.max_freq above max_freq, leave
-	 * it as is.
-	 */
-	if (policy->cpuinfo.max_freq < max_freq)
-		policy->cpuinfo.max_freq = max_freq;
+	policy->cpuinfo.max_freq = max_freq;

 	if (min_freq == ~0)
 		return -EINVAL;
--
2.43.0
