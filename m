From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH] cpufreq: Remove CONFIG_CPU_FREQ_STAT_DETAILS config option
Date: Thu, 5 Jan 2017 20:32:42 +0200
Message-ID: <20170105183242.cwyymvr37mdqb6mj@kozik-lap>
References: <d4299228a500a889c2b4b9e305674f3d1ea9ae06.1483604760.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <d4299228a500a889c2b4b9e305674f3d1ea9ae06.1483604760.git.viresh.kumar@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Andrew Lunn <andrew@lunn.ch>, linux-samsung-soc@vger.kernel.org, linaro-kernel@lists.linaro.org, Vincent Guittot <vincent.guittot@linaro.org>, Jason Cooper <jason@lakedaemon.net>, Simon Horman <horms@verge.net.au>, linux-pm@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org, Rafael Wysocki <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>, linux-renesas-soc@vger.kernel.org, Javier Martinez Canillas <javier@osg.samsung.com>, Kukjin Kim <kgene@kernel.org>, linux-mips@linux-mips.org, Gregory Clement <gregory.clement@free-electrons.com>, arnd.bergmann@linaro.org, linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Thu, Jan 05, 2017 at 01:57:41PM +0530, Viresh Kumar wrote:
> This doesn't have any benefit apart from saving a small amount of memory
> when it is disabled. The ifdef hackery in the code makes it dirty
> unnecessarily.
> 
> Clean it up by removing the Kconfig option completely. Few defconfigs
> are also updated and CONFIG_CPU_FREQ_STAT_DETAILS is replaced with
> CONFIG_CPU_FREQ_STAT now in them, as users wanted stats to be enabled.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  arch/arm/configs/exynos_defconfig         |  2 +-
>  arch/arm/configs/multi_v5_defconfig       |  2 +-
>  arch/arm/configs/multi_v7_defconfig       |  2 +-
>  arch/arm/configs/mvebu_v5_defconfig       |  2 +-
>  arch/arm/configs/pxa_defconfig            |  2 +-
>  arch/arm/configs/shmobile_defconfig       |  2 +-
>  arch/mips/configs/lemote2f_defconfig      |  1 -
>  arch/powerpc/configs/ppc6xx_defconfig     |  1 -
>  arch/sh/configs/sh7785lcr_32bit_defconfig |  2 +-
>  drivers/cpufreq/Kconfig                   |  8 --------
>  drivers/cpufreq/cpufreq_stats.c           | 14 --------------
>  11 files changed, 7 insertions(+), 31 deletions(-)
> 
> diff --git a/arch/arm/configs/exynos_defconfig b/arch/arm/configs/exynos_defconfig
> index 79c415c33f69..809f0bf3042a 100644
> --- a/arch/arm/configs/exynos_defconfig
> +++ b/arch/arm/configs/exynos_defconfig
> @@ -24,7 +24,7 @@ CONFIG_ARM_APPENDED_DTB=y
>  CONFIG_ARM_ATAG_DTB_COMPAT=y
>  CONFIG_CMDLINE="root=/dev/ram0 rw ramdisk=8192 initrd=0x41000000,8M console=ttySAC1,115200 init=/linuxrc mem=256M"
>  CONFIG_CPU_FREQ=y
> -CONFIG_CPU_FREQ_STAT_DETAILS=y
> +CONFIG_CPU_FREQ_STAT=y
>  CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=y
>  CONFIG_CPU_FREQ_GOV_POWERSAVE=m
>  CONFIG_CPU_FREQ_GOV_USERSPACE=m

For Exynos:
Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
