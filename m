From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v2 01/14] clk: shmobile: Add CPG Clock Domain support
Date: Mon, 22 Jun 2015 17:07:23 +0200
Message-ID: <CAMuHMdUuQkz9oiKdntd9KhMM9NGy1gMkiJ9jVZvkHA2yQNWBTg@mail.gmail.com>
References: <1432839219-475-1-git-send-email-geert+renesas@glider.be>
	<1432839219-475-2-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1432839219-475-2-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Mike Turquette <mturquette@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, linux-clk@vger.kernel.org, Linux PM list <linux-pm@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thu, May 28, 2015 at 8:53 PM, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
> Add Clock Domain support to the Clock Pulse Generator (CPG) Module Stop
> (MSTP) Clocks driver using the generic PM Domain.  This allows to
> power-manage the module clocks of SoC devices that are part of the CPG
> Clock Domain using Runtime PM, or for system suspend/resume.
>
> SoC devices that are part of a CPG Clock Domain and can be
> power-managed through an MSTP clock should be tagged in DT with a
> proper "power-domains" property.
>
> The CPG Clock Domain code will scan such devices for clocks that are
> suitable for power-managing the device, by looking for a clock that is
> compatible with "renesas,cpg-mstp-clocks".
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> Reviewed-by: Kevin Hilman <khilman@linaro.org>
> ---
> v2:
>   - Add Acked-by and Reviewed-by,
>   - Move core CPG Clock Domain code from the R-Car Gen2 driver to the
>     CPG MSTP Clocks driver, as it's generic, and can be used on other
>     Renesas SoCs that have a CPG/MSTP block,
>   - Scan for an MSTP clock instead of using the first clock tied to the
>     device (con_id NULL),
>   - Extract R-Car Gen2 specifics to a separate patch.
> ---
>  drivers/clk/shmobile/clk-mstp.c      | 86 ++++++++++++++++++++++++++++++++++++
>  drivers/clk/shmobile/clk-rcar-gen2.c |  2 +
>  include/linux/clk/shmobile.h         | 12 +++++
>  3 files changed, 100 insertions(+)
>
> diff --git a/drivers/clk/shmobile/clk-mstp.c b/drivers/clk/shmobile/clk-mstp.c
> index 2d2fe773ac8168f9..619f3eccefd4884f 100644
> --- a/drivers/clk/shmobile/clk-mstp.c
> +++ b/drivers/clk/shmobile/clk-mstp.c

> @@ -236,3 +241,84 @@ static void __init cpg_mstp_clocks_init(struct device_node *np)
>         of_clk_add_provider(np, of_clk_src_onecell_get, &group->data);
>  }
>  CLK_OF_DECLARE(cpg_mstp_clks, "renesas,cpg-mstp-clocks", cpg_mstp_clocks_init);
> +
> +
> +#ifdef CONFIG_PM_GENERIC_DOMAINS_OF
> +int cpg_mstp_attach_dev(struct generic_pm_domain *domain, struct device *dev)
> +{
> +       struct device_node *np = dev->of_node;
> +       struct of_phandle_args clkspec;
> +       struct clk *clk;
> +       int i = 0;
> +       int error;
> +
> +       while (!of_parse_phandle_with_args(np, "clocks", "#clock-cells", i,
> +                                          &clkspec)) {
> +               if (of_device_is_compatible(clkspec.np,
> +                                           "renesas,cpg-mstp-clocks"))
> +                       goto found;
> +
> +               of_node_put(clkspec.np);
> +               i++;
> +       }
> +
> +       return 0;
> +
> +found:
> +       clk = of_clk_get_from_provider(&clkspec);
> +       of_node_put(clkspec.np);
> +
> +       if (IS_ERR(clk))
> +               return PTR_ERR(clk);
> +
> +       error = pm_clk_create(dev);
> +       if (error) {
> +               dev_err(dev, "pm_clk_create failed %d\n", error);
> +               goto fail_put;
> +       }
> +
> +       error = pm_clk_add_clk(dev, clk);
> +       if (error) {
> +               dev_err(dev, "pm_clk_add_clk %pC failed %d\n", clk, error);
> +               goto fail_destroy;
> +       }
> +
> +       return 0;
> +
> +fail_destroy:
> +       pm_clk_destroy(dev);
> +fail_put:
> +       clk_put(clk);
> +       return error;
> +}
> +
> +void cpg_mstp_detach_dev(struct generic_pm_domain *domain, struct device *dev)
> +{
> +       pm_clk_destroy(dev);

This should only be done if cpg_mstp_attach_dev() actually added a clock, i.e.

        if (!list_empty(&dev->power.subsys_data->clock_list))
                pm_clk_destroy(dev);

Else it will free the subsys_data allocated by genpd_alloc_dev_data()
prematurely, and genpd_free_dev_data() will crash when dereferencing
dev->power.subsys_data.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
--
To unsubscribe from this list: send the line "unsubscribe linux-sh" in
