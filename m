From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Subject: [PATCH] power_suply: isp1704_charger: Fix isp1704_write() definition
Date: Fri,  1 Jan 2016 13:03:29 +0200
Message-ID: <1451646209-11618-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33410 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751364AbcAALEC (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 1 Jan 2016 06:04:02 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: pali.rohar@gmail.com, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>

All calls to isp1704_write() are using parameter sequence of
isp1704_write(isp, reg, val) but the function is defined as
isp1704_write(isp, val, reg). Fix isp1704_write function definition so that
the driver to be functional.

Signed-off-by: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
---
 drivers/power/isp1704_charger.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/isp1704_charger.c b/drivers/power/isp1704_charger.c
index f2a7d97..46a292a 100644
--- a/drivers/power/isp1704_charger.c
+++ b/drivers/power/isp1704_charger.c
@@ -76,7 +76,7 @@ static inline int isp1704_read(struct isp1704_charger *isp, u32 reg)
 	return usb_phy_io_read(isp->phy, reg);
 }
 
-static inline int isp1704_write(struct isp1704_charger *isp, u32 val, u32 reg)
+static inline int isp1704_write(struct isp1704_charger *isp, u32 reg, u32 val)
 {
 	return usb_phy_io_write(isp->phy, val, reg);
 }
-- 
1.9.1

