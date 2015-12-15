From: Eric Anholt <eric@anholt.net>
Subject: [PATCH v3 0/4] Raspberry Pi power domains
Date: Tue, 15 Dec 2015 13:40:18 -0800
Message-ID: <1450215622-27394-1-git-send-email-eric@anholt.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-arm-kernel@lists.infradead.org, linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Stephen Warren <swarren@wwwdotorg.org>, Lee Jones <lee@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alexander Aring <alex.aring@gmail.com>, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Eric Anholt <eric@anholt.net>
List-Id: linux-pm@vger.kernel.org

Since the pm_genpd_exit() patch is still going through review, and
other drivers in the tree just ignore the error cases, Ulf offered to
merge the series as a builtin driver not depending on that interface.
We still avoid dangling pointer references, by just continuing with
probing if of_genpd_add_provider_onecell() fails.  We can easily go
back and update the driver when a pm_genpd_exit() lands.

Alexander Aring (3):
  ARM: bcm2835: add rpi power domain driver
  dt-bindings: add rpi power domain driver bindings
  ARM: bcm2835: Add the Raspberry Pi power domain driver to the DT.

Eric Anholt (1):
  ARM: bcm2835: Define two new packets from the latest firmware.

 .../bindings/arm/bcm/raspberrypi,bcm2835-power.txt |  47 ++++
 arch/arm/boot/dts/bcm2835-rpi.dtsi                 |  11 +
 arch/arm/boot/dts/bcm2835.dtsi                     |   2 +-
 arch/arm/mach-bcm/Kconfig                          |  10 +
 arch/arm/mach-bcm/Makefile                         |   1 +
 arch/arm/mach-bcm/raspberrypi-power.c              | 247 +++++++++++++++++++++
 include/dt-bindings/arm/raspberrypi-power.h        |  41 ++++
 include/soc/bcm2835/raspberrypi-firmware.h         |   2 +
 8 files changed, 360 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-power.txt
 create mode 100644 arch/arm/mach-bcm/raspberrypi-power.c
 create mode 100644 include/dt-bindings/arm/raspberrypi-power.h

-- 
2.6.2
