From: Caesar Wang <wxt@rock-chips.com>
Subject: [PATCH v4 2/5] thermal: rockchip: fix a impossible condition caused by the warning
Date: Sun, 20 Dec 2015 17:06:45 +0800
Message-ID: <1450602405-20883-1-git-send-email-wxt@rock-chips.com>
References: <1449132523-18817-1-git-send-email-wxt@rock-chips.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f171.google.com ([209.85.192.171]:34133 "EHLO
	mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753677AbbLTJG4 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 20 Dec 2015 04:06:56 -0500
In-Reply-To: <1449132523-18817-1-git-send-email-wxt@rock-chips.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: edubezval@gmail.com
Cc: heiko@sntech.de, dmitry.torokhov@gmail.com, computersforpeace@gmail.com, linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, rui.zhang@intel.com, Caesar Wang <wxt@rock-chips.com>

As the Dan report the smatch check the thermal driver warning:
drivers/thermal/rockchip_thermal.c:551 rockchip_configure_from_dt()
warn: impossible condition '(thermal->tshut_temp > ((~0 >> 1))) =>
(s32min-s32max > s32max)'

Although The shut_temp read from DT is u32,the temperature is currently
represented as int not long in the thermal driver.
Let's change to make shut_temp instead of the thermal->tshut_temp for
the condition.

Fixes: commit 437df2172e8d
("thermal: rockchip: consistently use int for temperatures")

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Caesar Wang <wxt@rock-chips.com>

---

Changes in v4:
- As the Dmitry and Brain comments, let's change to make.sh
  tshut_temp instead of thermal->tshut_temp.

Changes in v3:
- As Brian comments on https://patchwork.kernel.org/patch/7580661/,
  let's remove the impossible condition.

Changes in v2:
- None

Changes in v1:
- None

 drivers/thermal/rockchip_thermal.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_thermal.c
index e845841..7106288 100644
--- a/drivers/thermal/rockchip_thermal.c
+++ b/drivers/thermal/rockchip_thermal.c
@@ -545,15 +545,14 @@ static int rockchip_configure_from_dt(struct device *dev,
 			 thermal->chip->tshut_temp);
 		thermal->tshut_temp = thermal->chip->tshut_temp;
 	} else {
+		if (shut_temp > INT_MAX) {
+			dev_err(dev, "Invalid tshut temperature specified: %d\n",
+				shut_temp);
+			return -ERANGE;
+		}
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

