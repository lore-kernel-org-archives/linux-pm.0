From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [RFC PATCH 15/16] power/reset: restart-poweroff: Register with
 kernel poweroff handler
Date: Fri, 3 Oct 2014 16:27:18 +0200
Message-ID: <20141003142718.GA8291@earth.universe>
References: <1412100056-15517-1-git-send-email-linux@roeck-us.net>
 <1412100056-15517-16-git-send-email-linux@roeck-us.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="BOKacYhQ+x31HxR3"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1412100056-15517-16-git-send-email-linux@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org, linux-ia64@vger.kernel.org, linux-metag@vger.kernel.org, linux-mips@linux-mips.org, linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org, xen-devel@lists.xenproject.org, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>
List-Id: linux-pm@vger.kernel.org


--BOKacYhQ+x31HxR3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Sep 30, 2014 at 11:00:55AM -0700, Guenter Roeck wrote:
> Register with kernel poweroff handler instead of seting pm_power_off
> directly.  Register as poweroff handler of last resort since the driver
> does not really power off the system but executes a restart.
>=20
> Cc: Sebastian Reichel <sre@kernel.org>
> Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
> Cc: David Woodhouse <dwmw2@infradead.org>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Acked-By: Sebastian Reichel <sre@kernel.org>

-- Sebastian

--BOKacYhQ+x31HxR3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJULrJGAAoJENju1/PIO/qaCuEP/jUqxYdfYb3oGnXL4qQQCuXC
4ODdpz4tRr+pPAbt+2MFu5Dg8IJ8CdlyiSxFwRKTRrQnKUH3x1ZZs4HHqkLo4P7L
pihROiTW5VpZ6pVkQ7AsS46QOU/WzXGLqMRX2fpZBILtidg+WG48508JyqK1vLYs
Ly6PUJdCLXpvcOUoLdVHq8oPbk4X/9ZS7oe/oLhtx/Gh9DuaY4du6J3dmViDC0Jk
xZy/S7FFeJZQ28rHfSqBn1cU/N5A0w3OELpMOXzE64US4D8dpiN602yeapC8S3nK
ZT4dm+tAqE5B9gS9YPrfM0QZ9sy6kDYEoSx0fsBHV9PgDybvYcmDnLBbduQjBWM4
Q8DIb0cPERR5N3p9I/jRBgqc7zsu1YeXttGcYVOeK8QxOPEt5WsdxmiV61/U+qXh
feMPyeXFbfAU6TXqDGrzhnSnY17G19a1hNSvUkG9zywJrPSGTMibwQi5/5oLqc/P
ZrTqyoHenojj3vF4VM6QiUZlaQXAV37kuwltIfxFPAsazUybUrPHcjA09xhhGO/D
uPwH1+z2FmI7TRXETQMKGrvpqFgBiAcA+DCKINBJqXVQlphA+EKoHQHUuH/GNTwS
Zi3+Vcb0VOD+It3Q0Mo3HDDeUAurhLRVeGmyEw50eN/379qql7oqlJBjIlfshO6D
RPZX2t8dORxxh7BvpoPc
=OT3F
-----END PGP SIGNATURE-----

--BOKacYhQ+x31HxR3--
