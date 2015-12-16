From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH v2] i2c: rcar: disable runtime PM correctly in slave mode
Date: Wed, 16 Dec 2015 20:05:18 +0100
Message-ID: <1450292718-11951-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Wolfram Sang <wsa@the-dreams.de>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

When we also are I2C slave, we need to disable runtime PM because the
address detection mechanism needs to be active all the time. However, we
can reenable runtime PM once the slave instance was unregistered. So,
use pm_runtime_get_sync/put to achieve this, since it has proper
refcounting. pm_runtime_allow/forbid is like a global knob controllable
from userspace which is unsuitable here.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Change since v1 is the use of get/put instead of enable/disable. Thanks to Alan
and Geert for the pointers!

 drivers/i2c/busses/i2c-rcar.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-rcar.c b/drivers/i2c/busses/i2c-rcar.c
index 7c523dcaee3e48..02f9f5d57b1eae 100644
--- a/drivers/i2c/busses/i2c-rcar.c
+++ b/drivers/i2c/busses/i2c-rcar.c
@@ -532,7 +532,7 @@ static int rcar_reg_slave(struct i2c_client *slave)
 	if (slave->flags & I2C_CLIENT_TEN)
 		return -EAFNOSUPPORT;
 
-	pm_runtime_forbid(rcar_i2c_priv_to_dev(priv));
+	pm_runtime_get_sync(rcar_i2c_priv_to_dev(priv));
 
 	priv->slave = slave;
 	rcar_i2c_write(priv, ICSAR, slave->addr);
@@ -554,7 +554,7 @@ static int rcar_unreg_slave(struct i2c_client *slave)
 
 	priv->slave = NULL;
 
-	pm_runtime_allow(rcar_i2c_priv_to_dev(priv));
+	pm_runtime_put(rcar_i2c_priv_to_dev(priv));
 
 	return 0;
 }
-- 
2.1.4

