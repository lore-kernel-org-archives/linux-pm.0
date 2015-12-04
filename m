From: Eric Anholt <eric@anholt.net>
Subject: [PATCH v2 0/5] Raspberry Pi power domains v2
Date: Fri,  4 Dec 2015 09:45:43 -0800
Message-ID: <1449251148-19344-1-git-send-email-eric@anholt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Florian Fainelli <f.fainelli@gmail.com>, Alexander Aring <alex.aring@gmail.com>, Pawel Moll <pawel.moll@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Eric Anholt <eric@anholt.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org, Lee Jones <lee@kernel.org>, linux-kernel@vger.kernel.org, Kevin Hilman <khilman@kernel.org>, Rob Herring <robh+dt@kernel.org>, linux-rpi-kernel@lists.infradead.org, Ian Campbell <ijc+devicetree@hellion.org.uk>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

This is a series to replace Alexander Aring's power domains
submission.  It uses a new firmware interface to add support for the
other power domains in the system, which I needed for the 3D support,
while still supporting the USB domain on older firmwares.  It also
drops the static declarations, so that the driver instance is entirely
contained inside of the device.

Alexander Aring (4):
  power: domain: add pm_genpd_exit
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
 arch/arm/mach-bcm/raspberrypi-power.c              | 269 +++++++++++++++++++++
 drivers/base/power/domain.c                        |  22 ++
 include/dt-bindings/arm/raspberrypi-power.h        |  41 ++++
 include/linux/pm_domain.h                          |   4 +
 include/soc/bcm2835/raspberrypi-firmware.h         |   2 +
 10 files changed, 408 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-power.txt
 create mode 100644 arch/arm/mach-bcm/raspberrypi-power.c
 create mode 100644 include/dt-bindings/arm/raspberrypi-power.h

-- 
2.6.2
