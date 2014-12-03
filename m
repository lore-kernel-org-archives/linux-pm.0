From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH RFC] PM / Runtime: Better support for nested irq_safe
 drivers
Date: Wed, 3 Dec 2014 09:45:43 +0200
Message-ID: <547EBFA7.2060005@ti.com>
References: <1417551543-15009-1-git-send-email-jsarha@ti.com> <2710424.RMSWoOIU7o@vostro.rjw.lan> <547E332D.3060405@ti.com> <3160452.2AXUHE51NB@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="pNvmjWc6tlSGwtKdGsBmAsBWQX9kn2ndC"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:56896 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750815AbaLCHpy (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 3 Dec 2014 02:45:54 -0500
In-Reply-To: <3160452.2AXUHE51NB@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Jyri Sarha <jsarha@ti.com>
Cc: linux-pm@vger.kernel.org, pavel@ucw.cz, t-kristo@ti.com

--pNvmjWc6tlSGwtKdGsBmAsBWQX9kn2ndC
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/12/14 01:11, Rafael J. Wysocki wrote:

> Second, what if the parent sets its irq_safe after the child does?

Then the behavior becomes the same as it is currently.

But isn't the probe of the parent always ran before the child? And the
only sane place (?) to set irq_safe is in probe, after
pm_runtime_enable. If so, it should never happen in practice that the
parent's irq_safe is called after the child's.

>> If the thing I am doing somehow fundamentally flawed, I 	apologize.=20
>> However, this was an RFC patch after all and the problem I am trying t=
o=20
>> solve is real.
>=20
> Well, the whole irq_safe concept if somewhat rough and fragile (for exa=
mple,
> it doesn't play well with bus type callbacks that may sleep) and I'm no=
t

I don't know enough of the PM to understand what you mean with above,
but isn't it a bug to set a device irq-safe if it may need sleeping
callbacks? Or do you mean that the device driver may not know if such
sleeping callbacks happen or not?

> sure if making it more fragile is a good idea.

Is there something we can do to fix it? Conceptually I don't see any
issues with it, but I'm probably only looking at it from the platform
device point of view.

 Tomi



--pNvmjWc6tlSGwtKdGsBmAsBWQX9kn2ndC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUfr+nAAoJEPo9qoy8lh71vesQAK6tkyTEvPlfibMIsDca6Am3
1v6qbUpdfDQwa2LCHwjJyl0hTodfRH40JOhsnoosbjsYDlBJnIA8UtGwRWTN/4jZ
MK350Qcp9EBm/LVRXMkzOhupZYKYAB/8p3RcsmEF86gzujWLtNN0DMeIUUn7C40p
2kNUwlWe7jn4NbsRtyvEHfnLBUJ769QyxmCUibWpAkyhycRYyr/JQ5sOq0vpXWMD
CWZZB5WW79VP9SLLaUZHqFxZVrKKYaHETBpPw4uD3Mvki2u/aVQ3gNhORoszJ3SP
CMDoFXeUs07R4a4iZ9TQghCESCu/Z0t2KhfsAg3BsZP1vRrr11QZ+onhgoIERPcy
WEu6xJjRyAFILQBi00lV6aZtEfqCTgPG5r0Oh17ABPnbd1IzuI//n91yFs/q37OJ
9r14/z607Dhe7IXkVzLHPJXi6rwGXKKIFo2HO67J2GgthJ3r4K+VyuKJiD3eiW9G
GU6xwly+JSw03UnzAVBasscgl9Ehv+6olt1GPM7km1Bf+pXb/mUF9bUlpbKuHzSe
XV1QOhJzSF9ixKffU88l687v/GUoJbZw0yrMoelwfqQpfiBFUycXAU0s+WrwZ7WK
jVjsSI2vcRGdCHFIGV4psdnK9PYFrCZEQwHwiVLDzDE3yCt5KuhMwOZNyuw9r3pe
auPv7eb0qUbMk13vfxnv
=RLt/
-----END PGP SIGNATURE-----

--pNvmjWc6tlSGwtKdGsBmAsBWQX9kn2ndC--
