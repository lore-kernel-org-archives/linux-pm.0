From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Subject: [PATCH v4 0/22] On-demand device probing
Date: Mon,  7 Sep 2015 14:23:25 +0200
Message-ID: <1441628627-5143-1-git-send-email-tomeu.vizoso@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Rob Herring <robh+dt@kernel.org>, Stephen Warren <swarren@wwwdotorg.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Mark Brown <broonie@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-arm-kernel@lists.infradead.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, devicetree@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, linux-acpi@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, linux-fbdev@vger.kernel.org, linux-usb@vger.kernel.org, Felipe Balbi <balbi@ti.com>, linux-pwm@vger.kernel.org, =?UTF-8?q?Terje=20Bergstr=C3=B6m?= <tbergstrom@nvidia.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jingoo Han <jingoohan1@gmail.com>, David Airlie <airlied@linux.ie>, Michael Turquette <mturquette@baylibre.com>, linux-clk@vger.kernel.org, dmaengine@vger.kern
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
of_device_probe() in the resource getters of each subsystem, but I thin=
k
it's the right thing to do given that the storage of resources is
currently subsystem-specific.

We could avoid the above by moving resource storage into the core, but =
I
don't think there's a compelling case for that.

I have tested this on boards with Tegra, iMX.6, Exynos, Rockchip and
OMAP SoCs, and these patches were enough to eliminate all the deferred
probes (except one in PandaBoard because omap_dma_system doesn't have a
firmware node as of yet).

Have submitted a branch [5] with only these patches on top of thursday'=
s
linux-next to kernelci.org and I don't see any issues that could be
caused by them. For some reason it currently has more passes than the
version of -next it's based on!

With this series I get the kernel to output to the panel in 0.5s,
instead of 2.8s.

Regards,

Tomeu

[0] http://lists.freedesktop.org/archives/dri-devel/2014-August/066527.=
html

[1] https://lkml.org/lkml/2014/5/12/452

[2] https://lkml.org/lkml/2015/6/17/305

[3] http://article.gmane.org/gmane.linux.ports.arm.kernel/277689

[4] https://lkml.org/lkml/2015/7/21/441a

[5] https://git.collabora.com/cgit/user/tomeu/linux.git/log/?h=3Don-dem=
and-probes-v6

[6] http://kernelci.org/boot/all/job/collabora/kernel/v4.2-11902-g25d80=
c927f8b/

[7] http://kernelci.org/boot/all/job/next/kernel/next-20150903/

Changes in v4:
- Added bus.pre_probe callback so the probes of Primecell devices can b=
e
  deferred if their device IDs cannot be yet read because of the clock
  driver not having probed when they are registered. Maybe this goes
  overboard and the matching information should be in the DT if there i=
s
  one.
- Rename of_platform_probe to of_device_probe
- Use device_node.device instead of device_node.platform_dev
- Take a reference to the regulator's device to prevent dangling
  pointers
- Add Kconfig DELAY_DEVICE_PROBES to allow disabling delayed probing in
  machines with initcalls that depend on devices probing at a given tim=
e.
- Start processing deferred probes in device_initcall_sync
- Also defer probes of AMBA devices registered from the DT as they can
  also request resources.

Changes in v3:
- Set and use device_node.platform_dev instead of reversing the logic t=
o
  find the platform device that encloses a device node.
- Drop the fwnode API to probe firmware nodes and add OF-only API for
  now. I think this same scheme could be used for machines with ACPI,
  but I haven't been able to find one that had to defer its probes beca=
use
  of the device probe order.
- Avoid unlocking the regulator device's mutex if we don't have a devic=
e

Changes in v2:
- Acquire regulator device lock before returning from regulator_dev_loo=
kup()

Tomeu Vizoso (22):
  driver core: Add pre_probe callback to bus_type
  ARM: amba: Move reading of periphid to pre_probe()
  of/platform: Point to struct device from device node
  of: add function to allow probing a device from a OF node
  gpio: Probe GPIO drivers on demand
  gpio: Probe pinctrl devices on demand
  regulator: core: Reduce critical area in _regulator_get
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
  driver core: Start processing deferred probes earlier
  of/platform: Defer probes of registered devices

 drivers/amba/bus.c                  | 78 ++++++++++++++++++-----------=
--------
 drivers/base/Kconfig                | 18 +++++++++
 drivers/base/dd.c                   | 35 ++++++++++++++++-
 drivers/clk/clk.c                   |  3 ++
 drivers/dma/of-dma.c                |  3 ++
 drivers/gpio/gpiolib-of.c           |  5 +++
 drivers/gpu/drm/drm_panel.c         |  3 ++
 drivers/gpu/drm/tegra/dpaux.c       |  3 ++
 drivers/i2c/i2c-core.c              |  4 ++
 drivers/of/device.c                 | 58 +++++++++++++++++++++++++++
 drivers/of/platform.c               | 26 +++++++------
 drivers/phy/phy-core.c              |  3 ++
 drivers/pinctrl/devicetree.c        |  3 ++
 drivers/power/power_supply_core.c   |  3 ++
 drivers/pwm/core.c                  |  3 ++
 drivers/regulator/core.c            | 58 ++++++++++++++++++---------
 drivers/usb/phy/phy.c               |  3 ++
 drivers/video/backlight/backlight.c |  3 ++
 include/linux/device.h              |  6 +++
 include/linux/of.h                  |  1 +
 include/linux/of_device.h           |  3 ++
 21 files changed, 251 insertions(+), 71 deletions(-)

--=20
2.4.3

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
