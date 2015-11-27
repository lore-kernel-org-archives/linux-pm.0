From: Caesar Wang <wxt@rock-chips.com>
Subject: [PATCH v1 2/5] thermal: rockchip: fix a impossible condition caused by the warning
Date: Fri, 27 Nov 2015 10:52:23 +0800
Message-ID: <1448592746-2129-3-git-send-email-wxt@rock-chips.com>
References: <1448592746-2129-1-git-send-email-wxt@rock-chips.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f65.google.com ([209.85.220.65]:34076 "EHLO
	mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753857AbbK0Cxs (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 26 Nov 2015 21:53:48 -0500
In-Reply-To: <1448592746-2129-1-git-send-email-wxt@rock-chips.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: linux-rockchip@lists.infradead.org, Heiko Stuebner <heiko@sntech.de>, Dan Carpenter <dan.carpenter@oracle.com>, Caesar Wang <wxt@rock-chips.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, linux-arm-kernel@lists.infradead.org

As the Dan report the smatch check the thermal driver warning:
drivers/thermal/rockchip_thermal.c:551 rockchip_configure_from_dt()
warn: impossible condition '(thermal->tshut_temp > ((~0 >> 1))) =>
(s32min-s32max > s32max)'

Since the Temperature is currently represented as int not long in
the thermal driver.

Fixes: commit 437df2172e8d
("thermal: rockchip: consistently use int for temperatures")

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Caesar Wang <wxt@rock-chips.com>

---

Changes in v1: None

 drivers/thermal/rockchip_thermal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_thermal.c
index 5a8840b..d00765f 100644
--- a/drivers/thermal/rockchip_thermal.c
+++ b/drivers/thermal/rockchip_thermal.c
@@ -548,7 +548,7 @@ static int rockchip_configure_from_dt(struct device *dev,
 		thermal->tshut_temp = shut_temp;
 	}
 
-	if (thermal->tshut_temp > INT_MAX) {
+	if (!(thermal->tshut_temp < INT_MAX)) {
 		dev_err(dev, "Invalid tshut temperature specified: %d\n",
 			thermal->tshut_temp);
 		return -ERANGE;
-- 
1.9.1

