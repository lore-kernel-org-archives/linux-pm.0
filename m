From: Johan Hovold <johan@kernel.org>
Subject: [PATCH v2 0/7] driver core/USB/thermal: fix device-tree node reuse
Date: Tue,  6 Jun 2017 17:58:57 +0200
Message-ID: <20170606155904.26819-1-johan@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, Peter Chen <peter.chen@nxp.com>, Rob Herring <robh@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Sricharan R <sricharan@codeaurora.org>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-usb@vger.kernel.org, Johan Hovold <johan@kernel.org>
List-Id: linux-pm@vger.kernel.org

This series fixes a few issues related to device-tree node reuse.

It is fairly common for drivers to reuse the device-tree node of a
parent (or other ancestor) device when creating class or bus devices
(e.g. gpio chips, i2c adapters, iio chips, spi masters, serdev, phys,
usb root hubs). But reusing a device-tree node may cause problems *if*
the new device is later probed as for example driver core would
currently attempt to reinitialise an already active associated pinmux
configuration.

[ NB: For most examples above this is currently not a problem as the
devices reusing a node are never probed. ]

Other potential issues include the platform-bus code unconditionally
dropping the device-tree-node reference in its device destructor,
reinitialisation of other bus-managed resources such as clocks, and
(possibly) the recently added DMA-setup in driver core.

Instead of having drivers try to work around this (as is currently done
for USB root hubs), we can allow devices to reuse a device-tree node by
setting a flag in their struct device that can be used by core, bus and
driver code to avoid resources from being over-allocated.

The first two patches fix a device-tree node reference leak for
non-root-hub devices in USB. These were submitted yesterday to the USB
list, but are included here for completeness.

The third and fourth patches add a helper that can be used when reusing
a device-tree node of another device and that specifically sets a new
of_node_reused flag which is then used by driver core to skip the
automatic pinctrl configuration during probe.

The fifth patch removes the pinctrl over-allocation workaround from USB
core, which also had some undesirable side-effects.

The final two patches fix a device-tree node imbalance and
use-after-free in an thermal driver, where a platform device was reusing
the device-tree node of its parent mfd during probe. This would also
prevent the child device from being reprobed (e.g. due to probe
deferral) if the parent node defines a pinctrl configuration.

Note that this series is against 4.12-rc3.

For reference, here is a list of relevant commits leading up to the
current situation:

 - [2013-01-22] ab78029ecc34 ("drivers/pinctrl: grab default handles from device core")
 - [2016-02-19] 69bec7259853 ("USB: core: let USB device know device node")
 - [2016-04-25] dc5878abf49c ("usb: core: move root hub's device node assignment after it is added to bus")
 - [2016-10-06] 51fa91475e43 ("usb/core: Added devspec sysfs entry for devices behind the usb hub")
 - [2017-03-13] a8c06e407ef9 ("usb: separate out sysdev pointer from usb_bus")
 - [2017-04-10] 09515ef5ddad ("of/acpi: Configure dma operations at probe time for platform/amba/pci bus devices")

Greg, I'm not sure how best to handle merging this, but I guess all
could go in through driver-core-next to make handling dependencies
easier even if patches 1,2 and 6 could otherwise be considered for
4.12-rc.

Johan


Changes in v2
 - update kernel doc comment (2/7)
 - add missing kernel doc comment (3/7)
 - add Peter's and Linus's acks (1/7 and 4/7)


Johan Hovold (7):
  USB: core: fix device node leak
  USB: of: document reference taken by child-lookup helper
  driver core: add helper to reuse a device-tree node
  driver core: fix automatic pinctrl management
  USB: of: fix root-hub device-tree node handling
  thermal: max77620: fix device-node reference imbalance
  thermal: max77620: fix pinmux conflict on reprobe

 drivers/base/core.c                | 16 ++++++++++++++++
 drivers/base/pinctrl.c             |  3 +++
 drivers/thermal/max77620_thermal.c |  8 ++++++--
 drivers/usb/core/hcd.c             |  2 --
 drivers/usb/core/of.c              |  3 ++-
 drivers/usb/core/usb.c             |  2 ++
 include/linux/device.h             |  4 ++++
 7 files changed, 33 insertions(+), 5 deletions(-)

-- 
2.13.0
