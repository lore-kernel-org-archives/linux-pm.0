From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCH v4 13/13] ARM: mvebu: register the cpuidle driver for
 the Armada XP SoCs
Date: Wed, 19 Feb 2014 17:46:34 +0100
Message-ID: <20140219174634.17123478@skate>
References: <1392312816-17657-1-git-send-email-gregory.clement@free-electrons.com>
	<1392312816-17657-14-git-send-email-gregory.clement@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:50805 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754460AbaBSQqh (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 19 Feb 2014 11:46:37 -0500
In-Reply-To: <1392312816-17657-14-git-send-email-gregory.clement@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-pm@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Lior Amsalem <alior@marvell.com>, Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, linux-arm-kernel@lists.infradead.org

Dear Gregory CLEMENT,

On Thu, 13 Feb 2014 18:33:36 +0100, Gregory CLEMENT wrote:
> The cpuidle is a platform driver so we have to register the device
> during the initialization of the boards.
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> ---
>  arch/arm/mach-mvebu/armada-370-xp.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/arch/arm/mach-mvebu/armada-370-xp.c b/arch/arm/mach-mvebu/armada-370-xp.c
> index f6c9d1d85c14..81b42980311c 100644
> --- a/arch/arm/mach-mvebu/armada-370-xp.c
> +++ b/arch/arm/mach-mvebu/armada-370-xp.c
> @@ -30,6 +30,11 @@
>  #include "common.h"
>  #include "coherency.h"
>  #include "mvebu-soc-id.h"
> +#include "pmsu.h"
> +
> +static struct platform_device armada_xp_cpuidle_device = {
> +	.name = "cpuidle-armada-370-xp",
> +};
>  
>  static void __init armada_370_xp_map_io(void)
>  {
> @@ -80,6 +85,13 @@ static void __init armada_370_xp_dt_init(void)
>  	if (of_machine_is_compatible("plathome,openblocks-ax3-4"))
>  		i2c_quirk();
>  	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
> +	if (of_find_compatible_node(NULL, NULL, "marvell,armada-370-xp-pmsu")
> +		&& of_find_compatible_node(NULL, NULL, "marvell,coherency-fabric")
> +		&& of_machine_is_compatible("marvell,armadaxp")) {
> +		armada_370_xp_pmsu_enable_l2_powerdown_onidle();
> +		armada_370_xp_cpu_pm_init();
> +		platform_device_register(&armada_xp_cpuidle_device);
> +	}

What about putting this in pmsu.c, in an arch_initcall() (or some other
initcall level) ? The cpuidle feature is really tied to the PMSU, so I
believe it makes sense to have the cpuidle-armada-370-xp
platform_device declared and registered in pmsu.c. As an added bonus,
you don't need to expose
armada_370_xp_pmsu_enable_l2_powerdown_onidle() and
armada_370_xp_cpu_pm_init() in a header: they can remain static
functions private to pmsu.c.

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
