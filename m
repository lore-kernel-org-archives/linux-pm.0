From: Eric Anholt <eric@anholt.net>
Subject: [PATCH v4 0/4] Raspberry Pi power domains
Date: Wed, 16 Dec 2015 16:26:45 -0800
Message-ID: <1450312009-1791-1-git-send-email-eric@anholt.net>
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
To: linux-rpi-kernel@lists.infradead.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Florian Fainelli <f.fainelli@gmail.com>, Pawel Moll <pawel.moll@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Kevin Hilman <khilman@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org, Lee Jones <lee@kernel.org>, linux-kernel@vger.kernel.org, Eric Anholt <eric@anholt.net>, Rob Herring <robh+dt@kernel.org>, Alexander Aring <alex.aring@gmail.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Update from v3 to move the driver under drivers/soc.  I've placed it
under drivers/soc/bcm since that's how the other drivers under
drivers/soc are structured.

Alexander Aring (3):
  ARM: bcm2835: add rpi power domain driver
  dt-bindings: add rpi power domain driver bindings
  ARM: bcm2835: Add the Raspberry Pi power domain driver to the DT.

Eric Anholt (1):
  ARM: bcm2835: Define two new packets from the latest firmware.

 .../bindings/soc/bcm/raspberrypi,bcm2835-power.txt |  47 ++++
 arch/arm/boot/dts/bcm2835-rpi.dtsi                 |  11 +
 arch/arm/boot/dts/bcm2835.dtsi                     |   2 +-
 drivers/soc/Kconfig                                |   1 +
 drivers/soc/Makefile                               |   1 +
 drivers/soc/bcm/Kconfig                            |   9 +
 drivers/soc/bcm/Makefile                           |   1 +
 drivers/soc/bcm/raspberrypi-power.c                | 247 +++++++++++++++++++++
 include/dt-bindings/soc/raspberrypi-power.h        |  41 ++++
 include/soc/bcm2835/raspberrypi-firmware.h         |   2 +
 10 files changed, 361 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/soc/bcm/raspberrypi,bcm2835-power.txt
 create mode 100644 drivers/soc/bcm/Kconfig
 create mode 100644 drivers/soc/bcm/Makefile
 create mode 100644 drivers/soc/bcm/raspberrypi-power.c
 create mode 100644 include/dt-bindings/soc/raspberrypi-power.h

-- 
2.6.2
