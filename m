From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH 1/2] cpufreq: armada-37xx: fix clock parenting
Date: Thu, 14 Mar 2019 14:13:58 +0200
Message-ID: <20190314121358.GA19385@apalos>
References: <20190308164710.10597-1-gregory.clement@bootlin.com>
 <20190308164710.10597-2-gregory.clement@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190308164710.10597-2-gregory.clement@bootlin.com>
Sender: stable-owner@vger.kernel.org
To: Gregory CLEMENT <gregory.clement@bootlin.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, Christian Neubert <christian.neubert.86@gmail.com>, Vincent Guittot <vincent.guittot@linaro.org>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, linux-arm-kernel@lists.infradead.org, Antoine Tenart <antoine.tenart@bootlin.com>, =?iso-8859-1?Q?Miqu=E8l?= Raynal <miquel.raynal@bootlin.com>, Maxime Chevallier <maxime.chevallier@bootlin.com>, stable@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Christian, Gregory,
> From: Christian Neubert <christian.neubert.86@gmail.com>
> 
> The clock parenting was not setup properly when DVFS was enabled. It was
> expected that the same clock source was used with and without DVFS which
> was not the case.
> 
> This patch fixes this issue, allowing to make the cpufreq support work
> when the CPU clock source are not the default ones.
> 
> Fixes: 92ce45fb875d ("cpufreq: Add DVFS support for Armada 37xx")
> Cc: <stable@vger.kernel.org>
> [gregory: extract from a larger patch, modify comments and commit log]
> Signed-off-by: Christian Neubert <christian.neubert.86@gmail.com>
> Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
> ---
>  drivers/cpufreq/armada-37xx-cpufreq.c | 20 +++++++++++++++++---
>  1 file changed, 17 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cpufreq/armada-37xx-cpufreq.c b/drivers/cpufreq/armada-37xx-cpufreq.c
> index 75491fc841a6..ad4463e4266e 100644
> --- a/drivers/cpufreq/armada-37xx-cpufreq.c
> +++ b/drivers/cpufreq/armada-37xx-cpufreq.c
> @@ -162,11 +162,25 @@ static void __init armada37xx_cpufreq_dvfs_setup(struct regmap *base,
>  	}
>  
>  	/*
> -	 * Set cpu clock source, for all the level we keep the same
> -	 * clock source that the one already configured. For this one
> -	 * we need to use the clock framework
> +	 * Set CPU clock source, for all the level we keep the same
> +	 * clock source that the one already configured with DVS
> +	 * disabled. For this one we need to use the clock framework
>  	 */
>  	parent = clk_get_parent(clk);
> +
> +	/*
> +	 * Unset parent clock to force the clock framework setting again
> +	 * the clock parent
> +	 */
> +	clk_set_parent(clk, NULL);
> +
> +	/*
> +	 * For the Armada 37xx CPU clocks, setting the parent will
> +	 * actually configure the parent when DVFS is enabled. At
> +	 * hardware level it will be a different register from the one
> +	 * read when doing clk_get_parent that will be set with
> +	 * clk_set_parent.
> +	 */
>  	clk_set_parent(clk, parent);
>  }
>  
> -- 
> 2.20.1
> 
I applied this and selected only 
CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
CONFIG_CPU_FREQ_GOV_POWERSAVE=y

The board boots up with 'powersave' instead of 'performance' (maybe some init
script?)

When i tried changing to 'performance' i got this:
[  164.134589] Internal error: synchronous parity or ECC error: 96000018 [#1]
PREEMPT SMP
[  164.139899] Modules linked in: mvneta mvmdio phylink crct10dif_ce ip_tables
x_tables ipv6
[  164.148321] CPU: 1 PID: 2485 Comm: bash Not tainted 5.0.0espressobin+ #68
[  164.155305] Hardware name: Globalscale Marvell ESPRESSOBin Board (DT)
[  164.161938] pstate: 000003c5 (nzcv DAIF -PAN -UAO)
[  164.166873] pc : do_mem_abort+0x48/0xb0
[  164.170808] lr : el1_da+0x20/0x88
[  164.174210] sp : ffff000011b5b1f0
[  164.177614] x29: ffff000011b5b1f0 x28: ffff80003a0ab800 
[  164.183080] x27: 0000000000000000 x26: 0000000000000000 
[  164.188545] x25: 0000000000000000 x24: 0000000000000025 
[  164.194012] x23: 00000000000003c5 x22: ffff000010c37318 
[  164.199477] x21: ffff000010c371f0 x20: ffff000011b5b220 
[  164.204942] x19: 000000009600004f x18: 0000000000000000 
[  164.210408] x17: 0000000000000000 x16: 0000000000000005 
[  164.215873] x15: 0000000000000000 x14: 0000000000000000 
[  164.221339] x13: ffff80003ac55168 x12: ffff80003ac55168 
[  164.226805] x11: 0000000000000026 x10: 0101010101010101 
[  164.232270] x9 : 0000000000000000 x8 : 0000000000000000 
[  164.237735] x7 : 0000000000000000 x6 : 0000000000000000 
[  164.243201] x5 : 0000000000000000 x4 : 0000000000000000 
[  164.248667] x3 : 0000000000000000 x2 : 0000000000000000 
[  164.254133] x1 : 0000000000000000 x0 : 0000000000000000 
[  164.259601] Process bash (pid: 2485, stack limit = 0x00000000eb09c765)
[  164.266318] Call trace:
[  164.268830]  do_mem_abort+0x48/0xb0
[  164.272413]  el1_da+0x20/0x88
[  164.275460]  el1_error+0x14/0xe4
[  164.278778] Code: 2a1303e1 9ba07c63 aa1603e0 8b030095 (f8636883) 
[  164.285053] ---[ end trace 78a878c96fcb4581 ]---
[  164.289795] Kernel panic - not syncing: Fatal exception
[  164.295171] SMP: stopping secondary CPUs
[  164.299211] Kernel Offset: disabled
[  164.302788] CPU features: 0x002,2000200c
[  164.306817] Memory Limit: none
[  164.309961] ---[ end Kernel panic - not syncing: Fatal exception ]---

Cheers
/Ilias
