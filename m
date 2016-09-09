From: NeilBrown <neilb@suse.com>
Subject: Re: [PATCH v16 0/4] Introduce usb charger framework to deal with the usb gadget power negotation
Date: Sat, 10 Sep 2016 07:57:26 +1000
Message-ID: <87pooc7n3t.fsf@notabene.neil.brown.name>
References: <cover.1470034830.git.baolin.wang@linaro.org> <CAMz4kuLotLs1ASuZaMRXf29khmQUfEQc+jFV8Fxp+fHFn90Z9g@mail.gmail.com> <CAMz4ku+pkRT70NcZEDepfshH7z7+Fm3yo-C2+ccWgJwDJE4C-Q@mail.gmail.com> <8760q9a8m6.fsf@notabene.neil.brown.name> <CAMz4kuJJwKFqU=6JnpUQNPeQ-uy-PyZ5VBaBKofn=8Jv5y0nXA@mail.gmail.com> <878tv297a0.fsf@notabene.neil.brown.name> <CAMz4kuLXyVSXjh1Sn06+wcUr+bVritCW3sN=XyEdap7h=MN7xw@mail.gmail.com> <87y4326l44.fsf@notabene.neil.brown.name> <20160909110727.GI27946@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:56417 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753554AbcIIV5p (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 9 Sep 2016 17:57:45 -0400
In-Reply-To: <20160909110727.GI27946@sirena.org.uk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Baolin Wang <baolin.wang@linaro.org>, NeilBrown <nfbrown@novell.com>, Felipe Balbi <balbi@kernel.org>, Greg KH <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, robh@kernel.org, Jun Li <jun.li@nxp.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Ruslan Bilovol <ruslan.bilovol@gmail.com>, Peter Chen <peter.chen@freescale.com>, Alan Stern <stern@rowland.harvard.edu>, r.baldyga@samsung.com, grygorii.strashko@ti.com, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Lee Jones <lee.jones@linaro.org>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, Linux PM list <linux-pm@vger.kernel.org>, USB <linux-usb@vg>

--=-=-=
Content-Type: text/plain

On Fri, Sep 09 2016, Mark Brown wrote:

> [ Unknown signature status ]
> On Fri, Sep 09, 2016 at 09:13:31AM +1000, NeilBrown wrote:
>
>> Conceptually, the PHY is separate from the power manager and a solution
>> which recognises that will be more universal.
>
> The wm831x driver in the patch series is an example of such hardware -
> it is purely a power manager, it has no USB PHY hardware at all.  It's a
> current limiter intended to sit in line with the USB power lines to
> ensure the system doesn't go over the maximum current draw (and also
> integrates with the power source selection logic the chip has to pick
> the best available power source for the system).

It might be instructive to look at exactly what happens with this
device.
The "probe" routine calls

 +			usb_charger_find_by_name(wm831x_pdata->usb_gadget);

Presumably wm831x_pdata is initialised by a board file?
I strongly suspect it is initialized to  "usb-charger.0" because the
names given to usb chargers are "usb-charger.%d" in discovery order.
I don't see this being at all useful if there is ever more than one
usb-charger.
Do you?

The probe function then registers for charger notifications.  When they
arrive, wm831x_usb_limit_change() will set the highest supported limit
which is less than the notified "limit".  So presumably that "limit"
must be the minimum guaranteed by the charger type.

Let's see when the notification is called...
->uchgr_nh is sent a notification from usb_charger_notify_others()
with (in the "charger is present" case) the value of
   __usb_charger_get_cur_limit(uchger)
which just pulls values out of the cur_limit structure, based on the
type, reported by
		usb_charger_get_type_by_others(uchger);
(The default values in this structure are not the minimums guaranteed
by the charger types, they are generally higher.  So this could easily
result in the charger shutting down).

usb_charger_get_type_by_others()  has two ways to get the charger
type, which it then caches in uchger->type until the charger is removed.

If there is a uchger->psy power supply, then the
  POWER_SUPPLY_PROP_CHARGE_TYPE
property is used...  Oh, that is weird.
The valid values for that property are:

enum {
        POWER_SUPPLY_CHARGE_TYPE_UNKNOWN = 0,
        POWER_SUPPLY_CHARGE_TYPE_NONE,
        POWER_SUPPLY_CHARGE_TYPE_TRICKLE,
        POWER_SUPPLY_CHARGE_TYPE_FAST,
};

but the code in usb_charger_get_type_by_others() compares it against:
 +		case POWER_SUPPLY_TYPE_USB:
 +		case POWER_SUPPLY_TYPE_USB_DCP:
 +		case POWER_SUPPLY_TYPE_USB_CDP:
 +		case POWER_SUPPLY_TYPE_USB_ACA:

Presumably that it just a bug and it was meant to request the
  POWER_SUPPLY_PROP_TYPE ??
I wonder how much testing was done on this code?

Anyway, assuming it is meant to request the TYPE, where is that set?
The new code doesn't set it at all.
Only three existing power supplies set any of
  POWER_SUPPLY_TYPE_USB_*
axp288_charger.c  gpio-charger.c isp1704_charger.c
As I wrote in https://lwn.net/Articles/694062/
axp288_charger.c is broken and cannot possibly work.
gpio-charger.c configures the type at boot-time so it cannot sensibly
detect a newly plugged in charger (how does that make any sense)
and isp1704_charger.c peeks in the usb registers (ULPI) to work out
the charger type.

None of these set the  POWER_SUPPLY_PROP_TYPE in a useful way, so why
would usb_charger_get_type_by_others() want to use that property?

Maybe it really does want to use POWER_SUPPLY_PROP_CHARGE_TYPE?
Quite a few chargers set that.  It would be a challenge to map names
like "TRICKLE" and "FAST" into mA values for a current limiter though.
My hardware knowledge is running out here.. I see wm8350_power.c reports
that property, but I don't know how that device fits into the picture.
With the patch, that driver would request that property from somewhere
else(?) and also report it.  That is kind-a strange.

The other possible source for the charger type is a call to
   uchger->get_charger_type()

There is no get_charger_type() function anywhere in the patchset.  No code
ever sets that field in the uchger.

So how can this wm831x driver actually find out what sort of charger is
connected and so set the power limit?  I just don't see this working *at*
*all*.

NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJX0zBHAAoJEDnsnt1WYoG5SUoP/0CLmrqUM7Bv8ZI6MbgHe23r
t9SNYRLlrjAYpfpxqdwjGwI/XxL3YWyIbULWywJ75YNu2J4BEXjQaMMOTi5y1GQw
0iZVx679ZS3MFpCrhlWYnOeGudny+AZYHD6crmnZ7QsHfP3IHlMKrUNES3BjyAKb
vKpF0mi5CijWSG6zzgRLwcBD+t60tjp7T41nYMOXzvV8PwM8PY6uj/a/7Z9cSKeC
UiBTvcYt7G0U+4YJJGbrzQKmRlywxqlQukS66p7dZEXOasEVtmGaiNzPbr4nbD+6
9XlbQ2VRf4G1SZ/iP8t75GclanxvLrC1ZNaBnx/m4vTAYEzBPucK/4UabWTVOJR3
vI5djPshXN6jIN6goNGzSBenuO+B/ajOPAfMsqfO6FAr0oNsdKChSkcCzNu6WDlj
0TzSCNL8MfDgOkO9L/qzSU/VJVrpP5WBlBq4k7X+JejEaVboSG5Wqvz1g7jZsAaF
QTeTBWYtE4XMNyO/jJp72zEYcXE1EylxEoHK89Rh5sw6nG46OyP0MEUEVR5rz8km
XB66tXfA0QvZHJnHfuWwXIKxYOrXcuXqs2fkABdOvnlw92o7upLejohVtwdltpxx
JRH4ih2rqD7usA+lPV5LVnInMX9xPDnzL90NDQ9jTd6ofQG4n2BuuGzvDWdqK1rl
8h+b6gi4XLBJT5atqYrV
=+f+U
-----END PGP SIGNATURE-----
--=-=-=--
