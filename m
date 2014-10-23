From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v3 03/11] ARM: shmobile: armadillo800eva legacy: Add missing A3SP pm domain devices
Date: Thu, 23 Oct 2014 13:18:53 +0200
Message-ID: <1414063141-8856-4-git-send-email-geert+renesas@glider.be>
References: <1414063141-8856-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from xavier.telenet-ops.be ([195.130.132.52]:38464 "EHLO
	xavier.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754909AbaJWLTC (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 23 Oct 2014 07:19:02 -0400
In-Reply-To: <1414063141-8856-1-git-send-email-geert+renesas@glider.be>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-sh@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Geert Uytterhoeven <geert+renesas@glider.be>

Commit 802a5639aa7041b2 ("ARM: shmobile: r8a7740: add A3SP pm domain
support") added the A3SP power domain, but forgot to hook up the TPU,
SDHI0/1, and MMCIF hardware blocks.

Note: As the default PM QoS latency constraint for SDHI is only 100 =C2=
=B5s
(cfr. commit c419e611c3c59c0e ("tmio_mmc / PM: Use PM QoS latency
constraint"), while DEFAULT_DEV_LATENCY_NS is 250000, suspend fails wit=
h
-EBUSY, unless the constraint is increased first to more than 500 =C2=B5=
s
using e.g.

    echo 501 > /sys/devices/platform/sh_mobile_sdhi.0/power/pm_qos_resu=
me_latency_us

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v3:
  - No changes,
v2:
  - Converted FIXME to Note, as this is expected behavior.
---
 arch/arm/mach-shmobile/board-armadillo800eva.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/board-armadillo800eva.c b/arch/arm/=
mach-shmobile/board-armadillo800eva.c
index f19459a8c3edbb77..64a68450c28a072c 100644
--- a/arch/arm/mach-shmobile/board-armadillo800eva.c
+++ b/arch/arm/mach-shmobile/board-armadillo800eva.c
@@ -1234,8 +1234,11 @@ static void __init eva_init(void)
 	static struct pm_domain_device domain_devices[] __initdata =3D {
 		{ "A4LC", &lcdc0_device },
 		{ "A4LC", &hdmi_lcdc_device },
+		{ "A3SP", &pwm_device },
+		{ "A3SP", &sdhi0_device },
+		{ "A3SP", &sh_mmcif_device },
 	};
-	struct platform_device *usb =3D NULL;
+	struct platform_device *usb =3D NULL, *sdhi1 =3D NULL;
=20
 	regulator_register_always_on(0, "fixed-3.3V", fixed3v3_power_consumer=
s,
 				     ARRAY_SIZE(fixed3v3_power_consumers), 3300000);
@@ -1304,6 +1307,7 @@ static void __init eva_init(void)
=20
 		platform_device_register(&vcc_sdhi1);
 		platform_device_register(&sdhi1_device);
+		sdhi1 =3D &sdhi1_device;
 	}
=20
=20
@@ -1324,6 +1328,8 @@ static void __init eva_init(void)
 				       ARRAY_SIZE(domain_devices));
 	if (usb)
 		rmobile_add_device_to_domain("A3SP", usb);
+	if (sdhi1)
+		rmobile_add_device_to_domain("A3SP", sdhi1);
=20
 	r8a7740_pm_init();
 }
--=20
1.9.1

