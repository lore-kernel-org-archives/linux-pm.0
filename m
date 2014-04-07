From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [Patch V1] thermal: Intel SoC DTS thermal
Date: Mon,  7 Apr 2014 13:57:14 -0700
Message-ID: <1396904235-23404-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:65384 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754637AbaDGXNF (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 7 Apr 2014 19:13:05 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: eduardo.valentin@ti.com, rui.zhang@intel.com
Cc: linux-pm@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>


v1
Removed debugfs includes

v0
Base version

Srinivas Pandruvada (1):
  thermal: Intel SoC DTS thermal

 drivers/thermal/Kconfig                 |  12 +
 drivers/thermal/Makefile                |   1 +
 drivers/thermal/intel_soc_dts_thermal.c | 479 ++++++++++++++++++++++++++++++++
 3 files changed, 492 insertions(+)
 create mode 100644 drivers/thermal/intel_soc_dts_thermal.c

-- 
1.9.1

