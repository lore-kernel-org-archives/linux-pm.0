From: Gregory CLEMENT <gregory.clement@bootlin.com>
Subject: Re: [PATCH V4 3/3] cpufreq: add suspend/resume support in Armada 37xx
 DVFS driver
Date: Wed, 02 May 2018 17:52:13 +0200
Message-ID: <87r2mu8382.fsf@bootlin.com>
References: <e98965068836e673ea826e8a03fd01e168fce3ed.1524561482.git.viresh.kumar@linaro.org>
 <cover.1524737432.git.viresh.kumar@linaro.org>
 <d6be605205f6af01968a99582b05026aec2eca42.1524737432.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <d6be605205f6af01968a99582b05026aec2eca42.1524737432.git.viresh.kumar@linaro.org>
 (Viresh Kumar's message of "Thu, 26 Apr 2018 15:42:17 +0530")
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
Cc: Andrew Lunn <andrew@lunn.ch>, Vincent Guittot <vincent.guittot@linaro.org>, Jason Cooper <jason@lakedaemon.net>, linux-pm@vger.kernel.org, Rafael Wysocki <rjw@rjwysocki.net>, Miquel Raynal <miquel.raynal@bootlin.com>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: linux-pm@vger.kernel.org

Hi Viresh,
 
 On jeu., avril 26 2018, Viresh Kumar <viresh.kumar@linaro.org> wrote:

> From: Miquel Raynal <miquel.raynal@bootlin.com>
>
> Add suspend/resume hooks in Armada 37xx DVFS driver to handle S2RAM
> operations. As there is currently no 'driver' structure, create one
> to store both the regmap and the register values during suspend
> operation.

I tested this patch on a Armada 3720 based board (EspressoBin), and it
worked well. I even made some power consumption measurement and after
the resume, the power consumption had the same value that before the
suspend, for low CPU frequency and high CPU frequency.

Tested-by: Gregory CLEMENT <gregory.clement@bootlin.com>

Thanks,

Gregory



>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> V3->V4:
> - Fix the "unused put_clk label" build error that happened between V2
>   and V3.
>
>  drivers/cpufreq/armada-37xx-cpufreq.c | 67 +++++++++++++++++++++++++++++++++--
>  1 file changed, 65 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/cpufreq/armada-37xx-cpufreq.c b/drivers/cpufreq/armada-37xx-cpufreq.c
> index 1d5db6f6ace9..739da90ff3f6 100644
> --- a/drivers/cpufreq/armada-37xx-cpufreq.c
> +++ b/drivers/cpufreq/armada-37xx-cpufreq.c
> @@ -23,6 +23,8 @@
>  #include <linux/regmap.h>
>  #include <linux/slab.h>
>  
> +#include "cpufreq-dt.h"
> +
>  /* Power management in North Bridge register set */
>  #define ARMADA_37XX_NB_L0L1	0x18
>  #define ARMADA_37XX_NB_L2L3	0x1C
> @@ -56,6 +58,16 @@
>   */
>  #define LOAD_LEVEL_NR	4
>  
> +struct armada37xx_cpufreq_state {
> +	struct regmap *regmap;
> +	u32 nb_l0l1;
> +	u32 nb_l2l3;
> +	u32 nb_dyn_mod;
> +	u32 nb_cpu_load;
> +};
> +
> +static struct armada37xx_cpufreq_state *armada37xx_cpufreq_state;
> +
>  struct armada_37xx_dvfs {
>  	u32 cpu_freq_max;
>  	u8 divider[LOAD_LEVEL_NR];
> @@ -136,7 +148,7 @@ static void __init armada37xx_cpufreq_dvfs_setup(struct regmap *base,
>  	clk_set_parent(clk, parent);
>  }
>  
> -static void __init armada37xx_cpufreq_disable_dvfs(struct regmap *base)
> +static void armada37xx_cpufreq_disable_dvfs(struct regmap *base)
>  {
>  	unsigned int reg = ARMADA_37XX_NB_DYN_MOD,
>  		mask = ARMADA_37XX_NB_DFS_EN;
> @@ -162,8 +174,44 @@ static void __init armada37xx_cpufreq_enable_dvfs(struct regmap *base)
>  	regmap_update_bits(base, reg, mask, mask);
>  }
>  
> +static int armada37xx_cpufreq_suspend(struct cpufreq_policy *policy)
> +{
> +	struct armada37xx_cpufreq_state *state = armada37xx_cpufreq_state;
> +
> +	regmap_read(state->regmap, ARMADA_37XX_NB_L0L1, &state->nb_l0l1);
> +	regmap_read(state->regmap, ARMADA_37XX_NB_L2L3, &state->nb_l2l3);
> +	regmap_read(state->regmap, ARMADA_37XX_NB_CPU_LOAD,
> +		    &state->nb_cpu_load);
> +	regmap_read(state->regmap, ARMADA_37XX_NB_DYN_MOD, &state->nb_dyn_mod);
> +
> +	return 0;
> +}
> +
> +static int armada37xx_cpufreq_resume(struct cpufreq_policy *policy)
> +{
> +	struct armada37xx_cpufreq_state *state = armada37xx_cpufreq_state;
> +
> +	/* Ensure DVFS is disabled otherwise the following registers are RO */
> +	armada37xx_cpufreq_disable_dvfs(state->regmap);
> +
> +	regmap_write(state->regmap, ARMADA_37XX_NB_L0L1, state->nb_l0l1);
> +	regmap_write(state->regmap, ARMADA_37XX_NB_L2L3, state->nb_l2l3);
> +	regmap_write(state->regmap, ARMADA_37XX_NB_CPU_LOAD,
> +		     state->nb_cpu_load);
> +
> +	/*
> +	 * NB_DYN_MOD register is the one that actually enable back DVFS if it
> +	 * was enabled before the suspend operation. This must be done last
> +	 * otherwise other registers are not writable.
> +	 */
> +	regmap_write(state->regmap, ARMADA_37XX_NB_DYN_MOD, state->nb_dyn_mod);
> +
> +	return 0;
> +}
> +
>  static int __init armada37xx_cpufreq_driver_init(void)
>  {
> +	struct cpufreq_dt_platform_data pdata;
>  	struct armada_37xx_dvfs *dvfs;
>  	struct platform_device *pdev;
>  	unsigned long freq;
> @@ -213,6 +261,15 @@ static int __init armada37xx_cpufreq_driver_init(void)
>  		return -EINVAL;
>  	}
>  
> +	armada37xx_cpufreq_state = kmalloc(sizeof(*armada37xx_cpufreq_state),
> +					   GFP_KERNEL);
> +	if (!armada37xx_cpufreq_state) {
> +		clk_put(clk);
> +		return -ENOMEM;
> +	}
> +
> +	armada37xx_cpufreq_state->regmap = nb_pm_base;
> +
>  	armada37xx_cpufreq_dvfs_setup(nb_pm_base, clk, dvfs->divider);
>  	clk_put(clk);
>  
> @@ -228,7 +285,11 @@ static int __init armada37xx_cpufreq_driver_init(void)
>  	/* Now that everything is setup, enable the DVFS at hardware level */
>  	armada37xx_cpufreq_enable_dvfs(nb_pm_base);
>  
> -	pdev = platform_device_register_simple("cpufreq-dt", -1, NULL, 0);
> +	pdata.suspend = armada37xx_cpufreq_suspend;
> +	pdata.resume = armada37xx_cpufreq_resume;
> +
> +	pdev = platform_device_register_data(NULL, "cpufreq-dt", -1, &pdata,
> +					     sizeof(pdata));
>  	ret = PTR_ERR_OR_ZERO(pdev);
>  	if (ret)
>  		goto disable_dvfs;
> @@ -244,6 +305,8 @@ static int __init armada37xx_cpufreq_driver_init(void)
>  		dev_pm_opp_remove(cpu_dev, freq);
>  	}
>  
> +	kfree(armada37xx_cpufreq_state);
> +
>  	return ret;
>  }
>  /* late_initcall, to guarantee the driver is loaded after A37xx clock driver */
> -- 
> 2.15.0.194.g9af6a3dea062
>

-- 
Gregory Clement, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com
