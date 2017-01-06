From: Matt Ranostay <matt-sk+viVC6FLCDq+mSdOJa79kegs52MxvZ@public.gmane.org>
Subject: Re: [PATCH v2 3/3] power: bq27xxx: add support for NVRAM R/W access
Date: Thu, 5 Jan 2017 18:34:03 -0800
Message-ID: <CAJ_EiSTVv90QSB6TY7+5KXWPbLkkr5vEXpDQrQ0VCvtAkddt5A@mail.gmail.com>
References: <20170105021007.22088-1-matt@ranostay.consulting>
 <20170105021007.22088-4-matt@ranostay.consulting> <20170106015314.7qju6eodkwldty6h@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170106015314.7qju6eodkwldty6h@earth>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On Thu, Jan 5, 2017 at 5:53 PM, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> On Wed, Jan 04, 2017 at 06:10:07PM -0800, Matt Ranostay wrote:
>> Initial support for access and modification of the non-volatile regions
>> of the bq27425 fuel gauge DesignEnergy, DesignCapacity, and
>> TerminateVoltage settings.
>>
>> This is intended for fine tuning the fuel gauge state machine for the
>> respective battery specifications.
>>
>> Cc: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
>> Signed-off-by: Matt Ranostay <matt-sk+viVC6FLCDq+mSdOJa79kegs52MxvZ@public.gmane.org>
>> ---
>>  drivers/power/supply/bq27xxx_battery_i2c.c | 335 ++++++++++++++++++++++=
+++++++
>>  include/linux/power/bq27xxx_battery.h      |   4 +
>>  2 files changed, 339 insertions(+)
>
> I only skipped over this one, as the changed DT binding requires
> quite some changes in this patch anyways. Here are a couple of
> comments how I would like to see this implemented:
>
> Add a patch for the power-supply core, which implements a
> structure for the battery info. Something like this:
>
> struct power_supply_battery_info {
>     uint32 energy; /* =C2=B5Wh */
>     uint32 power;  /* =C2=B5Ah */
>     uint32 nominal_voltage; /* =C2=B5V */
>     /* ... */
> };
>
> And a function in the core framework, which gets the information
> from DT. The function itself should *not* be DT specific, so that
> ACPI/platformdata/whatever support can be added later without
> modifying every single driver.
>
> static struct power_supply_battery_info*
> power_supply_get_battery_info(struct power_supply *psy) {
>     if (psy->dt) {
>         /* get battery phandle or return -ENXIO */
>         /* fill and return struct */
>     }
>
>     return -ENOTSUP;
> }
>
> Then call power_supply_get_battery_info() during bq27xxx probe and
> use the struct to initialize the registers. Also I expect that
> functionality in bq27xxx_battery.c instead of bq27xxx_battery_i2c.c,
> since it's not I=C2=B2C specific.

They may not be i2c specific but they are only used by the i2c path of
the code currently. Do you think that platform data would ever have a
struct to pass with the respective data?

Also it would have to be in bq27xxx_battery_setup() and not
bq27xxx_battery_platform_probe() since the former is only thing called
by both code paths.


>
> -- Sebastian
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
