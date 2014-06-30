From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCH 12/16] cpuidle: mvebu: Rename the driver from
 armada-370-xp to mvebu-v7
Date: Mon, 30 Jun 2014 15:28:06 +0200
Message-ID: <20140630152806.12d018cf@free-electrons.com>
References: <1403875377-940-1-git-send-email-gregory.clement@free-electrons.com>
	<1403875377-940-13-git-send-email-gregory.clement@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:54836 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752438AbaF3NiC (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 30 Jun 2014 09:38:02 -0400
In-Reply-To: <1403875377-940-13-git-send-email-gregory.clement@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Lior Amsalem <alior@marvell.com>, Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, linux-arm-kernel@lists.infradead.org

Gregory,

On Fri, 27 Jun 2014 15:22:53 +0200, Gregory CLEMENT wrote:
> Actually this driver will be able to manage the cpuidle for more SoCs
> that Armada 370 ad XP. It will support Armada 38x and potentially
> Armada 375. This patch change the names accordingly to this behavior.

I think the last sentence should rather be something like: "This patch
renames the driver as well as the functions and variables used in the
driver".

I would also specifically mention the renaming of the driver that
requires changing the pmsu.c file. It is worth mentioning that this
rename, touching both drivers/cpuidle and arch/arm/mach-mvebu, may
require some special handling in terms of patch merging (the patch
mainly touches drivers/cpuidle so it should theoretically go through
the cpuidle maintainer, but since the pmsu.c file is touched a lot by
other patches, there will probably be lots of conflicts if this patch
goes through the cpuidle tree). Surely something to mention as a
comment in the patch, maybe to get the Acked-by of the cpuidle people
and merge things through the mvebu and arm-soc trees.

> -config ARM_ARMADA_370_XP_CPUIDLE
> -	bool "CPU Idle Driver for Armada 370/XP family processors"
> +config ARM_MVEBU_V7_CPUIDLE
> +	bool "CPU Idle Driver for mvebu v7 family processors"

Actually, what worries me a bit of that Dove is a ARMv7 processor of
the mvebu family, but which is not using this cpuidle driver. Do you
expect Dove to be able to use this driver in the future?

>  	depends on ARCH_MVEBU
>  	help
> -	  Select this to enable cpuidle on Armada 370/XP processors.
> +	  Select this to enable cpuidle on Armada 370, 385 and XP processors.

385 -> 38x, because 380 and 385 are both capable of using this driver.

> diff --git a/drivers/cpuidle/cpuidle-armada-370-xp.c b/drivers/cpuidle/cpuidle-armada-370-xp.c
> deleted file mode 100644
> index a5fba0287bfb..000000000000
> --- a/drivers/cpuidle/cpuidle-armada-370-xp.c
> +++ /dev/null

You haven't enabled rename detection in git? Or git isn't detecting the
rename because of the number of changes in the file?

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
