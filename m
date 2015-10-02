From: Luis de Bethencourt <luisbg@osg.samsung.com>
Subject: [PATCH v2] PM / AVS: rockchip-io: Fix module autoload for OF platform driver
Date: Fri,  2 Oct 2015 15:27:57 +0100
Message-ID: <1443796077-24722-1-git-send-email-luisbg@osg.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:47038 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752158AbbJBO2L (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 2 Oct 2015 10:28:11 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org, rafael.j.wysocki@intel.com
Cc: khilman@kernel.org, nm@ti.com, heiko@sntech.de, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, Luis de Bethencourt <luisbg@osg.samsung.com>

This platform driver has a OF device ID table but the OF module
alias information is not created so module autoloading won't work.

Signed-off-by: Luis de Bethencourt <luisbg@osg.samsung.com>
Reviewed-by: Heiko Stuebner <heiko@sntech.de>
---

Hello,

Sending a second version to add Rafael Wysocki in the to-list as
suggested by Heiko St=C3=BCbner.
https://lkml.org/lkml/2015/10/2/431

This patch adds the missing MODULE_DEVICE_TABLE() for OF to export
that information so modules have the correct aliases built-in and
autoloading works correctly.

A longer explanation by Javier Canillas can be found here:
https://lkml.org/lkml/2015/7/30/519

Thanks,
Luis

 drivers/power/avs/rockchip-io-domain.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/power/avs/rockchip-io-domain.c b/drivers/power/avs=
/rockchip-io-domain.c
index 2e30002..8099456 100644
--- a/drivers/power/avs/rockchip-io-domain.c
+++ b/drivers/power/avs/rockchip-io-domain.c
@@ -271,6 +271,7 @@ static const struct of_device_id rockchip_iodomain_=
match[] =3D {
 	},
 	{ /* sentinel */ },
 };
+MODULE_DEVICE_TABLE(of, rockchip_iodomain_match);
=20
 static int rockchip_iodomain_probe(struct platform_device *pdev)
 {
--=20
2.5.1

