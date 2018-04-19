From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH/RFC 0/2] regulator: bd9571mwv: Add support for toggle
 power switches
Date: Thu, 19 Apr 2018 22:13:56 +0200
Message-ID: <20180419201356.GC25034@amd>
References: <1521026785-26456-1-git-send-email-geert+renesas@glider.be>
 <CAMuHMdXyWs1v_D4EUd-H75Q3cpQv6yD2V_MptjJP7FjYhu5c3g@mail.gmail.com>
 <20180418140041.GD10061@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="Clx92ZfkiYIKRjnr"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180418140041.GD10061@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Marek Vasut <marek.vasut+renesas@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Linux PM list <linux-pm@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org


--Clx92ZfkiYIKRjnr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2018-04-18 15:00:41, Mark Brown wrote:
> On Wed, Apr 18, 2018 at 03:29:36PM +0200, Geert Uytterhoeven wrote:
>=20
> > Any comments/suggestions?
>=20
> > In case you lost the patches from the thread:
> > https://www.spinics.net/lists/linux-renesas-soc/msg24955.html
>=20
> Please don't send content free pings and please allow a reasonable time
> for review.  People get busy, go on holiday, attend conferences and so=20
> on so unless there is some reason for urgency (like critical bug fixes)
> please allow at least a couple of weeks for review.  If there have been
> review comments then people may be waiting for those to be

If I follow the logs right, there was one month before ping. That
seems pretty reasonable time.

> Sending content free pings adds to the mail volume (if they are seen at
> all) which is often the problem and since they can't be reviewed

Yep, and sending content free complains about pings also adds to the
main volume :-(.

Anyway, last time I sent you a patch... you _had_ time to complain
that I'm pinging too often, but you apparently did not have time to
look at the patch. That patch would have been in time for v4.16-rc1
IIRC.

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--Clx92ZfkiYIKRjnr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlrY+IQACgkQMOfwapXb+vLzqgCeL7ZTf7fKhjiIrRwjNAwROwiz
kdsAni5RaYPZ16cP2+bhWpf5juj0RsL5
=aa5D
-----END PGP SIGNATURE-----

--Clx92ZfkiYIKRjnr--
