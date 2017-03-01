From: Len Brown <lenb@kernel.org>
Subject: [PATCH 26/44] tools/power turbostat: Denverton: use HW CC1 counter, skip C3, C7
Date: Wed,  1 Mar 2017 00:27:30 -0500
Message-ID: <7170a374377d7c70d63a2d3eb38f8fe32e6ffadd.1488345270.git.len.brown@intel.com>
References: <20170301052748.27810-1-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170301052748.27810-1-lenb@kernel.org>
In-Reply-To: <678a3bd1b3de6d2ebf604e7d708bc8150bb667e9.1488345270.git.len.brown@intel.com>
References: <678a3bd1b3de6d2ebf604e7d708bc8150bb667e9.1488345270.git.len.brown@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

From: Len Brown <len.brown@intel.com>

The CC1 column in tubostat can be computed by subtracting
the core c-state residency countes from the total Cx residency.

CC1 = (Idle_time_as_measured by MPERF) - (all core C-states with
residency counters)

However, as the underlying counter reads are not atomic,
error can be noticed in this calculations, especially
when the numbers are small.

Denverton has a hardware CC1 residency counter
to improve the accuracy of the cc1 statistic -- use it.

At the same time, Denverton has no concept of CC3, PC3, CC7, PC7,
so skip collecting and printing those columns.

Finally, a note of clarification.
Turbostat prints the standard PC2 residency counter,
but on Denverton hardware, that actually means PC1E.
Turbostat prints the standard PC6 residency counter,
but on Denverton hardware, that actually means PC2.

At this point, we document that differnce in this commit message,
rather than adding a quirk to the software.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 819d67fbb6ca..1010135ee973 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -2572,6 +2572,18 @@ int has_slv_msrs(unsigned int family, unsigned int model)
 	}
 	return 0;
 }
+int is_dnv(unsigned int family, unsigned int model)
+{
+
+	if (!genuine_intel)
+		return 0;
+
+	switch (model) {
+	case INTEL_FAM6_ATOM_DENVERTON:
+		return 1;
+	}
+	return 0;
+}
 
 int has_nhm_turbo_ratio_limit(unsigned int family, unsigned int model)
 {
@@ -3851,6 +3863,14 @@ void process_cpuid()
 		BIC_PRESENT(BIC_Mod_c6);
 		use_c1_residency_msr = 1;
 	}
+	if (is_dnv(family, model)) {
+		BIC_PRESENT(BIC_CPU_c1);
+		BIC_NOT_PRESENT(BIC_CPU_c3);
+		BIC_NOT_PRESENT(BIC_Pkgpc3);
+		BIC_NOT_PRESENT(BIC_CPU_c7);
+		BIC_NOT_PRESENT(BIC_Pkgpc7);
+		use_c1_residency_msr = 1;
+	}
 	if (has_hsw_msrs(family, model)) {
 		BIC_PRESENT(BIC_Pkgpc8);
 		BIC_PRESENT(BIC_Pkgpc9);
-- 
2.11.0.161.g6610af872
