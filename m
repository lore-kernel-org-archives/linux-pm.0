From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v16 0/4] Introduce usb charger framework to deal with the
 usb gadget power negotation
Date: Wed, 14 Sep 2016 12:16:03 +0100
Message-ID: <20160914111603.GU27946@sirena.org.uk>
References: <CAMz4kuJJwKFqU=6JnpUQNPeQ-uy-PyZ5VBaBKofn=8Jv5y0nXA@mail.gmail.com>
 <878tv297a0.fsf@notabene.neil.brown.name>
 <CAMz4kuLXyVSXjh1Sn06+wcUr+bVritCW3sN=XyEdap7h=MN7xw@mail.gmail.com>
 <87y4326l44.fsf@notabene.neil.brown.name>
 <20160909110727.GI27946@sirena.org.uk>
 <87pooc7n3t.fsf@notabene.neil.brown.name>
 <20160912122549.GZ27946@sirena.org.uk>
 <87inu11c5l.fsf@notabene.neil.brown.name>
 <20160912152627.GA27946@sirena.org.uk>
 <877fag1b6r.fsf@notabene.neil.brown.name>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="95xjieIIiUQImiTX"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <877fag1b6r.fsf@notabene.neil.brown.name>
Sender: linux-kernel-owner@vger.kernel.org
To: NeilBrown <neilb@suse.com>
Cc: Baolin Wang <baolin.wang@linaro.org>, Felipe Balbi <balbi@kernel.org>, Greg KH <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, robh@kernel.org, Jun Li <jun.li@nxp.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Ruslan Bilovol <ruslan.bilovol@gmail.com>, Peter Chen <peter.chen@freescale.com>, Alan Stern <stern@rowland.harvard.edu>, r.baldyga@samsung.com, grygorii.strashko@ti.com, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Lee Jones <lee.jones@linaro.org>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, Linux PM list <linux-pm@vger.kernel.org>, USB <linux-usb@vger.kernel.org>, device-m
List-Id: linux-pm@vger.kernel.org


--95xjieIIiUQImiTX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 13, 2016 at 10:00:28AM +0200, NeilBrown wrote:
> On Mon, Sep 12 2016, Mark Brown wrote:

> > That's not actually 100% clear to me - for what the wm831x is doing it
> > probably *does* want the higher limit.  This is a system inflow limit
> > (as it should be for this), at least the charger will adapt to voltage
> > variations though other users in the system are much less likely to do
> > so.

> Not having very much electrical engineering background, I cannot say for
> sure what will happen, but it seems likely that once the voltage drops
> much below 4.75V, the charger won't be operating at peak efficiency,
> which would be a waste.
> I can easily imagine that the hardware would switch off at some voltage
> level, rather than just making do with what is there.
> So I'm skeptical of this approach, but I'm open to being corrected by
> someone more knowledgeable than I.

Yes, the idea is that the charger will back off charging and stop
entirely if the rest of the system is consuming too much power to allow
it to continue effectively.  The same thing happens with wall power, if
a wall supply isn't able to power the charger (eg, because the rest of
the system is running flat out) it'll have to cope with that.

> Looking at it from a different perspective, according to the patch set,
> the limits that wm831x is able to impose are:

>  +	0,
>  +	2,
>  +	100,
>  +	500,
>  +	900,
>  +	1500,
>  +	1800,
>  +	550,

> These are, from the battery charger spec, minimums rather than maximums.
> e.g. a CDP provides at least 1500, and as much as 5000.  So it seems
> that the wm831x was designed to be told the minimum guaranteed available.
> But that is circumstantial evidence and might be misleading.

AIUI this is conservatisim in the system design - another way of reading
a spec with a range like this is that the consumer should aim for the
lower limit, the provider should aim for the upper limit and that way if
either of them has issues with tolerances things will still work out.
It predates wide availability of CDP so I wouldn't be surprised if that
bit were just an oversight.  Like I say this bit of hardware is totally
separate to the battery charger.

--95xjieIIiUQImiTX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJX2TFyAAoJECTWi3JdVIfQnOQH/Rh0W7ukjvm7sbdadvPlo2eF
3SGnE89Gc0+PtM25/AfI6/QutOASnjCSj++BOiAzpqBXCH2ctdLwcTD2gdvl2Bx5
/Sss6ZuPh80Q5U4FCzkXGA9N01g3r8Gsbq3MO+vf//tqTUq/XBb5OJHYho5t3jBA
pE9XvBzr41/sM+jWgXzkzbr5UZ+CneKo6re5HGraKaRV1bYvTGUabhmfePr+c2+a
oVNzUJ6/0D3cav+sZczH69oZSOVTRgqwAdxWrL1H6Qt2A9XHNgZBAh7AXi8A9c9t
ur6jC/+Oq3pa0VAWrBdyimY8dQyC/QFlKk2yTkwHiwv2rbvslFl2vzJkuiHScGQ=
=WzCN
-----END PGP SIGNATURE-----

--95xjieIIiUQImiTX--
