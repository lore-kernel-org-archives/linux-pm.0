From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2] clk: qoriq: Add clockgen support for lx2160a
Date: Thu, 25 Apr 2019 12:03:51 +0200
Message-ID: <CAJZ5v0iwrjonKpA3Skkhkg3g5Pp9Qzx0v2GBYKdv7eM_jL4p8g@mail.gmail.com>
References: <1556185703-26243-1-git-send-email-vabhav.sharma@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1556185703-26243-1-git-send-email-vabhav.sharma@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vabhav Sharma <vabhav.sharma@nxp.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "sboyd@kernel.org" <sboyd@kernel.org>, "mturquette@baylibre.com" <mturquette@baylibre.com>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>, Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>, Andy Tang <andy.tang@nxp.com>
List-Id: linux-pm@vger.kernel.org

On Thu, Apr 25, 2019 at 11:48 AM Vabhav Sharma <vabhav.sharma@nxp.com> wrote:
>
> From: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
>
> Add clockgen support for lx2160a.
> Added entry for compat 'fsl,lx2160a-clockgen'.

Well, if I'm expected to apply this, the above is a bit terse.

It looks like the patch makes the qoriq-cpufreq driver handle some new
hardware, but the changelog doesn't say much about that.

I'm guessing that the clockgen support added here makes it possible
for qoriq-cpufreq to handle this chip, is that correct?

> Signed-off-by: Tang Yuantian <andy.tang@nxp.com>
> Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
> Signed-off-by: Vabhav Sharma <vabhav.sharma@nxp.com>
> Acked-by: Scott Wood <oss@buserror.net>
> Acked-by: Stephen Boyd <sboyd@kernel.org>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> Changes for v2:
> - Subject line updated
>
>  drivers/clk/clk-qoriq.c         | 12 ++++++++++++
>  drivers/cpufreq/qoriq-cpufreq.c |  1 +
>  2 files changed, 13 insertions(+)
>
> diff --git a/drivers/clk/clk-qoriq.c b/drivers/clk/clk-qoriq.c
> index 3d51d7c..1a15201 100644
> --- a/drivers/clk/clk-qoriq.c
> +++ b/drivers/clk/clk-qoriq.c
> @@ -570,6 +570,17 @@ static const struct clockgen_chipinfo chipinfo[] = {
>                 .flags = CG_VER3 | CG_LITTLE_ENDIAN,
>         },
>         {
> +               .compat = "fsl,lx2160a-clockgen",
> +               .cmux_groups = {
> +                       &clockgen2_cmux_cga12, &clockgen2_cmux_cgb
> +               },
> +               .cmux_to_group = {
> +                       0, 0, 0, 0, 1, 1, 1, 1, -1
> +               },
> +               .pll_mask = 0x37,
> +               .flags = CG_VER3 | CG_LITTLE_ENDIAN,
> +       },
> +       {
>                 .compat = "fsl,p2041-clockgen",
>                 .guts_compat = "fsl,qoriq-device-config-1.0",
>                 .init_periph = p2041_init_periph,
> @@ -1427,6 +1438,7 @@ CLK_OF_DECLARE(qoriq_clockgen_ls1043a, "fsl,ls1043a-clockgen", clockgen_init);
>  CLK_OF_DECLARE(qoriq_clockgen_ls1046a, "fsl,ls1046a-clockgen", clockgen_init);
>  CLK_OF_DECLARE(qoriq_clockgen_ls1088a, "fsl,ls1088a-clockgen", clockgen_init);
>  CLK_OF_DECLARE(qoriq_clockgen_ls2080a, "fsl,ls2080a-clockgen", clockgen_init);
> +CLK_OF_DECLARE(qoriq_clockgen_lx2160a, "fsl,lx2160a-clockgen", clockgen_init);
>  CLK_OF_DECLARE(qoriq_clockgen_p2041, "fsl,p2041-clockgen", clockgen_init);
>  CLK_OF_DECLARE(qoriq_clockgen_p3041, "fsl,p3041-clockgen", clockgen_init);
>  CLK_OF_DECLARE(qoriq_clockgen_p4080, "fsl,p4080-clockgen", clockgen_init);
> diff --git a/drivers/cpufreq/qoriq-cpufreq.c b/drivers/cpufreq/qoriq-cpufreq.c
> index 4295e54..81f0288 100644
> --- a/drivers/cpufreq/qoriq-cpufreq.c
> +++ b/drivers/cpufreq/qoriq-cpufreq.c
> @@ -284,6 +284,7 @@ static const struct of_device_id node_matches[] __initconst = {
>         { .compatible = "fsl,ls1046a-clockgen", },
>         { .compatible = "fsl,ls1088a-clockgen", },
>         { .compatible = "fsl,ls2080a-clockgen", },
> +       { .compatible = "fsl,lx2160a-clockgen", },
>         { .compatible = "fsl,p4080-clockgen", },
>         { .compatible = "fsl,qoriq-clockgen-1.0", },
>         { .compatible = "fsl,qoriq-clockgen-2.0", },
> --
> 2.7.4
>
