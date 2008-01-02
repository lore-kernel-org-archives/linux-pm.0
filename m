From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [patch] hibernation: utilize ACPI hardware signature
Date: Wed, 02 Jan 2008 10:29:52 +0100
Message-ID: <1199266193.4172.76.camel__2920.9294742488$1199266282$gmane$org@johannes.berg>
References: <1199257162.14632.4.camel@sli10-desk.sh.intel.com>
	<200801020937.13808.maximlevitsky@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8061635876439929316=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200801020937.13808.maximlevitsky@gmail.com>
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
To: Maxim Levitsky <maximlevitsky@gmail.com>
Cc: linux acpi <linux-acpi@vger.kernel.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org


--===============8061635876439929316==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-Nv8dETkyLs45MBrWNI41"


--=-Nv8dETkyLs45MBrWNI41
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


> Once reading the ACPI spec I noticed that ACPI supports this feature
> so it is qute nice to implement it, since this will prevent resume from d=
isk what hardware was changed.
>=20
> But.. how many bioses are broken regarding this feature....

If they are broken though, how likely is it they'll have a changing
signature? I'd expect the most likely broken case is they just don't
calculate it at all and leave it constant.

johannes

--=-Nv8dETkyLs45MBrWNI41
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIVAwUAR3tZj6Vg1VMiehFYAQI6/hAAmedwsU9T8pw7GheWWqyHMlJ2VYU29Sut
BsxlUZ9VKHZ+weBOHVvYliGi8ztFPzyleu5bF5lwjNJW5Z7TgL8Ma1J9OhmXqVs9
nXEsYECtoOqf1qS06uX2VgtzaUI9mm4xA1sBKdNQq3zRexwaB9oBAhkD7z+Qvnq9
m8YyPDUJVNypMfy7H8NppWmkFL3T04Eogx5xlLni3e72YBcXOXiz69rFHUVmzvHr
CsUxzMAZZQGbuWqxWGLgCkEEJBCDbrF6SE2okizRN1PYQ1WsJbyUH2ehqTvfb4vf
aEuBCuZp5hZPNa2WuZ9yDfkK+Qj9Ca8KGY0AVYqusbvtlcEpFRUZP33rgO4L4F5Q
RQS9nb0kutvxu0TIe7MwsaRIk6/I4uykKNHL3C+guEKMHLlqikr8ifZygnqIj0Cx
SOjaqILJQqEWPEvEwbH5+Nbj3v6XuKUOEu39x80TkIwJsGlOI51vfMDiyFNHEopo
JQc7W0D0l/lHOUl1M2eaAKbLe3F2+rLUqEVLCnu/iYSJmdYsTlULDnoVikReK3CM
l3t3beSgMqeIvO/FQyP8XkfqddIIbP5AxAlMjJP6I2JyFO6SIKfUXQJ+9Tp1t8io
UYrFB6bAkpxkiMdfQI7IDFYX6Y1DEgZq0WMJse3idFbZ6xOcGfMVeLmOa0oRnIjh
+eQnOALHZEE=
=zCLQ
-----END PGP SIGNATURE-----

--=-Nv8dETkyLs45MBrWNI41--


--===============8061635876439929316==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8061635876439929316==--
