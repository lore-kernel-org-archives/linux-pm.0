Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC15A410D3A;
	Wed, 25 Mar 2026 18:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774462415; cv=none; b=M3YwETqjuJfl/4CtvEB5dvWl0i8sCVZy5ZM0139/w5XKG0Rjt76Ce8H7bEeH+U59sWqK7tPz68wWS012vdPfNPRalC4ex+IRGjH2rlc751DAPlFKK9BH5DTCL7hIKTpNG/eNLn0mkmeFeMK+781cTjUr1fiGDNkyastW4e9Zryw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774462415; c=relaxed/simple;
	bh=MGefsLCjmX6KD7/Oe9IWyWFpSAt46sQ2D5Cq7u/2T8A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ss+2XpgdrEWphJxsevf5hBvz/1iNZCfgIS1edSmAlZ2/Cshzel7W6g4XHubQzkFeFwXLUCdC8+I11sT9ZeH71rAtIp7vaYwWwE7lYc+KcfbX1sf+zNgUeBS8z0KoVTghwJCEH77hQ/ulp1iNdx1kl4/zYKz3ROQp13KxdcZdD70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=TWFoyWUu; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="TWFoyWUu"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E391C16F2;
	Wed, 25 Mar 2026 11:13:26 -0700 (PDT)
Received: from e127648.arm.com (unknown [10.57.83.185])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D5C713F836;
	Wed, 25 Mar 2026 11:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1774462412; bh=MGefsLCjmX6KD7/Oe9IWyWFpSAt46sQ2D5Cq7u/2T8A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TWFoyWUurknhbCK8K/kzsmMicyFKKcS5I0C2UzX+xtq/PWFOVKumiJA6rDyWdyWud
	 BymtyLkm1SgYP+9oyvP2ZU5Oyv3jrjSOHlNEfpuAQngdw0HU1HrSzGB6Nux4qGmBqi
	 uuIowiY+CWB4Cbq3kewKmiNJdLWdwrifIq8x+ufs=
From: Christian Loehle <christian.loehle@arm.com>
To: arighi@nvidia.com
Cc: peterz@infradead.org,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	valentin.schneider@arm.com,
	mingo@redhat.com,
	rostedt@goodmis.org,
	segall@google.com,
	mgorman@suse.de,
	catalin.marinas@arm.com,
	will@kernel.org,
	sudeep.holla@arm.com,
	rafael@kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	juri.lelli@redhat.com,
	kobak@nvidia.com,
	fabecassis@nvidia.com,
	Christian Loehle <christian.loehle@arm.com>
Subject: [PATCH 2/3] arch_topology: Export CPPC-based asympacking prios
Date: Wed, 25 Mar 2026 18:13:13 +0000
Message-Id: <20260325181314.3875909-3-christian.loehle@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260325181314.3875909-1-christian.loehle@arm.com>
References: <20260325181314.3875909-1-christian.loehle@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Determine asymmetric packing priorities by reading CPPC's
highest_perf so it can be read by arch code later to enable
asympacking if the difference between the minimum and
maximum highest_perf is small (<5%).

Signed-off-by: Christian Loehle <christian.loehle@arm.com>
---
 drivers/base/arch_topology.c | 40 ++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index 8c5e47c28d9a..c80c782e5eb2 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -321,8 +321,47 @@ void __weak freq_inv_set_max_ratio(int cpu, u64 max_rate)
 {
 }
 
+void __weak arch_topology_init_cppc_asym(void)
+{
+}
+
 #ifdef CONFIG_ACPI_CPPC_LIB
 #include <acpi/cppc_acpi.h>
+#include <linux/limits.h>
+
+/**
+ * topology_init_cppc_asym_packing() - Detect CPPC-based asymmetric packing
+ * @priority_var: Per-CPU variable to store CPU priorities
+ *
+ * Query CPPC highest_perf for all CPUs and determine if asymmetric packing
+ * should be enabled based on minor performance differences (~5% threshold).
+ *
+ * Return: true if asympacking should be enabled, false otherwise
+ */
+bool topology_init_cppc_asym_packing(int __percpu *priority_var)
+{
+	struct cppc_perf_caps perf_caps;
+	u32 max_perf = 0, min_perf = U32_MAX;
+	int cpu;
+
+	if (!acpi_cpc_valid())
+		return false;
+
+	for_each_possible_cpu(cpu) {
+		if (cppc_get_perf_caps(cpu, &perf_caps))
+			return false;
+		if (perf_caps.highest_perf < perf_caps.nominal_perf ||
+		    perf_caps.highest_perf < perf_caps.lowest_perf)
+			return false;
+
+		*per_cpu_ptr(priority_var, cpu) = perf_caps.highest_perf;
+		max_perf = max(max_perf, perf_caps.highest_perf);
+		min_perf = min(min_perf, perf_caps.highest_perf);
+	}
+
+	return (max_perf != min_perf) && !capacity_greater(max_perf, min_perf);
+}
+EXPORT_SYMBOL_GPL(topology_init_cppc_asym_packing);
 
 static inline void topology_init_cpu_capacity_cppc(void)
 {
@@ -369,6 +408,7 @@ static inline void topology_init_cpu_capacity_cppc(void)
 			cpu, topology_get_cpu_scale(cpu));
 	}
 
+	arch_topology_init_cppc_asym();
 	schedule_work(&update_topology_flags_work);
 	pr_debug("cpu_capacity: cpu_capacity initialization done\n");
 
-- 
2.34.1

