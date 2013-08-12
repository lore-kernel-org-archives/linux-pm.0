From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [GIT PULL] ARM: TC2: CPU idle big.LITTLE driver
Date: Mon, 12 Aug 2013 16:34:22 +0100
Message-ID: <20130812153422.GA6426@e102568-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:54502 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757105Ab3HLPe2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 12 Aug 2013 11:34:28 -0400
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: olof@lixom.net, khilman@linaro.org
Cc: linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, nicolas.pitre@linaro.org, daniel.lezcano@linaro.org

Hi Olof, Kevin,

please pull this patch series that provides a CPU idle driver for the vexpress
TC2 testchip, and it is a stepping stone towards an ARM unified CPU idle driver
based on the MCPM framework.

Series is based against this pull request from Pawel which is a strict
dependency and they must be merged in order:

http://lists.infradead.org/pipermail/linux-arm-kernel/2013-August/190067.html

Thanks !!
Lorenzo

The following changes since commit 2d6746c48076fd56619f11cdd5c74656ea8cde48:

  ARM: vexpress/TC2: implement PM suspend method (2013-08-12 10:59:13 +0100)

are available in the git repository at:

  git://linux-arm.org/linux-2.6-lp.git tags/cpuidle-bL

for you to fetch changes up to 04c40064928d3a1eb50e4ea3883765b9cfcb0f73:

  cpuidle: big.LITTLE: vexpress-TC2 CPU idle driver (2013-08-12 10:59:14 +0100)

----------------------------------------------------------------
This patch series contains:

- GIC driver update to add a method to disable the GIC CPU IF
- TC2 MCPM update to add GIC CPU disabling to suspend method
- TC2 CPU idle big.LITTLE driver

----------------------------------------------------------------
Lorenzo Pieralisi (2):
      ARM: vexpress: tc2: disable GIC CPU IF in tc2_pm_suspend
      cpuidle: big.LITTLE: vexpress-TC2 CPU idle driver

Nicolas Pitre (1):
      drivers: irq-chip: irq-gic: introduce gic_cpu_if_down()

 MAINTAINERS                          |   9 ++
 arch/arm/mach-vexpress/tc2_pm.c      |   2 +
 drivers/cpuidle/Kconfig              |  10 ++
 drivers/cpuidle/Makefile             |   1 +
 drivers/cpuidle/cpuidle-big_little.c | 209 +++++++++++++++++++++++++++++++++++
 drivers/irqchip/irq-gic.c            |   6 +
 include/linux/irqchip/arm-gic.h      |   1 +
 7 files changed, 238 insertions(+)
 create mode 100644 drivers/cpuidle/cpuidle-big_little.c

