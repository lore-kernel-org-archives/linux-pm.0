From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH 09/15] Platform: OLPC: add a regulator for the DCON
Date: Fri, 19 Oct 2018 16:39:35 +0300
Message-ID: <CAHp75VcwjoNT76F0qn=2CjETRCdNjX2P-GRLWT4pqJ-9Ch6+ZQ@mail.gmail.com>
References: <20181010172300.317643-1-lkundrak@v3.sk> <20181010172300.317643-10-lkundrak@v3.sk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181010172300.317643-10-lkundrak@v3.sk>
Sender: linux-kernel-owner@vger.kernel.org
To: Lubomir Rintel <lkundrak@v3.sk>
Cc: Mark Brown <broonie@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, quozl@laptop.org, Sebastian Reichel <sre@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Eric Miao <eric.y.miao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Daniel Mack <daniel@zonque.org>, Robert Jarzmik <robert.jarzmik@free.fr>, linux-spi <linux-spi@vger.kernel.org>, devicetree <devicetree@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, Platform Driver <platform-driver-x86@vger.kernel.org>, devel@driverdev.osuosl.or
List-Id: linux-pm@vger.kernel.org

On Wed, Oct 10, 2018 at 8:23 PM Lubomir Rintel <lkundrak@v3.sk> wrote:
>
> All OLPC ECs are able to turn the power to the DCON on an off. Use the
> regulator framework to expose the functionality.

> +static int olpc_ec_set_dcon_power(struct olpc_ec_priv *ec, bool state)
> +{
> +       unsigned char ec_byte = state;
> +       int ret;
> +
> +       if (ec->dcon_enabled == state)
> +               return 0;
> +

> +       ret = olpc_ec_cmd(EC_DCON_POWER_MODE, &ec_byte, 1, NULL, 0);
> +       if (ret == 0)
> +               ec->dcon_enabled = state;
> +
> +       return ret;

I would prefer to see usual pattern, i.e.

if (ret)
 return ret;

...
return 0;

This comment applies to entire series. (Yes, you might address an old
code in a separate patch to be on consistent side)

> +}

> +       return olpc_ec_set_dcon_power(ec, 1);

defined as boolean, supplied an int. Not good.

> +       return olpc_ec_set_dcon_power(ec, 0);

Ditto.

> +static int dcon_regulator_is_enabled(struct regulator_dev *rdev)
> +       return ec->dcon_enabled;

Ditto.

-- 
With Best Regards,
Andy Shevchenko
