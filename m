From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v16 0/4] Introduce usb charger framework to deal with the
 usb gadget power negotation
Date: Wed, 14 Sep 2016 15:57:03 +0100
Message-ID: <20160914145703.GX27946@sirena.org.uk>
References: <CAMz4kuLXyVSXjh1Sn06+wcUr+bVritCW3sN=XyEdap7h=MN7xw@mail.gmail.com>
 <87y4326l44.fsf@notabene.neil.brown.name>
 <20160909110727.GI27946@sirena.org.uk>
 <87pooc7n3t.fsf@notabene.neil.brown.name>
 <20160912122549.GZ27946@sirena.org.uk>
 <87inu11c5l.fsf@notabene.neil.brown.name>
 <20160912152627.GA27946@sirena.org.uk>
 <877fag1b6r.fsf@notabene.neil.brown.name>
 <20160914111603.GU27946@sirena.org.uk>
 <87r38mzi35.fsf@notabene.neil.brown.name>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Z1EIi0fvCUyWUKja"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <87r38mzi35.fsf@notabene.neil.brown.name>
Sender: linux-kernel-owner@vger.kernel.org
To: NeilBrown <neilb@suse.com>
Cc: Baolin Wang <baolin.wang@linaro.org>, Felipe Balbi <balbi@kernel.org>, Greg KH <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, robh@kernel.org, Jun Li <jun.li@nxp.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Ruslan Bilovol <ruslan.bilovol@gmail.com>, Peter Chen <peter.chen@freescale.com>, Alan Stern <stern@rowland.harvard.edu>, r.baldyga@samsung.com, grygorii.strashko@ti.com, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Lee Jones <lee.jones@linaro.org>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, Linux PM list <linux-pm@vger.kernel.org>, USB <linux-usb@vger.kernel.org>, device-m
List-Id: linux-pm@vger.kernel.org


--Z1EIi0fvCUyWUKja
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 14, 2016 at 04:11:58PM +0200, NeilBrown wrote:
> On Wed, Sep 14 2016, Mark Brown wrote:

> > Yes, the idea is that the charger will back off charging and stop
> > entirely if the rest of the system is consuming too much power to allow
> > it to continue effectively.  The same thing happens with wall power, if
> > a wall supply isn't able to power the charger (eg, because the rest of
> > the system is running flat out) it'll have to cope with that.

> Maybe you are correct.  I don't find your argument convincing, but maybe
> that is because I don't want to...

There's a *huge* variation in how chargers are designed, some are
designed to be dumb and won't function without software while the wm831x
is more at the opposite end of the spectrum and will quite happily run
all the charging and power source selection logic with no software
intervention at all - the parameters it uses can be changed at runtime
but that's about it.  Software implementations are obviously more
flexible but hardware implementations can be more responsive to changes
in system state like drooping supplies and aren't vulnerable to things
like software lockups.

>  1/ I had a report once from someone whose device stopped charging
>  because it was pulling more current than the charger could supply.
>  The voltage dropped below the 3.5V (I think) that the battery
>  charging hardware needed, so it switched off.  It wouldn't switch
>  back on again until explicitly told too.  It would then overload the
>  charger again and switch off.

That's just one charger's algorithm though, other options are available.

>     Which seems to say the maximum is just for safety, implying that the
>     minimum is the important value.

This is what I was saying about a sensible reading being for the supply
and consumer side to directly target the maximum and minimum limits
respectively (though for the battery charger spec it's a bit different
as the range is so wide).

>  3/  Felipe Balbi <balbi@kernel.org>  appears to agree with my
>    perspective.
>       http://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1224904.html
>    does argument-by-authority work?

TI do a lot of the more software managed chargers (which I suspect are
the main thing Felipe will have looked at) if that's what you're
referring to here?  The device is implementing pretty much the algorithm
you're describing in that e-mail so I'm a bit confused as to what you're
saying here.

--Z1EIi0fvCUyWUKja
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJX2WU/AAoJECTWi3JdVIfQpicH/i7VYOsJTEAuf1fVAqgCtzWJ
kJnvxfpzVEEam02s8yPKyHlQVsSHCb9wHyKJfztC3aI3vxQ0F83KOlKgMbiSU/Ft
7F/83OYCuM9UIGm0QdV2spiqXSvpIL+XlY7MdBA1QmMX6gox7lPqwzd3J0oe7Vuc
bsKf/ONS1TqayF7nsWUn11c5EJr43UOdoPuj9oJpda8ej070MgrBEAxEUTE5XRIG
CBaIgOiy7AzDX+FiZTztKkp6D9RQ0+A1BqZJpmb5dUNu1ZT6t26g04bCNbQkmu2R
OZhPkBfdG4Z0DoJZPP1C2yFgQ+x8JiA9LOE3bLD8MlF7bzAcj6XT2DjEzSzdp0k=
=DhfM
-----END PGP SIGNATURE-----

--Z1EIi0fvCUyWUKja--
