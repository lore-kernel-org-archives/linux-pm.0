From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] PM / s2idle: Clear the events_check_enabled flag
Date: Mon, 6 Nov 2017 12:13:26 +0100
Message-ID: <20171106111326.GD24863@amd>
References: <20171031214424.84783-1-rajatja@google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="J5MfuwkIyy7RmF4Q"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171031214424.84783-1-rajatja@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rajat Jain <rajatja@google.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, dtor@google.com, rajatxjain@gmail.com
List-Id: linux-pm@vger.kernel.org


--J5MfuwkIyy7RmF4Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 2017-10-31 14:44:24, Rajat Jain wrote:
> Problem: This flag does not get cleared currently in the suspend or
> resume path in the following cases:
>=20
> * In case some driver's suspend routine returns an error.
> * Successful s2idle case
> * etc?
>=20
> Why is this a problem: What happens is that the next suspend attempt
> could fail even though the user did not enable the flag by writing to
> /sys/power/wakeup_count. This is 1 use case how the issue can be seen
> (but similar use case with driver suspend failure can be thought of):
>=20
> 1. Read /sys/power/wakeup_count
> 2. echo count > /sys/power/wakeup_count
> 3. echo freeze > /sys/power/wakeup_count
> 4. Let the system suspend, and wakeup the system using some wake source
>    that calls pm_wakeup_event() e.g. power button or something.
> 5. Note that the combined wakeup count would be incremented due
>    to the pm_wakeup_event() in the resume path.
> 6. After resuming the events_check_enabled flag is still set.
>=20
> At this point if the user attempts to freeze again (without writing to
> /sys/power/wakeup_count), the suspend would fail even though there has
> been no wake event since the past resume.
>=20
> What this patch does:
>=20
> It moves the clearing of the flag to just before a resume is completed,
> so that it is always cleared for the corner cases mentioned above.
>=20
> Signed-off-by: Rajat Jain <rajatja@google.com>

Acked-by: Pavel Machek <pavel@ucw.cz>
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--J5MfuwkIyy7RmF4Q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAloAQ9YACgkQMOfwapXb+vKG+QCfQNkSWQfcicJGu1mwnsk/8ygE
RFQAoK7nG4BvFZEa1Spfky+VNbvrJeQH
=+ode
-----END PGP SIGNATURE-----

--J5MfuwkIyy7RmF4Q--
