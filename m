From: Guenter Roeck <groeck@google.com>
Subject: Re: [PATCH 1/2] power: supply: add input voltage limit property.
Date: Wed, 21 Nov 2018 11:00:57 -0800
Message-ID: <CABXOdTc3+ffgdjs6TbC0hZu0rbtExyO4RehGbD89ktqygA17dQ@mail.gmail.com>
References: <20181121153444.24747-1-enric.balletbo@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181121153444.24747-1-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: linux-pm@vger.kernel.org, Sebastian Reichel <sre@kernel.org>, Sameer Nanda <snanda@chromium.org>, Gwendal Grignou <gwendal@chromium.org>, linux-kernel <linux-kernel@vger.kernel.org>, Guenter Roeck <groeck@chromium.org>, kernel@collabora.com, Benson Leung <bleung@chromium.org>, rjw@rjwysocki.net, len.brown@intel.com, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On Wed, Nov 21, 2018 at 7:34 AM Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:
>
> We have a problem with USBPD chargers which under certain conditions
> can result in system overheating if the voltage provided by the USBPD
> port is too high. While the preferred means to control this would be
> through devicetree or ACPI settings, this is not always possible, and
> we need to have a means to set a voltage limit.
>
> This patch exposes a new property, similar to input current limit, to
> re-configure the maximum voltage from the external supply at runtime
> based on system-level knowledge or user input.
>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>


Reviewed-by: Guenter Roeck <groeck@chromium.org>

>
> ---
>
>  Documentation/power/power_supply_class.txt | 2 ++
>  drivers/power/supply/power_supply_sysfs.c  | 1 +
>  include/linux/power_supply.h               | 1 +
>  3 files changed, 4 insertions(+)
>
> diff --git a/Documentation/power/power_supply_class.txt b/Documentation/power/power_supply_class.txt
> index 300d37896e51..7b4be615b4f8 100644
> --- a/Documentation/power/power_supply_class.txt
> +++ b/Documentation/power/power_supply_class.txt
> @@ -137,6 +137,8 @@ power supply object.
>
>  INPUT_CURRENT_LIMIT - input current limit programmed by charger. Indicates
>  the current drawn from a charging source.
> +INPUT_VOLTAGE_LIMIT - input voltage limit programmed by charger. Indicates
> +the voltage limit from a charging source.
>
>  CHARGE_CONTROL_LIMIT - current charge control limit setting
>  CHARGE_CONTROL_LIMIT_MAX - maximum charge control limit setting
> diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
> index dce24f596160..5848742ebb59 100644
> --- a/drivers/power/supply/power_supply_sysfs.c
> +++ b/drivers/power/supply/power_supply_sysfs.c
> @@ -275,6 +275,7 @@ static struct device_attribute power_supply_attrs[] = {
>         POWER_SUPPLY_ATTR(charge_control_limit),
>         POWER_SUPPLY_ATTR(charge_control_limit_max),
>         POWER_SUPPLY_ATTR(input_current_limit),
> +       POWER_SUPPLY_ATTR(input_voltage_limit),
>         POWER_SUPPLY_ATTR(energy_full_design),
>         POWER_SUPPLY_ATTR(energy_empty_design),
>         POWER_SUPPLY_ATTR(energy_full),
> diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
> index f80769175c56..608ba88e32ee 100644
> --- a/include/linux/power_supply.h
> +++ b/include/linux/power_supply.h
> @@ -122,6 +122,7 @@ enum power_supply_property {
>         POWER_SUPPLY_PROP_CHARGE_CONTROL_LIMIT,
>         POWER_SUPPLY_PROP_CHARGE_CONTROL_LIMIT_MAX,
>         POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT,
> +       POWER_SUPPLY_PROP_INPUT_VOLTAGE_LIMIT,
>         POWER_SUPPLY_PROP_ENERGY_FULL_DESIGN,
>         POWER_SUPPLY_PROP_ENERGY_EMPTY_DESIGN,
>         POWER_SUPPLY_PROP_ENERGY_FULL,
> --
> 2.19.1
>
