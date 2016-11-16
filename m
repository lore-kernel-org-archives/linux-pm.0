From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v18 0/4] Introduce usb charger framework to deal with the
 usb gadget power negotation
Date: Wed, 16 Nov 2016 16:16:05 +0000
Message-ID: <20161116161605.smif6kf3mdhdhyhd@sirena.org.uk>
References: <CAMz4kuJPenbqf935EGW67UeqOiP48_Ti1Jf5YfJ_K=DEcrz++Q@mail.gmail.com>
 <87a8dls7yn.fsf@notabene.neil.brown.name>
 <CAMz4kuJdp+ijur_mDjcG3aghn8Q1gnJsTfFWBEiKWcdVQPMj7g@mail.gmail.com>
 <871sytqrqh.fsf@notabene.neil.brown.name>
 <CAMz4kuJV5wiCpWJF=-YpTf1sjNrOqjc53iRYmGoEQepqtrfUdA@mail.gmail.com>
 <87a8dbni27.fsf@notabene.neil.brown.name>
 <CAMz4ku+qY4U7=v5nEBEdPTjwki8j10jYbQuokz785NEy5SzYmg@mail.gmail.com>
 <87eg2ek7ye.fsf@notabene.neil.brown.name>
 <20161114120430.hpnetdedyofhlkad@sirena.org.uk>
 <87mvh1iw32.fsf@notabene.neil.brown.name>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jphfbqxfrftvae36"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <87mvh1iw32.fsf-wvvUuzkyo1HefUI2i7LXDhCRmIWqnp/j@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: NeilBrown <neilb-IBi9RG/b67k@public.gmane.org>
Cc: Baolin Wang <baolin.wang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Jun Li <jun.li-3arQi8VN3Tc@public.gmane.org>, Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Ruslan Bilovol <ruslan.bilovol-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Peter Chen <peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, grygorii.strashko-l0cyMroinI0@public.gmane.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, John Stultz <john.stultz-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Charles Keepax <ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, patches-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, Linux PM list <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, USB <linux-usb-u79uwXL29TZUIDd8j+nm9g@public.gmane.org>
List-Id: linux-pm@vger.kernel.org


--jphfbqxfrftvae36
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 15, 2016 at 08:35:13AM +1100, NeilBrown wrote:
> On Mon, Nov 14 2016, Mark Brown wrote:

> > Conflating the two seems like the whole point here.  We're looking for
> > something that sits between the power supply code and the USB code and
> > tells the power supply code what it's allowed to do which is the result
> > of a combination of physical cable detection and USB protocol.  It seems
> > reasonable that extcon drivers ought to be part of this but it doesn't
> > seem like they are the whole story.

> I don't think "between the power supply code and the USB code" is where
> this thing sits. I think it sits inside the power-supply driver.
> We already have extcon which sits between the phy and the power_supply
> code, and the usb_notifier which sits between the USB code and the
> power supply code.  We don't need another go-between.

...

> correct determinations and set the current limits itself.  All this
> could be done entirely internally, without the help of any new
> subsystem.
> Do you agree?

> Clearly doing it that way would result in lots of code duplication and
> would mean that each driver probably gets its own private set of bugs,
> but it would be possible.  Just undesirable.

I think this is the key here - the fact that it's technically possible
to implement doesn't really matter if it's sufficiently fiddly and non
obvious that nobody is actually joining everything up (bits are done
intermittently but not as a whole as far as I can see).

> So yes, it makes perfect to provide common code which handles the
> registrations, and captures the events, and translates the different
> events into current levels and feeds those back to the driver.  This
> isn't some new subsystem, this is just a resource, provided by a
> library, that power drivers can allocate and initialize if the want to.

To me that's pretty much what's being done here, the code just happens
to sit in USB instead but fundamentally it's just a blob of helper code,
you could replace the notifier with a callback if that's the big concern
here.

--jphfbqxfrftvae36
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAABCAAGBQJYLIZFAAoJECTWi3JdVIfQwiQH/3BSARvvrlWXDJICEQkOLhKq
zFTGKfVnjAJ1QR03yOT5JXiZ7Kp0bRaftRok4ggFznCCckH8Y7dYP+4ic/5aTMss
ekqn1Yx78kkAD5WVQugGwvBH8ImGV7VWWfpZiLhAYUn0Ri/wyDVGIZwLbgrFFg2p
Hke8Uhql8T4pTF2pZV4DeSDjjKCQy1XUUaWX+D0miCZF2hf/m74NGy8J9Wn9PxnT
5hEnVyxR2Ojpgujk6e8tCVJKm6ty0+aZ1yubN2AGsNRrBQUcxCJJCEAzUetoQdd4
TGd6jib6W9qedCkHhVPNC9TdjpS2G+xmPjZuKWqXgbSuhu5D+aIOZKFsOCr1Qs4=
=8eBb
-----END PGP SIGNATURE-----

--jphfbqxfrftvae36--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
