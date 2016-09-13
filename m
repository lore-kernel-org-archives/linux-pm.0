From: NeilBrown <neilb@suse.com>
Subject: Re: [PATCH v16 0/4] Introduce usb charger framework to deal with the usb gadget power negotation
Date: Tue, 13 Sep 2016 10:00:28 +0200
Message-ID: <877fag1b6r.fsf@notabene.neil.brown.name>
References: <CAMz4ku+pkRT70NcZEDepfshH7z7+Fm3yo-C2+ccWgJwDJE4C-Q@mail.gmail.com> <8760q9a8m6.fsf@notabene.neil.brown.name> <CAMz4kuJJwKFqU=6JnpUQNPeQ-uy-PyZ5VBaBKofn=8Jv5y0nXA@mail.gmail.com> <878tv297a0.fsf@notabene.neil.brown.name> <CAMz4kuLXyVSXjh1Sn06+wcUr+bVritCW3sN=XyEdap7h=MN7xw@mail.gmail.com> <87y4326l44.fsf@notabene.neil.brown.name> <20160909110727.GI27946@sirena.org.uk> <87pooc7n3t.fsf@notabene.neil.brown.name> <20160912122549.GZ27946@sirena.org.uk> <87inu11c5l.fsf@notabene.neil.brown.name> <20160912152627.GA27946@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha1; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160912152627.GA27946@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Baolin Wang <baolin.wang@linaro.org>, Felipe Balbi <balbi@kernel.org>, Greg KH <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, robh@kernel.org, Jun Li <jun.li@nxp.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Ruslan Bilovol <ruslan.bilovol@gmail.com>, Peter Chen <peter.chen@freescale.com>, Alan Stern <stern@rowland.harvard.edu>, r.baldyga@samsung.com, grygorii.strashko@ti.com, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Lee Jones <lee.jones@linaro.org>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, Linux PM list <linux-pm@vger.kernel.org>, USB <linux-usb@vger.kernel.org>, device-m
List-Id: linux-pm@vger.kernel.org

--=-=-=
Content-Type: text/plain

On Mon, Sep 12 2016, Mark Brown wrote:

> [ Unknown signature status ]
> On Mon, Sep 12, 2016 at 03:27:18PM +0200, NeilBrown wrote:
>> On Mon, Sep 12 2016, Mark Brown wrote:
>
>> > It's no worse than any other board file situation - if someone has that
>> > problem they get to fix it.
>
>> My point is that the present design does not appear to scale beyond a
>> single USB power supply (as if there were two, they would be named in
>> discovery order, which is not reliably stable).
>
> For the practical purposes of people making systems (as opposed to
> upstream where this is likely to get most use) it pretty much is.
> Though quite how many systems have multiple chargers is itself also a
> question.
>
>> Your point is, I think, that when someone actually cares about that lack
>> of scaling, they can fix it.
>
> Yes.
>
>> I am perfectly happy with that approach.  However if the code doesn't
>> scale beyond one charger, it shouldn't pretend that it does.
>> i.e.
>>   Don't have "usb_charger_find_by_name()", just a global "usb_charger"
>>   (or similar).
>>   The first charger to register gets to be the "usb_charger".  The
>>   second one gets an error.
>> I could be quite happy with that sort of interface.
>
> Well, a fairly standard way of extending would be to allow the explicit
> assignment of names to chargers so this'd avoid such churn.

Sure, that might work.  I'm just against a design that obviously cannot
work.


>
>> > The whole point from the point of view of the wm831x driver is that it
>> > just wants something to tell it how much current it's allowed to draw, I
>> > appreciate that doesn't change your analysis of the bit in the middle
>> > but the consumer driver bit seems fine here.
>
>> Yes, the wm831x driver probably does the right thing.
>> Other drivers might want to know not only the minimum they are allowed
>> to draw, but also the maximum they should try even if they are carefully
>> monitoring the voltage.
>> So wm831x is doing the right thing with the wrong interface.  Maybe you
>> can describe that as "fine".
>
> That's not actually 100% clear to me - for what the wm831x is doing it
> probably *does* want the higher limit.  This is a system inflow limit
> (as it should be for this), at least the charger will adapt to voltage
> variations though other users in the system are much less likely to do
> so.

Interesting ... I hadn't considered that possibility.

As long as the current remains below the maximum, the charger will
reduce the voltage towards 2V as load increases.  Somewhere before it
gets there, the system will not be able to make use of the power as the
voltage will be too low to be usable. So that will naturally limit the
current being drawn.

Not having very much electrical engineering background, I cannot say for
sure what will happen, but it seems likely that once the voltage drops
much below 4.75V, the charger won't be operating at peak efficiency,
which would be a waste.
I can easily imagine that the hardware would switch off at some voltage
level, rather than just making do with what is there.
So I'm skeptical of this approach, but I'm open to being corrected by
someone more knowledgeable than I.

Looking at it from a different perspective, according to the patch set,
the limits that wm831x is able to impose are:

 +	0,
 +	2,
 +	100,
 +	500,
 +	900,
 +	1500,
 +	1800,
 +	550,

These are, from the battery charger spec, minimums rather than maximums.
e.g. a CDP provides at least 1500, and as much as 5000.  So it seems
that the wm831x was designed to be told the minimum guaranteed available.
But that is circumstantial evidence and might be misleading.

NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJX17IcAAoJEDnsnt1WYoG5QOwP/iafdolNeKuJieXIrtq39wsx
DvER9KRViRaH6bBO5xba0VwmTldeDDYFbR5Wh9OEWoDPBh+QRIPDMzVdRAHScSEN
vkJTFTQuYEBa+B5wanZLihIIkovra7PAF7WVUiKOVWwPsuTWTY7FdcusJBQnAaPI
ylxzHegpwQTaC3lkPqImacB3VeuPViBSoEqxfrqetO/iFz/Viz2ctBDVu0SFIlav
lU8L74p/tAPpUXuYbX5299dYurI5VgBozBbhTHD5s8ZKWC1ab/fbCz2doicvahDG
5XW8Vnv82f58QnpKqXnDbrTJMfHEIzvDYe58dya0ZG8FfjjBSO7SEpFWXb8JaHpf
m0D5o1iGXep6y7eVRSIOubLFXwm1TEoOYsjWwQm5gQB1P8h53GKNbq/3x2TPLlJ6
Qpa5EZbqVEa7+mzVtaXyJk+V15MfLyne64M+yFsr8ev+eG2szTd2eOAnD+kHNdRf
9wxBoSGKWOCoyxqwfHwXkyj1OKTJWUsqaMqaT35Z/G2qr9UF573JqV5FrCH93DOu
1RRdoclddZKq4wvkXrRPlU9YVibB/7uB2NN4MDJLEASIjVxeduyC0gMdlGWYbNVf
DzBDd/idm0eY7svsHCbEbOq5hSshtzHm6ioGFM1FQSfy6uZZ89CaHof/Q3amDt8d
JUkKTNYqy3V9DFdZ5mLC
=MU/p
-----END PGP SIGNATURE-----
--=-=-=--
