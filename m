From: Luis de Bethencourt <luis@debethencourt.com>
Subject: [PATCH] PM / AVS: rockchip-io: Fix module autoload for OF platform
 driver
Date: Fri, 18 Sep 2015 18:52:58 +0200
Message-ID: <20150918165258.GA27398@goodgumbo.baconseed.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:32813 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753701AbbIRQxA (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 18 Sep 2015 12:53:00 -0400
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Kevin Hilman <khilman@kernel.org>, Nishanth Menon <nm@ti.com>, Heiko Stuebner <heiko@sntech.de>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org

This platform driver has a OF device ID table but the OF module
alias information is not created so module autoloading won't work.

Signed-off-by: Luis de Bethencourt <luisbg@osg.samsung.com>
---

Hello,

This patch adds the missing MODULE_DEVICE_TABLE() for OF to export
that information so modules have the correct aliases built-in and
autoloading works correctly.

A longer explanation by Javier Canillas can be found here:
https://lkml.org/lkml/2015/7/30/519

Thanks,
Luis

 drivers/power/avs/rockchip-io-domain.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/power/avs/rockchip-io-domain.c b/drivers/power/avs/rockchip-io-domain.c
index 2e30002..8099456 100644
--- a/drivers/power/avs/rockchip-io-domain.c
+++ b/drivers/power/avs/rockchip-io-domain.c
@@ -271,6 +271,7 @@ static const struct of_device_id rockchip_iodomain_match[] = {
 	},
 	{ /* sentinel */ },
 };
+MODULE_DEVICE_TABLE(of, rockchip_iodomain_match);
 
 static int rockchip_iodomain_probe(struct platform_device *pdev)
 {
-- 
2.4.6

