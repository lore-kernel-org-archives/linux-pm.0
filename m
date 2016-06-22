From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH 1/2] cpufreq: exynos: use relaxed IO accesors
Date: Wed, 22 Jun 2016 13:59:13 +0200
Message-ID: <CAJKOXPf--C=PXmMthaLy8MVL8BBFe9gWaFv9sMh6Xzft4k6U8g@mail.gmail.com>
References: <1466587984-14105-1-git-send-email-ben.dooks@codethink.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1466587984-14105-1-git-send-email-ben.dooks@codethink.co.uk>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Ben Dooks <ben.dooks@codethink.co.uk>
Cc: linux-kernel@lists.codethink.co.uk, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Wed, Jun 22, 2016 at 11:33 AM, Ben Dooks <ben.dooks@codethink.co.uk> wrote:
> The use of __raw IO accesors is not endian safe and should be used
> sparingly. The relaxed variants should be as lightweight and also
> are endian safe.
>
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> ---
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: linux-pm@vger.kernel.org
> Cc: linux-samsung-soc@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> ---
>  drivers/cpufreq/exynos5440-cpufreq.c | 28 ++++++++++++++--------------
>  1 file changed, 14 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/cpufreq/exynos5440-cpufreq.c b/drivers/cpufreq/exynos5440-cpufreq.c
> index c0f3373..7a5707f 100644
> --- a/drivers/cpufreq/exynos5440-cpufreq.c
> +++ b/drivers/cpufreq/exynos5440-cpufreq.c
> @@ -155,7 +155,7 @@ static int init_div_table(void)
>                 tmp = (clk_div | ema_div | (volt_id << P0_7_VDD_SHIFT)
>                         | ((freq / FREQ_UNIT) << P0_7_FREQ_SHIFT));
>
> -               __raw_writel(tmp, dvfs_info->base + XMU_PMU_P0_7 + 4 *
> +               writel_relaxed(tmp, dvfs_info->base + XMU_PMU_P0_7 + 4 *
>                                                 (pos - freq_tbl));
>         }
>
> @@ -169,17 +169,17 @@ static void exynos_enable_dvfs(unsigned int cur_frequency)
>         struct cpufreq_frequency_table *freq_table = dvfs_info->freq_table;
>         struct cpufreq_frequency_table *pos;
>         /* Disable DVFS */
> -       __raw_writel(0, dvfs_info->base + XMU_DVFS_CTRL);
> +       writel_relaxed(0,       dvfs_info->base + XMU_DVFS_CTRL);

Please fix the whitespace.

Rest looks good but this patch appeared twice. I suspect they are the same?

Best regards,
Krzysztof
