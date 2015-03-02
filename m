From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v1] Thermal/int340x: Fix memleak for aux trip
Date: Mon,  2 Mar 2015 13:12:06 -0800
Message-ID: <1425330727-18854-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:38510 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755893AbbCBVNQ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 2 Mar 2015 16:13:16 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rui.zhang@intel.com, edubezval@gmail.com
Cc: linux-pm@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

v1
Rebased with 4.0.0.rc1

v0
base version

Srinivas Pandruvada (1):
  Thermal/int340x: Fix memleak for aux trip

 drivers/thermal/int340x_thermal/int340x_thermal_zone.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

-- 
1.9.3

