Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07FD6124
	for <linux-pm@vger.kernel.org>; Thu, 14 Dec 2023 08:56:26 -0800 (PST)
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="2305221"
X-IronPort-AV: E=Sophos;i="6.04,276,1695711600"; 
   d="scan'208";a="2305221"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 08:56:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="947637113"
X-IronPort-AV: E=Sophos;i="6.04,276,1695711600"; 
   d="scan'208";a="947637113"
Received: from powerlab.fi.intel.com ([10.237.71.25])
  by orsmga005.jf.intel.com with ESMTP; 14 Dec 2023 08:56:23 -0800
From: Artem Bityutskiy <dedekind1@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM Mailing List <linux-pm@vger.kernel.org>,
	Artem Bityutskiy <dedekind1@gmail.com>
Subject: [PATCH 1/2] intel_idle: add Grand Ridge SoC support
Date: Thu, 14 Dec 2023 18:56:21 +0200
Message-Id: <20231214165622.100428-1-dedekind1@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: *

From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>

Add Intel Grand Ridge SoC C-states, which are C1, C1E, and C6S.

The Grand Ridge SoC is built with modules, each module includes 4 cores
(Crestmont microarchitecture). There is one L2 cache per module, shared between
the 4 cores.

There is no core C6 state, but there is C6S state, which has module scope:
when all 4 cores request C6S, the entire module (4 cores + L2 cache) enters the
low power state.

Package C6 is not supported by Grand Ridge SoC.

Signed-off-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
---
 drivers/idle/intel_idle.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index cfd0b24fd7f1..3b846d4f8707 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -1271,6 +1271,35 @@ static struct cpuidle_state snr_cstates[] __initdata = {
 		.enter = NULL }
 };
 
+static struct cpuidle_state grr_cstates[] __initdata = {
+	{
+		.name = "C1",
+		.desc = "MWAIT 0x00",
+		.flags = MWAIT2flg(0x00) | CPUIDLE_FLAG_ALWAYS_ENABLE,
+		.exit_latency = 1,
+		.target_residency = 1,
+		.enter = &intel_idle,
+		.enter_s2idle = intel_idle_s2idle, },
+	{
+		.name = "C1E",
+		.desc = "MWAIT 0x01",
+		.flags = MWAIT2flg(0x01) | CPUIDLE_FLAG_ALWAYS_ENABLE,
+		.exit_latency = 2,
+		.target_residency = 10,
+		.enter = &intel_idle,
+		.enter_s2idle = intel_idle_s2idle, },
+	{
+		.name = "C6S",
+		.desc = "MWAIT 0x22",
+		.flags = MWAIT2flg(0x22) | CPUIDLE_FLAG_TLB_FLUSHED,
+		.exit_latency = 140,
+		.target_residency = 500,
+		.enter = &intel_idle,
+		.enter_s2idle = intel_idle_s2idle, },
+	{
+		.enter = NULL }
+};
+
 static const struct idle_cpu idle_cpu_nehalem __initconst = {
 	.state_table = nehalem_cstates,
 	.auto_demotion_disable_flags = NHM_C1_AUTO_DEMOTE | NHM_C3_AUTO_DEMOTE,
@@ -1420,6 +1449,12 @@ static const struct idle_cpu idle_cpu_snr __initconst = {
 	.use_acpi = true,
 };
 
+static const struct idle_cpu idle_cpu_grr __initconst = {
+	.state_table = grr_cstates,
+	.disable_promotion_to_c1e = true,
+	.use_acpi = true,
+};
+
 static const struct x86_cpu_id intel_idle_ids[] __initconst = {
 	X86_MATCH_INTEL_FAM6_MODEL(NEHALEM_EP,		&idle_cpu_nhx),
 	X86_MATCH_INTEL_FAM6_MODEL(NEHALEM,		&idle_cpu_nehalem),
@@ -1466,6 +1501,7 @@ static const struct x86_cpu_id intel_idle_ids[] __initconst = {
 	X86_MATCH_INTEL_FAM6_MODEL(ATOM_GOLDMONT_PLUS,	&idle_cpu_bxt),
 	X86_MATCH_INTEL_FAM6_MODEL(ATOM_GOLDMONT_D,	&idle_cpu_dnv),
 	X86_MATCH_INTEL_FAM6_MODEL(ATOM_TREMONT_D,	&idle_cpu_snr),
+	X86_MATCH_INTEL_FAM6_MODEL(ATOM_CRESTMONT,	&idle_cpu_grr),
 	{}
 };
 

base-commit: ee96d5c15517fbdf136aeff1919646e843fbb6f3
-- 
2.40.1

