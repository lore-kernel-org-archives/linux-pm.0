From: Len Brown <lenb@kernel.org>
Subject: [PATCH 07/16] tools/power turbostat: Intel Xeon x200: fix erroneous bclk value
Date: Sat, 27 Feb 2016 04:01:01 -0500
Message-ID: <47d3ddcccba2ceb81d1945517ff62ed09f4540a6.1456563103.git.len.brown@intel.com>
References: <1456563670-23282-1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yk0-f194.google.com ([209.85.160.194]:35526 "EHLO
	mail-yk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756219AbcB0JB4 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 27 Feb 2016 04:01:56 -0500
Received: by mail-yk0-f194.google.com with SMTP id u9so2789820ykd.2
        for <linux-pm@vger.kernel.org>; Sat, 27 Feb 2016 01:01:56 -0800 (PST)
In-Reply-To: <1456563670-23282-1-git-send-email-lenb@kernel.org>
In-Reply-To: <69807a638f91524ed75027f808cd277417ecee7a.1456563103.git.len.brown@intel.com>
References: <69807a638f91524ed75027f808cd277417ecee7a.1456563103.git.len.brown@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: "Chrzaniuk, Hubert" <hubert.chrzaniuk@intel.com>, Len Brown <len.brown@intel.com>

From: "Chrzaniuk, Hubert" <hubert.chrzaniuk@intel.com>

x200 does not enable any way to programmatically obtain bus clock
speed. Bclk for the architecture has a fixed value of 100 MHz.
At the same time x200 cannot be included in has_snb_msrs since
it does not support C7 idle state.

prior to this patch, MHz values reported on this chip
were erroneously calculated using bclk of 133MHz,
causing MHz values to be reported 33% higher than actual.

Signed-off-by: Hubert Chrzaniuk <hubert.chrzaniuk@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index e411cc4..652d08d 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -2697,7 +2697,7 @@ double slm_bclk(void)
 
 double discover_bclk(unsigned int family, unsigned int model)
 {
-	if (has_snb_msrs(family, model))
+	if (has_snb_msrs(family, model) || is_knl(family, model))
 		return 100.00;
 	else if (is_slm(family, model))
 		return slm_bclk();
-- 
2.7.1.339.g0233b80

