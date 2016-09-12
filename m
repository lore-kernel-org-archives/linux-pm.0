From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v16 0/4] Introduce usb charger framework to deal with the
 usb gadget power negotation
Date: Mon, 12 Sep 2016 16:26:27 +0100
Message-ID: <20160912152627.GA27946@sirena.org.uk>
References: <CAMz4ku+pkRT70NcZEDepfshH7z7+Fm3yo-C2+ccWgJwDJE4C-Q@mail.gmail.com>
 <8760q9a8m6.fsf@notabene.neil.brown.name>
 <CAMz4kuJJwKFqU=6JnpUQNPeQ-uy-PyZ5VBaBKofn=8Jv5y0nXA@mail.gmail.com>
 <878tv297a0.fsf@notabene.neil.brown.name>
 <CAMz4kuLXyVSXjh1Sn06+wcUr+bVritCW3sN=XyEdap7h=MN7xw@mail.gmail.com>
 <87y4326l44.fsf@notabene.neil.brown.name>
 <20160909110727.GI27946@sirena.org.uk>
 <87pooc7n3t.fsf@notabene.neil.brown.name>
 <20160912122549.GZ27946@sirena.org.uk>
 <87inu11c5l.fsf@notabene.neil.brown.name>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Jsn5+Lu/ZvzbAGtZ"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <87inu11c5l.fsf-wvvUuzkyo1HefUI2i7LXDhCRmIWqnp/j@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: NeilBrown <neilb-IBi9RG/b67k@public.gmane.org>
Cc: Baolin Wang <baolin.wang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Jun Li <jun.li-3arQi8VN3Tc@public.gmane.org>, Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Ruslan Bilovol <ruslan.bilovol-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Peter Chen <peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, r.baldyga-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, grygorii.strashko-l0cyMroinI0@public.gmane.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Charles Keepax <ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, patches-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, Linux PM list <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, USB <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, device-m
List-Id: linux-pm@vger.kernel.org


--Jsn5+Lu/ZvzbAGtZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 12, 2016 at 03:27:18PM +0200, NeilBrown wrote:
> On Mon, Sep 12 2016, Mark Brown wrote:

> > It's no worse than any other board file situation - if someone has that
> > problem they get to fix it.

> My point is that the present design does not appear to scale beyond a
> single USB power supply (as if there were two, they would be named in
> discovery order, which is not reliably stable).

For the practical purposes of people making systems (as opposed to
upstream where this is likely to get most use) it pretty much is.
Though quite how many systems have multiple chargers is itself also a
question.

> Your point is, I think, that when someone actually cares about that lack
> of scaling, they can fix it.

Yes.

> I am perfectly happy with that approach.  However if the code doesn't
> scale beyond one charger, it shouldn't pretend that it does.
> i.e.
>   Don't have "usb_charger_find_by_name()", just a global "usb_charger"
>   (or similar).
>   The first charger to register gets to be the "usb_charger".  The
>   second one gets an error.
> I could be quite happy with that sort of interface.

Well, a fairly standard way of extending would be to allow the explicit
assignment of names to chargers so this'd avoid such churn.

> > The whole point from the point of view of the wm831x driver is that it
> > just wants something to tell it how much current it's allowed to draw, I
> > appreciate that doesn't change your analysis of the bit in the middle
> > but the consumer driver bit seems fine here.

> Yes, the wm831x driver probably does the right thing.
> Other drivers might want to know not only the minimum they are allowed
> to draw, but also the maximum they should try even if they are carefully
> monitoring the voltage.
> So wm831x is doing the right thing with the wrong interface.  Maybe you
> can describe that as "fine".

That's not actually 100% clear to me - for what the wm831x is doing it
probably *does* want the higher limit.  This is a system inflow limit
(as it should be for this), at least the charger will adapt to voltage
variations though other users in the system are much less likely to do
so.

--Jsn5+Lu/ZvzbAGtZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJX1skiAAoJECTWi3JdVIfQKY0H/R0FNjuK0aat01WGVS16c4n0
+8aDgG3uCfbwBjGNXl3yN8MCXFFEUu+kbCSscO5WqcLYswPFEledwj+AO96OR9OL
wKKr+FAKwhfmGyirzKb0FjMoFXkzd+0rWeGb9UnhP4nhkVkUSN5bEgj9RwBCWSY4
4DaHFOJatnrhe/U7jS4gVx8M5kCyvazxIrKBJVTiI+Yo/FU81Bo4bbOwNZJoIVpN
cIzFHNWnninf9RzYS7vMRAj1IUO7CA5GT0UeotlO79RpzPbSoQhWJb+v2lguNgVN
PBvNJ3RKZI0dUxj2OIHeMLFo3nF77dh8BjsfpVwl431SmyBbEFAXwErpnLtn0Qk=
=uIVa
-----END PGP SIGNATURE-----

--Jsn5+Lu/ZvzbAGtZ--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
