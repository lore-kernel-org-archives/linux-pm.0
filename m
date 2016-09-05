From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 2/5 v2] thermal: rcar_gen3_thermal: Add R-Car Gen3 thermal driver
Date: Mon, 5 Sep 2016 12:01:58 +0200
Message-ID: <CAMuHMdXjywuuQG8LLMddOTjCpC5Ady3hVWvm_SM_AcpFScwWDw@mail.gmail.com>
References: <SIXPR06MB09069C18D1F37BE5DB1284B3A8E40@SIXPR06MB0906.apcprd06.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <SIXPR06MB09069C18D1F37BE5DB1284B3A8E40@SIXPR06MB0906.apcprd06.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Khiem Nguyen <khiem.nguyen.xt@renesas.com>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Wolfram Sang <wsa@the-dreams.de>, Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <damm+renesas@opensource.se>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Thao Phuong Le. Nguyen" <thao.nguyen.yb@rvc.renesas.com>, Hien Dang <hien.dang.eb@renesas.com>, Toru Oishi <toru.oishi.zj@renesas.com>
List-Id: linux-pm@vger.kernel.org

Hi Khiem

On Sat, Sep 3, 2016 at 7:25 AM, Khiem Nguyen
<khiem.nguyen.xt@renesas.com> wrote:
> --- /dev/null
> +++ b/drivers/thermal/rcar_gen3_thermal.c

> +static int rcar_gen3_thermal_probe(struct platform_device *pdev)
> +{

> +       priv->id = of_alias_get_id(dev->of_node, "tsc");
> +       if (priv->id < 0) {
> +               dev_err(dev, "Failed to get alias id (%d)\n", priv->id);
> +               ret = priv->id;
> +               goto error_unregister;
> +       }

In v1, Morimoto-san wondered whether the alias is really needed, but you
haven't addressed his question.

While aliases can be useful in DT source files, using aliases like this imposes
hardcoded instance numbers, which is something we try to avoid these days.
Also, this puts a hard requirement on the presence of the alias in DT, which
should be documented in the DT bindings.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
