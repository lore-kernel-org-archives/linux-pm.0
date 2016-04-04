From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v7 1/4] gadget: Introduce the usb charger framework
Date: Mon, 4 Apr 2016 09:04:48 -0700
Message-ID: <20160404160448.GI2350@sirena.org.uk>
References: <cover.1458128215.git.baolin.wang@linaro.org>
 <11ce6df3eb8a95cfed26f3321f15c98a934db642.1458128215.git.baolin.wang@linaro.org>
 <87h9foqnur.fsf@intel.com>
 <CAMz4kuJ=StEMsdHgX6n6wi13bs3CZ+9GYXBvdZ5mu+giSmnWdg@mail.gmail.com>
 <87poubgnbh.fsf@intel.com>
 <20160331170635.GH2350@sirena.org.uk>
 <87d1q9anpt.fsf@intel.com>
 <20160401141643.GX2350@sirena.org.uk>
 <877fgd7iqx.fsf@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="4cXE7lVpOAUQvDc2"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <877fgd7iqx.fsf-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Baolin Wang <baolin.wang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Peter Chen <peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, r.baldyga-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Charles Keepax <ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, patches-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, Linux PM list <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, USB <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, device-mainlining-cunTk1MwBs98uUxBSJOaYoYkZiVZrdSR2LY78lusg7I@public.gmane.org, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org


--4cXE7lVpOAUQvDc2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 04, 2016 at 01:47:50PM +0300, Felipe Balbi wrote:
> Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> writes:

> > It does in this new world order.  IIRC on an earlier round of review
> > there was some code that didn't use a bus but that got complaints that
> > it was trying to reimplement the bus functionality.

> fair enough, I'll wait for Greg to have some time to comment on
> this. Bottomline is that there is *no* real bus. Charger ICs will use

I've got a feeling Greg is zoning this out by now...

> SPI or I2C and that's a real bus, $subject is not.

Well, there's the physical connection between the system power supply
and the USB port if you're very keen on looking for hardware.

--4cXE7lVpOAUQvDc2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXApCfAAoJECTWi3JdVIfQuesH/2lTBlAGc7td0yZ7oBU3UWtz
VSdvdlPXAtasE10IbCs/WQnv6ldRTETPJIR19qi7rIUAxjn4tMobdOYUpaHbclEy
zgomt2hGLz2P4Bkt7LjrUlksG6QcSrfeKK20ZUQOBdX1QvIehYBsEgqpRRsj+9Am
dxD2cyJgEhJiOu071U0dEsC58SHPnfB86QKTzT1wOqvoYLyYfLD4Lait4aBNn/Zu
I5vPSCH0sngUP1Xw3xOqk+fXEvS47NI8amx/4ZI0W7Jwhg/bjKkh0Y6CVXGNRnEc
M5GGDa37yRXmohABgLDyWh3aD504xkksFvJ4dVdMo5mh8QLp2dCs/wEuIjippFM=
=FJq0
-----END PGP SIGNATURE-----

--4cXE7lVpOAUQvDc2--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
