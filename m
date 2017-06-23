From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH v2] thermal: bcm2835: Fix error code in 'bcm2835_thermal_probe'
Date: Fri, 23 Jun 2017 21:44:35 +0200
Message-ID: <20170623194435.8094-1-christophe.jaillet@wanadoo.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rui.zhang@intel.com, edubezval@gmail.com, eric@anholt.net, stefan.wahren@i2se.com, f.fainelli@gmail.com, rjui@broadcom.com, sbranden@broadcom.com, bcm-kernel-feedback-list@broadcom.com, kernel@martin.sperl.org, rafal@milecki.pl
Cc: linux-pm@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, Christophe JAILLET <christophe.jaillet@wanadoo.fr>
List-Id: linux-pm@vger.kernel.org

'tz' is a valid pointer at this point, so calling PTR_ERR on it is
pointless.
This 'err = PTR_ERR(tz)' looks like a cut'n'paste from a few lines above.
So remove it. 'err' is already the error we want to report.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
v2: fix empty subject
---
 drivers/thermal/broadcom/bcm2835_thermal.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/thermal/broadcom/bcm2835_thermal.c b/drivers/thermal/broadcom/bcm2835_thermal.c
index 0ecf80890c84..e6863c841662 100644
--- a/drivers/thermal/broadcom/bcm2835_thermal.c
+++ b/drivers/thermal/broadcom/bcm2835_thermal.c
@@ -245,7 +245,6 @@ static int bcm2835_thermal_probe(struct platform_device *pdev)
 		 */
 		err = tz->ops->get_trip_temp(tz, 0, &trip_temp);
 		if (err < 0) {
-			err = PTR_ERR(tz);
 			dev_err(&pdev->dev,
 				"Not able to read trip_temp: %d\n",
 				err);
-- 
2.11.0
