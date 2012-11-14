From: Len Brown <lenb@kernel.org>
Subject: [PATCH 4/7] x86 power: define RAPL MSRs
Date: Wed, 14 Nov 2012 15:43:21 -0500
Message-ID: <8e95037d0d9172c87a2b4ebeaff49c4e793ee5d2.1352925508.git.len.brown@intel.com>
References: <1352925804-6746-1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1352925804-6746-1-git-send-email-lenb@kernel.org>
In-Reply-To: <39300ffb9b6666714c60735cf854e1280e4e75f4.1352925508.git.len.brown@intel.com>
References: <39300ffb9b6666714c60735cf854e1280e4e75f4.1352925508.git.len.brown@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>, x86@kernel.org
List-Id: linux-pm@vger.kernel.org

=46rom: Len Brown <len.brown@intel.com>

The Run Time Average Power Limiting interface
is currently model specific, present on Sandy Bridge
and Ivy Bridge processors.

These #defines correspond to documentation in the latest
"Intel=C2=AE 64 and IA-32 Architectures Software Developer Manual",
plus some typos in that document corrected.

Signed-off-by: Len Brown <len.brown@intel.com>
Cc: x86@kernel.org
---
 arch/x86/include/asm/msr-index.h | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/ms=
r-index.h
index c9775a3..7d05006 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -115,6 +115,29 @@
 #define MSR_CORE_C7_RESIDENCY		0x000003fe
 #define MSR_PKG_C2_RESIDENCY		0x0000060d
=20
+/* Run Time Average Power Limiting (RAPL) Interface */
+
+#define MSR_RAPL_POWER_UNIT		0x00000606
+
+#define MSR_PKG_POWER_LIMIT		0x00000610
+#define MSR_PKG_ENERGY_STATUS		0x00000611
+#define MSR_PKG_PERF_STATUS		0x00000613
+#define MSR_PKG_POWER_INFO		0x00000614
+
+#define MSR_DRAM_POWER_LIMIT		0x00000618
+#define MSR_DRAM_ENERGY_STATUS		0x00000619
+#define MSR_DRAM_PERF_STATUS		0x0000061b
+#define MSR_DRAM_POWER_INFO		0x0000061c
+
+#define MSR_PP0_POWER_LIMIT		0x00000638
+#define MSR_PP0_ENERGY_STATUS		0x00000639
+#define MSR_PP0_POLICY			0x0000063a
+#define MSR_PP0_PERF_STATUS		0x0000063b
+
+#define MSR_PP1_POWER_LIMIT		0x00000640
+#define MSR_PP1_ENERGY_STATUS		0x00000641
+#define MSR_PP1_POLICY			0x00000642
+
 #define MSR_AMD64_MC0_MASK		0xc0010044
=20
 #define MSR_IA32_MCx_CTL(x)		(MSR_IA32_MC0_CTL + 4*(x))
--=20
1.8.0
