From: Hubert Chrzaniuk <hubert.chrzaniuk@intel.com>
Subject: [PATCH 2/2] tools/power turbostat: changed bclk discovery path for Intel Xeon x200 Architecture
Date: Wed, 10 Feb 2016 16:35:17 +0100
Message-ID: <1455118517-14180-3-git-send-email-hubert.chrzaniuk@intel.com>
References: <CAJZ5v0hyAeK9L+NcETZQXJKfmr+TX59bZ+759RbXz_we3wgzpg@mail.gmail.com>
 <1455118517-14180-1-git-send-email-hubert.chrzaniuk@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:41811 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751360AbcBJPgQ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 10 Feb 2016 10:36:16 -0500
In-Reply-To: <1455118517-14180-1-git-send-email-hubert.chrzaniuk@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: hubert.chrzaniuk@intel.com, lukasz.anaczkowski@intel.com, len.brown@intel.com, dasaratharaman.chandramouli@intel.com, linux-pm@vger.kernel.org

x200 does not enable any way to programmatically obtain bus clock
speed. Bclk for the architecture has a fixed value of 100 MHz.
At the same time x200 cannot be included in has_snb_msrs since
it does not support C7 idle state.

Signed-off-by: Hubert Chrzaniuk <hubert.chrzaniuk@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 765c669..3a59aec 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -2601,7 +2601,7 @@ double slm_bclk(void)
 
 double discover_bclk(unsigned int family, unsigned int model)
 {
-	if (has_snb_msrs(family, model))
+	if (has_snb_msrs(family, model) || is_knl(family, model))
 		return 100.00;
 	else if (is_slm(family, model))
 		return slm_bclk();
-- 
1.8.3.1

