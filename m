From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 3/3] usb: renesas_usbhs: Remove dummy runtime PM callbacks
Date: Thu, 25 Oct 2018 23:57:42 +0100
Message-ID: <20181025225742.GB20207@kunai>
References: <20181024135134.28456-1-jarkko.nikula@linux.intel.com>
 <20181024135134.28456-4-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nVMJ2NtxeReIH9PS"
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181024135134.28456-4-jarkko.nikula@linux.intel.com>
Sender: netdev-owner@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: linux-pm@vger.kernel.org, linux-i2c@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>, netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, linux-renesas-soc@vger.kernel.org, linux-usb@vger.kernel.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
List-Id: linux-pm@vger.kernel.org


--nVMJ2NtxeReIH9PS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 24, 2018 at 04:51:34PM +0300, Jarkko Nikula wrote:
> Platform drivers don't need dummy runtime PM callbacks that just return
> success in order to have runtime PM happening. This has changed since
> following commits:
>=20
> 05aa55dddb9e ("PM / Runtime: Lenient generic runtime pm callbacks")
> 543f2503a956 ("PM / platform_bus: Allow runtime PM by default")
> 8b313a38ecff ("PM / Platform: Use generic runtime PM callbacks directly")
>=20
> Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>

Acked-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

>  static const struct dev_pm_ops usbhsc_pm_ops =3D {
>  	.suspend		=3D usbhsc_suspend,
>  	.resume			=3D usbhsc_resume,

Unrelated to this patch, but I wonder right now: is there a reason not
to use SET_SYSTEM_SLEEP_PM_OPS here? Shimoda-san?


--nVMJ2NtxeReIH9PS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlvSSmYACgkQFA3kzBSg
KbbAEBAAiijKbXVmk4TAvTBtxKdonKPpq0cfvkvdCZkf2sl2VauHrPnEvqurY9Mk
puhF4HRD+a/eL6E9YgGd/lK7gF8ytOGvYPxqkT+m4iKZLA4rWyEpS2gKt48EQQuJ
YWnRu2vH+5wrYhWN/k78yh69dJ5wB6IOix2X4RP3x6ceAn08Fz9B63Cf11c6ObLZ
31wOETuq6zB3gh07F81iUtkOyMksDFZu+eo1s5xZPSoJHMQ1oAo+xvzxw1qUAXdz
UqCi6m7++N6voOrwJOz05Fuo6oavL5vJoWxnBREoheG3Z5pZVryz9Ys2Mp+Ce+xS
SJLt0V2IfbcCWXbejqcfsdXv58QWydyGDSjKT3CU/VQk+3Km/302gfU8nhajXcew
qOf2eH9kMkO71+5fB41CXK3hNuyFHjB5G9f5ryUHdmIlqy32Xo6BGkAalhZnHuW9
7gpt8LG7oJjqxMH2Oc+TPQBorSHHZKMSMcmOO5EZoKBle5n4p2TbWwjQ+7sgU5hm
GqAug9YpIzh8WzpyzOGsguGc48Zn2keSXjCDn+3t90M83mYzg0v8BAnTlUguDYeD
FIv6FlWCrOkBuw4a6KK4m/rxwjk+CyUe6Q9gEw8TlOKT6E7YHggGsiKkhn5NTiAY
R8iDCM+agPcnbdgIYF0PwydbK64pJ75bguhXDpMKozk8njefk9o=
=tTS7
-----END PGP SIGNATURE-----

--nVMJ2NtxeReIH9PS--
