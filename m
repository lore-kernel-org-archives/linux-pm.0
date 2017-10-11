From: Len Brown <lenb@kernel.org>
Subject: [PATCH 1/1] x86/apic: Update TSC_DEADLINE quirk with additional HSX stepping
Date: Wed, 11 Oct 2017 17:06:43 -0400
Message-ID: <7f6f25d2332791092f30cbca4be26524ad854da1.1507755700.git.len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qt0-f194.google.com ([209.85.216.194]:35782 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752434AbdJKVGu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 11 Oct 2017 17:06:50 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rafael@kernel.org, tglx@linutronix.de
Cc: x86@kernel.org, srinivas.pandruvada@linux.intel.com, peterz@infradead.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>

From: Len Brown <len.brown@intel.com>

HSX stepping-3 fixed the TSC_DEADLINE issue in a different ucode
version number than stepping-4.  Linux needs to know this stepping-3
specific version number to also enable the TSC_DEADLINE on stepping-3.

The steppings and ucode versions are documented in the SKX BIOS update:
https://downloadmirror.intel.com/26978/eng/ReleaseNotes_R00.01.0004.txt

Signed-off-by: Len Brown <len.brown@intel.com>
---
 arch/x86/kernel/apic/apic.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index d705c769f77d..da13b6abef2c 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -573,11 +573,21 @@ static u32 bdx_deadline_rev(void)
 	return ~0U;
 }
 
+static u32 skx_deadline_rev(void)
+{
+	switch (boot_cpu_data.x86_mask) {
+	case 0x03: return 0x01000136;
+	case 0x04: return 0x02000014;
+	}
+
+	return ~0U;
+}
+
 static const struct x86_cpu_id deadline_match[] = {
 	DEADLINE_MODEL_MATCH_FUNC( INTEL_FAM6_HASWELL_X,	hsx_deadline_rev),
 	DEADLINE_MODEL_MATCH_REV ( INTEL_FAM6_BROADWELL_X,	0x0b000020),
 	DEADLINE_MODEL_MATCH_FUNC( INTEL_FAM6_BROADWELL_XEON_D,	bdx_deadline_rev),
-	DEADLINE_MODEL_MATCH_REV ( INTEL_FAM6_SKYLAKE_X,	0x02000014),
+	DEADLINE_MODEL_MATCH_FUNC( INTEL_FAM6_SKYLAKE_X,	skx_deadline_rev),
 
 	DEADLINE_MODEL_MATCH_REV ( INTEL_FAM6_HASWELL_CORE,	0x22),
 	DEADLINE_MODEL_MATCH_REV ( INTEL_FAM6_HASWELL_ULT,	0x20),
-- 
2.14.0-rc0
