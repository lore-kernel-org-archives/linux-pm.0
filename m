From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v3 3/3] regulator: bd9571mwv: Document "backup_mode"
 sysfs file
Date: Sun, 15 Jul 2018 18:59:26 +0200
Message-ID: <20180715165926.GB10023@amd>
References: <20180713154720.18316-1-geert+renesas@glider.be>
 <20180713154720.18316-4-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="mxv5cy4qt+RJ9ypb"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180713154720.18316-4-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Marek Vasut <marek.vasut+renesas@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--mxv5cy4qt+RJ9ypb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2018-07-13 17:47:20, Geert Uytterhoeven wrote:
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>


> +		     following steps must be followed exactly:
> +		       1. Configure PMIC for backup mode, to change the role of
> +			  the accessory power switch from a power switch to a
> +			  wake-up switch,
> +		       2. Switch accessory power switch off, to prepare for
> +			  system suspend, which is a manual step not controlled
> +			  by software,
> +		       3. Suspend system,
> +		       4. Switch accessory power switch on, to resume the
> +			  system.
> +		     DDR Backup Mode must be explicitly enabled by the user,
> +		     to invoke step 1.

I'd add "please don't design hardware like that" :-). Anyway,

Acked-by: Pavel Machek <pavel@ucw.cz>

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--mxv5cy4qt+RJ9ypb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAltLfW4ACgkQMOfwapXb+vIx3ACbBcTCUi/PPHfqfdSn02WIKtLs
my4AoL3X663508fomzXWo409JeBMNQCB
=RVAr
-----END PGP SIGNATURE-----

--mxv5cy4qt+RJ9ypb--
