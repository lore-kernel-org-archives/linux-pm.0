From: Evan Green <evgreen@google.com>
Subject: Re: [PATCH v7 2/2] cpufreq: qcom-hw: Add support for QCOM cpufreq HW driver
Date: Fri, 3 Aug 2018 12:40:41 -0700
Message-ID: <CAE=gft7_5SZKpU0i9Jbi6UV-eqW8=6Fm7rw4oKVXG6J9Q7_E+g@mail.gmail.com>
References: <1532428970-18122-1-git-send-email-tdas@codeaurora.org> <1532428970-18122-3-git-send-email-tdas@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1532428970-18122-3-git-send-email-tdas@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: tdas@codeaurora.org
Cc: rjw@rjwysocki.net, Viresh Kumar <viresh.kumar@linaro.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, sboyd@kernel.org, Rajendra Nayak <rnayak@codeaurora.org>, anischal@codeaurora.org, devicetree@vger.kernel.org, robh@kernel.org, Saravana Kannan <skannan@codeaurora.org>, amit.kucheria@linaro.org
List-Id: linux-pm@vger.kernel.org

Hi Taniya,

On Tue, Jul 24, 2018 at 3:44 AM Taniya Das <tdas@codeaurora.org> wrote:
>
> The CPUfreq HW present in some QCOM chipsets offloads the steps necessary
> for changing the frequency of CPUs. The driver implements the cpufreq
> driver interface for this hardware engine.
>
> Signed-off-by: Saravana Kannan <skannan@codeaurora.org>
> Signed-off-by: Taniya Das <tdas@codeaurora.org>
> ---
>  drivers/cpufreq/Kconfig.arm       |  11 ++
>  drivers/cpufreq/Makefile          |   1 +
>  drivers/cpufreq/qcom-cpufreq-hw.c | 348 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 360 insertions(+)
>  create mode 100644 drivers/cpufreq/qcom-cpufreq-hw.c
>
...
> diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
> new file mode 100644
> index 0000000..ea8f7d1
> --- /dev/null
> +++ b/drivers/cpufreq/qcom-cpufreq-hw.c
...
> +static int qcom_cpufreq_hw_read_lut(struct platform_device *pdev,
> +                                   struct cpufreq_qcom *c)
> +{
> +       struct device *dev = &pdev->dev;
> +       void __iomem *base;
> +       u32 data, src, lval, i, core_count, prev_cc, prev_freq, cur_freq;
> +
> +       c->table = devm_kcalloc(dev, LUT_MAX_ENTRIES + 1,
> +                               sizeof(*c->table), GFP_KERNEL);
> +       if (!c->table)
> +               return -ENOMEM;
> +
> +       base = c->reg_bases[REG_LUT_TABLE];
> +
> +       for (i = 0; i < LUT_MAX_ENTRIES; i++) {
> +               data = readl_relaxed(base + i * LUT_ROW_SIZE);
> +               src = (data & GENMASK(31, 30)) >> 30;
> +               lval = data & GENMASK(7, 0);
> +               core_count = CORE_COUNT_VAL(data);
> +
> +               if (src)
> +                       c->table[i].frequency = c->xo_rate * lval / 1000;
> +               else
> +                       c->table[i].frequency = INIT_RATE / 1000;

I don't know much about how this hardware works, but based on the
mask, src has 4 possible values. So does 0 mean INIT_RATE, and 1, 2,
and 3 all mean xo_rate?

Also, is INIT_RATE really constant? It sounds like gpll0 (or
gpll0_out_even?). You're already getting the xo clock, why not get
gpll0's real rate as well?
