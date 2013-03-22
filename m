From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: [PATCH 0/2] thermal: lookup temperature
Date: Fri, 22 Mar 2013 17:13:05 -0400
Message-ID: <1363986787-28147-1-git-send-email-eduardo.valentin@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:36546 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423058Ab3CVVNc (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 22 Mar 2013 17:13:32 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Eduardo Valentin <eduardo.valentin@ti.com>

hello Rui,

Here is a temperature lookup helper function.

The usage of it is exemplified on patch 02.

Please review. This may overlap with Durgas recent work. But I am resending
as no one has commented my RFC.

Cheers,

Eduardo Valentin (2):
  thermal: introduce thermal_zone_lookup_temperature helper function
  staging: ti-soc-thermal: remove external heat while extrapolating
    hotspot

 drivers/staging/ti-soc-thermal/ti-thermal-common.c |    5 +--
 drivers/thermal/thermal_sys.c                      |   32 ++++++++++++++++++++
 include/linux/thermal.h                            |    1 +
 3 files changed, 35 insertions(+), 3 deletions(-)

-- 
1.7.7.1.488.ge8e1c

