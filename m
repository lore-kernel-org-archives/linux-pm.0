From: Ben Hutchings <ben@decadent.org.uk>
Subject: [stable] cpufreq / Longhaul: Disable driver by default
Date: Thu, 09 May 2013 02:21:35 +0100
Message-ID: <1368062495.4131.233.camel@deadeye.wl.decadent.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-vcD2lOXz9NEfhLH7QsAo"
Return-path: <cpufreq-owner@vger.kernel.org>
Sender: cpufreq-owner@vger.kernel.org
To: stable@vger.kernel.org
Cc: =?UTF-8?Q?Rafa=C5=82?= Bilski <rafalbilski@interia.pl>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--=-vcD2lOXz9NEfhLH7QsAo
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This commit should be applied to the 3.4.y, 3.5.x.y and 3.6.x.y stable
branches:

commit b5811bc469c0dbebb4f947800b9b234a9c0a68dc
Author: Rafa=C5=82 Bilski <rafalbilski@interia.pl>
Date:   Sat Dec 15 00:45:02 2012 +0100

    cpufreq / Longhaul: Disable driver by default

See discussion in <http://marc.info/?l=3Dlinux-pm&m=3D135405593406165&w=3D2=
>
and my own results in <http://bugs.debian.org/707047>.

(On the positive side, this prompted me to replace the decadent.org.uk
server with slightly less crappy hardware...)

Ben.

--=20
Ben Hutchings
For every action, there is an equal and opposite criticism. - Harrison

--=-vcD2lOXz9NEfhLH7QsAo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIVAwUAUYr6H+e/yOyVhhEJAQrJ3w//SrorG/wX+fiue8K5Vkj8T33roefIkcXv
XzBzoYtXy/GOh+ri1UZaChJhglJtC+epj1lN7QSD0pcI/r6ik3p9esFr4oKA1s5+
Q/iZ4um8TmSlhEj9pbIKDzJmfArbE0IHmZgpYv11RE9M9e1s/xfHW//zUICU0S/4
hNytHaBVO22TpsYnZAdPMdbQzFcgsKlDKYLBYzh7aK5yGrfGc2/KRjRwm7/pQqqj
sHy7oz++BZf7XzAZgBgbpwKThGJgo0dGKvEbA3Eo+OZIN8E+ZEXy+A2wMOgqQF2t
JXBSUXQ20G1oc2sFUaGpWZwekfdJPRb55UIKIl6qs8EVq7JidYl1Jrj/QNjKc8yv
UKOi1hvS0OmzWhi4SYQLd4b6FykusGj0YtgNMsp/zXmpnJEmGBsG6zaGY5XFF5pb
zsoMxJzSnAhvw88YQ15SYDnm1S/n5rwvTbhqlK7eURvlJfLxccyda++cIMnpeTB9
cIorMSdfepeJEC0diWjoGZWUHf9qnR2YwfyUlSWpP7GDSPsbCmE+yLwJeCzmNXhT
hVs+bIsbysP5uml9Gnp4hrOZLn8kHcq+91cFf8bUBHaIvuS1eHicGUnAVRyKnwso
TkoOH9JtD15CQiA7JRn0CeaqID0cnXOij/ZpWFDtLH2O3N6d1+LfdmnzZCFKrnOn
waylioeOCkU=
=YyPB
-----END PGP SIGNATURE-----

--=-vcD2lOXz9NEfhLH7QsAo--
