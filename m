From: Pavel Machek <pavel@ucw.cz>
Subject: linux-next-20180723: battery status funny after bootup
Date: Mon, 23 Jul 2018 23:49:17 +0200
Message-ID: <20180723214917.GA3733@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="BOKacYhQ+x31HxR3"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, kernel list <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@vger.kernel.org>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--BOKacYhQ+x31HxR3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


pavel@amd:~$ cat /proc/acpi/battery/BAT0/state
present:                 yes
capacity state:          ok
charging state:          charged
present rate:            0 mW
remaining capacity:      0 mWh
present voltage:         0 mV
pavel@amd:~$ uname -a
Linux amd 4.18.0-rc6-next-20180723+ #141 SMP Mon Jul 23 22:11:47 CEST
2018 i686 GNU/Linux

It will correct itself if I unplug/replug the AC adapter, I
believe. Gnome2 battery monitor also looks confused.


--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--BOKacYhQ+x31HxR3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAltWTV0ACgkQMOfwapXb+vLHqACcCPP7t/ZmhjIA7zm1jnb2IlqL
aGUAnRHpeZvvAUEdi1k9xQpyNenbGXOd
=m7zw
-----END PGP SIGNATURE-----

--BOKacYhQ+x31HxR3--
