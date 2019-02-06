From: Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v7 05/10] clk: bd718x7: Support ROHM BD70528 clk block
Date: Wed, 06 Feb 2019 09:31:27 -0800
Message-ID: <154947428734.74891.4523492147164733315@swboyd.mtv.corp.google.com>
References: <cover.1549444366.git.matti.vaittinen@fi.rohmeurope.com> <88c49b30bbb4b1f3ecc24d333647585e2c82f4e4.1549444366.git.matti.vaittinen@fi.rohmeurope.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <88c49b30bbb4b1f3ecc24d333647585e2c82f4e4.1549444366.git.matti.vaittinen@fi.rohmeurope.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>, mazziesaccount@gmail.com
Cc: Guenter Roeck <linux@roeck-us.net>, heikki.haikola@fi.rohmeurope.com, mikko.mutanen@fi.rohmeurope.com, lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, broonie@kernel.org, gregkh@linuxfoundation.org, rafael@kernel.org, mturquette@baylibre.com, linus.walleij@linaro.org, bgolaszewski@baylibre.com, sre@kernel.org, lgirdwood@gmail.com, a.zummo@towertech.it, alexandre.belloni@bootlin.com, wim@linux-watchdog.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org, linux-watchdog@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Quoting Matti Vaittinen (2019-02-06 01:39:38)
> @@ -86,9 +87,21 @@ static int bd71837_clk_probe(struct platform_device *p=
dev)
>                 dev_err(&pdev->dev, "No parent clk found\n");
>                 return -EINVAL;
>         }
> -
> -       c->reg =3D BD718XX_REG_OUT32K;
> -       c->mask =3D BD718XX_OUT32K_EN;
> +       switch (mfd->chip_type) {
> +       case ROHM_CHIP_TYPE_BD71837:
> +       case ROHM_CHIP_TYPE_BD71847:
> +

Nitpick: why the extra newline above?

> +               c->reg =3D BD718XX_REG_OUT32K;
> +               c->mask =3D BD718XX_OUT32K_EN;
> +               break;
> +       case ROHM_CHIP_TYPE_BD70528:
> +               c->reg =3D BD70528_REG_CLK_OUT;
> +               c->mask =3D BD70528_CLK_OUT_EN_MASK;
> +               break;
> +       default:
> +               dev_err(&pdev->dev, "Unknown clk chip\n");
> +               return -EINVAL;
> +       }
>         c->mfd =3D mfd;
>         c->pdev =3D pdev;
>         c->hw.init =3D &init;
