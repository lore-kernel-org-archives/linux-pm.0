From: Johannes Berg <johannes@sipsolutions.net>
Subject: /sys/power/state contents
Date: Sat, 29 Apr 2006 10:44:18 +0200
Message-ID: <1146300258.5019.16.camel@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============16281458324006115=="
Return-path: <linux-pm-bounces@lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org


--===============16281458324006115==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-0CWYB9O4JlHS10Yz66RH"


--=-0CWYB9O4JlHS10Yz66RH
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Why does it say:
 *      show() returns what states are supported, which is hard-coded to
 *      'standby' (Power-On Suspend), 'mem' (Suspend-to-RAM), and
 *      'disk' (Suspend-to-Disk).

and not use the ->valid call to limit what is displayed to what can be
entered?

johannes

--=-0CWYB9O4JlHS10Yz66RH
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIVAwUARFMnYKVg1VMiehFYAQLJ0w//QBamertSkVqi/qvpbgw9ymxIz+s9EX2+
H7M+08DtePrcxORQLXfh3QFaW4kXayHxFLQ6AK+fj9Bae0W4sR4W6CTc6dgB7YXy
Xl6NG/ETEdYb0uOqUxSLx1Fa/25I26FdQ/cFKWccsyNAQaRnbhvjrjVL6RNfbEa5
vb7Mx+2qwIbRu5EWePTAVJFYDaJDX2h5+US8/w/g5e7QJb+aU1C8c6TqksF/jJw3
Knz/nN8BBcPHj17CJkbIp/ABnwJApyg1eYlB6Zr6YtVjKYcY1vZQ1xVHMcSh0Xmf
ajZv8eKfAPE88HCO+PaC/RHtmvNHXUR0sQAIg3lCEl57+tM/EF6To2FDEv4CI9B2
GRYHvWxti/m8ExvPG7VeFHqLjH24tOBCZ9hbGW+AIw2yNWPj75DYgkVdPez96msW
B5CrQ3uTCuiWsfyeMLm7maUMSxi2d1+97xTCSircidsCMX/ghhrSgrXBZk11oG6I
eLn1zLQuo9te3c69HJtNKa6Qpl2+j/pOCjfyp7To374LvD5uVPXNBVOngwILRI8q
aUUBCUcPT8JBmu9JN+nis2yLLWEe4zWAJRZjHN4FGAsWXcDb/rLq8P38nrq1EzYk
Yfil/fIHCZ+yhnIyFwflCdg6SnC6CAXbJ1qd90k5Bf0pPeAwThLgxael2gz0F7CE
td9Wquh7JLQ=
=2EPG
-----END PGP SIGNATURE-----

--=-0CWYB9O4JlHS10Yz66RH--


--===============16281458324006115==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============16281458324006115==--
