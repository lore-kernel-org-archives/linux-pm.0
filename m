From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v3] Optimize C3 entry on Centaur CPUs
Date: Mon, 31 Dec 2018 18:26:54 +0100
Message-ID: <20181231172654.GB14092@amd>
References: <1545900110-2757-1-git-send-email-davidwang@zhaoxin.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="5I6of5zJg18YgZEa"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1545900110-2757-1-git-send-email-davidwang@zhaoxin.com>
Sender: linux-kernel-owner@vger.kernel.org
To: David Wang <davidwang@zhaoxin.com>
Cc: rjw@rjwysocki.net, mingo@redhat.com, len.brown@intel.com, tglx@linutronix.de, hpa@zytor.com, x86@kernel.org, linux-pm@kernel.org, linux-kernel@vger.kernel.org, brucechang@via-alliance.com, cooperyan@zhaoxin.com, qiyuanwang@zhaoxin.com, timguo@zhaoxin.com
List-Id: linux-pm@vger.kernel.org


--5I6of5zJg18YgZEa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu 2018-12-27 16:41:50, David Wang wrote:
> For new Centaur CPUs the ucode will take care of the preservation of cach=
e coherence
> between CPU cores in C-states regardless of how deep the C-states are. So=
, it is not
> necessary to flush the caches in software befor entering C3. And this use=
less operation
> will cause performance drop for the cores which share some caches with th=
e idling core. =20
>=20
> Signed-off-by: David Wang <davidwang@zhaoxin.com>
> Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

Acked-by: Pavel Machek <pavel@ucw.cz>

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--5I6of5zJg18YgZEa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlwqUV4ACgkQMOfwapXb+vIUAACgjrtljk2juAmf4OAYGo1GtH4P
OpEAnAsXfd1wmlwcy7QcgyijpvZGT5vz
=JuLQ
-----END PGP SIGNATURE-----

--5I6of5zJg18YgZEa--
