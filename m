From: Icenowy Zheng <icenowy-h8G6r0blFSE@public.gmane.org>
Subject: [RFC PATCH v2 0/4] IIO-based thermal sensor driver for
 Allwinner H3 SoC
Date: Sun,  2 Apr 2017 21:33:00 +0800
Message-ID: <20170402133304.56824-1-icenowy@aosc.io>
Reply-To: icenowy-h8G6r0blFSE@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBDS6XAN6ZADRBV73QPDQKGQEHNFCG3I-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Quentin Schulz <quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Icenowy Zheng <icenowy-h8G6r0blFSE@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Allwiner H3 SoC has a thermal sensor, which is a large refactored version of
the old Allwinner "GPADC" (although it have already only thermal part left
in A33).

This patch tried to add support for the sensor in H3 based on the A33
thermal sensor patchset by Quentin Schulz at [1].

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2017-March/495505.html

Icenowy Zheng (4):
  dt-bindings: update the Allwinner GPADC device tree binding for H3
  iio: adc: sun4i-gpadc-iio: rename A23/A33-specified registers to
    contain A23
  iio: adc: sun4i-gpadc-iio: add support for H3 thermal sensor
  ARM: sun8i: h3: add support for the thermal sensor in H3

 .../devicetree/bindings/mfd/sun4i-gpadc.txt        |  23 ++-
 arch/arm/boot/dts/sun8i-h3.dtsi                    |  26 +++
 drivers/iio/adc/sun4i-gpadc-iio.c                  | 215 +++++++++++++++++----
 include/linux/mfd/sun4i-gpadc.h                    |  36 +++-
 4 files changed, 254 insertions(+), 46 deletions(-)

-- 
2.12.2
