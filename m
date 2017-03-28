From: Icenowy Zheng <icenowy-h8G6r0blFSE@public.gmane.org>
Subject: [RFC PATCH 0/3] IIO-based thermal sensor driver for Allwinner H3 SoC
Date: Wed, 29 Mar 2017 01:30:10 +0800
Message-ID: <20170328173013.16539-1-icenowy@aosc.io>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Quentin Schulz <quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Icenowy Zheng <icenowy-h8G6r0blFSE@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Allwiner H3 SoC has a thermal sensor, which is a large refactored version of
the old Allwinner "GPADC" (although it have already only thermal part left
in A33).

This patch tried to add support for the sensor in H3 based on the A33
thermal sensor patchset by Quentin Schulz at [1].

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2017-March/495505.html

Icenowy Zheng (3):
  dt-bindings: update the Allwinner GPADC device tree binding for H3
  iio: adc: sun4i-gpadc-iio: add support for H3 thermal sensor
  ARM: sun8i: h3: add support for the thermal sensor in H3

 .../devicetree/bindings/mfd/sun4i-gpadc.txt        |  23 +++-
 arch/arm/boot/dts/sun8i-h3.dtsi                    |  26 +++++
 drivers/iio/adc/sun4i-gpadc-iio.c                  | 130 ++++++++++++++++++---
 include/linux/mfd/sun4i-gpadc.h                    |  33 +++++-
 4 files changed, 188 insertions(+), 24 deletions(-)

-- 
2.12.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
