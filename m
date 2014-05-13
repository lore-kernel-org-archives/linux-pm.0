From: Thomas Renninger <trenn@suse.de>
Subject: [PATCH 1/9] cpupower: Rename cpufrequtils -> cpupower, and libcpufreq -> libcpupower.
Date: Tue, 13 May 2014 12:41:38 +0200
Message-ID: <1399977706-50854-2-git-send-email-trenn@suse.de>
References: <1399977706-50854-1-git-send-email-trenn@suse.de>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:51382 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759902AbaEMKlv (ORCPT <rfc822;linux-pm@vger.kernel.org>);
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
 tools/power/cpupower/README |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/power/cpupower/README b/tools/power/cpupower/README
index fd9d4c0..96ff1ff 100644
--- a/tools/power/cpupower/README
+++ b/tools/power/cpupower/README
@@ -1,4 +1,4 @@
-The cpufrequtils package (homepage: 
+The cpupower package (homepage:
 http://www.kernel.org/pub/linux/utils/kernel/cpufreq/cpufrequtils.html ) 
 consists of the following elements:
 
@@ -11,10 +11,10 @@ providing cpuid.h is needed.
 For both it's not explicitly checked for (yet).
 
 
-libcpufreq
+libcpupower
 ----------
 
-"libcpufreq" is a library which offers a unified access method for userspace
+"libcpupower" is a library which offers a unified access method for userspace
 tools and programs to the cpufreq core and drivers in the Linux kernel. This
 allows for code reduction in userspace tools, a clean implementation of
 the interaction to the cpufreq core, and support for both the sysfs and proc
@@ -28,7 +28,7 @@ make
 su
 make install
 
-should suffice on most systems. It builds default libcpufreq,
+should suffice on most systems. It builds default libcpupower,
 cpufreq-set and cpufreq-info files and installs them in /usr/lib and
 /usr/bin, respectively. If you want to set up the paths differently and/or
 want to configure the package to your specific needs, you need to open
@@ -39,11 +39,11 @@ CONFIGURATION.
 THANKS
 ------
 Many thanks to Mattia Dongili who wrote the autotoolization and
-libtoolization, the manpages and the italian language file for cpufrequtils;
+libtoolization, the manpages and the italian language file for cpupower;
 to Dave Jones for his feedback and his dump_psb tool; to Bruno Ducrot for his
 powernow-k8-decode and intel_gsic tools as well as the french language file;
 and to various others commenting on the previous (pre-)releases of 
-cpufrequtils.
+cpupower.
 
 
         Dominik Brodowski
-- 
1.7.6.1

