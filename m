From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Subject: [PATCH 00/21] On-demand device registration
Date: Mon, 25 May 2015 16:53:04 +0200
Message-ID: <1432565608-26036-1-git-send-email-tomeu.vizoso@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-gpio-owner@vger.kernel.org>
Sender: linux-gpio-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: =?UTF-8?q?St=C3=A9phane=20Marchesin?= <stephane.marchesin@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Alexander Holler <holler@ahsoftware.de>, Grant Likely <grant.likely@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Dan Williams <dan.j.williams@intel.com>, devicetree@vger.kernel.org, dmaengine@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-clk@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-gpio@vger.kernel.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-pwm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-tegra@vger.kernel.org, linux-usb@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hello,

I have a problem with the panel on my Tegra Chromebook taking longer th=
an
expected to be ready during boot (St=C3=A9phane Marchesin reported what=
 is
basically the same issue in [0]), and have looked into ordered probing =
as a
better way of solving this than moving nodes around in the DT or playin=
g with
initcall levels.

While reading the thread [1] that Alexander Holler started with his ser=
ies to
make probing order deterministic, it occurred to me that it should be p=
ossible
to achieve the same by registering devices as they are referenced by ot=
her
devices.

This basically reuses the information that is already implicit in the p=
robe()
implementations, saving us from refactoring existing drivers or adding
information to DTBs.

Something I'm not completely happy with is that I have had to move the =
call to
of_platform_populate after all platform drivers have been registered.
Otherwise I don't see how I could register drivers on demand as we don'=
t have
yet each driver's compatible strings.

=46or machs that don't move of_platform_populate() to a later point, th=
ese
patches shouldn't cause any problems but it's not guaranteed that we'll=
 avoid
all the deferred probes as some drivers may not be registered yet.

I have tested this on boards with Tegra, iMX.6 and Exynos SoCs, and the=
se
patches were enough to eliminate all the deferred probes.

With this series I get the kernel to output to the panel in 0.5s, inste=
ad of 2.8s.

Regards,

Tomeu

[0] http://lists.freedesktop.org/archives/dri-devel/2014-August/066527.=
html

[1] https://lkml.org/lkml/2014/5/12/452

Tomeu Vizoso (21):
  regulator: core: Reduce critical area in _regulator_get
  ARM: tegra: Add gpio-ranges property
  ARM: tegra: Register drivers before devices
  ARM: EXYNOS: Register drivers before devices
  ARM i.MX6q: Register drivers before devices
  of/platform: Add of_platform_device_ensure()
  of/platform: Ensure device registration on lookup
  gpio: Probe GPIO drivers on demand
  gpio: Probe pinctrl devices on demand
  regulator: core: Probe regulators on demand
  drm: Probe panels on demand
  drm/tegra: Probe dpaux devices on demand
  i2c: core: Probe i2c master devices on demand
  pwm: Probe PWM chip devices on demand
  backlight: Probe backlight devices on demand
  usb: phy: Probe phy devices on demand
  clk: Probe clk providers on demand
  pinctrl: Probe pinctrl devices on demand
  phy: core: Probe phy providers on demand
  dma: of: Probe DMA controllers on demand
  power-supply: Probe power supplies on demand

 arch/arm/boot/dts/tegra124.dtsi     |  1 +
 arch/arm/mach-exynos/exynos.c       |  4 +--
 arch/arm/mach-imx/mach-imx6q.c      | 12 ++++-----
 arch/arm/mach-tegra/tegra.c         | 21 ++++++---------
 drivers/clk/clk.c                   |  3 +++
 drivers/dma/of-dma.c                |  3 +++
 drivers/gpio/gpiolib-of.c           |  5 ++++
 drivers/gpu/drm/drm_panel.c         |  3 +++
 drivers/gpu/drm/tegra/dpaux.c       |  3 +++
 drivers/i2c/i2c-core.c              |  3 +++
 drivers/of/platform.c               | 53 +++++++++++++++++++++++++++++=
++++++++
 drivers/phy/phy-core.c              |  3 +++
 drivers/pinctrl/devicetree.c        |  2 ++
 drivers/power/power_supply_core.c   |  3 +++
 drivers/pwm/core.c                  |  3 +++
 drivers/regulator/core.c            | 45 +++++++++++++++--------------=
--
 drivers/usb/phy/phy.c               |  3 +++
 drivers/video/backlight/backlight.c |  3 +++
 include/linux/of_platform.h         |  2 ++
 19 files changed, 130 insertions(+), 45 deletions(-)

--=20
2.4.1

--
To unsubscribe from this list: send the line "unsubscribe linux-gpio" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
