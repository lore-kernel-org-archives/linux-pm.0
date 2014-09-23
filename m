From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH v3 3/3] power: gpio-charger: do not use gpio value directly
Date: Tue, 23 Sep 2014 09:06:34 -0700
Message-ID: <CAD=FV=UNK4oGP9Vj7TeKMDqAPmEvbqRfVE8uu9ZtO4pfDbE=cQ@mail.gmail.com>
References: <1411473545-3290-1-git-send-email-heiko@sntech.de>
	<1411473545-3290-4-git-send-email-heiko@sntech.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1411473545-3290-4-git-send-email-heiko@sntech.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Heiko Stuebner <heiko@sntech.de>
Cc: sre@kernel.org, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Heiko Stuebner <heiko.stuebner@bq.com>
List-Id: linux-pm@vger.kernel.org

Heiko,

On Tue, Sep 23, 2014 at 4:59 AM, Heiko Stuebner <heiko@sntech.de> wrote:
> From: Heiko Stuebner <heiko.stuebner@bq.com>
>
> Some gpio implementations return interesting values for gpio_get_value when
> the value is not 0 - as seen on a imx6sl board. Therefore do not use the
> value returned from gpio_get_value directly but simply check for 0 or not 0.
>
> Signed-off-by: Heiko Stuebner <heiko.stuebner@bq.com>
> ---
>  drivers/power/gpio-charger.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/power/gpio-charger.c b/drivers/power/gpio-charger.c
> index 22f084a..7d4eab2 100644
> --- a/drivers/power/gpio-charger.c
> +++ b/drivers/power/gpio-charger.c
> @@ -57,7 +57,7 @@ static int gpio_charger_get_property(struct power_supply *psy,
>
>         switch (psp) {
>         case POWER_SUPPLY_PROP_ONLINE:
> -               val->intval = gpio_get_value_cansleep(pdata->gpio);
> +               val->intval = !!gpio_get_value_cansleep(pdata->gpio);
>                 val->intval ^= pdata->gpio_active_low;

...so I guess the interface is that gpio_active_low must be exactly 1
or 0.  Oh, and that's actually defined in gpio-charger.h!  I should
have checked that before.

Reviewed-by: Doug Anderson <dianders@chromium.org>
Tested-by: Doug Anderson <dianders@chromium.org>
