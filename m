From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH v2 00/14] Marvell EBU thermal sensor consolidation
Date: Mon, 25 Mar 2013 10:30:01 +0100
Message-ID: <20130325093001.GH5627@lunn.ch>
References: <1363991114-4225-1-git-send-email-ezequiel.garcia@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from londo.lunn.ch ([80.238.139.98]:58201 "EHLO londo.lunn.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757806Ab3CYJaH (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 25 Mar 2013 05:30:07 -0400
Content-Disposition: inline
In-Reply-To: <1363991114-4225-1-git-send-email-ezequiel.garcia@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jason Cooper <jason@lakedaemon.net>, Lior Amsalem <alior@marvell.com>, Zhang Rui <rui.zhang@intel.com>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Gregory Clement <gregory.clement@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Andrew Lunn <andrew@lunn.ch>

On Fri, Mar 22, 2013 at 07:25:00PM -0300, Ezequiel Garcia wrote:
> Given Armada 370/XP and the other Marvell SoC with thermal support,
> namely Kirkwood and Dove, have fairly similar thermal devices it
> makes sense to integrate all of them into a single driver: mvebu-thermal.

Hi Ezequiel

I'm still not convinced that one driver is the right way to go.

As you have recently seen, Dove needs its own get_value() function,
adding yet more differences. There is still the open question about
370 "managed" temperature, do that also need exporting?

Lets also try to look into the crystal ball about what may happen
next. 

There is an out of tree Dove driver

https://github.com/rabeeh/linux-2.6.32.9/blob/master/arch/arm/mach-dove/hwmon.c

This shows that the same register space is also used for core and CPU
voltage measurements. At some point it might be nice to add support
for these, and it probably needs to be in this driver, otherwise the
locking is not nice. That driver also adds basic thermal management,
by scaling the CPU frequency. Most of the scaling code will go into a
driver in drivers/cpu_freq, but i guess there needs to be some glue
somewhere?

370 seems to have some thermal management hardware. There are
registers called Thermal Manager Control and Status Register, Thermal
Manager Cooling Delay Register, Thermal Manager Overheat Delay
Register. I've no idea what they do, if they are setup once and
forgotten, or if there needs to be active monitoring etc? Maybe we
will want to again link to cpu_freq? Will this need 370 specific glue
code?

I assume XP also have some thermal management system, since this is a
server class CPU. More glue to cpu_freq, again specific to XP? Maybe
the 370 and XP require the same glue?

Orion and Kirkwood are simple, in that i've never seen any thermal
management, other than a fan for the whole box, often controlled by a
PIC, sometimes by GPIO lines.

What does all this mean? I _think_ there will be less and less shared
code in future as these extra features are added.

I've not a strong opinion, but i think separate drivers are better. 

If we do stick to one driver, i would however want #ifdef
CONFIG_ARCH_DOVE, CONFIG_ARCH_KIRKWOOD, CONFIG_MACH_ARMADA_XP &
CONFIG_MACH_ARMADA_370 scattered through the code.

       Andrew
