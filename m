From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: [PATCH 3/4] thermal: imx: use consistent style to write temperatures
Date: Tue, 21 Nov 2017 21:02:24 +0100
Message-ID: <20171121200225.23316-4-u.kleine-koenig@pengutronix.de>
References: <20171121200225.23316-1-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from antares.kleine-koenig.org ([94.130.110.236]:56966 "EHLO
        antares.kleine-koenig.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751067AbdKUULk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 21 Nov 2017 15:11:40 -0500
In-Reply-To: <20171121200225.23316-1-u.kleine-koenig@pengutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Leonard Crestez <leonard.crestez@nxp.com>, Shawn Guo <shawnguo@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: linux-pm@vger.kernel.org, kernel@pengutronix.de

The previous commit already took care to use the right notation for
temperatures. Add correct units to all values representing temperatures in
the right notation for the rest of the file.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/thermal/imx_thermal.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_thermal.c
index c08883dff2cb..b24aa6cfebbf 100644
--- a/drivers/thermal/imx_thermal.c
+++ b/drivers/thermal/imx_thermal.c
@@ -394,27 +394,27 @@ static void imx_init_temp_grade(struct platform_device *pdev, u32 ocotp_mem0)
 
 	/* The maximum die temp is specified by the Temperature Grade */
 	switch ((ocotp_mem0 >> 6) & 0x3) {
-	case 0: /* Commercial (0 to 95C) */
+	case 0: /* Commercial (0 to 95 °C) */
 		data->temp_grade = "Commercial";
 		data->temp_max = 95000;
 		break;
-	case 1: /* Extended Commercial (-20 to 105C) */
+	case 1: /* Extended Commercial (-20 °C to 105 °C) */
 		data->temp_grade = "Extended Commercial";
 		data->temp_max = 105000;
 		break;
-	case 2: /* Industrial (-40 to 105C) */
+	case 2: /* Industrial (-40 °C to 105 °C) */
 		data->temp_grade = "Industrial";
 		data->temp_max = 105000;
 		break;
-	case 3: /* Automotive (-40 to 125C) */
+	case 3: /* Automotive (-40 °C to 125 °C) */
 		data->temp_grade = "Automotive";
 		data->temp_max = 125000;
 		break;
 	}
 
 	/*
-	 * Set the critical trip point at 5C under max
-	 * Set the passive trip point at 10C under max (can change via sysfs)
+	 * Set the critical trip point at 5 °C under max
+	 * Set the passive trip point at 10 °C under max (changable via sysfs)
 	 */
 	data->temp_critical = data->temp_max - (1000 * 5);
 	data->temp_passive = data->temp_max - (1000 * 10);
-- 
2.14.2
