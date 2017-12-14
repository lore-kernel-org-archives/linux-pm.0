From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: Re: [PATCH v3 3/4] cpufreq: Add DVFS support for Armada 37xx
Date: Thu, 14 Dec 2017 10:35:10 +0100
Message-ID: <87fu8dps8h.fsf@free-electrons.com>
References: <20171213175119.9441-1-gregory.clement@free-electrons.com>
        <20171213175119.9441-4-gregory.clement@free-electrons.com>
        <20171214030427.GQ3322@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:55411 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750737AbdLNJfM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 14 Dec 2017 04:35:12 -0500
In-Reply-To: <20171214030427.GQ3322@vireshk-i7> (Viresh Kumar's message of
        "Thu, 14 Dec 2017 08:34:27 +0530")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Antoine Tenart <antoine.tenart@free-electrons.com>, =?utf-8?Q?Miqu=C3=A8l?= Raynal <miquel.raynal@free-electrons.com>, Nadav Haklai <nadavh@marvell.com>, Victor Gu <xigu@marvell.com>, Marcin Wojtas <mw@semihalf.com>, Wilson Ding <dingwei@marvell.com>, Hua Jing <jinghua@marvell.com>, Neta Zur Hershkovits <neta@marvell.com>, Evan Wang <xswang@marvell.com>, Andre Heider <a.heider@gmail.com>

Hi Viresh,
 
 On jeu., déc. 14 2017, Viresh Kumar <viresh.kumar@linaro.org> wrote:

> I just searched for tabs and spaces in this patch and here are the observations.
>
> On 13-12-17, 18:51, Gregory CLEMENT wrote:
>> +/* Power management in North Bridge register set */
>> +#define ARMADA_37XX_NB_L0L1	0x18
>
> There is a single space after #define here, which is good.
>
>> +#define ARMADA_37XX_NB_L2L3	0x1C
>> +#define  ARMADA_37XX_NB_TBG_DIV_OFF	13
>
> But here and at many places below you have two spaces after #define, which isn't
> bad but isn't consistent as well.

Actually from the beginning the idea was to make difference between the
define for the offset of the register and then the define for the value
related to this register.

Initially I used tab for this distinction, but then I though you
suggested to only use space to have a more compact view, so I used double
space.

I don't mind using double space or tab, but for me making distinction
between offset of the register and content of the register helps the
readability of the code.

>
>> +#define  ARMADA_37XX_NB_TBG_DIV_MASK	0x7
>> +#define  ARMADA_37XX_NB_CLK_SEL_OFF	11
>> +#define  ARMADA_37XX_NB_CLK_SEL_MASK	0x1
>> +#define  ARMADA_37XX_NB_CLK_SEL_TBG      0x1
>
> You have used space instead of TAB after ARMADA_37XX_NB_CLK_SEL_TBG here, while
> everywhere else we have tabs. Maybe its better to be consistent ?

It was a typo.

>
>> +#define  ARMADA_37XX_NB_TBG_SEL_OFF	9
>> +#define  ARMADA_37XX_NB_TBG_SEL_MASK	0x3
>> +#define  ARMADA_37XX_NB_VDD_SEL_OFF	6
>> +#define  ARMADA_37XX_NB_VDD_SEL_MASK	0x3
>> +#define  ARMADA_37XX_NB_CONFIG_SHIFT	16
>> +#define ARMADA_37XX_NB_DYN_MOD	0x24
>> +#define  ARMADA_37XX_NB_CLK_SEL_EN	BIT(26)
>> +#define  ARMADA_37XX_NB_TBG_EN		BIT(28)
>> +#define  ARMADA_37XX_NB_DIV_EN		BIT(29)
>> +#define  ARMADA_37XX_NB_VDD_EN		BIT(30)
>> +#define  ARMADA_37XX_NB_DFS_EN		BIT(31)
>> +#define ARMADA_37XX_NB_CPU_LOAD 0x30
>> +#define  ARMADA_37XX_NB_CPU_LOAD_MASK	0x3
>> +#define  ARMADA_37XX_DVFS_LOAD_0	0
>> +#define  ARMADA_37XX_DVFS_LOAD_1	1
>> +#define  ARMADA_37XX_DVFS_LOAD_2	2
>> +#define  ARMADA_37XX_DVFS_LOAD_3	3
>> +
>> +/*
>> + * On Armada 37xx the Power management manages 4 level of CPU load,
>> + * each level can be associated with a CPU clock source, a CPU
>> + * divider, a VDD level, etc...
>> + */
>> +#define LOAD_LEVEL_NR	4
>> +
>> +struct armada_37xx_dvfs {
>> +	u32 cpu_freq_max;
>> +	u8 divider[LOAD_LEVEL_NR];
>> +};
>> +
>> +static struct armada_37xx_dvfs armada_37xx_dvfs[] = {
>> +	{.cpu_freq_max = 1200*1000*1000, .divider = {1, 2, 4, 6} },
>> +	{.cpu_freq_max = 1000*1000*1000, .divider = {1, 2, 4, 5} },
>> +	{.cpu_freq_max = 800*1000*1000,  .divider = {1, 2, 3, 4} },
>> +	{.cpu_freq_max = 600*1000*1000,  .divider = {2, 4, 5, 6} },
>> +};
>> +
>> +static struct armada_37xx_dvfs *armada_37xx_cpu_freq_info_get(u32 freq)
>> +{
>> +	int i;
>> +
>> +	for (i = 0; i < ARRAY_SIZE(armada_37xx_dvfs); i++) {
>> +		if (freq == armada_37xx_dvfs[i].cpu_freq_max)
>> +			return &armada_37xx_dvfs[i];
>> +	}
>> +
>> +	pr_err("Unsupported CPU frequency %d MHz\n", freq/1000000);
>> +	return NULL;
>> +}
>> +
>> +/*
>> + * Setup the four level managed by the hardware. Once the four level
>> + * will be configured then the DVFS will be enabled.
>> + */
>> +static void __init armada37xx_cpufreq_dvfs_setup(struct regmap *base,
>> +						 struct clk *clk, u8 *divider)
>> +{
>> +	int load_lvl;
>> +	struct clk *parent;
>> +
>> +	for (load_lvl = 0; load_lvl < LOAD_LEVEL_NR; load_lvl++) {
>> +		unsigned int reg, mask,  val, offset = 0;
>
> double space before "val".
>

Typo

>> +
>> +		if (load_lvl <= ARMADA_37XX_DVFS_LOAD_1)
>> +			reg = ARMADA_37XX_NB_L0L1;
>> +		else
>> +			reg = ARMADA_37XX_NB_L2L3;
>> +
>> +		if (load_lvl ==  ARMADA_37XX_DVFS_LOAD_0 ||
>> +		    load_lvl ==  ARMADA_37XX_DVFS_LOAD_2)
>
> double spaces after ==

Typo

>
>> +			offset += ARMADA_37XX_NB_CONFIG_SHIFT;
>> +
>> +		/* Set cpu clock source, for all the level we use TBG */
>> +		val = ARMADA_37XX_NB_CLK_SEL_TBG << ARMADA_37XX_NB_CLK_SEL_OFF;
>> +		mask = (ARMADA_37XX_NB_CLK_SEL_MASK
>> +			<< ARMADA_37XX_NB_CLK_SEL_OFF);
>> +
>> +		/*
>> +		 * Set cpu divider based on the pre-computed array in
>> +		 * order to have balanced step.
>> +		 */
>> +		val |= divider[load_lvl] << ARMADA_37XX_NB_TBG_DIV_OFF;
>> +		mask |= (ARMADA_37XX_NB_TBG_DIV_MASK
>> +			<< ARMADA_37XX_NB_TBG_DIV_OFF);
>> +
>> +		/* Set VDD divider which is actually the load level. */
>> +		val |= load_lvl << ARMADA_37XX_NB_VDD_SEL_OFF;
>> +		mask |= (ARMADA_37XX_NB_VDD_SEL_MASK
>> +			<< ARMADA_37XX_NB_VDD_SEL_OFF);
>> +
>> +		val <<= offset;
>> +		mask <<= offset;
>> +
>> +		regmap_update_bits(base, reg, mask, val);
>> +	}
>> +
>> +	/*
>> +	 * Set cpu clock source, for all the level we keep the same
>> +	 * clock source that the one already configured. For this one
>> +	 * we need to use the clock framework
>> +	 */
>> +	parent = clk_get_parent(clk);
>> +	clk_set_parent(clk, parent);
>> +}
>> +
>> +static void __init armada37xx_cpufreq_disable_dvfs(struct regmap *base)
>> +{
>> +	unsigned int reg = ARMADA_37XX_NB_DYN_MOD,
>> +		mask = ARMADA_37XX_NB_DFS_EN;
>> +
>> +	regmap_update_bits(base, reg, mask, 0);
>> +}
>> +
>> +static void __init armada37xx_cpufreq_enable_dvfs(struct regmap *base)
>> +{
>> +	unsigned int val, reg = ARMADA_37XX_NB_CPU_LOAD,
>> +		mask = ARMADA_37XX_NB_CPU_LOAD_MASK;
>> +
>> +	/* Start with the highest load (0) */
>> +	val = ARMADA_37XX_DVFS_LOAD_0;
>> +	regmap_update_bits(base, reg, mask, val);
>> +
>> +	/* Now enable DVFS for the CPUs */
>> +	reg = ARMADA_37XX_NB_DYN_MOD;
>> +	mask =	ARMADA_37XX_NB_CLK_SEL_EN | ARMADA_37XX_NB_TBG_EN |
>> +		ARMADA_37XX_NB_DIV_EN | ARMADA_37XX_NB_VDD_EN |
>> +		ARMADA_37XX_NB_DFS_EN;
>> +
>> +	regmap_update_bits(base, reg, mask, mask);
>> +}
>> +
>> +static int __init armada37xx_cpufreq_driver_init(void)
>> +{
>> +	struct armada_37xx_dvfs *dvfs;
>> +	struct platform_device *pdev;
>> +	unsigned int cur_frequency;
>> +	struct regmap *nb_pm_base;
>> +	struct device *cpu_dev;
>> +	int load_lvl, ret;
>> +	struct clk *clk;
>> +
>> +	nb_pm_base =
>> +		syscon_regmap_lookup_by_compatible("marvell,armada-3700-nb-pm");
>> +
>> +	if (IS_ERR(nb_pm_base))
>> +		return -ENODEV;
>> +
>> +	/* Before doing any configuration on the DVFS first, disable it */
>> +	armada37xx_cpufreq_disable_dvfs(nb_pm_base);
>> +
>> +	/*
>> +	 * On CPU 0 register the operating points supported (which are
>> +	 * the nominal CPU frequency and full integer divisions of
>> +	 * it).
>> +	 */
>> +	cpu_dev = get_cpu_device(0);
>> +	if (!cpu_dev) {
>> +		dev_err(cpu_dev, "Cannot get CPU\n");
>> +		return -ENODEV;
>> +	}
>> +
>> +	clk = clk_get(cpu_dev, 0);
>> +	if (IS_ERR(clk)) {
>> +		dev_err(cpu_dev, "Cannot get clock for CPU0\n");
>> +		return PTR_ERR(clk);
>> +	}
>> +
>> +	/* Get nominal (current) CPU frequency */
>> +	cur_frequency = clk_get_rate(clk);
>> +	if (!cur_frequency) {
>> +		dev_err(cpu_dev, "Failed to get clock rate for CPU\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	dvfs = armada_37xx_cpu_freq_info_get(cur_frequency);
>> +	if (!dvfs)
>> +		return -EINVAL;
>> +
>> +	armada37xx_cpufreq_dvfs_setup(nb_pm_base, clk, dvfs->divider);
>> +
>> +	for (load_lvl = ARMADA_37XX_DVFS_LOAD_0; load_lvl < LOAD_LEVEL_NR;
>> +	     load_lvl++) {
>> +		unsigned long freq = cur_frequency / dvfs->divider[load_lvl];
>> +
>> +		ret = dev_pm_opp_add(cpu_dev, freq, 0);
>> +		if (ret) {
>> +			/*  clean-up the already added opp before leaving */
>
> Double space after /*

Typo

>
>> +			while (load_lvl-- > ARMADA_37XX_DVFS_LOAD_0) {
>> +				freq = cur_frequency / dvfs->divider[load_lvl];
>> +				dev_pm_opp_remove(cpu_dev, freq);
>> +			}
>> +			return ret;
>> +		}
>> +	}
>> +
>> +	/* Now that everything is setup, enable the DVFS at hardware level */
>> +	armada37xx_cpufreq_enable_dvfs(nb_pm_base);
>> +
>> +	pdev = platform_device_register_simple("cpufreq-dt", -1, NULL, 0);
>> +
>> +	return PTR_ERR_OR_ZERO(pdev);
>> +}
>> +/* late_initcall, to guarantee the driver is loaded after A37xx clock driver */
>> +late_initcall(armada37xx_cpufreq_driver_init);
>> +
>> +MODULE_AUTHOR("Gregory CLEMENT <gregory.clement@free-electrons.com>");
>> +MODULE_DESCRIPTION("Armada 37xx cpufreq driver");
>> +MODULE_LICENSE("GPL");
>
> I am not objecting to using double spaces at all these locations, its fine. Just
> that I wanted to point it out in case it is not intentional.

I will send a new version fixing the last typo you find, however unless
your are strongly against it I would like to keep the  distinction
between register and their content.

Thanks,

Gregory


>
> -- 
> viresh

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
