From: Alexander Aring <alex.aring-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 0/3] ARM: bcm2835: add support for rpi power domain driver
Date: Thu, 19 Nov 2015 19:08:07 +0100
Message-ID: <1447956490-22930-1-git-send-email-alex.aring@gmail.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, rjui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, sbranden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, pavel-+ZI9xUNit7I@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, Alexander Aring <alex.aring-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Hi,

this patch series contains at first a patch for the power domain subsystem
which offers to uninit generic power domains when init was called before.

The RPi Power-Domains need to be enabled/disabled by interacting with the
RPi firmware which can fail. To cleanup the probing we need to undo the
power domains again which was registered before.

- Alex

changes since PATCH (was RFCv2 before):
 - add WARN_ON_ONCE if there are still references from generic power domain
   inside the power domain subsystem when running pm_genpd_uninit.
 - add mutex_destroy when running pm_genpd_uninit.
 - split devicetree binding for rpi power domain driver into a separate patch.
 - rename config RASPBERRY_POWER to RASPBERRYPI_POWER
 - order list of <linux/...> includes alphabetical.
 - use rpi_ prefix than raspberrypi_ prefix.
 - rename _DT_BINDINGS_ARM_BCM2835_MBOX_POWER_H to _DT_BINDINGS_ARM_BCM2835_RPI_POWER_H

changes since RFCv2:
 - add pm_genpd_uninit to handle probing failure.
 - move power domain drive to his own driver in arch/arm/mach-bcm/
   Also add own devicetree node for this driver, "raspberrypi,bcm2835-power".
 - Removing all power domains which might exists for the firmware API but
   we currently have no use-case for it. I tried to keep the same domain
   numbering in generic power domains subsystem like they are offered from
   the firmware API. This works, all power_domains which are NULL inside
   the array of genpd_onecell_data.domains[#] will be ignored.
 - Adding Eric Anholt and me to the authors.
 - Creating devicetree documentation for the power domain driver.
 - fix error handling in raspberrypi_firmware_set_power.
 - Remove comment about mapping between power domains array, this is not
   necessary anymore. I add a "enabled" attribute to raspberrypi_power_domain
   which indicates if a domain should be registered or not (zeroed values
   does not indicate such handling, but enabled is false then).
 - remove "goto mbox" not necessary anymore because an own driver
   implementation.
 - Update devicetrees for changes in v2.

Alexander Aring (3):
  power: domain: add pm_genpd_uninit
  ARM: bcm2835: add rpi power domain driver
  devicetree: add rpi power domain driver bindings

 .../bindings/arm/bcm/raspberrypi,bcm2835-power.txt |  25 +++
 arch/arm/boot/dts/bcm2835-rpi.dtsi                 |  11 ++
 arch/arm/boot/dts/bcm2835.dtsi                     |   2 +-
 arch/arm/mach-bcm/Kconfig                          |  10 ++
 arch/arm/mach-bcm/Makefile                         |   1 +
 arch/arm/mach-bcm/raspberrypi-power.c              | 180 +++++++++++++++++++++
 drivers/base/power/domain.c                        |  22 +++
 include/dt-bindings/arm/raspberrypi-power.h        |  14 ++
 include/linux/pm_domain.h                          |   4 +
 9 files changed, 268 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-power.txt
 create mode 100644 arch/arm/mach-bcm/raspberrypi-power.c
 create mode 100644 include/dt-bindings/arm/raspberrypi-power.h

-- 
2.6.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
