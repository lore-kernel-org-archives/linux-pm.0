From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: [PATCH] MAINTAINERS: add entry for intel_pstate
Date: Mon, 15 Dec 2014 15:58:24 -0800
Message-ID: <1418687904-16904-1-git-send-email-kristen@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:28016 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750818AbaLOX6Z (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 15 Dec 2014 18:58:25 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net
Cc: linux-pm@vger.kernel.org

Add entry for intel_pstate.

Signed-off-by:  Kristen Carlson Accardi <kristen@linux.intel.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e186bf9..f81f139 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4928,6 +4928,12 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux.git
 S:	Supported
 F:	drivers/idle/intel_idle.c
 
+INTEL PSTATE DRIVER
+M:	Kristen Carlson Accardi <kristen@linux.intel.com>
+L:	linux-pm@vger.kernel.org
+S:	Supported
+F:	drivers/cpufreq/intel_pstate.c
+
 INTEL FRAMEBUFFER DRIVER (excluding 810 and 815)
 M:	Maik Broemme <mbroemme@plusserver.de>
 L:	linux-fbdev@vger.kernel.org
-- 
1.9.3

