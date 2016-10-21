From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v2 4/4] Documentation: kernel parameters: per core P-State control
Date: Fri, 21 Oct 2016 09:14:26 -0700
Message-ID: <1477066466-22367-5-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1477066466-22367-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:5553 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934420AbcJUQOj (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 21 Oct 2016 12:14:39 -0400
In-Reply-To: <1477066466-22367-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net
Cc: linux-pm@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Additional command line control to enable per core performance
control.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 Documentation/kernel-parameters.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index 37babf9..e216f6e 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -1780,6 +1780,9 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
 			Description Table, specifies preferred power management
 			profile as "Enterprise Server" or "Performance Server",
 			then this feature is turned on by default.
+		per_cpu_perf_limits
+			Allow per core P-State performance control limits using
+			cpufreq sysfs interface
 
 	intremap=	[X86-64, Intel-IOMMU]
 			on	enable Interrupt Remapping (default)
-- 
2.7.4

