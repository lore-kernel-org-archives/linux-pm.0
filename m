From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] thermal: underflow bug in imx_set_trip_temp()
Date: Fri, 21 Aug 2015 11:49:09 +0300
Message-ID: <20150821084909.GD25369@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:18482 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751775AbbHUIui (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 21 Aug 2015 04:50:38 -0400
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Sascha Hauer <s.hauer@pengutronix.de>
Cc: Eduardo Valentin <edubezval@gmail.com>, linux-pm@vger.kernel.org, kernel-janitors@vger.kernel.org, lm-sensors@lm-sensors.org

We recently changed this from unsigned long to int so it introduced an
underflow bug.

Fixes: 17e8351a7739 ('thermal: consistently use int for temperatures')
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_thermal.c
index 4bec1d3..7a06465 100644
--- a/drivers/thermal/imx_thermal.c
+++ b/drivers/thermal/imx_thermal.c
@@ -288,7 +288,7 @@ static int imx_set_trip_temp(struct thermal_zone_device *tz, int trip,
 	if (trip == IMX_TRIP_CRITICAL)
 		return -EPERM;
 
-	if (temp > IMX_TEMP_PASSIVE)
+	if (temp < 0 || temp > IMX_TEMP_PASSIVE)
 		return -EINVAL;
 
 	data->temp_passive = temp;
