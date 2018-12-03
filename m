From: Matthias Kaehlcke <mka@chromium.org>
Subject: Re: [PATCH v11 2/2] cpufreq: qcom-hw: Add support for QCOM cpufreq
 HW driver
Date: Mon, 3 Dec 2018 09:46:42 -0800
Message-ID: <20181203174642.GE22824@google.com>
References: <1543722903-10989-1-git-send-email-tdas@codeaurora.org>
 <1543722903-10989-3-git-send-email-tdas@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1543722903-10989-3-git-send-email-tdas@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Taniya Das <tdas@codeaurora.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>, Rajendra Nayak <rnayak@codeaurora.org>, devicetree@vger.kernel.org, robh@kernel.org, skannan@codeaurora.org, linux-arm-msm@vger.kernel.org, evgreen@google.com, Stephen Boyd <swboyd@chromium.org>
List-Id: linux-pm@vger.kernel.org

On Sun, Dec 02, 2018 at 09:25:03AM +0530, Taniya Das wrote:
> The CPUfreq HW present in some QCOM chipsets offloads the steps necessary
> for changing the frequency of CPUs. The driver implements the cpufreq
> driver interface for this hardware engine.
> 
> Signed-off-by: Saravana Kannan <skannan@codeaurora.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> Signed-off-by: Taniya Das <tdas@codeaurora.org>
> ---
>  drivers/cpufreq/Kconfig.arm       |  11 ++
>  drivers/cpufreq/Makefile          |   1 +
>  drivers/cpufreq/qcom-cpufreq-hw.c | 334 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 346 insertions(+)
>  create mode 100644 drivers/cpufreq/qcom-cpufreq-hw.c
> 
> ...
> 
> diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
> new file mode 100644
> index 0000000..8dc6b73
> --- /dev/null
> +++ b/drivers/cpufreq/qcom-cpufreq-hw.c
> 
> ...
> 
> +static int qcom_cpufreq_hw_read_lut(struct device *dev, struct cpufreq_qcom *c,
> +				    void __iomem *base, unsigned long xo_rate,
> +				    unsigned long cpu_hw_rate)
> +{
> +	u32 data, src, lval, i, core_count, prev_cc = 0, prev_freq = 0, freq;
> +	unsigned int max_cores = cpumask_weight(&c->related_cpus);
> +
> +	c->table = devm_kcalloc(dev, LUT_MAX_ENTRIES + 1,
> +				sizeof(*c->table), GFP_KERNEL);
> +	if (!c->table)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < LUT_MAX_ENTRIES; i++) {
> +		data = readl_relaxed(base + REG_LUT_TABLE + i * LUT_ROW_SIZE);
> +		src = FIELD_GET(LUT_SRC, data);
> +		lval = FIELD_GET(LUT_L_VAL, data);
> +		core_count = FIELD_GET(LUT_CORE_COUNT, data);
> +
> +		if (src)
> +			freq = xo_rate * lval / 1000;
> +		else
> +			freq = cpu_hw_rate / 1000;
> +
> +		/* Ignore boosts in the middle of the table */
> +		if (core_count != max_cores) {
> +			c->table[i].frequency = CPUFREQ_ENTRY_INVALID;
> +		} else {
> +			c->table[i].frequency = freq;
> +			dev_dbg(dev, "index=%d freq=%d, core_count %d\n", i,
> +				freq, core_count);
> +		}

nit: IMO it would be better to put the normal case ("core_count !=
max_cores") first and the exception in the else branch.

> +MODULE_DESCRIPTION("QCOM CPUFREQ HW Driver");

nit: my suggestion was 'QCOM CPUFreq HW driver', which is what's used
elsewhere in the driver.

Anyway, no need to respin just for the nits, we can address them (or
not) with follow-up patches.

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
