From: Josef Gajdusek <atx-MwjtXicnQwU@public.gmane.org>
Subject: [PATCH v2 0/5] sunxi: THS support
Date: Mon, 23 Nov 2015 09:02:47 +0100
Message-ID: <cover.1448263428.git.atx@atx.name>
Reply-To: atx-MwjtXicnQwU@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBCYM5N4ES4IRBOEQZOZAKGQERNEMHFI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Cc: Josef Gajdusek <atx-MwjtXicnQwU@public.gmane.org>, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gpatchesrdh-I1/eAgTnXDYAvxtiuMwx3w@public.gmane.org, mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
List-Id: linux-pm@vger.kernel.org

Hello everyone,

this is v2 of my THS patchset

Changelog:

 * Some stylistic changes
 * devm_reset_control_get_optional -> devm_reset_control_get
 * Added the clk-h3-ths clock driver
   - Note: A23/A33/A83T do not have a separate clock, H3 seems to be the first
	 (and only?) SoC with it
   - Because of this, I moved the clock init code to the H3-specific init
	 function.
 * Use the nvmem cell abstraction instead of accessing the configuration memory directly
 * Use the IRQ line (and fixed incorrect interrupt number in the DTS)
 * Renamed to sun8i_ths

Ad the "magical constants": what I meant is that altough the datasheet explains
what they are, it does not explain how to pick their values. "ADC" and "Sensor"
"acquire time" are also not exactly the most helpful descriptions.
Anyway, I changed the values such as the final sampling rate is about 1Hz.

Josef Gajdusek (5):
  ARM: dts: sun8i: Add SID node
  clk: sunxi: Add driver for the H3 THS clock
  thermal: Add a driver for the Allwinner THS sensor
  dt-bindings: document sun8i_ths
  ARM: dts: sun8i: Add THS node to the H3 .dtsi

 Documentation/devicetree/bindings/clock/sunxi.txt  |   1 +
 .../devicetree/bindings/thermal/sun8i-ths.txt      |  31 ++
 arch/arm/boot/dts/sun8i-h3.dtsi                    |  40 +++
 drivers/clk/sunxi/Makefile                         |   1 +
 drivers/clk/sunxi/clk-h3-ths.c                     |  98 ++++++
 drivers/thermal/Kconfig                            |   7 +
 drivers/thermal/Makefile                           |   1 +
 drivers/thermal/sun8i_ths.c                        | 365 +++++++++++++++++++++
 8 files changed, 544 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/sun8i-ths.txt
 create mode 100644 drivers/clk/sunxi/clk-h3-ths.c
 create mode 100644 drivers/thermal/sun8i_ths.c

-- 
2.4.10
