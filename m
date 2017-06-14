From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH] thermal: bcm2835: fix an error code in probe()
Date: Wed, 14 Jun 2017 12:13:27 +0300
Message-ID: <20170614091327.GD29394@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
Sender: kernel-janitors-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Stefan Wahren <stefan.wahren@i2se.com>
Cc: Eduardo Valentin <edubezval@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, bcm-kernel-feedback-list@broadcom.com, Eric Anholt <eric@anholt.net>, =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>, Martin Sperl <kernel@martin.sperl.org>, linux-pm@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

This causes a static checker because we're passing a valid pointer to
PTR_ERR().  "err" is already the correct error code, so we can just
delete this line.

Fixes: bcb7dd9ef206 ("thermal: bcm2835: add thermal driver for bcm2835 SoC")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

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
