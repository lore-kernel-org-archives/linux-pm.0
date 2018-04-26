From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v8 0/6] typec: tcpm: Add sink side support for PPS
Date: Thu, 26 Apr 2018 09:33:26 +0200
Message-ID: <20180426073326.GA12261@kroah.com>
References: <cover.1524490253.git.Adam.Thomson.Opensource@diasemi.com>
 <20180424135749.GA21610@kroah.com>
 <20180424232633.s475bsccxjhm7lpy@earth.universe>
 <20180425123045.GA22950@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180425123045.GA22950@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Guenter Roeck <linux@roeck-us.net>, Hans de Goede <hdegoede@redhat.com>, Jun Li <jun.li@nxp.com>, linux-usb@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, support.opensource@diasemi.com
List-Id: linux-pm@vger.kernel.org

On Wed, Apr 25, 2018 at 02:30:45PM +0200, Greg Kroah-Hartman wrote:
> On Wed, Apr 25, 2018 at 01:26:33AM +0200, Sebastian Reichel wrote:
> > Hi Greg,
> > 
> > On Tue, Apr 24, 2018 at 03:57:49PM +0200, Greg Kroah-Hartman wrote:
> > > On Mon, Apr 23, 2018 at 03:10:55PM +0100, Adam Thomson wrote:
> > > > This patch set adds sink side support for the PPS feature introduced in the
> > > > USB PD 3.0 specification.
> > > > 
> > > > The source PPS supply is represented using the Power Supply framework to provide
> > > > access and control APIs for dealing with it's operating voltage and current,
> > > > and switching between a standard PDO and PPS APDO operation. During standard PDO
> > > > operation the voltage and current is read-only, but for APDO PPS these are
> > > > writable as well to allow for control.
> > > > 
> > > > It should be noted that the keepalive for PPS is not handled within TCPM. The
> > > > expectation is that the external user will be required to ensure re-requests
> > > > occur regularly to ensure PPS remains and the source does not hard reset.
> > > 
> > > Sebastian, any objection from me taking this series through my USB tree?
> > 
> > I currently have the power-supply bits in a local branch for
> > testing. I would like to have this in the power-supply
> > tree, since there is at least one pending driver which could
> > directly use the newly introduced usb_type.
> > 
> > I can either provide an immutable branch with a signed tag, or
> > you can merged it and provide me an immutable branch.
> > 
> > If you merge it via the USB tree patch 2-4 are
> > 
> > Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
> 
> I've applied these to a testing branch in my usb tree, and if they
> survive the 0-day bot, I'll move them to a branch that you can pull from
> that will not change.
> 
> Oh, I had to add a follow-on patch to fix up a gcc warning that really
> wasn't a warning, but it saves us problems of people complaining about
> it.

All looks good now.

Here's the signed tag you can pull from, with the full information of
all of the other USB patches that you are going to be getting here
(sorry about that).

thanks,

greg k-h

-----------------

The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:

  Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git/ tags/tcpm-pps-4.18

for you to fetch changes up to 0c718676ab3f02e98e85e7049e03d2879c62cb10:

  typec: tcpm: fix compiler warning about stupid things (2018-04-25 14:24:34 +0200)

----------------------------------------------------------------
Tag/Merge point for adding typeC power supply support

This is a signed tag/merge point to handle the cross-tree merge of the
USB and power supply subsystems for the patch series:
	Subject: [PATCH v8 0/6] typec: tcpm: Add sink side support for PPS

It is based on the usb.git tree, in the usb-next branch, for merging in
4.18-rc1.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Adam Thomson (6):
      typec: tcpm: Add core support for sink side PPS
      Documentation: power: Initial effort to document power_supply ABI
      power: supply: Add error checking of psy desc during registration
      power: supply: Add 'usb_type' property and supporting code
      typec: tcpm: Represent source supply through power_supply
      typec: tcpm: Add support for sink PPS related messages

Dmitry Osipenko (3):
      usb: phy: tegra: Cleanup error messages
      usb: tegra: Move utmi-pads reset from ehci-tegra to tegra-phy
      usb: phy: Add Kconfig entry for Tegra PHY driver

Dominik Bozek (1):
      usb: hub: Don't wait for connect state at resume for powered-off ports

Geert Uytterhoeven (1):
      usb: Remove depends on HAS_DMA in case of platform dependency

Greg Kroah-Hartman (1):
      typec: tcpm: fix compiler warning about stupid things

Gregory CLEMENT (2):
      usb: host: xhci-plat: Remove useless test before clk_disable_unprepare
      usb: host: xhci-plat: Fix clock resource by adding a register clock

Gustavo A. R. Silva (1):
      usb: core: hcd: mark expected switch fall-through

Jia-Ju Bai (3):
      usb: storage: Replace mdelay with msleep in init_freecom
      usb: isp1760: Replace mdelay with msleep in isp1760_init_core
      usb: isp1760: Replace mdelay with msleep in isp1760_stop

Johan Hovold (6):
      USB: phy: drop unused legacy controller-phy bind helper
      USB: core: hcd: drop support for legacy phys
      USB: ehci-omap: drop unused legacy phy support
      USB: musb: omap2430: drop non-DT support
      USB: renesas_usbhs: drop unused legacy-phy support
      USB: phy: drop legacy board-file support

Li Jun (5):
      usb: typec: tcpm: pdo matching optimization
      usb: typec: fusb302: remove max_snk_* for sink config
      dt-bindings: usb: fusb302: remove max-sink-* properties
      usb: typec: wcove: remove max_snk_* for sink config
      usb: typec: tcpm: remove max_snk_mv/ma/mw

Mathias Nyman (6):
      usb: define HCD_USB32 speed option for hosts that support USB 3.2 dual-lane
      USB: Add support to store lane count used by USB 3.2
      usb: set root hub lane counts
      USB: show USB 3.2 Dual-lane devices as Gen Xx2 during device enumeration
      USB: USB 3.2 Add sysfs entries for a usb device rx_lanes and tx_lanes
      Documentation sysfs-bus-usb: Add rx_lanes and tx_lanes introduced in USB 3.2

Maxim Moseychuk (1):
      usb: do not reset if a low-speed or full-speed device timed out

ShuFan Lee (2):
      staging: typec: rt1711h typec chip driver
      dt-bindings: usb: rt1711h device tree binding document

Shuah Khan (1):
      usbip: usbip_host: refine probe and disconnect debug msgs to be useful

Souptick Joarder (1):
      usb: mon: Change return type to vm_fault_t

Takashi Iwai (1):
      usb: audio-v2: Correct the comment for struct uac_clock_selector_descriptor

Wei Yongjun (1):
      usb: roles: Fix potential NULL dereference in intel_xhci_usb_probe()

Wolfram Sang (2):
      usb: phy: simplify getting .drvdata
      usb: mtu3: simplify getting .drvdata

Yossi Mansharoff (1):
      doc: usb: ci-hdrc-usb2: Add property "mux-controls"

 Documentation/ABI/testing/sysfs-bus-usb            |   18 +
 Documentation/ABI/testing/sysfs-class-power        |  455 +++++++++
 .../devicetree/bindings/usb/ci-hdrc-usb2.txt       |    6 +
 .../devicetree/bindings/usb/fcs,fusb302.txt        |    6 -
 .../devicetree/bindings/usb/richtek,rt1711h.txt    |   17 +
 Documentation/devicetree/bindings/usb/usb-xhci.txt |    5 +-
 MAINTAINERS                                        |    1 +
 drivers/power/supply/power_supply_core.c           |   11 +-
 drivers/power/supply/power_supply_sysfs.c          |   45 +
 drivers/staging/typec/Kconfig                      |    8 +
 drivers/staging/typec/Makefile                     |    1 +
 drivers/staging/typec/tcpci.h                      |    1 +
 drivers/staging/typec/tcpci_rt1711h.c              |  312 ++++++
 drivers/usb/core/hcd.c                             |   47 +-
 drivers/usb/core/hub.c                             |   23 +-
 drivers/usb/core/sysfs.c                           |   22 +
 drivers/usb/gadget/udc/Kconfig                     |    4 +-
 drivers/usb/host/Kconfig                           |    4 +-
 drivers/usb/host/ehci-omap.c                       |    5 +-
 drivers/usb/host/ehci-tegra.c                      |   87 +-
 drivers/usb/host/xhci-plat.c                       |   31 +-
 drivers/usb/host/xhci.h                            |    3 +-
 drivers/usb/isp1760/isp1760-core.c                 |    2 +-
 drivers/usb/isp1760/isp1760-hcd.c                  |    2 +-
 drivers/usb/mon/mon_bin.c                          |    2 +-
 drivers/usb/mtu3/Kconfig                           |    2 +-
 drivers/usb/mtu3/mtu3_plat.c                       |    6 +-
 drivers/usb/musb/omap2430.c                        |   95 +-
 drivers/usb/phy/Kconfig                            |    9 +
 drivers/usb/phy/Makefile                           |    2 +-
 drivers/usb/phy/phy-am335x.c                       |    6 +-
 drivers/usb/phy/phy-tegra-usb.c                    |  140 ++-
 drivers/usb/phy/phy.c                              |  133 +--
 drivers/usb/renesas_usbhs/common.h                 |    1 -
 drivers/usb/renesas_usbhs/rcar2.c                  |   29 -
 drivers/usb/roles/intel-xhci-usb-role-switch.c     |    2 +
 drivers/usb/storage/freecom.c                      |    4 +-
 drivers/usb/typec/Kconfig                          |    1 +
 drivers/usb/typec/fusb302/Kconfig                  |    2 +-
 drivers/usb/typec/fusb302/fusb302.c                |  105 +-
 drivers/usb/typec/tcpm.c                           | 1059 ++++++++++++++++++--
 drivers/usb/typec/typec_wcove.c                    |    4 +-
 drivers/usb/usbip/stub_dev.c                       |    4 +-
 include/linux/power_supply.h                       |   16 +
 include/linux/usb.h                                |    4 +
 include/linux/usb/audio-v2.h                       |    2 +-
 include/linux/usb/hcd.h                            |    2 +-
 include/linux/usb/pd.h                             |    4 +-
 include/linux/usb/phy.h                            |   36 -
 include/linux/usb/tcpm.h                           |   10 +-
 include/linux/usb/tegra_usb_phy.h                  |    2 +
 include/uapi/linux/usb/ch11.h                      |    5 +
 52 files changed, 2240 insertions(+), 563 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/usb/richtek,rt1711h.txt
 create mode 100644 drivers/staging/typec/tcpci_rt1711h.c
