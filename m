From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: [RFC/PATCH 0/2] ARM: kirkwood: Add suspend/resume support
Date: Mon,  1 Jul 2013 19:47:27 -0300
Message-ID: <1372718849-2912-1-git-send-email-ezequiel.garcia@free-electrons.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:43508 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755196Ab3GAWri (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 1 Jul 2013 18:47:38 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Gregory Clement <gregory.clement@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Lior Amsalem <alior@marvell.com>, Simon Guinot <sguinot@lacie.com>, Russell King <linux@arm.linux.org.uk>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>

This patchset implements a very basic suspend/resume support on
Kirkwood SoC's, based on the work of Simon Guinot.
Given the CPU itself is not stopped on suspend, but just sits
waiting for interruption, this is more similar to a standby-mode,
than to a real suspend-to-RAM.

In this opportunity, I'm sending this patchset as a very early RFC,
mostly to get some feedback on the first patch that implements the
suspend/resume procedures in the Feroceon CPU. This implemenation
has been copy-pasted from the one in ARM926, since I failed to spot
any differences between the CPU's on that matter.

Maybe someone more knowledgable can take a look and provide some insights.

This applies cleanly on top of v3.10-rc7 and has been tested on an
Openblocks A6 box. Notice that the network controller clock is not gated,
because the driver still needs proper suspend/resume operations.

Thanks a lot!

Ezequiel Garcia (2):
  ARM: feroceon: Add suspend/resume operation
  ARM: kirkwood: Add basic suspend-to-RAM support

 arch/arm/Kconfig                                  |  2 +-
 arch/arm/mach-kirkwood/Makefile                   |  1 +
 arch/arm/mach-kirkwood/include/mach/bridge-regs.h |  2 +
 arch/arm/mach-kirkwood/pm.c                       | 83 +++++++++++++++++++++++
 arch/arm/mm/proc-feroceon.S                       | 26 +++++++
 5 files changed, 113 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/mach-kirkwood/pm.c

-- 
1.8.1.5

