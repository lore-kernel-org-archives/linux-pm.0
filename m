From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Subject: [PATCH 1/2 RESEND] PM / AVS: rockchip-io: depend on CONFIG_POWER_AVS
Date: Tue, 04 Aug 2015 21:36:12 +0200
Message-ID: <3371948.nX6iqYbHnA@diego>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from gloria.sntech.de ([95.129.55.99]:38925 "EHLO gloria.sntech.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752290AbbHDTgQ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 4 Aug 2015 15:36:16 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org

The rockchip io-domain driver currently only depends on ARCH_ROCKCHIP
itself. This makes it possible to select the power-domain driver, but
not the POWER_AVS class and results in the iodomain-driver not getting
build in this case.

So add the additional dependency, which also results in the driver
config option now being placed nicely into the AVS submenu.

Fixes: 662a958638bd ("PM / AVS: rockchip-io: add driver handling Rockchip io domains")
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Acked-by: Kevin Hilman <khilman@linaro.org>
---
Kevin wrote when he Acked the patch: "Rafael, feel free to queue this
up as a fix.  I don't have any other drivers/power/avs stuff queued up."

Although I don't know if this is the case anymore.


 drivers/power/avs/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/avs/Kconfig b/drivers/power/avs/Kconfig
index 7f3d389..a67eeac 100644
--- a/drivers/power/avs/Kconfig
+++ b/drivers/power/avs/Kconfig
@@ -13,7 +13,7 @@ menuconfig POWER_AVS
 
 config ROCKCHIP_IODOMAIN
         tristate "Rockchip IO domain support"
-        depends on ARCH_ROCKCHIP && OF
+        depends on POWER_AVS && ARCH_ROCKCHIP && OF
         help
           Say y here to enable support io domains on Rockchip SoCs. It is
           necessary for the io domain setting of the SoC to match the
-- 
2.1.4


