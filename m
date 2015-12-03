From: Caesar Wang <wxt@rock-chips.com>
Subject: [PATCH v3 2/5] thermal: rockchip: fix a impossible condition caused by the warning
Date: Thu,  3 Dec 2015 16:48:40 +0800
Message-ID: <1449132523-18817-3-git-send-email-wxt@rock-chips.com>
References: <1449132523-18817-1-git-send-email-wxt@rock-chips.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f65.google.com ([209.85.220.65]:35781 "EHLO
	mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758691AbbLCItR (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 3 Dec 2015 03:49:17 -0500
In-Reply-To: <1449132523-18817-1-git-send-email-wxt@rock-chips.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: huangtao@rock-chips.com, Heiko Stuebner <heiko@sntech.de>, dmitry.torokhov@gmail.com, dianders@chromium.org, linux-rockchip@lists.infradead.org, computersforpeace@gmail.com, Dan Carpenter <dan.carpenter@oracle.com>, Caesar Wang <wxt@rock-chips.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, linux-arm-kernel@lists.infradead.org

As the Dan report the smatch check the thermal driver warning:
drivers/thermal/rockchip_thermal.c:551 rockchip_configure_from_dt()
warn: impossible condition '(thermal->tshut_temp > ((~0 >> 1))) =>
(s32min-s32max > s32max)'

Let's we remove the imposssible condition Since the Temperature is
currently represented as int not long in the thermal driver.

Fixes: commit 437df2172e8d
("thermal: rockchip: consistently use int for temperatures")

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Caesar Wang <wxt@rock-chips.com>

---

Changes in v3:
- As Brian comments on https://patchwork.kernel.org/patch/7580661/,
  let's remove the impossible condition.

Changes in v2: None
Changes in v1: None

 drivers/thermal/rockchip_thermal.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_thermal.c
index ae796ec..611de00 100644
--- a/drivers/thermal/rockchip_thermal.c
+++ b/drivers/thermal/rockchip_thermal.c
@@ -549,12 +549,6 @@ static int rockchip_configure_from_dt(struct device *dev,
 		thermal->tshut_temp = shut_temp;
 	}
 
-	if (thermal->tshut_temp > INT_MAX) {
-		dev_err(dev, "Invalid tshut temperature specified: %d\n",
-			thermal->tshut_temp);
-		return -ERANGE;
-	}
-
 	if (of_property_read_u32(np, "rockchip,hw-tshut-mode", &tshut_mode)) {
 		dev_warn(dev,
 			 "Missing tshut mode property, using default (%s)\n",
-- 
1.9.1

