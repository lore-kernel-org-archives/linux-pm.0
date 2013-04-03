From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: [PATCHv2 0/3] thermal: lookup temperature
Date: Wed, 3 Apr 2013 18:13:14 -0400
Message-ID: <1365027197-2793-1-git-send-email-eduardo.valentin@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:56139 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755939Ab3DCWNo (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 3 Apr 2013 18:13:44 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rui.zhang@intel.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, durgadoss.r@intel.com, Eduardo Valentin <eduardo.valentin@ti.com>

Hello Rui,

Here is V2 of temperature lookup helper function. This has been
split into two API as suggested on V1.

The usage of it is exemplified on patch 03.


Eduardo Valentin (3):
  thermal: introduce thermal_zone_get_zone_by_name helper function
  thermal: expose thermal_zone_get_temp API
  staging: ti-soc-thermal: remove external heat while extrapolating
    hotspot

 drivers/staging/ti-soc-thermal/ti-thermal-common.c |   30 +++++++----
 drivers/thermal/thermal_sys.c                      |   54 ++++++++++++++++++-
 include/linux/thermal.h                            |    2 +
 3 files changed, 73 insertions(+), 13 deletions(-)

-- 
1.7.7.1.488.ge8e1c

