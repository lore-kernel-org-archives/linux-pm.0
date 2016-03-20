From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] lan78xx: Protect runtime_auto check by #ifdef CONFIG_PM
Date: Sun, 20 Mar 2016 11:43:56 +0100
Message-ID: <1458470636-18986-1-git-send-email-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from andre.telenet-ops.be ([195.130.132.53]:41708 "EHLO
	andre.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755295AbcCTKn6 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 20 Mar 2016 06:43:58 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Woojung Huh <woojung.huh@microchip.com>, Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>, "David S. Miller" <davem@davemloft.net>
Cc: Guenter Roeck <linux@roeck-us.net>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, netdev@vger.kernel.org, linux-usb@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>

If CONFIG_PM=3Dn:

    drivers/net/usb/lan78xx.c: In function =E2=80=98lan78xx_get_stats64=
=E2=80=99:
    drivers/net/usb/lan78xx.c:3274: error: =E2=80=98struct dev_pm_info=E2=
=80=99 has no member named =E2=80=98runtime_auto=E2=80=99

If PM is disabled, the runtime_auto flag is not available, but auto
suspend is not enabled anyway.  Hence protect the check for runtime_aut=
o
by #ifdef CONFIG_PM to fix this.

=46ixes: a59f8c5b048dc938 ("lan78xx: add ndo_get_stats64")
Reported-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
Alternatively, we can add a dev_pm_runtime_auto_is_enabled() wrapper to
include/linux/pm.h, which always return false if CONFIG_PM is disabled.

The only other user in non-core code (drivers/usb/core/sysfs.c) has a
big #ifdef CONFIG_PM check around all PM-related code.

Thoughts?
---
 drivers/net/usb/lan78xx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index d36d5ebf37f355f2..7b9ac47b2ecf9905 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -3271,7 +3271,9 @@ struct rtnl_link_stats64 *lan78xx_get_stats64(str=
uct net_device *netdev,
 	 * periodic reading from HW will prevent from entering USB auto suspe=
nd.
 	 * if autosuspend is disabled, read from HW.
 	 */
+#ifdef CONFIG_PM
 	if (!dev->udev->dev.power.runtime_auto)
+#endif
 		lan78xx_update_stats(dev);
=20
 	mutex_lock(&dev->stats.access_lock);
--=20
1.9.1

