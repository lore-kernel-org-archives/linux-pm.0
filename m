From: dirk.brandewie@gmail.com
Subject: [PATCH 1/3] intel_pstate: Fix setting VID
Date: Fri, 20 Jun 2014 07:27:58 -0700
Message-ID: <1403274480-10593-2-git-send-email-dirk.j.brandewie@intel.com>
References: <1403274480-10593-1-git-send-email-dirk.j.brandewie@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pb0-f42.google.com ([209.85.160.42]:38213 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752069AbaFTO2M (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 20 Jun 2014 10:28:12 -0400
In-Reply-To: <1403274480-10593-1-git-send-email-dirk.j.brandewie@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: rjw@rjwysocki.net, dirk.brandewie@gmail.com, stable@vger.kernel.org, Dirk Brandewie <dirk.j.brandewie@intel.com>

From: Dirk Brandewie <dirk.j.brandewie@intel.com>

Commit 21855ff5 intel_pstate: Set turbo VID for BayTrail introduced
setting the turbo VID which is required to prevent a machine check on
some Baytrail SKUs under heavy graphics based workloads.  The
docmumentation update that brought the requirement to light also
changed the bit mask used for enumerating P state and VID values from
0x7f to 0x3f.

This change returns the mask value to 0x7f.

Tested with the Intel NUC DN2820FYK,
BIOS version FYBYT10H.86A.0034.2014.0513.1413 with v3.16-rc1 and
v3.14.8 kernel versions.

Reported-by: Rune Reterson <rune@megahurts.dk>
Reported-by: Eric Eickmeyer <erich@ericheickmeyer.com>
Tested-by: Rune Reterson <rune@megahurts.dk>
Tested-by: Eric Eickmeyer <erich@ericheickmeyer.com>

References: https://bugzilla.kernel.org/show_bug.cgi?id=77951

Cc: Cc: Stable <stable@vger.kernel.org>  [3.13+]
Signed-off-by: Dirk Brandewie <dirk.j.brandewie@intel.com>
---
 drivers/cpufreq/intel_pstate.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 924bb2d..74376d6 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -357,21 +357,21 @@ static int byt_get_min_pstate(void)
 {
 	u64 value;
 	rdmsrl(BYT_RATIOS, value);
-	return (value >> 8) & 0x3F;
+	return (value >> 8) & 0x7F;
 }
 
 static int byt_get_max_pstate(void)
 {
 	u64 value;
 	rdmsrl(BYT_RATIOS, value);
-	return (value >> 16) & 0x3F;
+	return (value >> 16) & 0x7F;
 }
 
 static int byt_get_turbo_pstate(void)
 {
 	u64 value;
 	rdmsrl(BYT_TURBO_RATIOS, value);
-	return value & 0x3F;
+	return value & 0x7F;
 }
 
 static void byt_set_pstate(struct cpudata *cpudata, int pstate)
@@ -405,8 +405,8 @@ static void byt_get_vid(struct cpudata *cpudata)
 
 
 	rdmsrl(BYT_VIDS, value);
-	cpudata->vid.min = int_tofp((value >> 8) & 0x3f);
-	cpudata->vid.max = int_tofp((value >> 16) & 0x3f);
+	cpudata->vid.min = int_tofp((value >> 8) & 0x7f);
+	cpudata->vid.max = int_tofp((value >> 16) & 0x7f);
 	cpudata->vid.ratio = div_fp(
 		cpudata->vid.max - cpudata->vid.min,
 		int_tofp(cpudata->pstate.max_pstate -
-- 
1.9.0

