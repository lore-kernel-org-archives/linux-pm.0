From: Thomas Renninger <trenn@suse.de>
Subject: [PATCH 2/9] cpupower: Remove dead link to homepage, and update the targets built.
Date: Tue, 13 May 2014 12:41:39 +0200
Message-ID: <1399977706-50854-3-git-send-email-trenn@suse.de>
References: <1399977706-50854-1-git-send-email-trenn@suse.de>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:51380 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759642AbaEMKlv (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 13 May 2014 06:41:51 -0400
In-Reply-To: <1399977706-50854-1-git-send-email-trenn@suse.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net
Cc: linux-pm@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>, Thomas Renninger <trenn@suse.de>

From: Ramkumar Ramachandra <artagnon@gmail.com>

Cc: Thomas Renninger <trenn@suse.de>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
Signed-off-by: Thomas Renninger <trenn@suse.de>
---
 tools/power/cpupower/README |   16 +++++++---------
 tools/power/cpupower/ToDo   |    1 -
 2 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/tools/power/cpupower/README b/tools/power/cpupower/README
index 96ff1ff..1c68f47 100644
--- a/tools/power/cpupower/README
+++ b/tools/power/cpupower/README
@@ -1,6 +1,4 @@
-The cpupower package (homepage:
-http://www.kernel.org/pub/linux/utils/kernel/cpufreq/cpufrequtils.html ) 
-consists of the following elements:
+The cpupower package consists of the following elements:
 
 requirements
 ------------
@@ -28,12 +26,12 @@ make
 su
 make install
 
-should suffice on most systems. It builds default libcpupower,
-cpufreq-set and cpufreq-info files and installs them in /usr/lib and
-/usr/bin, respectively. If you want to set up the paths differently and/or
-want to configure the package to your specific needs, you need to open
-"Makefile" with an editor of your choice and edit the block marked
-CONFIGURATION.
+should suffice on most systems. It builds libcpupower to put in
+/usr/lib; cpupower, cpufreq-bench_plot.sh to put in /usr/bin; and
+cpufreq-bench to put in /usr/sbin. If you want to set up the paths
+differently and/or want to configure the package to your specific
+needs, you need to open "Makefile" with an editor of your choice and
+edit the block marked CONFIGURATION.
 
 
 THANKS
diff --git a/tools/power/cpupower/ToDo b/tools/power/cpupower/ToDo
index 874b78b..6e8b89f 100644
--- a/tools/power/cpupower/ToDo
+++ b/tools/power/cpupower/ToDo
@@ -3,7 +3,6 @@ ToDos sorted by priority:
 - Use bitmask functions to parse CPU topology more robust
   (current implementation has issues on AMD)
 - Try to read out boost states and frequencies on Intel
-- Adjust README
 - Somewhere saw the ability to read power consumption of
   RAM from HW on Intel SandyBridge -> another monitor?
 - Add another c1e debug idle monitor
-- 
1.7.6.1

