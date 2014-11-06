From: dirk.brandewie@gmail.com
Subject: [PATCH] intel_pstate: Add CPUID for BDW-H CPU
Date: Thu,  6 Nov 2014 09:50:45 -0800
Message-ID: <1415296245-4368-1-git-send-email-dirk.j.brandewie@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f180.google.com ([209.85.192.180]:42054 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750877AbaKFRuy (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 6 Nov 2014 12:50:54 -0500
Received: by mail-pd0-f180.google.com with SMTP id ft15so1547389pdb.25
        for <linux-pm@vger.kernel.org>; Thu, 06 Nov 2014 09:50:53 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: rjw@rjwysocki.net, dirk.brandewie@gmail.com, Dirk Brandewie <dirk.j.brandewie@intel.com>

From: Dirk Brandewie <dirk.j.brandewie@intel.com>

Add BDW-H to the list of supported processors.

Signed-off-by: Dirk Brandewie <dirk.j.brandewie@intel.com>
---
 drivers/cpufreq/intel_pstate.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 27bb6d3..6dafd4f 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -730,6 +730,7 @@ static const struct x86_cpu_id intel_pstate_cpu_ids[] = {
 	ICPU(0x3f, core_params),
 	ICPU(0x45, core_params),
 	ICPU(0x46, core_params),
+	ICPU(0x47, core_params),
 	ICPU(0x4c, byt_params),
 	ICPU(0x4f, core_params),
 	ICPU(0x56, core_params),
-- 
1.9.3

