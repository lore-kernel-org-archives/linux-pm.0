From: Ognjen =?utf-8?B?R2FsacSH?= <smclt30p-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/3] thinkpad_acpi: add support for
 inhibit_charge
Date: Mon, 14 May 2018 15:38:43 +0200
Message-ID: <20180514133843.GB6417@thinkpad>
References: <20180513152937.GA5072@thinkpad>
 <20180514094620.wfoom4mwwyqb7qe5@localhost>
 <CAHp75VdPOH7J1X4ZXmRsQ1yrB5n5RRmhPneWOnu7TFOAysgE6Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAHp75VdPOH7J1X4ZXmRsQ1yrB5n5RRmhPneWOnu7TFOAysgE6Q-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/ibm-acpi-devel>,
 <mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ibm-acpi-devel>
List-Post: <mailto:ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
 <mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Platform Driver <platform-driver-x86-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Rafael J. Wysocki" <rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Henrique de Moraes Holschuh <ibm-acpi-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>, Linux PM <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Robert Moore <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, ACPI Devel Maling List <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Kevin Locke <kevin-yFOG++GfaLUI8/NkjqMgMw@public.gmane.org>, Darren Hart <dvhart-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Andy Shevchenko <andy-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, devel-E0kO6a4B6psdnm+yROfE0A@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On Mon, May 14, 2018 at 01:41:33PM +0300, Andy Shevchenko wrote:
> On Mon, May 14, 2018 at 12:46 PM, Christoph B=F6hmwalder
> <christoph-KeW1gJXA36yNJhrcwGid2A@public.gmane.org> wrote:
> > On Sun, May 13, 2018 at 05:29:37PM +0200, Ognjen Galic wrote:
> >> Lenovo ThinkPad systems support the prevention of
> >> battery charging via a manual override called Inhibit Charge.
> >>
> >> This patch adds support for that attribute and exposes it via the
> >> battery ACPI driver in the generic location:
> >>
> >> /sys/class/power_supply/BATX/inhibit_charge
> =

> >> +             /* When setting inhbitit charge, we set a default vaulue=
 of
> >
> > This comment does not adhere to the Linux coding style
> =

> While you are right in principle, the whole driver is so old and uses
> this style. So, for such cases we, as maintainers, prefer less
> deviation work, i.e. keeping the
> style is a good thing to do.

That's what I did, follow the driver style.

> =

> >> +             /* The only valid values are 1 and 0 */
> >> +             if (value !=3D 0 && value !=3D 1)
> >
> > I'm not sure, but maybe `if (value < 2)` is better here?
> =

> Since it's about integer-as-a-boolean, test for bit 0 would be
> sufficient, i.e. ~BIT(0). =


That seems uncessarily complicated. Whats wrong with LT and GT
operators?

> Though, I find this form not so readable
> since the input comes actually from the user.

I agree.

> It would be nice to have just kstrtobool() called instead for such
> options, but see above. It would need a (huge) refactoring of the
> driver first.

That needs a whole lot of refactoring for no real functional benefit.

> =

> -- =

> With Best Regards,
> Andy Shevchenko

---------------------------------------------------------------------------=
---
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
