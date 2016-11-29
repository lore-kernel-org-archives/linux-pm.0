From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v3 2/4] thermal: rcar_gen3_thermal: Add R-Car Gen3 thermal driver
Date: Tue, 29 Nov 2016 09:43:17 +0100
Message-ID: <CAMuHMdW=Ap6ENtN0_Q=MHkhGLy0WuJUPtdb7n34yNAw1rXR4Fw@mail.gmail.com>
References: <20161128210924.2921-1-wsa+renesas@sang-engineering.com> <20161128210924.2921-3-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34738 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754522AbcK2InU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 29 Nov 2016 03:43:20 -0500
In-Reply-To: <20161128210924.2921-3-wsa+renesas@sang-engineering.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Khiem Nguyen <khiem.nguyen.xt@renesas.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Hien Dang <hien.dang.eb@renesas.com>, Thao Nguyen <thao.nguyen.yb@rvc.renesas.com>

Hi Wolfram,

On Mon, Nov 28, 2016 at 10:09 PM, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> --- /dev/null
> +++ b/drivers/thermal/rcar_gen3_thermal.c

> +/* Structure for thermal temperature calculation */
> +struct equation_coefs {
> +       long a1;
> +       long b1;
> +       long a2;
> +       long b2;

Why long? Long has a different size for 32-bit and 64-bit platforms.
I know this is a driver for arm64, but if you need 64-bits, you want to make
this clear using s64, or long long.

> +static inline u32 rcar_gen3_thermal_read(struct rcar_gen3_thermal_tsc *tsc, u32 reg)

What a long function name...

> +{
> +       return ioread32(tsc->base + reg);
> +}
> +
> +static inline void rcar_gen3_thermal_write(struct rcar_gen3_thermal_tsc *tsc,
> +                                    u32 reg, u32 data)
> +{
> +       iowrite32(data, tsc->base + reg);
> +}

... so using the "convenience" wrappers is more (typing) work than using
io{read,write}32() directly?

> +static void _linear_coefficient_calculation(struct rcar_gen3_thermal_tsc *tsc,
> +                                           int *ptat, int *thcode)
> +{
> +       int tj_2;
> +       long a1, b1;
> +       long a2, b2;
> +       long a1_num, a1_den;
> +       long a2_num, a2_den;

s64?

> +       tj_2 = (CODETSD((ptat[1] - ptat[2]) * 137)
> +               / (ptat[0] - ptat[2])) - CODETSD(41);

Isn't "* 1000" easier to read then CODETSD()?

> +       /* calculate coefficients for linear equation */
> +       a1_num = CODETSD(thcode[1] - thcode[2]);
> +       a1_den = tj_2 - TJ_3;
> +       a1 = (10000 * a1_num) / a1_den;
> +       b1 = (10000 * thcode[2]) - ((a1 * TJ_3) / 1000);

Rounding needed for / 1000?

> +       a2_num = CODETSD(thcode[1] - thcode[0]);
> +       a2_den = tj_2 - TJ_1;
> +       a2 = (10000 * a2_num) / a2_den;
> +       b2 = (10000 * thcode[0]) - ((a2 * TJ_1) / 1000);

Idem.

> +static int rcar_gen3_thermal_probe(struct platform_device *pdev)
> +{
> +       struct rcar_gen3_thermal_priv *priv;
> +       struct device *dev = &pdev->dev;
> +       struct resource *res;
> +       struct thermal_zone_device *zone;
> +       int ret, i;

unsigned int i;

> +       const struct rcar_gen3_thermal_data *match_data = of_device_get_match_data(dev);
> +
> +       /* default values if FUSEs are missing */
> +       int ptat[3] = { 2351, 1509, 435 };

unsigned?

> +       int thcode[TSC_MAX_NUM][3] = {

unsigned?

> +               { 3248, 2800, 2221 },
> +               { 3245, 2795, 2216 },
> +               { 3250, 2805, 2237 },
> +       };
> +
> +       priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +       if (!priv)
> +               return -ENOMEM;
> +
> +       platform_set_drvdata(pdev, priv);
> +
> +       pm_runtime_enable(dev);
> +       pm_runtime_get_sync(dev);
> +
> +       for (i = 0; i < TSC_MAX_NUM; i++) {
> +               struct rcar_gen3_thermal_tsc *tsc;
> +
> +               tsc = devm_kzalloc(dev, sizeof(*tsc), GFP_KERNEL);
> +               if (!tsc)
> +                       return -ENOMEM;

Missing pm_runtime_put() etc.?

ret = -ENOMEM;
goto error_unregister;

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
