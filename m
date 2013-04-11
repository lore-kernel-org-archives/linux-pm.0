From: Joseph Lo <josephl@nvidia.com>
Subject: Re: [PATCH 13/18] ARM: tegra2: cpuidle: use init/exit common routine
Date: Thu, 11 Apr 2013 09:01:40 +0800
Message-ID: <1365642100.1806.5.camel@jlo-ubuntu-64.nvidia.com>
References: <1365603743-5618-1-git-send-email-daniel.lezcano@linaro.org>
 <1365603743-5618-14-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1365603743-5618-14-git-send-email-daniel.lezcano@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "andrew@lunn.ch" <andrew@lunn.ch>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "linus.walleij@linaro.org" <linus.walleij@linaro.org>, "nsekhar@ti.com" <nsekhar@ti.com>, "kgene.kim@samsung.com" <kgene.kim@samsung.com>, "patches@linaro.org" <patches@linaro.org>, "magnus.damm@gmail.com" <magnus.damm@gmail.com>, "tony@atomide.com" <tony@atomide.com>, "plagnioj@jcrosoft.com" <plagnioj@jcrosoft.com>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, "jason@lakedaemon.net" <jason@lakedaemon.net>, "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>, "nicolas.ferre@atmel.com" <nicolas.ferre@atmel.com>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, "rjw@sisk.pl" <rjw@sisk.pl>, "horms@verge.net.au" <horms@verge.net.au>, "linux@maxim.org.za" <linux@maxim.org.za>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

On Wed, 2013-04-10 at 22:22 +0800, Daniel Lezcano wrote:
> Remove the duplicated code and use the cpuidle common code for initialization.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  arch/arm/mach-tegra/cpuidle-tegra20.c |   33 +--------------------------------
>  1 file changed, 1 insertion(+), 32 deletions(-)
> 
> diff --git a/arch/arm/mach-tegra/cpuidle-tegra20.c b/arch/arm/mach-tegra/cpuidle-tegra20.c
> index f1f6ac4..d6c2ba6 100644
> --- a/arch/arm/mach-tegra/cpuidle-tegra20.c
> +++ b/arch/arm/mach-tegra/cpuidle-tegra20.c
> @@ -70,8 +70,6 @@ static struct cpuidle_driver tegra_idle_driver = {
>  	.safe_state_index = 0,
>  };
>  
> -static DEFINE_PER_CPU(struct cpuidle_device, tegra_idle_device);
> -
>  #ifdef CONFIG_PM_SLEEP
>  #ifdef CONFIG_SMP
>  static void __iomem *pmc = IO_ADDRESS(TEGRA_PMC_BASE);
> @@ -220,34 +218,5 @@ static int tegra20_idle_lp2_coupled(struct cpuidle_device *dev,
>  
>  int __init tegra20_cpuidle_init(void)
>  {
> -	int ret;
> -	unsigned int cpu;
> -	struct cpuidle_device *dev;
> -	struct cpuidle_driver *drv = &tegra_idle_driver;
> -
> -#ifdef CONFIG_PM_SLEEP
> -	tegra_tear_down_cpu = tegra20_tear_down_cpu;
> -#endif

Hi Daniel,

Please keep these 3 lines above, just like you did for Tegra30.

Thanks,
Joseph

> +	return cpuidle_register(&tegra_idle_driver, cpu_possible_mask);
>  }
