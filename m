From: Calvin Walton <calvin.walton@kepstin.ca>
Subject: [PATCH v3 2/2] [WIP] tools/power turbostat: Also read package power on AMD F17h (Zen)
Date: Fri, 17 Aug 2018 12:34:42 -0400
Message-ID: <20180817163442.10065-3-calvin.walton@kepstin.ca>
References: <20180817163442.10065-1-calvin.walton@kepstin.ca>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180817163442.10065-1-calvin.walton@kepstin.ca>
Sender: linux-kernel-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Calvin Walton <calvin.walton@kepstin.ca>
List-Id: linux-pm@vger.kernel.org

The package power can also be read from an MSR. It's not clear exactly
what is included, and whether it's aggregated over all nodes or
reported separately.

It does look like this is reported separately per CCX (I get a single
value on the Ryzen R7 1700), but it might be reported separately per-
die (node?) on larger processors. If that's the case, it would have to
be recorded per node and aggregated for the socket.

Note that although Zen has these MSRs reporting power, it looks like
the actual RAPL configuration (power limits, configured TDP) is done
through PCI configuration space. I have not yet found any public
documentation for this.

Signed-off-by: Calvin Walton <calvin.walton@kepstin.ca>
---
 tools/power/x86/turbostat/turbostat.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 89d4e2e75774..675c894b8595 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -1973,6 +1973,11 @@ int get_counters(struct thread_data *t, struct core_data *c, struct pkg_data *p)
 			return -16;
 		p->rapl_dram_perf_status = msr & 0xFFFFFFFF;
 	}
+	if (do_rapl & RAPL_AMD_F17H) {
+		if (get_msr(cpu, MSR_PKG_ENERGY_STAT, &msr))
+			return -13;
+		p->energy_pkg = msr & 0xFFFFFFFF;
+	}
 	if (DO_BIC(BIC_PkgTmp)) {
 		if (get_msr(cpu, MSR_IA32_PACKAGE_THERM_STATUS, &msr))
 			return -17;
@@ -3986,10 +3991,13 @@ void rapl_probe_amd(unsigned int family, unsigned int model)
 	switch (family) {
 	case 0x17: /* Zen, Zen+ */
 		do_rapl = RAPL_AMD_F17H | RAPL_PER_CORE_ENERGY;
-		if (rapl_joules)
+		if (rapl_joules) {
+			BIC_PRESENT(BIC_Pkg_J);
 			BIC_PRESENT(BIC_Cor_J);
-		else
+		} else {
+			BIC_PRESENT(BIC_PkgWatt);
 			BIC_PRESENT(BIC_CorWatt);
+		}
 		break;
 	default:
 		return;
-- 
2.18.0
