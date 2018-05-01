From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 0/3] PM / core: Clean up suspend/resume diagnostic
 messages
Date: Tue, 1 May 2018 23:01:15 +0200
Message-ID: <20180501210115.GB9637@amd>
References: <152477804633.202432.12678470890830085798.stgit@bhelgaas-glaptop.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="LpQ9ahxlCli8rRTG"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <152477804633.202432.12678470890830085798.stgit@bhelgaas-glaptop.roam.corp.google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--LpQ9ahxlCli8rRTG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu 2018-04-26 16:36:20, Bjorn Helgaas wrote:
> These are pretty minor cleanups to the suspend/resume diagnostic messages.
>=20
> The first two are trivial.  The third may break scripts that parse dmesg
> output.  I looked at scripts/bootgraph.pl, and I don't think it is
> affected, but there may be others I don't know about.  Let me know if the=
re
> are.

Looks good.

Acked-by: Pavel Machek <pavel@ucw.cz>

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--LpQ9ahxlCli8rRTG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlro1ZsACgkQMOfwapXb+vICHQCfepsrP/0TGbrVIm9yHq5lZrU5
8wgAoJCeACqeBpJgMMQs2sr8zplvkPAp
=dICQ
-----END PGP SIGNATURE-----

--LpQ9ahxlCli8rRTG--
