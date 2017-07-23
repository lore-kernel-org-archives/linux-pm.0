From: Icenowy Zheng <icenowy-h8G6r0blFSE@public.gmane.org>
Subject: [PATCH 00/10] A trial to Allwinner H3 DVFS support
Date: Sun, 23 Jul 2017 18:27:39 +0800
Message-ID: <20170723102749.17323-1-icenowy@aosc.io>
Reply-To: icenowy-h8G6r0blFSE@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sunxi+bncBDS6XAN6ZADRBN7U2HFQKGQEBIKPRAA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Icenowy Zheng <icenowy-h8G6r0blFSE@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

This patchset is a trial for DVFS support for Allwinner H3 SoC,
considering two kinds of adjustable regulators used on H3 boards:
SY8106A I2C-controlled regulator and SY8113B regulator (controllable
by GPIO with some special designs on the board).

PATCH 1 and PATCH 2 are for the SY8106A regulator, then PATCH 3 and
PATCH 4 are for the r_i2c bus, which is used by boards with SY8106A
to communicate with the regulator.

PATCH 5 and 6 are CCU fixes for H3 DVFS.

PATCH 7 is adding new compatible strings to the cpufreq-dt driver.

PATCH 8 adds the opp-v2 table for H3 SoC (without OPPs higher than
1.008GHz).

PATCH 9 and 10 finally adds DVFS support for two boards, Orange Pi
Zero (SY8113B) and Orange Pi PC (SY8106A).

Tested on these boards mentioned.

PATCH 9 and 10 finally adds DVFS support for two boards, Orange Pi
Zero (SY8113B) and Orange Pi PC (SY8106A).

Tested on these boards mentioned.

Chen-Yu Tsai (1):
  clk: sunxi-ng: h3: gate then ungate PLL CPU clk after rate change

Icenowy Zheng (4):
  clk: sunxi-ng: allow set parent clock (PLL_CPUX) for CPUX clock on H3
  cpufreq: dt: Add support for some new Allwinner SoCs
  ARM: sun8i: h3: add operating-points-v2 table for CPU
  ARM: sun8i: h2+: add SY8113B regulator used by Orange Pi Zero board

Ondrej Jirman (5):
  dt-bindings: add binding for the SY8160A voltage regulator
  regulator: add support for SY8106A regulator
  ARM: sunxi: h3/h5: Add r_i2c pinmux node
  ARM: sunxi: h3/h5: Add r_i2c I2C controller
  ARM: dts: sun8i: Add SY8106A regulator to Orange Pi PC

 .../bindings/regulator/sy8106a-regulator.txt       |  21 +++
 arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts  |  21 +++
 arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts         |  19 +++
 arch/arm/boot/dts/sun8i-h3.dtsi                    |  38 ++++-
 arch/arm/boot/dts/sunxi-h3-h5.dtsi                 |  19 +++
 drivers/clk/sunxi-ng/ccu-sun8i-h3.c                |  13 +-
 drivers/cpufreq/cpufreq-dt-platdev.c               |   6 +
 drivers/regulator/Kconfig                          |   8 +-
 drivers/regulator/Makefile                         |   2 +-
 drivers/regulator/sy8106a-regulator.c              | 163 +++++++++++++++++++++
 10 files changed, 306 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/regulator/sy8106a-regulator.txt
 create mode 100644 drivers/regulator/sy8106a-regulator.c

-- 
2.13.0
