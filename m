From: dirk.brandewie@gmail.com
Subject: [PATCH 5/5] intel_pstate: Correct BYT VID values.
Date: Mon, 13 Oct 2014 08:37:44 -0700
Message-ID: <1413214664-17687-5-git-send-email-dirk.j.brandewie@intel.com>
References: <1413214664-17687-1-git-send-email-dirk.j.brandewie@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f179.google.com ([209.85.192.179]:60595 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754490AbaJMPiA (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 13 Oct 2014 11:38:00 -0400
In-Reply-To: <1413214664-17687-1-git-send-email-dirk.j.brandewie@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: rjw@rjwysocki.net, dirk.brandewie@gmail.com, Dirk Brandewie <dirk.j.brandewie@intel.com>, stable@vger.kernel.org

From: Dirk Brandewie <dirk.j.brandewie@intel.com>

Using a VID value that is not high enough for the requested P state can
cause machine checks. Add a ceiling function to ensure calulated VIDs
with fractional values are set to the next highest integer VID value.

The algorythm for calculating the non-trubo VID from the BIOS writers
guide is:
 vid_ratio = (vid_max - vid_min) / (max_pstate - min_pstate)
 vid = ceiling(vid_min + (req_pstate - min_pstate) * vid_ratio)


Cc: stable@vger.kernel.org
Signed-off-by: Dirk Brandewie <dirk.j.brandewie@intel.com>
---
 drivers/cpufreq/intel_pstate.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 77a87fa..6f6d588 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -52,6 +52,17 @@ static inline int32_t div_fp(int32_t x, int32_t y)
 	return div_s64((int64_t)x << FRAC_BITS, y);
 }
 
+static inline int ceiling_fp(int32_t x)
+{
+	int mask, ret;
+
+	ret = fp_toint(x);
+	mask = (1 << FRAC_BITS) - 1;
+	if (x & mask)
+		ret += 1;
+	return ret;
+}
+
 struct sample {
 	int32_t core_pct_busy;
 	u64 aperf;
@@ -425,7 +436,7 @@ static void byt_set_pstate(struct cpudata *cpudata, int pstate)
 		cpudata->vid.ratio);
 
 	vid_fp = clamp_t(int32_t, vid_fp, cpudata->vid.min, cpudata->vid.max);
-	vid = fp_toint(vid_fp);
+	vid = ceiling_fp(vid_fp);
 
 	if (pstate > cpudata->pstate.max_pstate)
 		vid = cpudata->vid.turbo;
-- 
1.9.3

