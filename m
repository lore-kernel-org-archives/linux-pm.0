From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 2/3] cpufreq: add imx6q-cpufreq driver
Date: Tue, 8 Jan 2013 22:35:57 +0800
Message-ID: <20130108143554.GC19534@S2101-09.ap.freescale.net>
References: <1357628043-19256-1-git-send-email-shawn.guo@linaro.org>
 <1357628043-19256-3-git-send-email-shawn.guo@linaro.org>
 <CAOh2x=mv9_iWt+y9cP0oA4WKs86Ne9nRP6CgKy_1COnPm57YOA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from co9ehsobe004.messaging.microsoft.com ([207.46.163.27]:18886
	"EHLO co9outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756416Ab3AHOfi (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 8 Jan 2013 09:35:38 -0500
Content-Disposition: inline
In-Reply-To: <CAOh2x=mv9_iWt+y9cP0oA4WKs86Ne9nRP6CgKy_1COnPm57YOA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Sascha Hauer <s.hauer@pengutronix.de>

On Tue, Jan 08, 2013 at 02:46:31PM +0530, Viresh Kumar wrote:
> Hi Shawn,
> 
> Apart from Sascha's comments, please see few comment from my side:
> 
> On Tue, Jan 8, 2013 at 12:24 PM, Shawn Guo <shawn.guo@linaro.org> wrote:
> > diff --git a/drivers/cpufreq/imx6q-cpufreq.c b/drivers/cpufreq/imx6q-cpufreq.c
> > +static struct regulator *arm_reg;
> > +static struct regulator *pu_reg;
> > +static struct regulator *soc_reg;
> 
> Can move to a single line, if you like.
> 
> > +static struct clk *arm_clk;
> > +static struct clk *pll1_sys_clk;
> > +static struct clk *pll1_sw_clk;
> > +static struct clk *step_clk;
> > +static struct clk *pll2_pfd2_396m_clk;
> 
> same.
> 
My personal taste is to have them on separate lines, so that it's
a little easier for reading and editing.

> > +static int imx6q_set_target(struct cpufreq_policy *policy,
> > +                           unsigned int target_freq, unsigned int relation)
> > +{
> > +       struct cpufreq_freqs freqs;
> > +       struct opp *opp;
> > +       unsigned long freq_hz, volt, volt_old;
> > +       unsigned int index, cpu;
> > +       int ret;
> > +
> > +       ret = cpufreq_frequency_table_target(policy, freq_table, target_freq,
> > +                                            relation, &index);
> > +       if (ret) {
> > +               pr_err("failed to match target freqency %d: %d\n",
> 
> s/freqency/frequency
> 
Thanks.

> > +                      target_freq, ret);
> > +               return ret;
> > +       }
> > +
> > +       freq_hz = freq_table[index].frequency * 1000;
> > +       freqs.new = freq_hz / 1000;
> 
> could be written as:
> 
>        freqs.new = freq_table[index].frequency;
>        freq_hz = freqs.new * 1000;
> 
Yeah, it looks better.

> 
> > +       freqs.old = clk_get_rate(arm_clk) / 1000;
> > +
> > +       if (freqs.old == freqs.new)
> > +               return 0;
> > +
> > +       for_each_online_cpu(cpu) {
> > +               freqs.cpu = cpu;
> > +               cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
> > +       }
> > +
> > +       opp = opp_find_freq_ceil(cpu_dev, &freq_hz);
> > +       if (IS_ERR(opp)) {
> > +               pr_err("failed to find OPP for %ld\n", freq_hz);
> > +               return PTR_ERR(opp);
> > +       }
> > +
> > +       volt = opp_get_voltage(opp);
> > +       volt_old = regulator_get_voltage(arm_reg);
> > +
> > +       pr_debug("%u MHz, %ld mV --> %u MHz, %ld mV\n",
> > +                freqs.old / 1000, volt_old / 1000,
> > +                freqs.new / 1000, volt / 1000);
> > +
> > +       /* scaling up?  scale voltage before frequency */
> > +       if (freqs.new > freqs.old) {
> > +               ret = regulator_set_voltage_tol(arm_reg, volt, 0);
> > +               if (ret) {
> > +                       pr_err("failed to scale voltage up: %d\n", ret);
> > +                       freqs.new = freqs.old;
> 
> is this useful?
> 
No, it's not.  Will remove it.

> > +                       return ret;
> > +               }
> > +
> > +               /*
> > +                * Need to increase vddpu and vddsoc for safety
> > +                * if we are about to run at 1.2 GHz.
> > +                */
> > +               if (freqs.new == FREQ_1P2_GHZ / 1000) {
> > +                       regulator_set_voltage_tol(pu_reg,
> > +                                       PU_SOC_VOLTAGE_HIGH, 0);
> > +                       regulator_set_voltage_tol(soc_reg,
> > +                                       PU_SOC_VOLTAGE_HIGH, 0);
> > +               }
> > +       }
> > +
> > +       /*
> > +        * The setpoints are selected per PLL/PDF frequencies, so we need to
> > +        * reprogram PLL for frequency scaling.  The procedure of reprogramming
> > +        * PLL1 is as blow.
> > +        *
> > +        *  - Enable pll2_pfd2_396m_clk and reparent pll1_sw_clk to it
> > +        *  - Disable pll1_sys_clk and reprogram it
> > +        *  - Enable pll1_sys_clk and reparent pll1_sw_clk back to it
> > +        *  - Disable pll2_pfd2_396m_clk
> > +        */
> > +       clk_prepare_enable(pll2_pfd2_396m_clk);
> > +       clk_set_parent(step_clk, pll2_pfd2_396m_clk);
> > +       clk_set_parent(pll1_sw_clk, step_clk);
> > +       clk_prepare_enable(pll1_sys_clk);
> > +       if (freq_hz > clk_get_rate(pll2_pfd2_396m_clk)) {
> > +               clk_disable_unprepare(pll1_sys_clk);
> > +               clk_set_rate(pll1_sys_clk, freqs.new * 1000);
> > +               clk_prepare_enable(pll1_sys_clk);
> > +               clk_set_parent(pll1_sw_clk, pll1_sys_clk);
> > +               clk_disable_unprepare(pll2_pfd2_396m_clk);
> > +       } else {
> > +               /*
> > +                * Disable pll1_sys_clk if pll2_pfd2_396m_clk is sufficient
> > +                * to provide the frequency.
> > +                */
> > +               clk_disable_unprepare(pll1_sys_clk);
> 
> Are you doing anything in  clk_[un]prepare ? If not, do clk_[un]prepare
> at init and exit and do enable/disable here.
> 
Yes, we do power on/off PLL in clk_[un]prepare.

> > +       }
> > +
> > +       /* Ensure the arm clock divider is what we expect */
> > +       ret = clk_set_rate(arm_clk, freqs.new * 1000);
> > +       if (ret) {
> > +               pr_err("failed to set clock rate: %d\n", ret);
> > +               regulator_set_voltage_tol(arm_reg, volt_old, 0);
> > +               return ret;
> > +       }
> > +
> > +       /* scaling down?  scale voltage after frequency */
> > +       if (freqs.new < freqs.old) {
> > +               ret = regulator_set_voltage_tol(arm_reg, volt, 0);
> > +               if (ret)
> > +                       pr_warn("failed to scale voltage down: %d\n", ret);
> > +
> > +               if (freqs.old == FREQ_1P2_GHZ / 1000) {
> > +                       regulator_set_voltage_tol(pu_reg,
> > +                                       PU_SOC_VOLTAGE_NORMAL, 0);
> > +                       regulator_set_voltage_tol(soc_reg,
> > +                                       PU_SOC_VOLTAGE_NORMAL, 0);
> > +               }
> > +       }
> > +
> > +       for_each_online_cpu(cpu) {
> > +               freqs.cpu = cpu;
> > +               cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> > +static int imx6q_cpufreq_init(struct cpufreq_policy *policy)
> > +{
> > +       int ret;
> > +
> > +       if (policy->cpu != 0)
> > +               return -EINVAL;
> 
> Why? The problem here is when you hot-unplug cpu0, init would be called for
> cpu1 and it would fail.
> 

On imx6q, we can never hot-unplug cpu0.  And all the cores of imx6q
share the clock and voltage, so have to scale together.  That's why
we only need to do this init for cpu0.

> > +
> > +       ret = cpufreq_frequency_table_cpuinfo(policy, freq_table);
> > +       if (ret) {
> > +               pr_err("invalid frequency table: %d\n", ret);
> > +               return ret;
> > +       }
> > +
> > +       policy->cpuinfo.transition_latency = transition_latency;
> > +       policy->cur = clk_get_rate(arm_clk) / 1000;
> > +       policy->shared_type = CPUFREQ_SHARED_TYPE_ANY;
> > +       cpumask_setall(policy->cpus);
> > +       cpufreq_frequency_table_get_attr(freq_table, policy->cpu);
> > +
> > +       return 0;
> > +}
> > +
> > +static int imx6q_cpufreq_exit(struct cpufreq_policy *policy)
> > +{
> > +       cpufreq_frequency_table_put_attr(policy->cpu);
> > +       return 0;
> > +}
> > +
> > +static struct freq_attr *imx6q_cpufreq_attr[] = {
> > +       &cpufreq_freq_attr_scaling_available_freqs,
> > +       NULL,
> > +};
> > +
> > +static struct cpufreq_driver imx6q_cpufreq_driver = {
> > +       .verify = imx6q_verify_speed,
> > +       .target = imx6q_set_target,
> > +       .get = imx6q_get_speed,
> > +       .init = imx6q_cpufreq_init,
> > +       .exit = imx6q_cpufreq_exit,
> > +       .name = "imx6q-cpufreq",
> > +       .attr = imx6q_cpufreq_attr,
> > +};
> > +
> > +static int imx6q_cpufreq_probe(struct platform_device *pdev)
> > +{
> > +       struct device_node *np;
> > +       int ret;
> > +
> > +       np = of_find_node_by_path("/cpus/cpu@0");
> > +       if (!np) {
> > +               pr_err("failed to find cpu0 node\n");
> > +               return -ENOENT;
> > +       }
> > +
> > +       cpu_dev = get_cpu_device(0);
> > +       if (!cpu_dev) {
> > +               pr_err("failed to get cpu0 device\n");
> > +               ret = -ENODEV;
> > +               goto put_node;
> > +       }
> > +
> > +       cpu_dev->of_node = np;
> > +
> > +       arm_clk = clk_get(cpu_dev, "arm");
> > +       pll1_sys_clk = clk_get(cpu_dev, "pll1_sys");
> > +       pll1_sw_clk = clk_get(cpu_dev, "pll1_sw");
> > +       step_clk = clk_get(cpu_dev, "step");
> > +       pll2_pfd2_396m_clk = clk_get(cpu_dev, "pll2_pfd2_396m");
> > +       if (IS_ERR(arm_clk) || IS_ERR(pll1_sys_clk) || IS_ERR(pll1_sw_clk) ||
> > +           IS_ERR(step_clk) || IS_ERR(pll2_pfd2_396m_clk)) {
> > +               pr_err("failed to get clocks\n");
> > +               ret = -ENOENT;
> > +               goto put_node;
> 
> That looks to be wrong. If clk failed for the last clk_get, you must
> free all other
> clks too.

Yes, you are right.  I just figured out a way to use managed functions,
so it will not be a problem any more.

Shawn

> 
> > +       }
> > +
> > +       arm_reg = regulator_get(cpu_dev, "arm");
> > +       pu_reg = regulator_get(cpu_dev, "pu");
> > +       soc_reg = regulator_get(cpu_dev, "soc");
> > +       if (!arm_reg || !pu_reg || !soc_reg) {
> > +               pr_err("failed to get regulators\n");
> > +               ret = -ENOENT;
> > +               goto put_clk;
> 
> ditto

