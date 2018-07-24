From: Pavel Machek <pavel@ucw.cz>
Subject: Re: linux-next-20180723: battery status funny after bootup
Date: Tue, 24 Jul 2018 11:12:26 +0200
Message-ID: <20180724091226.GB22465@amd>
References: <20180723214917.GA3733@amd>
 <CAJZ5v0g=Ey6ZiyjA3NWS_C5zXBUydJNaKOZDbRNFYUGEc8YuaQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="v9Ux+11Zm5mwPlX6"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJZ5v0g=Ey6ZiyjA3NWS_C5zXBUydJNaKOZDbRNFYUGEc8YuaQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>, lucas.magasweran@ieee.org
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, kernel list <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@vger.kernel.org>, Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org


--v9Ux+11Zm5mwPlX6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 2018-07-24 10:27:08, Rafael J. Wysocki wrote:
> On Mon, Jul 23, 2018 at 11:49 PM, Pavel Machek <pavel@ucw.cz> wrote:
> >
> > pavel@amd:~$ cat /proc/acpi/battery/BAT0/state
> > present:                 yes
> > capacity state:          ok
> > charging state:          charged
> > present rate:            0 mW
> > remaining capacity:      0 mWh
> > present voltage:         0 mV
> > pavel@amd:~$ uname -a
> > Linux amd 4.18.0-rc6-next-20180723+ #141 SMP Mon Jul 23 22:11:47 CEST
> > 2018 i686 GNU/Linux
> >
> > It will correct itself if I unplug/replug the AC adapter, I
> > believe. Gnome2 battery monitor also looks confused.
>=20
> There are two battery changes in linux-next now that are not present
> in the mainline
>=20
> 2a2aad34362b ACPI: battery: remove redundant old_present check on inserti=
on
> 706ac4aa536f ACPI: battery: use cache_time as cache "enabled"
>=20
> Does reverting any of them help?  Or is the problem present in the
> mainline too?

Thanks for pointers! Not it mainline, I'd notice that.

I reverted 706ac4aa536f , and on the next boot:

pavel@amd:~$ cat /proc/acpi/battery/BAT0/state
present:                 yes
capacity state:          ok
charging state:          charged
present rate:            0 mW
remaining capacity:      37150 mWh
present voltage:         16400 mV

=2E.plus icon was ok from the start.

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--v9Ux+11Zm5mwPlX6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAltW7XoACgkQMOfwapXb+vJKoACfX7UvnOz1OH8T4iDG1HcD+fV7
TfgAoIeanpCs3k+VsgMI5UkwxEFm0oDZ
=SXUu
-----END PGP SIGNATURE-----

--v9Ux+11Zm5mwPlX6--
