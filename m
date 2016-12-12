From: Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH 3/3] power: supply: bq24735-charger: allow chargers to
 share the ac-detect gpio
Date: Mon, 12 Dec 2016 12:39:32 +0100
Message-ID: <f3eab793-84bc-53da-9485-8a12f95c7f59@axentia.se>
References: <1481540424-19293-1-git-send-email-peda@axentia.se>
 <1481540424-19293-4-git-send-email-peda@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1481540424-19293-4-git-send-email-peda@axentia.se>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 2016-12-12 12:00, Peter Rosin wrote:
> If several parallel bq24735 chargers have their ac-detect gpios wired
> together (or if only one of the parallel bq24735 chargers have its
> ac-detect pin wired to a gpio, and the others are assumed to react the
> same), then all driver instances need to check the same gpio. But the
> gpio subsystem does not allow sharing gpios, so handle that locally.
> 
> However, only do this for the polling case, sharing is not supported if
> the ac detection is handled with interrupts.
> 
> Signed-off-by: Peter Rosin <peda@axentia.se>
> ---
>  drivers/power/supply/bq24735-charger.c | 101 +++++++++++++++++++++++++++++----
>  1 file changed, 90 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/power/supply/bq24735-charger.c b/drivers/power/supply/bq24735-charger.c
> index 3765806d5d46..3b21a064a9a7 100644
> --- a/drivers/power/supply/bq24735-charger.c
> +++ b/drivers/power/supply/bq24735-charger.c
> @@ -25,6 +25,7 @@
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> +#include <linux/of_gpio.h>
>  #include <linux/gpio/consumer.h>
>  #include <linux/power_supply.h>
>  #include <linux/slab.h>
> @@ -43,12 +44,24 @@
>  #define BQ24735_MANUFACTURER_ID		0xfe
>  #define BQ24735_DEVICE_ID		0xff
>  
> +struct bq24735;
> +
> +struct bq24735_shared {
> +	struct list_head		list;
> +	struct bq24735			*owner;
> +	struct gpio_desc		*status_gpio;
> +};
> +
> +static struct mutex shared_lock;

Aww crap, that should of course be

static DEFINE_MUTEX(shared_lock);

Will fix in v2, but I'll wait for other feedback first. Why is it
impossible to see these things before hitting send?

Cheers,
peda
