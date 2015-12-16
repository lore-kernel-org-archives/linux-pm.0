From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH] i2c: rcar: disable runtime PM correctly in slave mode
Date: Wed, 16 Dec 2015 12:02:36 +0100
Message-ID: <1450263756-12013-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:46772 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752203AbbLPLDF (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 16 Dec 2015 06:03:05 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Wolfram Sang <wsa@the-dreams.de>, linux-pm@vger.kernel.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

When we also are I2C slave, we need to disable runtime PM because the
address detection mechanism needs to be active all the time. However, we
can reenable runtime PM once the slave instance was unregistered. So,
use pm_runtime_disable/enable to achieve this, since it has proper
refcounting. pm_runtime_allow/forbid is like a global switch which is
unsuitable here.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

I'd be grateful to get an ACK from a runtime PM expert to verify that my
assumptions match reality :)

 drivers/i2c/busses/i2c-rcar.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-rcar.c b/drivers/i2c/busses/i2c-rcar.c
index b2389c492579cf..dc3343291e7497 100644
--- a/drivers/i2c/busses/i2c-rcar.c
+++ b/drivers/i2c/busses/i2c-rcar.c
@@ -533,7 +533,7 @@ static int rcar_reg_slave(struct i2c_client *slave)
 	if (slave->flags & I2C_CLIENT_TEN)
 		return -EAFNOSUPPORT;
 
-	pm_runtime_forbid(rcar_i2c_priv_to_dev(priv));
+	pm_runtime_disable(rcar_i2c_priv_to_dev(priv));
 
 	priv->slave = slave;
 	rcar_i2c_write(priv, ICSAR, slave->addr);
@@ -555,7 +555,7 @@ static int rcar_unreg_slave(struct i2c_client *slave)
 
 	priv->slave = NULL;
 
-	pm_runtime_allow(rcar_i2c_priv_to_dev(priv));
+	pm_runtime_enable(rcar_i2c_priv_to_dev(priv));
 
 	return 0;
 }
-- 
2.1.4

