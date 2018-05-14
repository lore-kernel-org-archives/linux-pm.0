From: Ognjen =?utf-8?B?R2FsacSH?= <smclt30p-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/3] thinkpad_acpi: add support for
 inhibit_charge
Date: Mon, 14 May 2018 15:36:51 +0200
Message-ID: <20180514133651.GA6417@thinkpad>
References: <20180513152937.GA5072@thinkpad>
 <20180514094620.wfoom4mwwyqb7qe5@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20180514094620.wfoom4mwwyqb7qe5@localhost>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/ibm-acpi-devel>,
 <mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ibm-acpi-devel>
List-Post: <mailto:ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
 <mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Christoph =?iso-8859-1?Q?B=F6hmwalder?= <christoph-KeW1gJXA36yNJhrcwGid2A@public.gmane.org>
Cc: Platform Driver <platform-driver-x86-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Rafael J. Wysocki" <rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Henrique de Moraes Holschuh <ibm-acpi-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>, Linux PM <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Robert Moore <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, ACPI Devel Maling List <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kevin Locke <kevin-yFOG++GfaLUI8/NkjqMgMw@public.gmane.org>, Darren Hart <dvhart-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, devel-E0kO6a4B6psdnm+yROfE0A@public.gmane.org, ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Andy Shevchenko <andy-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Mon, May 14, 2018 at 11:46:20AM +0200, Christoph B=F6hmwalder wrote:
> On Sun, May 13, 2018 at 05:29:37PM +0200, Ognjen Galic wrote:
> > Lenovo ThinkPad systems support the prevention of
> > battery charging via a manual override called Inhibit Charge.
> > =

> > This patch adds support for that attribute and exposes it via the
> > battery ACPI driver in the generic location:
> > =

> > /sys/class/power_supply/BATX/inhibit_charge
> > =

> > Signed-off-by: Ognjen Galic <smclt30p-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> > ---
> >  drivers/platform/x86/thinkpad_acpi.c | 66 +++++++++++++++++++++++++++-
> >  1 file changed, 64 insertions(+), 2 deletions(-)
> > =

> > diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x8=
6/thinkpad_acpi.c
> > index da1ca485..b8b74889 100644
> > --- a/drivers/platform/x86/thinkpad_acpi.c
> > +++ b/drivers/platform/x86/thinkpad_acpi.c
> > @@ -9233,6 +9233,11 @@ static struct ibm_struct mute_led_driver_data =
=3D {
> >  #define GET_STOP	"BCSG"
> >  #define SET_STOP	"BCSS"
> >  =

> > +#define SET_INHIBIT	"BICS"
> > +#define GET_INHIBIT	"BICG"
> > +
> > +#define INHIBIT_ATTR	"inhibit_charge"
> > +
> >  #define START_ATTR "charge_start_threshold"
> >  #define STOP_ATTR  "charge_stop_threshold"
> >  =

> > @@ -9251,6 +9256,7 @@ enum {
> >  	/* This is used in the get/set helpers */
> >  	THRESHOLD_START,
> >  	THRESHOLD_STOP,
> > +	INHIBIT_CHARGE
> >  };
> >  =

> >  struct tpacpi_battery_data {
> > @@ -9258,6 +9264,7 @@ struct tpacpi_battery_data {
> >  	int start_support;
> >  	int charge_stop;
> >  	int stop_support;
> > +	int inhibit_support;
> >  };
> >  =

> >  struct tpacpi_battery_driver_data {
> > @@ -9315,6 +9322,13 @@ static int tpacpi_battery_get(int what, int batt=
ery, int *ret)
> >  		if (*ret =3D=3D 0)
> >  			*ret =3D 100;
> >  		return 0;
> > +	case INHIBIT_CHARGE:
> > +		if ACPI_FAILURE(tpacpi_battery_acpi_eval(GET_INHIBIT, ret, battery))
> > +			return -ENODEV;
> > +
> > +		/* The inhibit charge status is in the first bit */
> > +		*ret =3D *ret & 0x01;
> > +		return 0;
> >  	default:
> >  		pr_crit("wrong parameter: %d", what);
> >  		return -EINVAL;
> > @@ -9343,6 +9357,21 @@ static int tpacpi_battery_set(int what, int batt=
ery, int value)
> >  			return -ENODEV;
> >  		}
> >  		return 0;
> > +	case INHIBIT_CHARGE:
> > +		/* When setting inhbitit charge, we set a default vaulue of
> =

> This comment does not adhere to the Linux coding style

I followed the style in the driver.

> =

> > +		 * always breaking on AC detach and the effective time is set to
> > +		 * be permanent.
> > +		 * The battery ID is in bits 4-5, 2 bits and the effective time
> > +		 * is in bits 8-23, 2 bytes. A time of FFFF indicates forever.
> > +		 */
> > +		param =3D value;
> > +		param |=3D battery << 4;
> > +		param |=3D 0xFFFF << 8;
> > +		if ACPI_FAILURE(tpacpi_battery_acpi_eval(SET_INHIBIT, &ret, param)) {
> > +			pr_err("failed to set inhibit charge on %d", battery);
> > +			return -ENODEV;
> > +		}
> > +		return 0;
> >  	default:
> >  		pr_crit("wrong parameter: %d", what);
> >  		return -EINVAL;
> > @@ -9359,6 +9388,8 @@ static int tpacpi_battery_probe(int battery)
> >  	 * 2) Check for support
> >  	 * 3) Get the current stop threshold
> >  	 * 4) Check for support
> > +	 * 5) Check for inhibit charge support
> > +	 * 6) Get the current inhibit charge status
> >  	 */
> >  	if (acpi_has_method(hkey_handle, GET_START)) {
> >  		if ACPI_FAILURE(tpacpi_battery_acpi_eval(GET_START, &ret, battery)) {
> > @@ -9395,10 +9426,16 @@ static int tpacpi_battery_probe(int battery)
> >  			return -ENODEV;
> >  		}
> >  	}
> > -	pr_info("battery %d registered (start %d, stop %d)",
> > +	if (acpi_has_method(hkey_handle, GET_INHIBIT))
> > +		if (!ACPI_FAILURE(tpacpi_battery_acpi_eval(GET_INHIBIT, &ret, batter=
y)))
> > +			/* Support is marked in bit 5 */
> > +			battery_info.batteries[battery].inhibit_support =3D ret & BIT(5);
> > +
> > +	pr_info("battery %d registered (start %d, stop %d, inhibit: %d)",
> >  			battery,
> >  			battery_info.batteries[battery].charge_start,
> > -			battery_info.batteries[battery].charge_stop);
> > +			battery_info.batteries[battery].charge_stop,
> > +			battery_info.batteries[battery].inhibit_support);
> >  =

> >  	return 0;
> >  }
> > @@ -9484,6 +9521,15 @@ static ssize_t tpacpi_battery_store(int what,
> >  		if (tpacpi_battery_set(THRESHOLD_STOP, battery, value))
> >  			return -EINVAL;
> >  		return count;
> > +	case INHIBIT_CHARGE:
> > +		if (!battery_info.batteries[battery].inhibit_support)
> > +			return -ENODEV;
> > +		/* The only valid values are 1 and 0 */
> > +		if (value !=3D 0 && value !=3D 1)
> =

> I'm not sure, but maybe `if (value < 2)` is better here?

I think the exisiting validation is just fine. Anything other is
cosmetic and obfuscation IMO.

> =

> > +			return -EINVAL;
> > +		if (tpacpi_battery_set(INHIBIT_CHARGE, battery, value))
> > +			return -ENODEV;
> > +		return count;
> >  	default:
> >  		pr_crit("Wrong parameter: %d", what);
> >  		return -EINVAL;
> > @@ -9546,12 +9592,28 @@ static ssize_t charge_stop_threshold_store(stru=
ct device *dev,
> >  	return tpacpi_battery_store(THRESHOLD_STOP, dev, buf, count);
> >  }
> >  =

> > +static ssize_t inhibit_charge_store(struct device *dev,
> > +				struct device_attribute *attr,
> > +				const char *buf, size_t count)
> > +{
> > +	return tpacpi_battery_store(INHIBIT_CHARGE, dev, buf, count);
> > +}
> > +
> > +static ssize_t inhibit_charge_show(struct device *device,
> > +				struct device_attribute *attr,
> > +				char *buf)
> > +{
> > +	return tpacpi_battery_show(INHIBIT_CHARGE, device, buf);
> > +}
> > +
> >  static DEVICE_ATTR_RW(charge_start_threshold);
> >  static DEVICE_ATTR_RW(charge_stop_threshold);
> > +static DEVICE_ATTR_RW(inhibit_charge);
> >  =

> >  static struct attribute *tpacpi_battery_attrs[] =3D {
> >  	&dev_attr_charge_start_threshold.attr,
> >  	&dev_attr_charge_stop_threshold.attr,
> > +	&dev_attr_inhibit_charge.attr,
> >  	NULL,
> >  };
> >  =

> > -- =

> > 2.17.0
> > =


---------------------------------------------------------------------------=
---
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
