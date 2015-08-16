From: Len Brown <lenb@kernel.org>
Subject: [PATCH 5/7] tools/power turbostat: fix typo on DRAM column in Joules-mode
Date: Sat, 15 Aug 2015 23:25:46 -0400
Message-ID: <bd6906ed3d7a00d55c9bd368a640ef83bb487d1d.1439695194.git.len.brown@intel.com>
References: <1439695548-21174-1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-vk0-f51.google.com ([209.85.213.51]:34494 "EHLO
	mail-vk0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752090AbbHPDec (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 15 Aug 2015 23:34:32 -0400
In-Reply-To: <1439695548-21174-1-git-send-email-lenb@kernel.org>
In-Reply-To: <75fd7ffa7fab91c2c3234bd3e465ba4f366733f4.1439695194.git.len.brown@intel.com>
References: <75fd7ffa7fab91c2c3234bd3e465ba4f366733f4.1439695194.git.len.brown@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>

From: Len Brown <len.brown@intel.com>

< RAM_W
> RAM_J

Reported-by: Hubert Chrzaniuk <hubert.chrzaniuk@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 915eb28..9655cb4 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -372,7 +372,7 @@ void print_header(void)
 		if (do_rapl & RAPL_GFX)
 			outp += sprintf(outp, "   GFX_J");
 		if (do_rapl & RAPL_DRAM)
-			outp += sprintf(outp, "   RAM_W");
+			outp += sprintf(outp, "   RAM_J");
 		if (do_rapl & RAPL_PKG_PERF_STATUS)
 			outp += sprintf(outp, "   PKG_%%");
 		if (do_rapl & RAPL_DRAM_PERF_STATUS)
-- 
2.5.0.330.g130be8e

