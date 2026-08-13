Received: from outbound.baidu.com (mx16.baidu.com [111.202.115.101])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 17DED38239F;
	Thu, 13 Aug 2026 09:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.202.115.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786611732; cv=none; b=tlQYXhH2qhQ+nhYFxaAkuaSfTPYJNh4Q0UsvQDsoQBKsaICoQCmPAkYnigxE9AYYTPBhgpwz5cgeaU4yipn6PIH2fpJb4AhWDda3cIg5TKRPkIASbqvocnUtPmV5Lv56WOWr14Ry9WHH2LNQwq5iV/U6hb3iAaAcuKYJ5TSgBzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786611732; c=relaxed/simple;
	bh=3ngXCeyvGnHfWKSqJVpav60LYKdm6LAbQLhsgQ8Fruw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mpCn3IXV2TvbZYTXdKDXe6tfATeWwiWUY8ZPeGE2Rgu3sfRdnh7srw/+B8YQpMvux5lZjfyxi9Tr4ywW+J+WZDx8z5EP4LqENjPq1tLNHY83iA9kCjjag3RLlKSCj3QUuT4rWKPMD4JeJiDfLbrh4ZdA2L409sc2OQX28JCC3SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; dkim=pass (2048-bit key) header.d=baidu.com header.i=@baidu.com header.b=VfkyoseM; arc=none smtp.client-ip=111.202.115.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baidu.com header.i=@baidu.com header.b="VfkyoseM"
X-MD-Sfrom: lirongqing@baidu.com
X-MD-SrcIP: 172.31.50.47
From: lirongqing <lirongqing@baidu.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>, Viresh Kumar
	<viresh.kumar@linaro.org>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <zhongqiu.han@oss.qualcomm.com>, Li RongQing <lirongqing@baidu.com>
Subject: [PATCH v2 1/2] cpufreq: acpi-cpufreq: fix P-state index mismatch in extract_io()
Date: Thu, 13 Aug 2026 17:01:44 +0800
Message-ID: <20260813090145.2450-2-lirongqing@baidu.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260813090145.2450-1-lirongqing@baidu.com>
References: <20260813090145.2450-1-lirongqing@baidu.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: bjhj-exc6.internal.baidu.com (172.31.3.16) To
 bjkjy-exc3.internal.baidu.com (172.31.50.47)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=baidu.com;
	s=selector1; t=1786611718;
	bh=RiA2nDSsa39q/3zStCXF8prWJYGTHdP7bM/LW+mUF4c=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type;
	b=VfkyoseMZNbGcmsmi8xDLqI7h1ZtqlLxamcM0tVIiAGCJug7nzFE8c7PPnyD7rtE0
	 A5QWLV2eIJfsaVOB3Rsv9DaL39+7KBwVdxuTOs8eXhSmV1uBqvr+bklQa6xhlvWDj/
	 fqnT34N+4Ytxc57YkTroYWJAQoD6v+yM2mGk0jlsGUTEqGPkjz+WD4HJlWPmUaqr5L
	 mjls8nNtoQiw3CUeZwR3EPf9LCsYV3AcGe2hCq3LzZRrLO/gOzqqctF31vx7s111bZ
	 wOdOdT8DjWRtnVx2+1H/l8PKFwjLDxE/Zvt5v+TZejPbZQjsprIURmQ7Dm0i1kF+XU
	 aiZA7/k8O7rgw==

From: Li RongQing <lirongqing@baidu.com>

When policy->freq_table is built in acpi_cpufreq_cpu_init(), entries
with duplicate frequencies are skipped. The original P-state index for
each remaining entry is stored in freq_table[].driver_data, so the index
space of freq_table no longer matches perf->states[].

extract_io() walks perf->states[] with index i and uses the same i to
index policy->freq_table[i]. This causes two problems when duplicate
frequencies exist:

  - Returning the frequency of the wrong P-state
  - Returning 0 from a zeroed tail entry, or even CPUFREQ_TABLE_END
    (~1u) reported as 0xfffffffe kHz

Fix it by walking policy->freq_table with cpufreq_for_each_entry() and
using perf->states[pos->driver_data].status, aligning with extract_msr().

Fixes: 8cee1eed8e78 ("cpufreq: ACPI: Remove freq_table from acpi_cpufreq_data")
Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 drivers/cpufreq/acpi-cpufreq.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
index 21639d9..1abe9ab 100644
--- a/drivers/cpufreq/acpi-cpufreq.c
+++ b/drivers/cpufreq/acpi-cpufreq.c
@@ -197,14 +197,13 @@ static unsigned extract_io(struct cpufreq_policy *policy, u32 value)
 {
 	struct acpi_cpufreq_data *data = policy->driver_data;
 	struct acpi_processor_performance *perf;
-	int i;
+	struct cpufreq_frequency_table *pos;
 
 	perf = to_perf_data(data);
 
-	for (i = 0; i < perf->state_count; i++) {
-		if (value == perf->states[i].status)
-			return policy->freq_table[i].frequency;
-	}
+	cpufreq_for_each_entry(pos, policy->freq_table)
+		if (value == perf->states[pos->driver_data].status)
+			return pos->frequency;
 	return 0;
 }
 
-- 
2.9.4

