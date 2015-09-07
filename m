From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 5/7] staging: board: Add support for devices with
 complex dependencies
Date: Mon, 7 Sep 2015 13:45:05 +0200
Message-ID: <CAPDyKFrRhaShh9x8jxsGFdtFF8_VEF4=GCFEmKR-m7fVD4ZyRQ@mail.gmail.com>
References: <1434530336-15073-1-git-send-email-geert+renesas@glider.be>
	<1434530336-15073-6-git-send-email-geert+renesas@glider.be>
	<CAPDyKFqouMeTKuXyyohH-VDmWXH+TiLNDT-7MKFa_-TqeF2WSw@mail.gmail.com>
	<CAMuHMdUiH+WZnPtnM-HNs-SpZ8ZxULiKeAiTC1ONTJoP3YMXKg@mail.gmail.com>
	<CAPDyKFriANthZbDcAQT8WXM2Z857p9+-UZB+woss04ZwM-97ZA@mail.gmail.com>
	<alpine.DEB.2.10.1509041616140.8359@ayla.of.borg>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:35866 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750953AbbIGLpH (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 7 Sep 2015 07:45:07 -0400
Received: by wicgb1 with SMTP id gb1so42793456wic.1
        for <linux-pm@vger.kernel.org>; Mon, 07 Sep 2015 04:45:05 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.10.1509041616140.8359@ayla.of.borg>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Simon Horman <horms+renesas@verge.net.au>, Magnus Damm <damm+renesas@opensource.se>, Arnd Bergmann <arnd@arndb.de>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Marc Zyngier <marc.zyngier@arm.com>, driverdevel <devel@driverdev.osuosl.org>, Linux-sh list <linux-sh@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 4 September 2015 at 17:03, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>         Hi Ulf,
>
> On Fri, 4 Sep 2015, Ulf Hansson wrote:
>> On 3 September 2015 at 15:35, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>> > On Thu, Sep 3, 2015 at 2:53 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>> >> On 17 June 2015 at 10:38, Geert Uytterhoeven <geert+renesas@glider.be> wrote:
>> >>> Add support for easy registering of one ore more platform devices that
>> >>> may:
>> >>>   - need clocks that are described in DT,
>> >>>   - be part of a PM Domain.
>> >
>> >>> diff --git a/drivers/staging/board/board.c b/drivers/staging/board/board.c
>> >>> index 8712f566b31196e0..29d456e29f38feac 100644
>> >>> --- a/drivers/staging/board/board.c
>> >>> +++ b/drivers/staging/board/board.c
>> >
>> >>> +int __init board_staging_register_device(const struct board_staging_dev *dev)
>> >>> +{
>> >>> +       struct platform_device *pdev = dev->pdev;
>> >>> +       unsigned int i;
>> >>> +       int error;
>> >>> +
>> >>> +       pr_debug("Trying to register device %s\n", pdev->name);
>> >>> +       if (board_staging_dt_node_available(pdev->resource,
>> >>> +                                           pdev->num_resources)) {
>> >>> +               pr_warn("Skipping %s, already in DT\n", pdev->name);
>> >>> +               return -EEXIST;
>> >>> +       }
>> >>> +
>> >>> +       board_staging_gic_fixup_resources(pdev->resource, pdev->num_resources);
>> >>> +
>> >>> +       for (i = 0; i < dev->nclocks; i++)
>> >>> +               board_staging_register_clock(&dev->clocks[i]);
>> >>> +
>> >>> +       error = platform_device_register(pdev);
>> >>> +       if (error) {
>> >>> +               pr_err("Failed to register device %s (%d)\n", pdev->name,
>> >>> +                      error);
>> >>> +               return error;
>> >>> +       }
>> >>> +
>> >>> +       if (dev->domain)
>> >>> +               __pm_genpd_name_add_device(dev->domain, &pdev->dev, NULL);
>> >>
>> >> Urgh, this managed to slip through my filters.
>> >>
>> >> It seems like we almost managed to remove all users of the
>> >> "..._name_add..." APIs for genpd. If hasn't been for $subject patch.
>> >> :-)
>> >>
>> >> Now, I realize this is already too late here, but let's try to fix
>> >> this before it turns into a bigger issue.
>> >>
>> >> Geert, do you think it's possible to convert into using the non-named
>> >> bases APIs?
>> >
>> > That will be difficult. This code is meant to use drivers that are not yet
>> > DT-aware on DT-based systems. Hence it uses platform devices with named PM
>> > domains, while the PM domains are described in DT.
>> > I don't think there's another way to look up a PM domain by name, is there?
>>
>> As a matter of fact there are, especially for those genpds that has
>> been created through DT as in this case. The API to use is
>> of_genpd_get_from_provider() to find the struct generic_pm_domain.
>
> Thanks!
>
>> Yes, I do realize that you need to manage the parsing of the domain
>> name to make sure it's the one you want, but I would rather keep that
>> "hack" in this driver than in the generic API.
>
> OK. It turned out not to be that complex, cfr. the patch below.
> For now this supports PM domains with "#power-domain-cells = <0>" only,
> but of course it can be extended if the need arises.
>
> I've also tried:
>
>     np = of_find_compatible_node(NULL, NULL, "renesas,sysc-rmobile");
>     np = of_find_node_by_name(np, "a4lc");
>
> (the second step is needed because of the domain hierarchy in DT), but that
> would require adding the compatible string to struct board_staging_dev,
> and doesn't work if you have multiple identical power providers.
>
> I hope you like it?
>
> From 5fb11904845eb929a5b3382a9d5153c151cde1cf Mon Sep 17 00:00:00 2001
> From: Geert Uytterhoeven <geert+renesas@glider.be>
> Date: Fri, 4 Sep 2015 16:52:33 +0200
> Subject: [PATCH/RFC] staging: board: Migrate away from
>  __pm_genpd_name_add_device()
>
> The named genpd APIs are deprecated. Hence convert the board staging
> code from using genpd names to DT node paths.
>
> For now this supports PM domains with "#power-domain-cells = <0>" only.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Geert, thanks for posting this patch!

I wonder whether we could get this sent for the 4.3 rc[n], since that
would enable us to remove some of the named based API for genpd
through Rafael's linux-pm tree during this release cycle.

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  drivers/staging/board/armadillo800eva.c |  2 +-
>  drivers/staging/board/board.c           | 36 ++++++++++++++++++++++++++++++++-
>  2 files changed, 36 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/staging/board/armadillo800eva.c b/drivers/staging/board/armadillo800eva.c
> index 0165591a52443c46..912c96b0536def7c 100644
> --- a/drivers/staging/board/armadillo800eva.c
> +++ b/drivers/staging/board/armadillo800eva.c
> @@ -91,7 +91,7 @@ static const struct board_staging_dev armadillo800eva_devices[] __initconst = {
>                 .pdev           = &lcdc0_device,
>                 .clocks         = lcdc0_clocks,
>                 .nclocks        = ARRAY_SIZE(lcdc0_clocks),
> -               .domain         = "a4lc",
> +               .domain         = "/system-controller@e6180000/pm-domains/c5/a4lc@1"
>         },
>  };
>
> diff --git a/drivers/staging/board/board.c b/drivers/staging/board/board.c
> index 29d456e29f38feac..3eb5eb8f069c236d 100644
> --- a/drivers/staging/board/board.c
> +++ b/drivers/staging/board/board.c
> @@ -135,6 +135,40 @@ int __init board_staging_register_clock(const struct board_staging_clk *bsc)
>         return error;
>  }
>
> +#ifdef CONFIG_PM_GENERIC_DOMAINS_OF
> +static int board_staging_add_dev_domain(struct platform_device *pdev,
> +                                       const char *domain)
> +{
> +       struct of_phandle_args pd_args;
> +       struct generic_pm_domain *pd;
> +       struct device_node *np;
> +
> +       np = of_find_node_by_path(domain);
> +       if (!np) {
> +               pr_err("Cannot find domain node %s\n", domain);
> +               return -ENOENT;
> +       }
> +
> +       pd_args.np = np;
> +       pd_args.args_count = 0;
> +       pd = of_genpd_get_from_provider(&pd_args);
> +       if (IS_ERR(pd)) {
> +               pr_err("Cannot find genpd %s (%ld)\n", domain, PTR_ERR(pd));
> +               return PTR_ERR(pd);
> +
> +       }
> +       pr_debug("Found genpd %s for device %s\n", pd->name, pdev->name);
> +
> +       return pm_genpd_add_device(pd, &pdev->dev);
> +}
> +#else
> +static inline int board_staging_add_dev_domain(struct platform_device *pdev,
> +                                              const char *domain)
> +{
> +       return 0;
> +}
> +#endif
> +
>  int __init board_staging_register_device(const struct board_staging_dev *dev)
>  {
>         struct platform_device *pdev = dev->pdev;
> @@ -161,7 +195,7 @@ int __init board_staging_register_device(const struct board_staging_dev *dev)
>         }
>
>         if (dev->domain)
> -               __pm_genpd_name_add_device(dev->domain, &pdev->dev, NULL);
> +               board_staging_add_dev_domain(pdev, dev->domain);
>
>         return error;
>  }
> --
> 1.9.1
>
> Gr{oetje,eeting}s,
>
>                                                 Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                                             -- Linus Torvalds
