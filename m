From: Matt Ranostay <matt@ranostay.consulting>
Subject: Re: [RFC 1/2] power: power_supply: add new property POWER_SUPPLY_PROP_POLL_INTERVAL
Date: Tue, 27 Sep 2016 16:53:22 -0700
Message-ID: <CAJ_EiSTQ09yn7FpDTHa-daWg8jd6DD_GZ+gZXKcryrMPS+guLQ@mail.gmail.com>
References: <1474523544-3064-1-git-send-email-matt@ranostay.consulting> <1474523544-3064-2-git-send-email-matt@ranostay.consulting>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1474523544-3064-2-git-send-email-matt@ranostay.consulting>
Sender: linux-kernel-owner@vger.kernel.org
To: Matt Ranostay <mranostay@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wed, Sep 21, 2016 at 10:52 PM, Matt Ranostay <mranostay@gmail.com> wrote:
> Add new POWER_SUPPLY_PROP_POLL_INTERVAL property to display/set update
> interval in milliseconds of the device.

Should be seconds.
>
> Signed-off-by: Matt Ranostay <matt@ranostay.consulting>
> ---
>  Documentation/power/power_supply_class.txt | 1 +
>  drivers/power/power_supply_sysfs.c         | 1 +
>  include/linux/power_supply.h               | 1 +
>  3 files changed, 3 insertions(+)
>
> diff --git a/Documentation/power/power_supply_class.txt b/Documentation/power/power_supply_class.txt
> index 82dacc06e355..c2e97872374a 100644
> --- a/Documentation/power/power_supply_class.txt
> +++ b/Documentation/power/power_supply_class.txt
> @@ -158,6 +158,7 @@ while battery powers a load)
>  TIME_TO_FULL - seconds left for battery to be considered full (i.e.
>  while battery is charging)
>
> +POLL_INTERVAL - seconds between battery stats querying
>
>  Battery <-> external power supply interaction
>  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> diff --git a/drivers/power/power_supply_sysfs.c b/drivers/power/power_supply_sysfs.c
> index 80fed98832f9..df66fad322c2 100644
> --- a/drivers/power/power_supply_sysfs.c
> +++ b/drivers/power/power_supply_sysfs.c
> @@ -198,6 +198,7 @@ static struct device_attribute power_supply_attrs[] = {
>         POWER_SUPPLY_ATTR(scope),
>         POWER_SUPPLY_ATTR(charge_term_current),
>         POWER_SUPPLY_ATTR(calibrate),
> +       POWER_SUPPLY_ATTR(poll_interval),
>         /* Properties of type `const char *' */
>         POWER_SUPPLY_ATTR(model_name),
>         POWER_SUPPLY_ATTR(manufacturer),
> diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
> index 751061790626..5d45ac511a64 100644
> --- a/include/linux/power_supply.h
> +++ b/include/linux/power_supply.h
> @@ -148,6 +148,7 @@ enum power_supply_property {
>         POWER_SUPPLY_PROP_SCOPE,
>         POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT,
>         POWER_SUPPLY_PROP_CALIBRATE,
> +       POWER_SUPPLY_PROP_POLL_INTERVAL, /* in seconds! */
>         /* Properties of type `const char *' */
>         POWER_SUPPLY_PROP_MODEL_NAME,
>         POWER_SUPPLY_PROP_MANUFACTURER,
> --
> 2.7.4
>
