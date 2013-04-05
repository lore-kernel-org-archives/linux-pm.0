From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: [PATCHv3 0/3] thermal: lookup temperature
Date: Fri, 5 Apr 2013 08:32:27 -0400
Message-ID: <1365165150-11720-1-git-send-email-eduardo.valentin@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:48386 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752128Ab3DEMc6 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 5 Apr 2013 08:32:58 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rui.zhang@intel.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, durgadoss.r@intel.com, Eduardo Valentin <eduardo.valentin@ti.com>

Hello Rui,

Here is V3 of temperature lookup helper function. This has been
split into two API as suggested on V1 and now the API returns an
specific error code for multiple matches, as suggested in V2.

The usage of it is exemplified on patch 03.


Eduardo Valentin (3):
  thermal: introduce thermal_zone_get_zone_by_name helper function
  thermal: expose thermal_zone_get_temp API
  staging: ti-soc-thermal: remove external heat while extrapolating
    hotspot

 drivers/staging/ti-soc-thermal/ti-thermal-common.c |   30 +++++++----
 drivers/thermal/thermal_sys.c                      |   58 +++++++++++++++++++-
 include/linux/thermal.h                            |    2 +
 3 files changed, 77 insertions(+), 13 deletions(-)

-- 
1.7.7.1.488.ge8e1c

