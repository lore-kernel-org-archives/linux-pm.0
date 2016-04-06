From: Len Brown <lenb@kernel.org>
Subject: [PATCH 7/7] tools/power turbostat: work around RC6 counter wrap
Date: Wed,  6 Apr 2016 17:16:00 -0400
Message-ID: <28d901098006fb4f1d5b9d6b5de67d832f85b351.1459977091.git.len.brown@intel.com>
References: <1459977360-2841-1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yw0-f194.google.com ([209.85.161.194]:33828 "EHLO
	mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753035AbcDFVQs (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 6 Apr 2016 17:16:48 -0400
Received: by mail-yw0-f194.google.com with SMTP id h6so6047100ywc.1
        for <linux-pm@vger.kernel.org>; Wed, 06 Apr 2016 14:16:47 -0700 (PDT)
In-Reply-To: <1459977360-2841-1-git-send-email-lenb@kernel.org>
In-Reply-To: <c0137ec621c50427091eeebeaff5cb7f7a426ecb.1459977091.git.len.brown@intel.com>
References: <c0137ec621c50427091eeebeaff5cb7f7a426ecb.1459977091.git.len.brown@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

From: Len Brown <len.brown@intel.com>

Sometimes the rc6 sysfs counter spontaneously resets,
causing turbostat prints a very large number
as it tries to calcuate % = 100 * (old - new) / interval

When we see (old > new), print ***.**% instead
of a bogus huge number.

Note that this detection is not fool-proof, as the counter
could reset several times and still result in new > old.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index e3b803b..acbf7ff 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -189,7 +189,7 @@ struct pkg_data {
 	unsigned long long pkg_any_core_c0;
 	unsigned long long pkg_any_gfxe_c0;
 	unsigned long long pkg_both_core_gfxe_c0;
-	unsigned long long gfx_rc6_ms;
+	long long gfx_rc6_ms;
 	unsigned int gfx_mhz;
 	unsigned int package_id;
 	unsigned int energy_pkg;	/* MSR_PKG_ENERGY_STATUS */
@@ -623,8 +623,14 @@ int format_counters(struct thread_data *t, struct core_data *c,
 		outp += sprintf(outp, "%8d", p->pkg_temp_c);
 
 	/* GFXrc6 */
-	if (do_gfx_rc6_ms)
-		outp += sprintf(outp, "%8.2f", 100.0 * p->gfx_rc6_ms / 1000.0 / interval_float);
+	if (do_gfx_rc6_ms) {
+		if (p->gfx_rc6_ms == -1) {	/* detect counter reset */
+			outp += sprintf(outp, "  ***.**");
+		} else {
+			outp += sprintf(outp, "%8.2f",
+				p->gfx_rc6_ms / 10.0 / interval_float);
+		}
+	}
 
 	/* GFXMHz */
 	if (do_gfx_mhz)
@@ -768,7 +774,12 @@ delta_package(struct pkg_data *new, struct pkg_data *old)
 	old->pc10 = new->pc10 - old->pc10;
 	old->pkg_temp_c = new->pkg_temp_c;
 
-	old->gfx_rc6_ms = new->gfx_rc6_ms - old->gfx_rc6_ms;
+	/* flag an error when rc6 counter resets/wraps */
+	if (old->gfx_rc6_ms >  new->gfx_rc6_ms)
+		old->gfx_rc6_ms = -1;
+	else
+		old->gfx_rc6_ms = new->gfx_rc6_ms - old->gfx_rc6_ms;
+
 	old->gfx_mhz = new->gfx_mhz;
 
 	DELTA_WRAP32(new->energy_pkg, old->energy_pkg);
-- 
2.8.0.rc4.16.g56331f8

