From: Jason Cooper <jason@lakedaemon.net>
Subject: Re: [PATCH for 3.10 v2 0/4] thermal: Add Armada 370/XP support
Date: Sat, 30 Mar 2013 20:47:08 -0400
Message-ID: <20130331004708.GH13280@titan.lakedaemon.net>
References: <1364292988-8358-1-git-send-email-ezequiel.garcia@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:21140 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754726Ab3CaArR (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 30 Mar 2013 20:47:17 -0400
Content-Disposition: inline
In-Reply-To: <1364292988-8358-1-git-send-email-ezequiel.garcia@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Gregory Clement <gregory.clement@free-electrons.com>, Zhang Rui <rui.zhang@intel.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

On Tue, Mar 26, 2013 at 07:16:24AM -0300, Ezequiel Garcia wrote:
> After Andrew Lunn objected the single driver approach [1] that merged
> all the Marvell EBU SoC thermal drivers, we have agreed to proceed step
> by step. For the time being we are adding support for Armada 370/XP only.
> Given both Armada 370 and Armada XP have a similar feature set, it
> makes sense to provide a single driver for them.
> 
> In the future we can unify this with the other drivers,
> if this proves to be worthwhile.
> 
> This driver has been influenced by the existing Kirkwood driver,
> also taking account of suggestions made by Jason Gunthorpe.
> 
> Testing has been done on the following boards:
> 
> For Armada 370: Globalscale Mirabox and Marvell Armada 370 RD
> For Armada XP:  Plat'home Openblocks AX3 and Marvell Armada XP DB-MV784MP-GP
> 
> This series is based in v3.9-rc2. To make testing easier this patchset
> can be found on a github branch [2].
> 
> Changes from v1:
>   * Reorder Kconfig and Makefiles entries as requested by Andrew Lunn.
>   * Make armada_get_temp() more readable, as requested by Durgadoss R.
> 
> Any feedback or comments are welcome!
> 
> [1] http://permalink.gmane.org/gmane.linux.power-management.general/32123
> [2] https://github.com/MISL-EBU-System-SW/mainline-public/tree/armada-thermal-v2
> 
> Ezequiel Garcia (4):
...
>   ARM: mvebu: Add thermal support to Armada XP device tree
>   ARM: mvebu: Add thermal support to Armada 370 device tree
>   ARM: configs: Update mvebu defconfig for thermal
...
>  arch/arm/boot/dts/armada-370.dtsi                  |    6 +
>  arch/arm/boot/dts/armada-xp.dtsi                   |    6 +
>  arch/arm/configs/mvebu_defconfig                   |    2 +

Patches 2 through 4 applied to mvebu/dt

thx,

Jason.
