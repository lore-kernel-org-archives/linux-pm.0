From: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Subject: Re: [PATCH 1/3] thinkpad_acpi: add support for
 inhibit_charge
Date: Mon, 14 May 2018 08:39:28 -0300
Message-ID: <20180514113928.dnsxjqov7l6rvorb@khazad-dum.debian.net>
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
Cc: Platform Driver <platform-driver-x86-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Kevin Locke <kevin-yFOG++GfaLUI8/NkjqMgMw@public.gmane.org>, "Rafael J. Wysocki" <rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Henrique de Moraes Holschuh <ibm-acpi-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>, Linux PM <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Robert Moore <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Ognjen Galic <smclt30p-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, ACPI Devel Maling List <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Darren Hart <dvhart-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, devel-E0kO6a4B6psdnm+yROfE0A@public.gmane.org, ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Andy Shevchenko <andy-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Mon, 14 May 2018, Christoph B=F6hmwalder wrote:
> > +	case INHIBIT_CHARGE:
> > +		if ACPI_FAILURE(tpacpi_battery_acpi_eval(GET_INHIBIT, ret, battery))
> > +			return -ENODEV;
> > +
> > +		/* The inhibit charge status is in the first bit */
> > +		*ret =3D *ret & 0x01;
> > +		return 0;

Do we know what is in the other bits?  If so, please document the ACPI
method using a comment somewhere in the driver code, like you did for
SET_INHIBIT.

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

Much on the driver doesn't, because it is _OLD_.  But yeah, it is
preferrable to fix this as we add code, so it would be good to have all
new (and modified) comments switched to modern kernel style.

> > +	case INHIBIT_CHARGE:
> > +		if (!battery_info.batteries[battery].inhibit_support)
> > +			return -ENODEV;
> > +		/* The only valid values are 1 and 0 */
> > +		if (value !=3D 0 && value !=3D 1)
> =

> I'm not sure, but maybe `if (value < 2)` is better here?

Indeed... with a comment that says 0 =3D main battery, 1 =3D extra/dock
battery or something.

-- =

  Henrique Holschuh

---------------------------------------------------------------------------=
---
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
