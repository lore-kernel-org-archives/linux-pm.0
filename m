From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Subject: RE: [PATCH v3 1/2] power: supply: add input voltage limit property
Date: Thu, 13 Dec 2018 14:13:34 +0000
Message-ID: <AM5PR1001MB0994B12D02798D56BC1C550780A00@AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM>
References: <20181213120944.30967-1-enric.balletbo@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181213120944.30967-1-enric.balletbo@collabora.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "sre@kernel.org" <sre@kernel.org>
Cc: Sameer Nanda <snanda@chromium.org>, "bleung@chromium.org" <bleung@chromium.org>, "gwendal@chromium.org" <gwendal@chromium.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "groeck@chromium.org" <groeck@chromium.org>, Adam Thomson <Adam.Thomson.Opensource@diasemi.com>, "kernel@collabora.com" <kernel@collabora.com>, Pavel Machek <pavel@ucw.cz>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

On 13 December 2018 12:10, Enric Balletbo i Serra wrote:

> This is part of the Pixel C's thermal management strategy to effectively =
limit the
> input power to 5V 3A when the screen is on. When the screen is on, the di=
splay,
> the CPU, and the GPU all contribute more heat to the system than while th=
e
> screen is off, and we made a tradeoff to throttle the charger in order to=
 give
> more of the thermal budget to those other components.
>=20
> So there's nothing fundamentally broken about the hardware that would cau=
se
> the Pixel C to malfunction if we were charging at 9V or 12V instead of 5V=
 when
> the screen is on, ie if userspace doesn't change this.
>=20
> What would happen is that you wouldn't meet Google's skin temperature tar=
gets
> on the system if the charger was allowed to run at 9V or 12V with the scr=
een on.
>=20
> For folks hacking on Pixel Cs (which is now outside of Google's official =
support
> window for Android) and customizing their own kernel and userspace this w=
ould
> be acceptable, but we wanted to expose this feature in the power supply
> properties because the feature does exist in the Emedded Controller firmw=
are of
> the Pixel C and all of Google's Chromebooks with USB-C made since 2015 in=
 case
> someone running an up to date kernel wanted to limit the charging power f=
or
> thermal or other reasons.
>=20
> This patch exposes a new property, similar to input current limit, to re-=
configure
> the maximum voltage from the external supply at runtime based on system-l=
evel
> knowledge or user input.
>=20
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Reviewed-by: Guenter Roeck <groeck@chromium.org>

Acked-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>

> ---
>=20
> Changes in v3:
> - Improve commit log and documentation with Benson comments.
>=20
> Changes in v2:
> - Document the new property in ABI/testing/sysfs-class-power.
> - Add the Reviewed-by Guenter Roeck tag.
>=20
>  Documentation/ABI/testing/sysfs-class-power | 15 +++++++++++++++
> Documentation/power/power_supply_class.txt  |  2 ++
>  drivers/power/supply/power_supply_sysfs.c   |  1 +
>  include/linux/power_supply.h                |  1 +
>  4 files changed, 19 insertions(+)
>=20
> diff --git a/Documentation/ABI/testing/sysfs-class-power
> b/Documentation/ABI/testing/sysfs-class-power
> index 5e23e22dce1b..6dee5c105a28 100644
> --- a/Documentation/ABI/testing/sysfs-class-power
> +++ b/Documentation/ABI/testing/sysfs-class-power
> @@ -335,6 +335,21 @@ Description:
>  		Access: Read, Write
>  		Valid values: Represented in microamps
>=20
> +What:		/sys/class/power_supply/<supply_name>/input_voltage_limit
> +Date:		Nov 2018
> +Contact:	linux-pm@vger.kernel.org
> +Description:
> +		This entry configures the incoming VBUS voltage limit currently
> +		set in the supply. Normally this is configured based on
> +		system-level knowledge or user input (e.g. This is part of the
> +		Pixel C's thermal management strategy to effectively limit the
> +		input power to 5V when the screen is on to meet Google's skin
> +		temperature targets). Note that this feature should not be
> +		used for safety critical things.
> +
> +		Access: Read, Write
> +		Valid values: Represented in microvolts
> +
>  What:		/sys/class/power_supply/<supply_name>/online,
>  Date:		May 2007
>  Contact:	linux-pm@vger.kernel.org
> diff --git a/Documentation/power/power_supply_class.txt
> b/Documentation/power/power_supply_class.txt
> index 300d37896e51..7b4be615b4f8 100644
> --- a/Documentation/power/power_supply_class.txt
> +++ b/Documentation/power/power_supply_class.txt
> @@ -137,6 +137,8 @@ power supply object.
>=20
>  INPUT_CURRENT_LIMIT - input current limit programmed by charger. Indicat=
es
> the current drawn from a charging source.
> +INPUT_VOLTAGE_LIMIT - input voltage limit programmed by charger.
> +Indicates the voltage limit from a charging source.
>=20
>  CHARGE_CONTROL_LIMIT - current charge control limit setting
> CHARGE_CONTROL_LIMIT_MAX - maximum charge control limit setting diff --gi=
t
> a/drivers/power/supply/power_supply_sysfs.c
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
> diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h =
index
> f80769175c56..608ba88e32ee 100644
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
> 2.19.2
