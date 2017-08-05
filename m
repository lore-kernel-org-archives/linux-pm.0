From: Julia Lawall <Julia.Lawall@lip6.fr>
Subject: [PATCH 4/4] thermal: bcm2835: constify thermal_zone_of_device_ops structures
Date: Sat,  5 Aug 2017 22:37:17 +0200
Message-ID: <1501965437-30730-5-git-send-email-Julia.Lawall@lip6.fr>
References: <1501965437-30730-1-git-send-email-Julia.Lawall@lip6.fr>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:56153
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752632AbdHEVCs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 5 Aug 2017 17:02:48 -0400
In-Reply-To: <1501965437-30730-1-git-send-email-Julia.Lawall@lip6.fr>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: bhumirks@gmail.com, kernel-janitors@vger.kernel.org, Eduardo Valentin <edubezval@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, bcm-kernel-feedback-list@broadcom.com, Eric Anholt <eric@anholt.net>, Stefan Wahren <stefan.wahren@i2se.com>, linux-pm@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

The thermal_zone_of_device_ops structure is only passed as the fourth
argument to thermal_zone_of_sensor_register, which is declared as const.
Thus the thermal_zone_of_device_ops structure itself can be const.

Done with the help of Coccinelle.

// <smpl>
@r disable optional_qualifier@
identifier i;
position p;
@@
static struct thermal_zone_of_device_ops i@p = { ... };

@ok1@
identifier r.i;
expression e1,e2,e3;
position p;
@@
thermal_zone_of_sensor_register(e1,e2,e3,&i@p)

@bad@
position p != {r.p,ok1.p};
identifier r.i;
struct thermal_zone_of_device_ops e;
@@
e@i@p

@depends on !bad disable optional_qualifier@
identifier r.i;
@@
static
+const
 struct thermal_zone_of_device_ops i = { ... };
// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 drivers/thermal/broadcom/bcm2835_thermal.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/broadcom/bcm2835_thermal.c b/drivers/thermal/broadcom/bcm2835_thermal.c
index e6863c8..a4d6a0e 100644
--- a/drivers/thermal/broadcom/bcm2835_thermal.c
+++ b/drivers/thermal/broadcom/bcm2835_thermal.c
@@ -145,7 +145,7 @@ static void bcm2835_thermal_debugfs(struct platform_device *pdev)
 	debugfs_create_regset32("regset", 0444, data->debugfsdir, regset);
 }
 
-static struct thermal_zone_of_device_ops bcm2835_thermal_ops = {
+static const struct thermal_zone_of_device_ops bcm2835_thermal_ops = {
 	.get_temp = bcm2835_thermal_get_temp,
 };
 
