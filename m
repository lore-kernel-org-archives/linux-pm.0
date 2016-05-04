From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [GIT PULL] ARM: dts: exynos: Devfreq for v4.7
Date: Wed, 04 May 2016 15:05:36 +0200
Message-ID: <1462367136-28627-1-git-send-email-k.kozlowski@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout3.w1.samsung.com ([210.118.77.13]:8571 "EHLO
	mailout3.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750862AbcEDNFv (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 4 May 2016 09:05:51 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>, Kevin Hilman <khilman@kernel.org>, arm@kernel.org
Cc: Kukjin Kim <kgene@kernel.org>, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, myungjoo.ham@samsung.com, cw00.choi@samsung.com, linux-pm@vger.kernel.org, rjw@rjwysocki.net

Hi,


Topic branch with DTS changes for v4.7, adding nodes for new generic
devfreq driver. The devfreq driver will support Exynos3250, 4210, 4212,
4412 and 542x.

This is a long work of Chanwoo Choi, recently merged (including
documentation of bindings) by devfreq maintainer, MyungJoo Ham:
http://permalink.gmane.org/gmane.linux.power-management.general/75599


This pull request includes dependency: changes coming from clk tree
with a clk-v4.7-exynos542x tag.

Below you will find full log. At the end - only commits existing
in my tree.


Best regards,
Krzysztof

Cc: myungjoo.ham@samsung.com
Cc: cw00.choi@samsung.com
Cc: linux-pm@vger.kernel.org
Cc: rjw@rjwysocki.net


The following changes since commit f55532a0c0b8bb6148f4e07853b876ef73bc69ca:

  Linux 4.6-rc1 (2016-03-26 16:03:24 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-dt-devfreq-4.7

for you to fetch changes up to 3f2129fd0daeaf9e60a51f9ebd2d9faabb437308:

  ARM: dts: exynos: Add support of Bus frequency using VDD_INT for exynos5422-odroidxu3 (2016-05-03 12:27:52 +0200)

----------------------------------------------------------------
Topic branch for Device Tree changes adding new generic devfreq driver, for
v4.7:
1. Add bus nodes for Exynos3250, Exynos4x12, Exynos4210 and Exynos542x.
2. Split out common PPMU (Performance Monitoring Unit) nodes into separate
   DTSI. The PPMU provides performance data for devfreq.
3. Add NoCP (Network on Chip Probe) node for Exynos542x. On this SoC, like PPMU
   on older designs, provides performance data for devfreq.
4. Enable DFVS (Dynamic Voltage and Frequency Scaling) on boards:
   - Exynos3250 Rinato,
   - Exynos4412 Odroid-X/X2/U3 and Trats2,
   - Exynos5422 Odroid XU3/XU3-Lite/XU4.

----------------------------------------------------------------
Chanwoo Choi (15):
      dt-bindings: clock: Add the clock id for ACLK clock of Exynos542x SoC
      clk: samsung: exynos542x: Add the clock id for ACLK
      ARM: dts: exynos: Add DMC bus node for Exynos3250
      ARM: dts: exynos: Add DMC bus frequency for exynos3250-rinato/monk
      ARM: dts: exynos: Add bus nodes using VDD_INT for Exynos3250
      ARM: dts: exynos: Add bus nodes using VDD_MIF for Exynos4x12
      ARM: dts: exynos: Add bus nodes using VDD_INT for Exynos4x12
      ARM: dts: exynos: Add bus nodes using VDD_MIF for Exynos4210
      ARM: dts: exynos: Add exynos4412-ppmu-common dtsi to delete duplicate PPMU nodes
      ARM: dts: exynos: Add support of bus frequency using VDD_INT for exynos3250-rinato
      ARM: dts: exynos: Expand the voltage range of buck1/3 regulator for exynos4412-odroidu3
      ARM: dts: exynos: Add support of bus frequency for exynos4412-trats/odroidu3
      ARM: dts: exynos: Add NoC Probe dt node for Exynos542x SoC
      ARM: dts: exynos: Add bus nodes using VDD_INT for Exynos542x SoC
      ARM: dts: exynos: Add support of Bus frequency using VDD_INT for exynos5422-odroidxu3

Krzysztof Kozlowski (1):
      Merge tag 'clk-v4.7-exynos542x' of git://linuxtv.org/snawrocki/samsung into for-v4.7-late/dts-exynos-devfreq

 arch/arm/boot/dts/exynos3250-monk.dts              |  47 +--
 arch/arm/boot/dts/exynos3250-rinato.dts            |  88 +++--
 arch/arm/boot/dts/exynos3250.dtsi                  | 181 +++++++++
 arch/arm/boot/dts/exynos4210.dtsi                  | 159 ++++++++
 arch/arm/boot/dts/exynos4412-odroid-common.dtsi    |  56 ++-
 arch/arm/boot/dts/exynos4412-ppmu-common.dtsi      |  50 +++
 arch/arm/boot/dts/exynos4412-trats2.dts            |  88 +++--
 arch/arm/boot/dts/exynos4x12.dtsi                  | 174 +++++++++
 arch/arm/boot/dts/exynos5420.dtsi                  | 407 +++++++++++++++++++++
 arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi |  99 +++++
 drivers/clk/samsung/clk-exynos5420.c               |  77 ++--
 include/dt-bindings/clock/exynos5420.h             |  24 +-
 12 files changed, 1295 insertions(+), 155 deletions(-)
 create mode 100644 arch/arm/boot/dts/exynos4412-ppmu-common.dtsi

----------------------------------------------------------------


Commits only in samsung-soc:
----------------------------------------------------------------
Chanwoo Choi (13):
      ARM: dts: exynos: Add DMC bus node for Exynos3250
      ARM: dts: exynos: Add DMC bus frequency for exynos3250-rinato/monk
      ARM: dts: exynos: Add bus nodes using VDD_INT for Exynos3250
      ARM: dts: exynos: Add bus nodes using VDD_MIF for Exynos4x12
      ARM: dts: exynos: Add bus nodes using VDD_INT for Exynos4x12
      ARM: dts: exynos: Add bus nodes using VDD_MIF for Exynos4210
      ARM: dts: exynos: Add exynos4412-ppmu-common dtsi to delete duplicate PPMU nodes
      ARM: dts: exynos: Add support of bus frequency using VDD_INT for exynos3250-rinato
      ARM: dts: exynos: Expand the voltage range of buck1/3 regulator for exynos4412-odroidu3
      ARM: dts: exynos: Add support of bus frequency for exynos4412-trats/odroidu3
      ARM: dts: exynos: Add NoC Probe dt node for Exynos542x SoC
      ARM: dts: exynos: Add bus nodes using VDD_INT for Exynos542x SoC
      ARM: dts: exynos: Add support of Bus frequency using VDD_INT for exynos5422-odroidxu3

 arch/arm/boot/dts/exynos3250-monk.dts              |  47 +--
 arch/arm/boot/dts/exynos3250-rinato.dts            |  88 +++--
 arch/arm/boot/dts/exynos3250.dtsi                  | 181 +++++++++
 arch/arm/boot/dts/exynos4210.dtsi                  | 159 ++++++++
 arch/arm/boot/dts/exynos4412-odroid-common.dtsi    |  56 ++-
 arch/arm/boot/dts/exynos4412-ppmu-common.dtsi      |  50 +++
 arch/arm/boot/dts/exynos4412-trats2.dts            |  88 +++--
 arch/arm/boot/dts/exynos4x12.dtsi                  | 174 +++++++++
 arch/arm/boot/dts/exynos5420.dtsi                  | 407 +++++++++++++++++++++
 arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi |  99 +++++
 10 files changed, 1225 insertions(+), 124 deletions(-)
 create mode 100644 arch/arm/boot/dts/exynos4412-ppmu-common.dtsi
