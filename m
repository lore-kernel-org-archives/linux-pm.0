From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC PATCH] PM / core: skip suspend next time if resume returns
 an error
Date: Tue, 2 Oct 2018 10:05:54 +0200
Message-ID: <20181002080554.GC19677@amd>
References: <20180927203523.60856-1-dianders@chromium.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="f+W+jCU1fRNres8c"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180927203523.60856-1-dianders@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Douglas Anderson <dianders@chromium.org>
Cc: rjw@rjwysocki.net, Dilip Kota <dkota@codeaurora.org>, dtor@chromium.org, swboyd@chromium.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: linux-pm@vger.kernel.org


--f+W+jCU1fRNres8c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> In general Linux doesn't behave super great if you get an error while
> executing a device's resume handler.  Nothing will come along later
> and and try again to resume the device (and all devices that depend on
> it), so pretty much you're left with a non-functioning device and
> that's not good.
>=20
> However, even though you'll end up with a non-functioning device we
> still don't consider resume failures to be fatal to the system.  We'll
> keep chugging along and just hope that the device that failed to
> resume wasn't too critical.  This establishes the precedent that we
> should at least try our best not to fully bork the system after a
> resume failure.
>=20
> I will argue that the best way to keep the system in the best shape is
> to assume that if a resume callback failed that it did as close to
> no-op as possible.  Because of this we should consider the device
> still suspended and shouldn't try to suspend the device again next
> time around.  Today that's not what happens.  AKA if you have a
> device

I don't think there are many guarantees when device resume fail. It
may have done nothing, and it may have resumed the device almost
fully.

I guess the best option would be to refuse system suspend after some
device failed like that.

That leaves user possibility to debug it...

								Pavel--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--f+W+jCU1fRNres8c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAluzJuIACgkQMOfwapXb+vI5jQCfYeH7EypOPhY6xWmkmVkb96+/
r0YAoJQjxy0djxFFkgUyLzeVlEmkI7xF
=5M63
-----END PGP SIGNATURE-----

--f+W+jCU1fRNres8c--
