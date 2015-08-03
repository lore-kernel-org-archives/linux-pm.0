From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v1] thermal: kconfig: select THERMAL_WRITABLE_TRIPS for x86 thermal
Date: Mon,  3 Aug 2015 04:13:15 -0700
Message-ID: <1438600396-3482-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:50806 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753402AbbHCSNq (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 3 Aug 2015 14:13:46 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: edubezval@gmail.com, rui.zhang@intel.com
Cc: linux-pm@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

v1
Amended commit message to be clear that RW trips are required for the user space
thermal tools for x86.

v0
base version

Srinivas Pandruvada (1):
  thermal: kconfig: select THERMAL_WRITABLE_TRIPS for x86 thermal

 drivers/thermal/Kconfig | 3 +++
 1 file changed, 3 insertions(+)

-- 
2.4.3

