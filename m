From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v3 4/4] Documentation: kernel parameters: per core P-State control
Date: Tue, 25 Oct 2016 13:20:43 -0700
Message-ID: <1477426843-63821-5-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1477426843-63821-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:44577 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932301AbcJYUU5 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 25 Oct 2016 16:20:57 -0400
In-Reply-To: <1477426843-63821-1-git-send-email-srinivas.pandruvada@linux.intel.com>
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
index 37babf9..fa2336e 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -1780,6 +1780,9 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
 			Description Table, specifies preferred power management
 			profile as "Enterprise Server" or "Performance Server",
 			then this feature is turned on by default.
+		per_cpu_perf_limits
+			Allow per-logical-CPU P-State performance control limits using
+			cpufreq sysfs interface
 
 	intremap=	[X86-64, Intel-IOMMU]
 			on	enable Interrupt Remapping (default)
-- 
2.7.4

