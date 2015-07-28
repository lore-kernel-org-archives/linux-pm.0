From: Tomeu Vizoso <tomeu.vizoso-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
Subject: [PATCH v2 0/22] On-demand device probing
Date: Tue, 28 Jul 2015 15:19:31 +0200
Message-ID: <1438089593-7696-1-git-send-email-tomeu.vizoso@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Tomeu Vizoso <tomeu.vizoso-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, =?UTF-8?q?Terje=20Bergstr=C3=B6m?= <tbergstrom-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, Michael Turquette <mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jean-Christophe
List-Id: linux-pm@vger.kernel.org

Hello,

I have a problem with the panel on my Tegra Chromebook taking longer
than expected to be ready during boot (St=C3=A9phane Marchesin reported=
 what
is basically the same issue in [0]), and have looked into ordered
probing as a better way of solving this than moving nodes around in the
DT or playing with initcall levels and linking order.

While reading the thread [1] that Alexander Holler started with his
series to make probing order deterministic, it occurred to me that it
should be possible to achieve the same by probing devices as they are
referenced by other devices.

This basically reuses the information that is already implicit in the
probe() implementations, saving us from refactoring existing drivers or
adding information to DTBs.

During review of v1 of this series Linus Walleij suggested that it
should be the device driver core to make sure that dependencies are
ready before probing a device. I gave this idea a try [2] but Mark Brow=
n
pointed out to the logic duplication between the resource acquisition
and dependency discovery code paths (though I think it's fairly minor).

To address that code duplication I experimented with Arnd's devm_probe
[3] concept of having drivers declare their dependencies instead of
acquiring them during probe, and while it worked [4], I don't think we
end up winning anything when compared to just probing devices on-demand
from resource getters.

One remaining objection is to the "sprinkling" of calls to
fwnode_ensure_device() in the resource getters of each subsystem, but I
think it's the right thing to do given that the storage of resources is
currently subsystem-specific.

We could avoid the above by moving resource storage into the core, but =
I
don't think there's a compelling case for that.

I have tested this on boards with Tegra, iMX.6, Exynos and OMAP SoCs,
and these patches were enough to eliminate all the deferred probes
(except one in PandaBoard because omap_dma_system doesn't have a
firmware node as of yet).

With this series I get the kernel to output to the panel in 0.5s,
instead of 2.8s.

Regards,

Tomeu

[0] http://lists.freedesktop.org/archives/dri-devel/2014-August/066527.=
html

[1] https://lkml.org/lkml/2014/5/12/452

[2] https://lkml.org/lkml/2015/6/17/305

[3] http://article.gmane.org/gmane.linux.ports.arm.kernel/277689

[4] https://lkml.org/lkml/2015/7/21/441

Changes in v2:
- Move delay to platform.c
- Use set_primary_fwnode()
- Use of_node_full_name()
- Move the logic for finding a platform device from its firmware node t=
o
  of/platform.c as it's not needed for ACPI nodes.
- Add acpi_dev_get_device()
- Add fwnode_ensure_device() so the mechanism for probing devices on
  demand is independent of the firmware format.
- Acquire regulator device lock before returning from regulator_dev_loo=
kup()

Tomeu Vizoso (22):
  platform: delay device-driver matches until late_initcall
  of/platform: Set fwnode field for new devices
  device property: add fwnode_get_name()
  of/platform: add of_platform_device_find()
  ACPI: add acpi_dev_get_device()
  device property: add fwnode_ensure_device()
  gpio: Probe GPIO drivers on demand
  gpio: Probe pinctrl devices on demand
  regulator: core: Reduce critical area in _regulator_get
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
  ASoC: core: Probe components on demand

 drivers/base/platform.c             | 28 +++++++++++
 drivers/base/property.c             | 73 +++++++++++++++++++++++++++
 drivers/clk/clk.c                   |  3 ++
 drivers/dma/of-dma.c                |  2 +
 drivers/gpio/gpiolib-of.c           |  4 ++
 drivers/gpu/drm/drm_panel.c         |  2 +
 drivers/gpu/drm/tegra/dpaux.c       |  2 +
 drivers/i2c/i2c-core.c              |  2 +
 drivers/of/platform.c               | 61 +++++++++++++++++++++++
 drivers/phy/phy-core.c              |  2 +
 drivers/pinctrl/devicetree.c        |  1 +
 drivers/power/power_supply_core.c   |  2 +
 drivers/pwm/core.c                  |  2 +
 drivers/regulator/core.c            | 99 +++++++++++++++++++++--------=
--------
 drivers/usb/phy/phy.c               |  2 +
 drivers/video/backlight/backlight.c |  2 +
 include/linux/acpi.h                | 10 ++++
 include/linux/of_platform.h         |  1 +
 include/linux/property.h            |  4 ++
 sound/soc/soc-core.c                |  6 ++-
 20 files changed, 264 insertions(+), 44 deletions(-)

--=20
2.4.3

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
