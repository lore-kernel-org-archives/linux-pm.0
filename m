From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: [PATCH v2 0/4] Add standby support for the recent mvebu SoCs
Date: Tue, 30 Jun 2015 19:18:56 +0200
Message-ID: <1435684740-24912-1-git-send-email-gregory.clement@free-electrons.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:50927 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750821AbbF3RUb (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 30 Jun 2015 13:20:31 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Maxime Ripard <maxime.ripard@free-electrons.com>, Boris BREZILLON <boris.brezillon@free-electrons.com>, Lior Amsalem <alior@marvell.com>, Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

Hi,

Until now only few mvebu v7 based board supported suspend to ram. This
suspend to ram mode was unusual because it involved shutting down the
SoC and relied on a PIC to wake up the system.

However, most of the recent mvebu SoCs can support the standby
mode. Unlike for the suspend to ram, nothing special have to be done
for these SoCs. In this mode the SoCs go in idle mode (but they remain
powered up) and the devices enter in suspend mode. The support itself
was added in the patch 2.

In order to wake-up the interrupt controller driver have been
updated. As in standby mode the interrupt controller is not shutdown,
any interrupt can be a wake-up source. So the GIC (patch 3) now used
the flags IRQCHIP_SKIP_SET_WAKE and IRQCHIP_MASK_ON_SUSPEND.

A wake up source is supposed to work in suspend _and_ in standby mode
but for the mvebu SoCs, no interrupt can wake up the system. The last
patch warns the user about it.

The first patch is a clean-up found while working on this series

This series was applied on top of Thomas' series "ARM: mvebu: add
suspend to RAM support for Armada 38x":
http://thread.gmane.org/gmane.linux.ports.arm.kernel/420458

It has been either using rtcwake or by setting the serial line as a
wake-up source through the sysfs interface.

Thanks,

Gregory


Gregory CLEMENT (4):
  ARM: mvebu: Use __init for the PM initialization functions
  ARM: mvebu: Add standby support
  ARM: mvebu: Allow using the GIC for wakeup in standby mode
  ARM: mvebu: Warn about the wake-up sources not taken into account in
    suspend

 arch/arm/mach-mvebu/board-v7.c |  7 +++++
 arch/arm/mach-mvebu/common.h   |  5 ++--
 arch/arm/mach-mvebu/pm-board.c | 19 +++++++++-----
 arch/arm/mach-mvebu/pm.c       | 58 +++++++++++++++++++++++++++++++++++++-----
 4 files changed, 73 insertions(+), 16 deletions(-)

-- 
2.1.0

