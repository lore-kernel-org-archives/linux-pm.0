From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v4 2/4] mvebu: Dove: Instantiate cpufreq driver.
Date: Wed, 4 Dec 2013 14:36:28 +0000
Message-ID: <20131204143628.GB29200@e106331-lin.cambridge.arm.com>
References: <1386166641-7567-1-git-send-email-andrew@lunn.ch>
 <1386166641-7567-3-git-send-email-andrew@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1386166641-7567-3-git-send-email-andrew@lunn.ch>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Andrew Lunn <andrew@lunn.ch>
Cc: "rjw@rjwysocki.net" <rjw@rjwysocki.net>, Jason Cooper <jason@lakedaemon.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>, Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>, linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Dec 04, 2013 at 02:17:19PM +0000, Andrew Lunn wrote:
> Add a platform driver definition to instantiate the dove cpufreq
> driver. Also indicate the ARCH has cpufreq support, so allowing the
> cpufreq framework to be enabled.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> Tested-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> ---
> Make resource names consistent.
> Fix length of ranges
> ---
>  arch/arm/Kconfig                       |  1 +
>  arch/arm/mach-dove/board-dt.c          |  3 +++
>  arch/arm/mach-dove/common.c            | 36 ++++++++++++++++++++++++++++++++++
>  arch/arm/mach-dove/common.h            |  1 +
>  arch/arm/mach-dove/include/mach/dove.h |  1 +
>  5 files changed, 42 insertions(+)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index c1f1a7eee953..908b02f8d901 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -500,6 +500,7 @@ config ARCH_IXP4XX
>  
>  config ARCH_DOVE
>  	bool "Marvell Dove"
> +	select ARCH_HAS_CPUFREQ
>  	select ARCH_REQUIRE_GPIOLIB
>  	select CPU_PJ4
>  	select GENERIC_CLOCKEVENTS
> diff --git a/arch/arm/mach-dove/board-dt.c b/arch/arm/mach-dove/board-dt.c
> index 49fa9abd09da..845e8b328432 100644
> --- a/arch/arm/mach-dove/board-dt.c
> +++ b/arch/arm/mach-dove/board-dt.c
> @@ -27,6 +27,9 @@ static void __init dove_dt_init(void)
>  	tauros2_init(0);
>  #endif
>  	BUG_ON(mvebu_mbus_dt_init());
> +
> +	dove_cpufreq_init();
> +
>  	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
>  }
>  
> diff --git a/arch/arm/mach-dove/common.c b/arch/arm/mach-dove/common.c
> index c122bcff9f7c..323fcd4b27b6 100644
> --- a/arch/arm/mach-dove/common.c
> +++ b/arch/arm/mach-dove/common.c
> @@ -344,6 +344,42 @@ void __init dove_sdio1_init(void)
>  	platform_device_register(&dove_sdio1);
>  }
>  
> +/*****************************************************************************
> + * CPU Frequency
> + ****************************************************************************/
> +static struct resource dove_cpufreq_resources[] = {
> +	[0] = {
> +		.start  = DOVE_PMU_PHYS_BASE,
> +		.end    = DOVE_PMU_PHYS_BASE + 0x7,
> +		.flags  = IORESOURCE_MEM,
> +		.name   = "cpufreq: DFS"
> +	},
> +	[1] = {
> +		.start  = DOVE_PMU_PHYS_BASE + 0x8000,
> +		.end    = DOVE_PMU_PHYS_BASE + 0x8003,
> +		.flags  = IORESOURCE_MEM,
> +		.name   = "cpufreq: PMU CR"
> +	},
> +	[2] = {
> +		.start  = DOVE_PMU_PHYS_BASE + 0x0044,
> +		.end    = DOVE_PMU_PHYS_BASE + 0x0047,
> +		.flags  = IORESOURCE_MEM,
> +		.name   = "cpufreq: PMU Clk Div"
> +	},
> +};
> +
> +static struct platform_device dove_cpufreq_device = {
> +	.name		= "dove-cpufreq",
> +	.id		= -1,
> +	.num_resources	= ARRAY_SIZE(dove_cpufreq_resources),
> +	.resource	= dove_cpufreq_resources,
> +};
> +
> +void __init dove_cpufreq_init(void)
> +{
> +	platform_device_register(&dove_cpufreq_device);
> +}

Please describe your power management unit in the DT. Your hardcoding
physical addresses that can easily be described in the DT, and you don't
appear to have an early probing requirement.

> +
>  void __init dove_setup_cpu_wins(void)
>  {
>  	/*
> diff --git a/arch/arm/mach-dove/common.h b/arch/arm/mach-dove/common.h
> index 1d725224d146..5c9a77bdd442 100644
> --- a/arch/arm/mach-dove/common.h
> +++ b/arch/arm/mach-dove/common.h
> @@ -44,6 +44,7 @@ void dove_spi1_init(void);
>  void dove_i2c_init(void);
>  void dove_sdio0_init(void);
>  void dove_sdio1_init(void);
> +void dove_cpufreq_init(void);
>  void dove_restart(enum reboot_mode, const char *);
>  
>  #endif
> diff --git a/arch/arm/mach-dove/include/mach/dove.h b/arch/arm/mach-dove/include/mach/dove.h
> index 0c4b35f4ee5b..48db186ae6bc 100644
> --- a/arch/arm/mach-dove/include/mach/dove.h
> +++ b/arch/arm/mach-dove/include/mach/dove.h
> @@ -144,6 +144,7 @@
>  #define  DOVE_SD0_GPIO_SEL		(1 << 0)
>  
>  /* Power Management */
> +#define DOVE_PMU_PHYS_BASE	(DOVE_SB_REGS_PHYS_BASE + 0xd0000)
>  #define DOVE_PMU_VIRT_BASE	(DOVE_SB_REGS_VIRT_BASE + 0xd0000)
>  #define DOVE_PMU_SIG_CTRL	(DOVE_PMU_VIRT_BASE + 0x802c)

If you need to describe the large block this appears to be in, do that
too.

Thanks,
Mark.
