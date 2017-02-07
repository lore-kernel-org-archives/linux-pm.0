From: Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH 2/2][RFC v3] x86/pm: Delete the quirk to save/restore extra MSR around suspend/resume
Date: Wed,  8 Feb 2017 00:25:17 +0800
Message-ID: <375f00c5ab749cc8160275ecedd391de773436b5.1486483294.git.yu.c.chen@intel.com>
References: <cover.1486483294.git.yu.c.chen@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:23977 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754020AbdBGQZr (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 7 Feb 2017 11:25:47 -0500
In-Reply-To: <cover.1486483294.git.yu.c.chen@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: inux-kernel@vger.kernel.org, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>, Zhang Rui <rui.zhang@intel.com>, Ingo Molnar <mingo@kernel.org>, Chen Yu <yu.c.chen@intel.com>

As we have already added the logic to disable the MSR T-state
if it is enabled after resumed, the quirk here seems not valuable
anymore, thus delete it and also keep the save/restore MSR framework
for future use.

Cc: Len Brown <lenb@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: linux-pm@vger.kernel.org
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 arch/x86/power/cpu.c | 38 +++++---------------------------------
 1 file changed, 5 insertions(+), 33 deletions(-)

diff --git a/arch/x86/power/cpu.c b/arch/x86/power/cpu.c
index 66ade16..db75b91 100644
--- a/arch/x86/power/cpu.c
+++ b/arch/x86/power/cpu.c
@@ -378,7 +378,7 @@ static int __init bsp_pm_check_init(void)
 
 core_initcall(bsp_pm_check_init);
 
-static int msr_init_context(const u32 *msr_id, const int total_num)
+static int  __maybe_unused msr_init_context(const u32 *msr_id, const int total_num)
 {
 	int i = 0;
 	struct saved_msr *msr_array;
@@ -405,40 +405,12 @@ static int msr_init_context(const u32 *msr_id, const int total_num)
 	return 0;
 }
 
-/*
- * The following section is a quirk framework for problematic BIOSen:
- * Sometimes MSRs are modified by the BIOSen after suspended to
- * RAM, this might cause unexpected behavior after wakeup.
- * Thus we save/restore these specified MSRs across suspend/resume
- * in order to work around it.
- *
- * For any further problematic BIOSen/platforms,
- * please add your own function similar to msr_initialize_bdw.
- */
-static int msr_initialize_bdw(const struct dmi_system_id *d)
-{
-	/* Add any extra MSR ids into this array. */
-	u32 bdw_msr_id[] = { MSR_IA32_THERM_CONTROL };
-
-	pr_info("x86/pm: %s detected, MSR saving is needed during suspending.\n", d->ident);
-	return msr_init_context(bdw_msr_id, ARRAY_SIZE(bdw_msr_id));
-}
-
-static struct dmi_system_id msr_save_dmi_table[] = {
-	{
-	 .callback = msr_initialize_bdw,
-	 .ident = "BROADWELL BDX_EP",
-	 .matches = {
-		DMI_MATCH(DMI_PRODUCT_NAME, "GRANTLEY"),
-		DMI_MATCH(DMI_PRODUCT_VERSION, "E63448-400"),
-		},
-	},
-	{}
-};
-
 static int pm_check_save_msr(void)
 {
-	dmi_check_system(msr_save_dmi_table);
+	/* Save/restore MSRs in the future, for example:
+	 * u32 msr_id[] = { MSR_IA32_THERM_CONTROL };
+	 * msr_init_context(msr_id, ARRAY_SIZE(msr_id));
+	 */
 	return 0;
 }
 
-- 
2.7.4

