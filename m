From: "Wendy Ng" <wendy.ng-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Subject: [PATCH V2 0/3] thermal: bcm281xx: Add Temperature Monitor
 driver
Date: Tue, 5 Nov 2013 11:54:41 -0800
Message-ID: <1383681284-17643-1-git-send-email-wendy.ng@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Eduardo Valentin <eduardo.valentin-l0cyMroinI0@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Christian Daudt <bcm-xK7y4jjYLqYh9ZMKESR00Q@public.gmane.org>, Markus Mayer <mmayer-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Tim Kryger <tim.kryger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Matt Porter <matt.porter-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Wendy Ng <wendy.ng-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

This patch series adds the support of the Temperature Monitor driver
for Broadcom bcm281xx SoCs. This TMON driver can be used with the
Thermal Framework.

This patch series incoporates the feedback from the old series:
V1: https://lkml.org/lkml/2013/9/23/424
V2: https://lkml.org/lkml/2013/9/27/555

Note that this patch series is dependent on the following patches:
https://lkml.org/lkml/2013/9/26/787
http://www.spinics.net/lists/arm-kernel/msg274963.html
https://lkml.org/lkml/2013/10/3/645

---
Delta from V1 of this patch series:
1. Update bcm-kona-thermal.txt to remove the 'status' property
2. Added the references to the generic thermal sensor binding 
and the generic clock consumer binding in bcm-kona-thermal.txt.


Wendy Ng (3):
  thermal: bcm281xx: Add Temperature Monitor driver
  ARM: configs:enable thermal framework for bcm281xx
  ARM: dts: Add TMON driver support to bcm281xx

 .../bindings/thermal/bcm-kona-thermal.txt          |   27 +++
 arch/arm/boot/dts/bcm11351-brt.dts                 |    4 +
 arch/arm/boot/dts/bcm11351.dtsi                    |   29 ++++
 arch/arm/boot/dts/bcm28155-ap.dts                  |    4 +
 arch/arm/configs/bcm_defconfig                     |    4 +-
 drivers/thermal/Kconfig                            |   11 ++
 drivers/thermal/Makefile                           |    1 +
 drivers/thermal/bcm_kona_tmon.c                    |  173 ++++++++++++++++++++
 8 files changed, 252 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/thermal/bcm-kona-thermal.txt
 create mode 100644 drivers/thermal/bcm_kona_tmon.c

-- 
1.7.9.5


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
