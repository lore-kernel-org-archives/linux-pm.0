From: Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH] PM / AVS: rockchip-io: depend on CONFIG_POWER_AVS
Date: Sat, 23 May 2015 15:41:30 +0200
Message-ID: <28649509.lINlAh7Sts@phil>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Kevin Hilman <khilman@kernel.org>, Nishanth Menon <nm@ti.com>
Cc: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, dianders@chromium.org, amstan@chromium.org
List-Id: linux-pm@vger.kernel.org

The rockchip io-domain driver currently only depends on ARCH_ROCKCHIP
itself. This makes it possible to select the power-domain driver, but
not the POWER_AVS class and results in the iodomain-driver not getting
build in this case.

So add the additional dependency, which also results in the driver
config option now being placed nicely into the AVS submenu.

Fixes: 662a958638bd ("PM / AVS: rockchip-io: add driver handling Rockchip io domains")
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
Found while trying to make the wifi on current rk3288 Chromebooks work.

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
