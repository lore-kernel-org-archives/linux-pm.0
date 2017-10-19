From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 0/3] thermal: Support for Coffee Lake and Cannon Lake
Date: Thu, 19 Oct 2017 14:51:31 -0700
Message-ID: <1508449894-58797-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:58477 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752693AbdJSVvp (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 19 Oct 2017 17:51:45 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rui.zhang@intel.com, edubezval@gmail.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Added support for PCH and processor thermal device.

Srinivas Pandruvada (3):
  thermal: int340x: processor_thermal: Add Cannon Lake support
  thermal: int340x: processor_thermal: Add Coffee Lake support
  thermal: pch: Add Cannon Lake support

 drivers/thermal/int340x_thermal/processor_thermal_device.c |  5 +++++
 drivers/thermal/intel_pch_thermal.c                        | 11 +++++++++++
 2 files changed, 16 insertions(+)

-- 
2.7.5
