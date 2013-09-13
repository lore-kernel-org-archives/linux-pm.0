From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH] drivers: cpuidle: rename ARM big.LITTLE driver config
 and makefile entries
Date: Fri, 13 Sep 2013 15:01:25 +0100
Message-ID: <20130913140125.GA2062@e102568-lin.cambridge.arm.com>
References: <1379071966-26757-1-git-send-email-lorenzo.pieralisi@arm.com>
 <5232FCD4.2070802@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:48232 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933243Ab3IMOBa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 13 Sep 2013 10:01:30 -0400
In-Reply-To: <5232FCD4.2070802@free-electrons.com>
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Kevin Hilman <khilman@linaro.org>, Olof Johansson <olof@lixom.net>, Daniel Lezcano <daniel.lezcano@linaro.org>

On Fri, Sep 13, 2013 at 12:53:56PM +0100, Gregory CLEMENT wrote:
> Hi Lorenzo,
> 
> On 13/09/2013 13:32, Lorenzo Pieralisi wrote:
> > Following the reorganization of CPU idle drivers configurations into an ARM
> > specific Kconfig, the existing idle drivers Kconfig entries were renamed and
> > moved to the Kconfig.arm file. Makefile entries were updated accordingly.
> > 
> > This patch renames the entries in Kconfig.arm and makefile to make the newly
> > added big.LITTLE CPUidle driver compliant with the new naming convention.
> 
> Do you also consider to reorder the entries in alphabetic order?
> It should help to reduce the merge conflict.

Sure, here it is, thanks for pointing that out.

Lorenzo

-- >8 --
Subject: [PATCH] drivers: cpuidle: rename ARM big.LITTLE driver config and
 makefile entries

Following the reorganization of CPU idle drivers configurations into an ARM
specific Kconfig, the existing idle drivers Kconfig entries were renamed and
moved to the Kconfig.arm file. Makefile entries were updated accordingly.

This patch renames the entries in Kconfig.arm and makefile to make the newly
added big.LITTLE CPUidle driver compliant with the new naming convention.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 drivers/cpuidle/Kconfig.arm | 22 +++++++++++-----------
 drivers/cpuidle/Makefile    |  2 +-
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/cpuidle/Kconfig.arm b/drivers/cpuidle/Kconfig.arm
index 8e36603..6a7e6f2 100644
--- a/drivers/cpuidle/Kconfig.arm
+++ b/drivers/cpuidle/Kconfig.arm
@@ -2,6 +2,17 @@
 # ARM CPU Idle drivers
 #
 
+config ARM_BIG_LITTLE_CPUIDLE
+	bool "Support for ARM big.LITTLE processors"
+	depends on ARCH_VEXPRESS_TC2_PM
+	select ARM_CPU_SUSPEND
+	select CPU_IDLE_MULTIPLE_DRIVERS
+	help
+	  Select this option to enable CPU idle driver for big.LITTLE based
+	  ARM systems. Driver manages CPUs coordination through MCPM and
+	  define different C-states for little and big cores through the
+	  multiple CPU idle drivers infrastructure.
+
 config ARM_HIGHBANK_CPUIDLE
 	bool "CPU Idle Driver for Calxeda processors"
 	depends on ARCH_HIGHBANK
@@ -26,14 +37,3 @@ config ARM_U8500_CPUIDLE
 	depends on ARCH_U8500
 	help
 	  Select this to enable cpuidle for ST-E u8500 processors
-
-config CPU_IDLE_BIG_LITTLE
-	bool "Support for ARM big.LITTLE processors"
-	depends on ARCH_VEXPRESS_TC2_PM
-	select ARM_CPU_SUSPEND
-	select CPU_IDLE_MULTIPLE_DRIVERS
-	help
-	  Select this option to enable CPU idle driver for big.LITTLE based
-	  ARM systems. Driver manages CPUs coordination through MCPM and
-	  define different C-states for little and big cores through the
-	  multiple CPU idle drivers infrastructure.
diff --git a/drivers/cpuidle/Makefile b/drivers/cpuidle/Makefile
index cea5ef5..d08bd40 100644
--- a/drivers/cpuidle/Makefile
+++ b/drivers/cpuidle/Makefile
@@ -7,8 +7,8 @@ obj-$(CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED) += coupled.o
 
 ##################################################################################
 # ARM SoC drivers
+obj-$(CONFIG_ARM_BIG_LITTLE_CPUIDLE)	+= cpuidle-big_little.o
 obj-$(CONFIG_ARM_HIGHBANK_CPUIDLE)	+= cpuidle-calxeda.o
 obj-$(CONFIG_ARM_KIRKWOOD_CPUIDLE)	+= cpuidle-kirkwood.o
 obj-$(CONFIG_ARM_ZYNQ_CPUIDLE)		+= cpuidle-zynq.o
 obj-$(CONFIG_ARM_U8500_CPUIDLE)         += cpuidle-ux500.o
-obj-$(CONFIG_CPU_IDLE_BIG_LITTLE)	+= cpuidle-big_little.o
-- 
1.8.2.2


