From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Subject: [GIT PULL] On-demand device probing
Date: Thu, 15 Oct 2015 13:42:08 +0200
Message-ID: <1444909328-24761-1-git-send-email-tomeu.vizoso@collabora.com>
References: <20151014092644.GO14956@sirena.org.uk>
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20151014092644.GO14956@sirena.org.uk>
Sender: linux-gpio-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>
Cc: Russell King <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Vinod Koul <vinod.koul@intel.com>, Dan Williams <dan.j.williams@intel.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, David Airlie <airlied@linux.ie>, =?UTF-8?q?Terje=20Bergstr=C3=B6m?= <tbergstrom@nvidia.com>, Stephen Warren <swarren@wwwdotorg.org>, Wolfram Sang <wsa@the-dreams.de>, Frank Rowand <frowand.list@gmail.com>, Grant Likely <grant.likely@linaro.org>, Kishon Vijay Abraham I <kishon@ti.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Felipe Balbi <balbi@ti.com>
List-Id: linux-pm@vger.kernel.org

Hi,

this second pull request replaces the last references to device_initcall_sync with late_initcall, as noticed by Frank Rowand.

Also fixes the url of the git repo and the wrapping, as suggested by Mark Brown.

Thanks,

Tomeu

The following changes since commit 6ff33f3902c3b1c5d0db6b1e2c70b6d76fba357f:

  Linux 4.3-rc1 (2015-09-12 16:35:56 -0700)

are available in the git repository at:

  git://git.collabora.com/git/user/tomeu/linux.git on-demand-probes-for-next

for you to fetch changes up to c074fef5d36e1c27dfdf7474e23c01a1b044ff98:

  of/platform: Defer probes of registered devices (2015-10-15 13:25:47 +0200)

----------------------------------------------------------------
Tomeu Vizoso (20):
      driver core: handle -EPROBE_DEFER from bus_type.match()
      ARM: amba: Move reading of periphid to amba_match()
      of/platform: Point to struct device from device node
      of: add function to allow probing a device from a OF node
      gpio: Probe GPIO drivers on demand
      pinctrl: Probe pinctrl devices on demand
      regulator: core: Probe regulators on demand
      drm: Probe panels on demand
      drm/tegra: Probe dpaux devices on demand
      i2c: core: Probe i2c adapters and devices on demand
      pwm: Probe PWM chip devices on demand
      backlight: Probe backlight devices on demand
      usb: phy: Probe phy devices on demand
      clk: Probe clk providers on demand
      pinctrl: Probe pinctrl devices on demand
      phy: core: Probe phy providers on demand
      dma: of: Probe DMA controllers on demand
      power-supply: Probe power supplies on demand
      driver core: Allow deferring probes until late init
      of/platform: Defer probes of registered devices

 drivers/amba/bus.c                  | 88 +++++++++++++++++++------------------
 drivers/base/Kconfig                | 18 ++++++++
 drivers/base/dd.c                   | 30 ++++++++++++-
 drivers/clk/clk.c                   |  3 ++
 drivers/dma/of-dma.c                |  3 ++
 drivers/gpio/gpiolib-of.c           |  5 +++
 drivers/gpu/drm/drm_panel.c         |  3 ++
 drivers/gpu/drm/tegra/dpaux.c       |  3 ++
 drivers/i2c/i2c-core.c              |  4 ++
 drivers/of/device.c                 | 61 +++++++++++++++++++++++++
 drivers/of/platform.c               | 30 ++++++++-----
 drivers/phy/phy-core.c              |  3 ++
 drivers/pinctrl/devicetree.c        |  3 ++
 drivers/power/power_supply_core.c   |  3 ++
 drivers/pwm/core.c                  |  3 ++
 drivers/regulator/core.c            |  2 +
 drivers/usb/phy/phy.c               |  3 ++
 drivers/video/backlight/backlight.c |  3 ++
 include/linux/device.h              |  4 +-
 include/linux/of.h                  |  1 +
 include/linux/of_device.h           |  3 ++
 21 files changed, 219 insertions(+), 57 deletions(-)
