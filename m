From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH 07/15] Platform: OLPC: Avoid a warning if the EC didn't
 register yet
Date: Fri, 19 Oct 2018 16:11:50 +0300
Message-ID: <CAHp75Ve7v0xL-qd5Ri82W1z7jku_Mbxg531J_261-EW0dxsouQ@mail.gmail.com>
References: <20181010172300.317643-1-lkundrak@v3.sk> <20181010172300.317643-8-lkundrak@v3.sk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181010172300.317643-8-lkundrak@v3.sk>
Sender: linux-kernel-owner@vger.kernel.org
To: Lubomir Rintel <lkundrak@v3.sk>
Cc: Mark Brown <broonie@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, quozl@laptop.org, Sebastian Reichel <sre@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Eric Miao <eric.y.miao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Daniel Mack <daniel@zonque.org>, Robert Jarzmik <robert.jarzmik@free.fr>, linux-spi <linux-spi@vger.kernel.org>, devicetree <devicetree@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, Platform Driver <platform-driver-x86@vger.kernel.org>, devel@driverdev.osuosl.or
List-Id: linux-pm@vger.kernel.org

On Wed, Oct 10, 2018 at 8:23 PM Lubomir Rintel <lkundrak@v3.sk> wrote:
>
> Just return ENODEV, so that whoever attempted to use the EC call can
> defer their work.
>
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> ---
>  drivers/platform/olpc/olpc-ec.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/platform/olpc/olpc-ec.c b/drivers/platform/olpc/olpc-ec.c
> index 35a21c66cd0d..342f5bb7f7a8 100644
> --- a/drivers/platform/olpc/olpc-ec.c
> +++ b/drivers/platform/olpc/olpc-ec.c
> @@ -116,8 +116,11 @@ int olpc_ec_cmd(u8 cmd, u8 *inbuf, size_t inlen, u8 *outbuf, size_t outlen)
>         struct olpc_ec_priv *ec = ec_priv;
>         struct ec_cmd_desc desc;
>
> -       /* Ensure a driver and ec hook have been registered */
> -       if (WARN_ON(!ec_driver || !ec_driver->ec_cmd))
> +       /* Driver not yet registered. */
> +       if (!ec_driver)
> +               return -ENODEV;

Why -ENODEV is preferred over -EPROBE_DEFER?

> +
> +       if (WARN_ON(!ec_driver->ec_cmd))
>                 return -ENODEV;
>
>         if (!ec)
> --
> 2.19.0
>


-- 
With Best Regards,
Andy Shevchenko
