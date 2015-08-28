From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v1 5/6] Documentation: kernel_parameters for Intel P state driver
Date: Thu, 27 Aug 2015 18:34:25 -0700
Message-ID: <1440725666-3550-6-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1440725666-3550-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:17215 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751711AbbH1Bfm (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 27 Aug 2015 21:35:42 -0400
In-Reply-To: <1440725666-3550-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: kristen.c.accardi@intel.com, rafael.j.wysocki@intel.com, len.brown@intel.com
Cc: linux-pm@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Added new option "no_acpi" for not using ACPI processor performance
control objects in Intel P state driver.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 Documentation/kernel-parameters.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index 1d6f045..1c923c1 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -1540,6 +1540,9 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
 		hwp_only
 			Only load intel_pstate on systems which support
 			hardware P state control (HWP) if available.
+		no_acpi
+			Don't use ACPI processor performance control objects
+			_PSS and _PPC specified limits.
 
 	intremap=	[X86-64, Intel-IOMMU]
 			on	enable Interrupt Remapping (default)
-- 
2.4.3

