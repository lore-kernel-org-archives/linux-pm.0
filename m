From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v4 1/4] cpufreq: Add a cpufreq driver for Marvell Dove
Date: Wed, 4 Dec 2013 14:54:13 +0000
Message-ID: <20131204145413.GD29200@e106331-lin.cambridge.arm.com>
References: <1386166641-7567-1-git-send-email-andrew@lunn.ch>
 <1386166641-7567-2-git-send-email-andrew@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1386166641-7567-2-git-send-email-andrew@lunn.ch>
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

On Wed, Dec 04, 2013 at 02:17:18PM +0000, Andrew Lunn wrote:
> The Marvell Dove SoC can run the CPU at two frequencies. The high
> frequencey is from a PLL, while the lower is the same as the DDR
> clock. Add a cpufreq driver to swap between these frequences.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> Tested-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> Sort header files
> Remove unneeded header files
> Notify only on change
> Use get_cpu_device(0), devm_clk_get()
> Use platform_get_resource_byname()
> Error check clk_prepare_enable()
> Comment the interrupt handler
> 
> rebase onto 3.13-rc2 linux-next
> use target_index
> ---
>  drivers/cpufreq/Kconfig.arm    |   5 +
>  drivers/cpufreq/Makefile       |   1 +
>  drivers/cpufreq/dove-cpufreq.c | 259 +++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 265 insertions(+)
>  create mode 100644 drivers/cpufreq/dove-cpufreq.c

[...]

> +static int dove_cpufreq_target(struct cpufreq_policy *policy,
> +			       unsigned int index)
> +{
> +	unsigned int state = dove_freq_table[index].driver_data;
> +	unsigned long reg, cr;
> +
> +	local_irq_disable();
> +
> +	/* Mask IRQ and FIQ to CPU */
> +	cr = readl(priv.pmu_cr);
> +	cr |= MASK_IRQ | MASK_FIQ;
> +	writel(cr, priv.pmu_cr);
> +
> +	/* Set/Clear the CPU_SLOW_EN bit */
> +	reg = readl_relaxed(priv.dfs + DFS_CR);
> +	reg &= ~L2_RATIO_MASK;
> +
> +	switch (state) {
> +	case STATE_CPU_FREQ:
> +		reg |= priv.xpratio;
> +		reg &= ~CPU_SLOW_EN;
> +		break;
> +	case STATE_DDR_FREQ:
> +		reg |= (priv.dpratio | CPU_SLOW_EN);
> +		break;
> +	}
> +
> +	/* Start the DFS process */
> +	reg |= DFS_EN;
> +
> +	writel(reg, priv.dfs + DFS_CR);
> +
> +	/* Wait-for-Interrupt, while the hardware changes frequency */
> +	cpu_do_idle();
> +
> +	local_irq_enable();

Just to check -- does the PMU automatically unmask IRQ and FIQ? 

[...]

> +static int dove_cpufreq_probe(struct platform_device *pdev)
> +{
> +	struct device *cpu_dev;
> +	struct resource *res;
> +	int err, irq;
> +
> +	memset(&priv, 0, sizeof(priv));
> +	priv.dev = &pdev->dev;
> +
> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
> +					   "cpufreq: DFS");
> +	priv.dfs = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(priv.dfs))
> +		return PTR_ERR(priv.dfs);
> +
> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
> +					   "cpufreq: PMU CR");
> +	priv.pmu_cr = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(priv.pmu_cr))
> +		return PTR_ERR(priv.pmu_cr);
> +
> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
> +					   "cpufreq: PMU Clk Div");
> +	priv.pmu_clk_div = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(priv.pmu_clk_div))
> +		return PTR_ERR(priv.pmu_clk_div);

I'd very much prefer that the PMU were described in the DT, and the
driver probed based on that.

> +
> +	cpu_dev = get_cpu_device(0);
> +
> +	priv.cpu_clk = devm_clk_get(cpu_dev, "cpu_clk");
> +	if (IS_ERR(priv.cpu_clk)) {
> +		err = PTR_ERR(priv.cpu_clk);
> +		goto out;
> +	}

I think it would be better to describe the clocks as being fed to the
PMU than directly to the CPU -- the PMU selects the appropriate clock
and feeds it to the CPU.

Also, the clocks could be named better with respect to their logical
function. One is the high-frequency default, and the other is a
low-frequency option. They're both able to feed the CPU, and the fact
that one also feeds the DDR isn't relevant to the CPU. Does the PMu also
control the input to the DDR?

> +
> +	err = clk_prepare_enable(priv.cpu_clk);
> +	if (err)
> +		goto out;
> +
> +	dove_freq_table[0].frequency = clk_get_rate(priv.cpu_clk) / 1000;
> +
> +	priv.ddr_clk = devm_clk_get(cpu_dev, "ddrclk");
> +	if (IS_ERR(priv.ddr_clk)) {
> +		err = PTR_ERR(priv.ddr_clk);
> +		goto out;
> +	}
> +
> +	err = clk_prepare_enable(priv.ddr_clk);
> +	if (err)
> +		goto out;
> +
> +	dove_freq_table[1].frequency = clk_get_rate(priv.ddr_clk) / 1000;
> +
> +	irq = irq_of_parse_and_map(cpu_dev->of_node, 0);
> +	if (!irq) {
> +		err = -ENXIO;
> +		goto out;
> +	}

Similarly, the interrupt is a property of the PMU.

Thanks,
Mark.
