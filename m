From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v7 1/2] PM / sleep: refactor the filesystems sync to
 reduce duplication
Date: Fri, 22 Mar 2019 09:21:06 +0100
Message-ID: <20190322082106.GA27015@amd>
References: <20190224061753.17638-2-harry.pan@intel.com>
 <20190225123642.17111-1-harry.pan@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="bg08WKrSYDhXBjb5"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190225123642.17111-1-harry.pan@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Harry Pan <harry.pan@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, gs0622@gmail.com, rjw@rjwysocki.net, len.brown@intel.com, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--bg08WKrSYDhXBjb5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2019-02-25 20:36:41, Harry Pan wrote:
> This patch creates a common helper to sync filesystems and shares
> to the suspend, hibernate, and snapshot.
>=20
> Signed-off-by: Harry Pan <harry.pan@intel.com>

ACK.

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--bg08WKrSYDhXBjb5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlyUmvIACgkQMOfwapXb+vIdigCfRAYktLKnih5/9rlYqZ2KPvNE
rAcAn0Q8VToSSHWYQKmbTDbr8/1EiuwB
=URrF
-----END PGP SIGNATURE-----

--bg08WKrSYDhXBjb5--
