From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] i2c: rcar: disable runtime PM correctly in slave mode
Date: Wed, 16 Dec 2015 16:55:28 +0100
Message-ID: <CAMuHMdV81YwhVn_BYTaEybZhW04KFg_gERPJ88UsKSSSwWcvKg@mail.gmail.com>
References: <1450263756-12013-1-git-send-email-wsa@the-dreams.de>
	<Pine.LNX.4.44L0.1512161011070.1751-100000@iolanthe.rowland.org>
	<20151216154358.GA14817@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner@vger.kernel.org>
In-Reply-To: <20151216154358.GA14817@katana>
Sender: linux-i2c-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Alan Stern <stern@rowland.harvard.edu>, Linux I2C <linux-i2c@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Wolfram,

On Wed, Dec 16, 2015 at 4:43 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
> I have another case, may I ask your advice about this, too? When an I2C
> bus is marked in DT as multi-master, then RuntimePM also needs to be
> disabled, because arbitration detection needs to stay awake. I am
> currently implementing this for the i2c-rcar driver:
>
> -       pm_runtime_enable(dev);
> +       /* No RuntimePM in multi-master to keep arbitration working */
> +       if (!of_get_property(dev->of_node, "multi-master", NULL)) {
> +               pm_runtime_enable(dev);
> +               priv->flags |= ID_P_PM;
> +       }
> +
>         pm_runtime_get_sync(dev);
>         ...
>
> @@ -664,7 +673,8 @@ static int rcar_i2c_remove(struct platform_device *pdev)
>         struct device *dev = &pdev->dev;
>
>         i2c_del_adapter(&priv->adap);
> -       pm_runtime_disable(dev);
> +       if (priv->flags & ID_P_PM)
> +               pm_runtime_disable(dev);
>
>         return 0;
>  }
>
> Here, I'd tend to keep using enable/disable, although get/put would
> probably also work. What is the rule of thumb using this pattern or the
> other?

Have you actually tried the above?

All our drivers rely on Runtime PM for the power/clock domain handling.
I believe the pm_runtime_get_sync() won't do anything if you haven't enabled
Runtime PM for the device, so the device's module clock won't be enabled at
all.

Hence I think you should add just add additional pm_runtime_get_sync()/
pm_runtime_put() calls in the driver's probe() and remove() methods if
multi-master mode is enabled.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
