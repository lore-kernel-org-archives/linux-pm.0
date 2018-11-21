From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Subject: RE: [PATCH 1/2] power: supply: add input voltage limit property.
Date: Wed, 21 Nov 2018 22:11:47 +0000
Message-ID: <AM5PR1001MB0994B41A3CE03A098C4DC83680DA0@AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM>
References: <20181121153444.24747-1-enric.balletbo@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181121153444.24747-1-enric.balletbo@collabora.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "sre@kernel.org" <sre@kernel.org>
Cc: Sameer Nanda <snanda@chromium.org>, "gwendal@chromium.org" <gwendal@chromium.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "groeck@chromium.org" <groeck@chromium.org>, "kernel@collabora.com" <kernel@collabora.com>, "bleung@chromium.org" <bleung@chromium.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On 21 November 2018 15:35, Enric Balletbo i Serra wrote:

> We have a problem with USBPD chargers which under certain conditions=20
> can result in system overheating if the voltage provided by the USBPD=20
> port is too high. While the preferred means to control this would be=20
> through devicetree or ACPI settings, this is not always possible, and=20
> we need to have a means to set a voltage limit.
>=20
> This patch exposes a new property, similar to input current limit, to=20
> re-configure the maximum voltage from the external supply at runtime=20
> based on system-level knowledge or user input.

I think we should be adding new documentation to the following file for any=
 property changes:

Documentation/ABI/testing/sysfs-class-power

Sebastian can maybe comment further though.=20
=20
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
>=20
>  Documentation/power/power_supply_class.txt | 2 ++=20
> drivers/power/supply/power_supply_sysfs.c  | 1 +
>  include/linux/power_supply.h               | 1 +
>  3 files changed, 4 insertions(+)
>=20
> diff --git a/Documentation/power/power_supply_class.txt
> b/Documentation/power/power_supply_class.txt
> index 300d37896e51..7b4be615b4f8 100644
> --- a/Documentation/power/power_supply_class.txt
> +++ b/Documentation/power/power_supply_class.txt
> @@ -137,6 +137,8 @@ power supply object.
>=20
>  INPUT_CURRENT_LIMIT - input current limit programmed by charger.=20
> Indicates the current drawn from a charging source.
> +INPUT_VOLTAGE_LIMIT - input voltage limit programmed by charger.
> +Indicates the voltage limit from a charging source.
>=20
>  CHARGE_CONTROL_LIMIT - current charge control limit setting=20
> CHARGE_CONTROL_LIMIT_MAX - maximum charge control limit setting diff=20
> --git a/drivers/power/supply/power_supply_sysfs.c
> b/drivers/power/supply/power_supply_sysfs.c
> index dce24f596160..5848742ebb59 100644
> --- a/drivers/power/supply/power_supply_sysfs.c
> +++ b/drivers/power/supply/power_supply_sysfs.c
> @@ -275,6 +275,7 @@ static struct device_attribute power_supply_attrs[] =
=3D {
>  	POWER_SUPPLY_ATTR(charge_control_limit),
>  	POWER_SUPPLY_ATTR(charge_control_limit_max),
>  	POWER_SUPPLY_ATTR(input_current_limit),
> +	POWER_SUPPLY_ATTR(input_voltage_limit),
>  	POWER_SUPPLY_ATTR(energy_full_design),
>  	POWER_SUPPLY_ATTR(energy_empty_design),
>  	POWER_SUPPLY_ATTR(energy_full),
> diff --git a/include/linux/power_supply.h=20
> b/include/linux/power_supply.h index f80769175c56..608ba88e32ee 100644
> --- a/include/linux/power_supply.h
> +++ b/include/linux/power_supply.h
> @@ -122,6 +122,7 @@ enum power_supply_property {
>  	POWER_SUPPLY_PROP_CHARGE_CONTROL_LIMIT,
>  	POWER_SUPPLY_PROP_CHARGE_CONTROL_LIMIT_MAX,
>  	POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT,
> +	POWER_SUPPLY_PROP_INPUT_VOLTAGE_LIMIT,
>  	POWER_SUPPLY_PROP_ENERGY_FULL_DESIGN,
>  	POWER_SUPPLY_PROP_ENERGY_EMPTY_DESIGN,
>  	POWER_SUPPLY_PROP_ENERGY_FULL,
> --
> 2.19.1
