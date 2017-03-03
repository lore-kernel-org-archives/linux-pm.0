From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH V10 0/6] thermal: bcm2835: add thermal driver for bcm2835 SoC
Date: Fri,  3 Mar 2017 23:18:43 +0000
Message-ID: <1488583129-4159-1-git-send-email-stefan.wahren@i2se.com>
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
To: Eric Anholt <eric@anholt.net>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: Stefan Wahren <stefan.wahren@i2se.com>, devicetree@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>, linux-pm@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Rob Herring <robh+dt@kernel.org>, linux-rpi-kernel@lists.infradead.org, Martin Sperl <kernel@martin.sperl.org>, Frank Rowand <frowand.list@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

This is an attempt to finish Martin's great work on the bcm2835 thermal driver.
It includes now all Eduardo's suggestions and the explanations from the
Raspberry Pi forum [1].

ChangeLog:
V1 -> V2: added specific settings depending on compatiblity
added trip point based on register
setting up ctrl-register if HW is not enabled by firmware
as per recommendation of Eric (untested)
check that clock frequency is in range
(1.9 - 5MHz - as per comment in clk-bcm2835.c)
V2 -> V4: moved back to thermal (not using bcm sub-directory)
set polling interval to 1second (was 0ms, so interrupt driven)
V5 -> V6: added correct depends in KConfig
removed defined default for RESET_DELAY
removed obvious comments
clarify HW setup comments if not set up by FW already
move clk_prepare_enable to an earlier stage and add error handling
clarify warning when TS-clock runs out of recommended range
clk_disable_unprepare added in bcm2835_thermal_remove
added comment on recommended temperature ranges for SOC
V6 -> V7: removed depends on ARCH_BCM2836 || ARCH_BCM2837 in Kconfig
V7 -> V8: rebased
V8 -> V9: moved to use the thermal framework offset and slope in
thermal_zone_parameters as per request
V9 -> V10: implement support for thermal zone descriptor, define offset and
slope within DT, apply forum explanations, replace symbolic with octal
permissions

[1] - https://www.raspberrypi.org/forums/viewtopic.php?f=72&t=160289&p=1040448

Martin Sperl (1):
  thermal: bcm2835: add thermal driver for bcm2835 SoC

Stefan Wahren (5):
  of: base: Implement read function for s32 array
  thermal: of-thermal: Implement signed coefficient support
  dt-bindings: Add thermal zone to bcm2835-thermal example
  ARM: dts: bcm283x: Add CPU thermal zone with 1 trip point
  ARM64: dts: bcm2837: Define CPU thermal coefficients

 .../bindings/thermal/brcm,bcm2835-thermal.txt      |   32 +-
 arch/arm/boot/dts/bcm2835.dtsi                     |    4 +
 arch/arm/boot/dts/bcm2836.dtsi                     |    4 +
 arch/arm/boot/dts/bcm283x.dtsi                     |   21 ++
 arch/arm64/boot/dts/broadcom/bcm2837.dtsi          |    4 +
 drivers/thermal/Kconfig                            |    8 +
 drivers/thermal/Makefile                           |    1 +
 drivers/thermal/bcm2835_thermal.c                  |  319 ++++++++++++++++++++
 drivers/thermal/of-thermal.c                       |    5 +-
 include/linux/of.h                                 |   35 +++
 10 files changed, 427 insertions(+), 6 deletions(-)
 create mode 100644 drivers/thermal/bcm2835_thermal.c

-- 
1.7.9.5
