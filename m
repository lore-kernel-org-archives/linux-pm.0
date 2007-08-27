From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH, RFC] linkstation: implement standby
Date: Mon, 27 Aug 2007 13:32:07 +0200
Message-ID: <1188214327.7837.9.camel@johannes.berg>
References: <Pine.LNX.4.60.0708260157330.3809@poirot.grange>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4764760370207881326=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.60.0708260157330.3809@poirot.grange>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Mime-version: 1.0
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linuxppc-dev@ozlabs.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org


--===============4764760370207881326==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-KmUNYJrFsD9tMOtLzTLj"


--=-KmUNYJrFsD9tMOtLzTLj
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2007-08-26 at 02:03 +0200, Guennadi Liakhovetski wrote:

> +#ifdef CONFIG_PM

some of those probably want to be CONFIG_PM_SLEEP now.

johannes

--=-KmUNYJrFsD9tMOtLzTLj
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBG0rY3/ETPhpq3jKURArfIAKC2MPW1GwkBK/asGcPPva3xkgskOQCeIVkv
laCrRFpYP1ptMfDcZSWYZvA=
=TDsh
-----END PGP SIGNATURE-----

--=-KmUNYJrFsD9tMOtLzTLj--


--===============4764760370207881326==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4764760370207881326==--
