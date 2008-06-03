From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH] add a printk_init variant storing
	format	strings in __initdata
Date: Tue, 03 Jun 2008 19:49:32 +0200
Message-ID: <1212515372.27643.29.camel__34900.0184484341$1212515579$gmane$org@johannes.berg>
References: <20080529162257.03426e48.akpm@linux-foundation.org>
	<1212485252.0@pinky>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0504597672758342501=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1212485252.0@pinky>
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
To: Andy Whitcroft <apw@shadowen.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, mingo@elte.hu, linux-pm@lists.linux-foundation.org, pavel@suse.cz, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--===============0504597672758342501==
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-Omh/+UuJajw+ueDMyn4C"


--=-Omh/+UuJajw+ueDMyn4C
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


> +asmlinkage __init int __printk_init(const char *fmt, ...)
> +{
> +	va_list args;
> +	int r;
> +
> +	va_start(args, fmt);
> +	r =3D vprintk(fmt, args);
> +	va_end(args);
> +
> +	return r;
> +}
> +

Wouldn't you have to export that?

johannes

--=-Omh/+UuJajw+ueDMyn4C
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIVAwUASEWEK6Vg1VMiehFYAQLwgg/+KKqdxxoTlI8Sy0ah6x+zoLd2n8dscVuM
x4SjkdsMbocL7g2+PcL0upK2+w9LjylBpl4zAviE5Q62nhMIwwjkeIGeQU54Y1q6
eBV1c5NEp6xS8+9JQYBXizkTVpkUQb0BfKne2O1+TPqLctFuhgxafvRrjjAQERW/
2ZsBRe6Q6dO8nIZBX+PywduOXohsDIiV6cLezBTJCxlw3GHn3IIAvz7JkvcpkEd3
kH4//Uoz66crUasmr01nR7phXub+MzM335//UBk66dFi5KteNApXXiYRYGvaQA+d
TErBJJ1K5/Grk3RaKUsk5QVl6NbCMSt6YyaxQIgizTbPXeMoQH0rEuk+4CJzh17J
T+jOoLGNVQaHS1SyZgI3kgCZWj+aHAgRSw8VYbWJI4xtBtIFXKKGnxDcN/saFxLH
caimbzv6rMrXng8g6dwpDnkU8Bzy94unKeR4yEVWQ8GM+54q4PaM6Fa0dyRe41gK
lymg//lgoB6sIWgCym0pj6fHql90gMamFMT88u7ZOcKEf82DFv/odW5ITjbkG/xU
rj0dlTlWvU4AaqcQqcAxU2SZ2fn+y/eD4DZku5xoAhha4E6naGk7Slt4dTjpB4Ui
is97P8yrPGopaFZGjsW98U84sRa9tRzdkwG0lSt8lFP0Q8U1SXHjtrQ5EjfM3/vu
Alz3zy/rUlg=
=YgC3
-----END PGP SIGNATURE-----

--=-Omh/+UuJajw+ueDMyn4C--


--===============0504597672758342501==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0504597672758342501==--
