From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 2/3] cpufreq: add imx6q-cpufreq driver
Date: Tue, 8 Jan 2013 14:46:31 +0530
Message-ID: <CAOh2x=mv9_iWt+y9cP0oA4WKs86Ne9nRP6CgKy_1COnPm57YOA@mail.gmail.com>
References: <1357628043-19256-1-git-send-email-shawn.guo@linaro.org>
 <1357628043-19256-3-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1357628043-19256-3-git-send-email-shawn.guo@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Sascha Hauer <s.hauer@pengutronix.de>, linux-arm-kernel@lists.infradead.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Shawn,

Apart from Sascha's comments, please see few comment from my side:

On Tue, Jan 8, 2013 at 12:24 PM, Shawn Guo <shawn.guo@linaro.org> wrote:
> diff --git a/drivers/cpufreq/imx6q-cpufreq.c b/drivers/cpufreq/imx6q-cpufreq.c
> +static struct regulator *arm_reg;
> +static struct regulator *pu_reg;
> +static struct regulator *soc_reg;

Can move to a single line, if you like.

> +static struct clk *arm_clk;
> +static struct clk *pll1_sys_clk;
> +static struct clk *pll1_sw_clk;
> +static struct clk *step_clk;
> +static struct clk *pll2_pfd2_396m_clk;

same.

> +static int imx6q_set_target(struct cpufreq_policy *policy,
> +                           unsigned int target_freq, unsigned int relation)
> +{
> +       struct cpufreq_freqs freqs;
> +       struct opp *opp;
> +       unsigned long freq_hz, volt, volt_old;
> +       unsigned int index, cpu;
> +       int ret;
> +
> +       ret = cpufreq_frequency_table_target(policy, freq_table, target_freq,
> +                                            relation, &index);
> +       if (ret) {
> +               pr_err("failed to match target freqency %d: %d\n",

s/freqency/frequency

> +                      target_freq, ret);
> +               return ret;
> +       }
> +
> +       freq_hz = freq_table[index].frequency * 1000;
> +       freqs.new = freq_hz / 1000;

could be written as:

       freqs.new = freq_table[index].frequency;
       freq_hz = freqs.new * 1000;


> +       freqs.old = clk_get_rate(arm_clk) / 1000;
> +
> +       if (freqs.old == freqs.new)
> +               return 0;
> +
> +       for_each_online_cpu(cpu) {
> +               freqs.cpu = cpu;
> +               cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
> +       }
> +
> +       opp = opp_find_freq_ceil(cpu_dev, &freq_hz);
> +       if (IS_ERR(opp)) {
> +               pr_err("failed to find OPP for %ld\n", freq_hz);
> +               return PTR_ERR(opp);
> +       }
> +
> +       volt = opp_get_voltage(opp);
> +       volt_old = regulator_get_voltage(arm_reg);
> +
> +       pr_debug("%u MHz, %ld mV --> %u MHz, %ld mV\n",
> +                freqs.old / 1000, volt_old / 1000,
> +                freqs.new / 1000, volt / 1000);
> +
> +       /* scaling up?  scale voltage before frequency */
> +       if (freqs.new > freqs.old) {
> +               ret = regulator_set_voltage_tol(arm_reg, volt, 0);
> +               if (ret) {
> +                       pr_err("failed to scale voltage up: %d\n", ret);
> +                       freqs.new = freqs.old;

is this useful?

> +                       return ret;
> +               }
> +
> +               /*
> +                * Need to increase vddpu and vddsoc for safety
> +                * if we are about to run at 1.2 GHz.
> +                */
> +               if (freqs.new == FREQ_1P2_GHZ / 1000) {
> +                       regulator_set_voltage_tol(pu_reg,
> +                                       PU_SOC_VOLTAGE_HIGH, 0);
> +                       regulator_set_voltage_tol(soc_reg,
> +                                       PU_SOC_VOLTAGE_HIGH, 0);
> +               }
> +       }
> +
> +       /*
> +        * The setpoints are selected per PLL/PDF frequencies, so we need to
> +        * reprogram PLL for frequency scaling.  The procedure of reprogramming
> +        * PLL1 is as blow.
> +        *
> +        *  - Enable pll2_pfd2_396m_clk and reparent pll1_sw_clk to it
> +        *  - Disable pll1_sys_clk and reprogram it
> +        *  - Enable pll1_sys_clk and reparent pll1_sw_clk back to it
> +        *  - Disable pll2_pfd2_396m_clk
> +        */
> +       clk_prepare_enable(pll2_pfd2_396m_clk);
> +       clk_set_parent(step_clk, pll2_pfd2_396m_clk);
> +       clk_set_parent(pll1_sw_clk, step_clk);
> +       clk_prepare_enable(pll1_sys_clk);
> +       if (freq_hz > clk_get_rate(pll2_pfd2_396m_clk)) {
> +               clk_disable_unprepare(pll1_sys_clk);
> +               clk_set_rate(pll1_sys_clk, freqs.new * 1000);
> +               clk_prepare_enable(pll1_sys_clk);
> +               clk_set_parent(pll1_sw_clk, pll1_sys_clk);
> +               clk_disable_unprepare(pll2_pfd2_396m_clk);
> +       } else {
> +               /*
> +                * Disable pll1_sys_clk if pll2_pfd2_396m_clk is sufficient
> +                * to provide the frequency.
> +                */
> +               clk_disable_unprepare(pll1_sys_clk);

Are you doing anything in  clk_[un]prepare ? If not, do clk_[un]prepare
at init and exit and do enable/disable here.

> +       }
> +
> +       /* Ensure the arm clock divider is what we expect */
> +       ret = clk_set_rate(arm_clk, freqs.new * 1000);
> +       if (ret) {
> +               pr_err("failed to set clock rate: %d\n", ret);
> +               regulator_set_voltage_tol(arm_reg, volt_old, 0);
> +               return ret;
> +       }
> +
> +       /* scaling down?  scale voltage after frequency */
> +       if (freqs.new < freqs.old) {
> +               ret = regulator_set_voltage_tol(arm_reg, volt, 0);
> +               if (ret)
> +                       pr_warn("failed to scale voltage down: %d\n", ret);
> +
> +               if (freqs.old == FREQ_1P2_GHZ / 1000) {
> +                       regulator_set_voltage_tol(pu_reg,
> +                                       PU_SOC_VOLTAGE_NORMAL, 0);
> +                       regulator_set_voltage_tol(soc_reg,
> +                                       PU_SOC_VOLTAGE_NORMAL, 0);
> +               }
> +       }
> +
> +       for_each_online_cpu(cpu) {
> +               freqs.cpu = cpu;
> +               cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
> +       }
> +
> +       return 0;
> +}
> +
> +static int imx6q_cpufreq_init(struct cpufreq_policy *policy)
> +{
> +       int ret;
> +
> +       if (policy->cpu != 0)
> +               return -EINVAL;

Why? The problem here is when you hot-unplug cpu0, init would be called for
cpu1 and it would fail.

> +
> +       ret = cpufreq_frequency_table_cpuinfo(policy, freq_table);
> +       if (ret) {
> +               pr_err("invalid frequency table: %d\n", ret);
> +               return ret;
> +       }
> +
> +       policy->cpuinfo.transition_latency = transition_latency;
> +       policy->cur = clk_get_rate(arm_clk) / 1000;
> +       policy->shared_type = CPUFREQ_SHARED_TYPE_ANY;
> +       cpumask_setall(policy->cpus);
> +       cpufreq_frequency_table_get_attr(freq_table, policy->cpu);
> +
> +       return 0;
> +}
> +
> +static int imx6q_cpufreq_exit(struct cpufreq_policy *policy)
> +{
> +       cpufreq_frequency_table_put_attr(policy->cpu);
> +       return 0;
> +}
> +
> +static struct freq_attr *imx6q_cpufreq_attr[] = {
> +       &cpufreq_freq_attr_scaling_available_freqs,
> +       NULL,
> +};
> +
> +static struct cpufreq_driver imx6q_cpufreq_driver = {
> +       .verify = imx6q_verify_speed,
> +       .target = imx6q_set_target,
> +       .get = imx6q_get_speed,
> +       .init = imx6q_cpufreq_init,
> +       .exit = imx6q_cpufreq_exit,
> +       .name = "imx6q-cpufreq",
> +       .attr = imx6q_cpufreq_attr,
> +};
> +
> +static int imx6q_cpufreq_probe(struct platform_device *pdev)
> +{
> +       struct device_node *np;
> +       int ret;
> +
> +       np = of_find_node_by_path("/cpus/cpu@0");
> +       if (!np) {
> +               pr_err("failed to find cpu0 node\n");
> +               return -ENOENT;
> +       }
> +
> +       cpu_dev = get_cpu_device(0);
> +       if (!cpu_dev) {
> +               pr_err("failed to get cpu0 device\n");
> +               ret = -ENODEV;
> +               goto put_node;
> +       }
> +
> +       cpu_dev->of_node = np;
> +
> +       arm_clk = clk_get(cpu_dev, "arm");
> +       pll1_sys_clk = clk_get(cpu_dev, "pll1_sys");
> +       pll1_sw_clk = clk_get(cpu_dev, "pll1_sw");
> +       step_clk = clk_get(cpu_dev, "step");
> +       pll2_pfd2_396m_clk = clk_get(cpu_dev, "pll2_pfd2_396m");
> +       if (IS_ERR(arm_clk) || IS_ERR(pll1_sys_clk) || IS_ERR(pll1_sw_clk) ||
> +           IS_ERR(step_clk) || IS_ERR(pll2_pfd2_396m_clk)) {
> +               pr_err("failed to get clocks\n");
> +               ret = -ENOENT;
> +               goto put_node;

That looks to be wrong. If clk failed for the last clk_get, you must
free all other
clks too.

> +       }
> +
> +       arm_reg = regulator_get(cpu_dev, "arm");
> +       pu_reg = regulator_get(cpu_dev, "pu");
> +       soc_reg = regulator_get(cpu_dev, "soc");
> +       if (!arm_reg || !pu_reg || !soc_reg) {
> +               pr_err("failed to get regulators\n");
> +               ret = -ENOENT;
> +               goto put_clk;

ditto

> +       }
> +
> +       /* We expect an OPP table supplied by platform */
> +       ret = opp_get_opp_count(cpu_dev);
> +       if (ret < 0) {
> +               pr_err("no OPP table is found: %d\n", ret);
> +               goto put_reg;
> +       }
> +
> +       ret = opp_init_cpufreq_table(cpu_dev, &freq_table);
> +       if (ret) {
> +               pr_err("failed to init cpufreq table: %d\n", ret);
> +               goto put_reg;
> +       }
> +
> +       if (of_property_read_u32(np, "clock-latency", &transition_latency))
> +               transition_latency = CPUFREQ_ETERNAL;
> +
> +       ret = cpufreq_register_driver(&imx6q_cpufreq_driver);
> +       if (ret) {
> +               pr_err("failed register driver: %d\n", ret);
> +               goto free_freq_table;
> +       }
> +
> +       of_node_put(np);
> +       return 0;
> +
> +free_freq_table:
> +       opp_free_cpufreq_table(cpu_dev, &freq_table);
> +put_reg:
> +       regulator_put(soc_reg);
> +       regulator_put(pu_reg);
> +       regulator_put(arm_reg);
> +put_clk:
> +       clk_put(pll2_pfd2_396m_clk);
> +       clk_put(step_clk);
> +       clk_put(pll1_sw_clk);
> +       clk_put(pll1_sys_clk);
> +       clk_put(arm_clk);
> +put_node:
> +       of_node_put(np);
> +       return ret;
> +}
> +
> +static int imx6q_cpufreq_remove(struct platform_device *pdev)
> +{
> +       cpufreq_unregister_driver(&imx6q_cpufreq_driver);
> +       opp_free_cpufreq_table(cpu_dev, &freq_table);
> +       regulator_put(soc_reg);
> +       regulator_put(pu_reg);
> +       regulator_put(arm_reg);
> +       clk_put(pll2_pfd2_396m_clk);
> +       clk_put(step_clk);
> +       clk_put(pll1_sw_clk);
> +       clk_put(pll1_sys_clk);
> +       clk_put(arm_clk);
> +
> +       return 0;
> +}
> +
> +static struct platform_driver imx6q_cpufreq_platdrv = {
> +       .driver = {
> +               .name   = "imx6q_cpufreq",
> +               .owner  = THIS_MODULE,
> +       },
> +       .probe          = imx6q_cpufreq_probe,
> +       .remove         = imx6q_cpufreq_remove,
> +};
> +module_platform_driver(imx6q_cpufreq_platdrv);
> +
> +MODULE_AUTHOR("Shawn Guo <shawn.guo@linaro.org>");
> +MODULE_DESCRIPTION("Freescale i.MX6Q cpufreq driver");
> +MODULE_LICENSE("GPL");
> --
> 1.7.9.5
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
