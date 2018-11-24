From: Mikulas Patocka <mpatocka@redhat.com>
Subject: [PATCH] thermal: armada: fix broken temperature sensor in 4.19
Date: Sat, 24 Nov 2018 18:45:00 -0500 (EST)
Message-ID: <alpine.LRH.2.02.1811241838180.7275@file01.intranet.prod.int.rdu2.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Miquel Raynal <miquel.raynal@bootlin.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

The patch 8c0e64ac4075b7ca870098ed2ad6089868f5fa7b ("thermal: armada: get
rid of the ->is_valid() pointer") breaks temperature readings on the
MacchiatoBIN board. Reading the temperature with
	cat /sys/devices/virtual/thermal/thermal_zone*/temp
results in errors:

armada_thermal f06f808c.thermal: Temperature sensor reading not valid
armada_thermal f2400078.thermal: Temperature sensor reading not valid
armada_thermal f4400078.thermal: Temperature sensor reading not valid

The patch was meant as simple refactoring, but unfortunatelly, it reverses
the condition in armada_get_temp_legacy, so that the error is reported if
armada_is_valid returns true.

Fixes: 8c0e64ac4075 ("thermal: armada: get rid of the ->is_valid() pointer")
Cc: stable@vger.kernel.org	# 4.19

---
 drivers/thermal/armada_thermal.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-4.19.4/drivers/thermal/armada_thermal.c
===================================================================
--- linux-4.19.4.orig/drivers/thermal/armada_thermal.c	2018-11-25 00:19:20.000000000 +0100
+++ linux-4.19.4/drivers/thermal/armada_thermal.c	2018-11-25 00:39:49.000000000 +0100
@@ -357,7 +357,7 @@ static int armada_get_temp_legacy(struct
 	int ret;
 
 	/* Valid check */
-	if (armada_is_valid(priv)) {
+	if (!armada_is_valid(priv)) {
 		dev_err(priv->dev,
 			"Temperature sensor reading not valid\n");
 		return -EIO;
