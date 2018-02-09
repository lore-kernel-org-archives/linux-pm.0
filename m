From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v13 4/4] battery: Add the ThinkPad "Not Charging" quirk
Date: Fri, 9 Feb 2018 14:26:41 +0100
Message-ID: <20180209132641.6vkwasa4b5pygjkr@earth.universe>
References: <20180207145936.ockmmkipxtwkdsot@thinkpad>
 <20180209104530.s5i6lymcpgkqyego@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mz7u4sqedrcthzyh"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:46462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751029AbeBIN0o (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 9 Feb 2018 08:26:44 -0500
Content-Disposition: inline
In-Reply-To: <20180209104530.s5i6lymcpgkqyego@khazad-dum.debian.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Ognjen Galic <smclt30p@gmail.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, devel@acpica.org, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>, Platform Driver <platform-driver-x86@vger.kernel.org>, ibm-acpi-devel@lists.sourceforge.net, Linux PM <linux-pm@vger.kernel.org>, Christoph =?iso-8859-1?Q?B=F6hmwalder?= <christoph@boehmwalder.at>, Kevin Locke <kevin@kevinlocke.name>


--mz7u4sqedrcthzyh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Feb 09, 2018 at 08:45:30AM -0200, Henrique de Moraes Holschuh wrote:
> On Wed, 07 Feb 2018, Ognjen Galic wrote:
> > The EC/ACPI firmware on Lenovo ThinkPads used to report a status
> > of "Unknown" when the battery is between the charge start and
> > charge stop thresholds. On Windows, it reports "Not Charging"
> > so the quirk has been added to also report correctly.
> >=20
> > Now the "status" attribute returns "Not Charging" when the
> > battery on ThinkPads is not physicaly charging.
> >=20
> > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > Signed-off-by: Ognjen Galic <smclt30p@gmail.com>
>=20
> AFAIK, This behavior goes back to the initial SBS implementation in the
> IBM era ECs of the Thinkpads...  We've always called it "idle" in the
> linux-thinkpad community.  The behavior comes from SBS
> (http://smartbattery.org/specs/), the EC was reporting its status
> (charging/not charging *THIS* battery) in one bit, and the battery's
> status (discharging/not discharging *THIS* battery) in a different bit.
>=20
> It was rather simple to observe the behavior of those bits in a
> two-battery system.
>=20
> Would that apply to these newer Lenovo models?  If so, you might want to
> consider using "idle", instead. "not charging" does _not_ imply "neither
> charging nor discharging", while "idle" does.

I agree, that "Idle" is a better term than "Not Charging", but
the power supply property exists with this name since it has
been introduced. This is exposed to userspace and cannot be
changed easily.

-- Sebastian

--mz7u4sqedrcthzyh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlp9oZEACgkQ2O7X88g7
+prx6g/+MURnUmcOywI7DGgmd2hm6czCCC4rxQK1BRBE2tc9rcpuEDZ9XAeCfUDS
mkdYDkvz+Ap4GYHZXnZ3CbqsJv5jW/R3w6MVHVDoaN04t8x2BlRlTNQK60nUR5qe
F9+NGvP8y/4M/yz6jLVhbTsyZP1JTOnZo9EoJik/Uuyx/kI+rzn+o5MrhkUnUB4t
hxKl7Cd34Vdem/CNkXVIfylVcnDcaze5iQV20FbunDSUj1FEX/iiJAYqgi7ITGzi
8QBoLzDs/vDaHEOAp7rHToV9AIhB4xbNO602e1oKykEDJa9nwXARNIKcZO1zIRWO
tY5MqD5CuFNnHdEadfvneXgj0Qe6gQu6ZScgxD0qxXVVEob23h/dRXE+xnCS3ENT
tVz3A2m++4DSqYgtkco/XcfLAvzYNT1hhuwigOsJ4In6OmsrIF9jvMAUzyrTSKOv
z8GtKuXk9ltRGABtH+xJ/DcLu0iUOg/R1p76XmF7zMj09ywq6D+WcjuFX7RR1dcf
T1gKgKmaK2cH50PkHf2VJhULq2kLQ4jHh/JpqJ/cmS95XVr/VhxE3atBalyO9iv5
7wAtZQa+vgfYbvzpTQYAGOt1LBFtDXHOo8J3BgAAnHd76pGaBHXV9v2CL+FsX0g4
hPceeoOSASIFNciA3J5fAC4buywd5PEiNP2F1w45vOqbS0P+gUA=
=WoXc
-----END PGP SIGNATURE-----

--mz7u4sqedrcthzyh--
