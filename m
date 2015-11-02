From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] MAINTAINERS: update for intel Pstate driver
Date: Mon,  2 Nov 2015 09:45:46 -0800
Message-ID: <1446486346-3381-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:57932 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752603AbbKBRrb (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 2 Nov 2015 12:47:31 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: kristen.c.accardi@intel.com, rafael.j.wysocki@intel.com, len.brown@intel.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Added Len Brown and Srinivas Pandruvada as maintainers.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 MAINTAINERS | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 747c653..d263f4a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5429,7 +5429,8 @@ S:	Supported
 F:	drivers/idle/intel_idle.c
 
 INTEL PSTATE DRIVER
-M:	Kristen Carlson Accardi <kristen@linux.intel.com>
+M:	Len Brown <lenb@kernel.org>
+M:	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
 L:	linux-pm@vger.kernel.org
 S:	Supported
 F:	drivers/cpufreq/intel_pstate.c
-- 
1.9.3

