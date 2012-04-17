From: Andrey Rahmatullin <wrar-Bxt/JK/G85ezQB+pC5nmwQ@public.gmane.org>
Subject: Re: [linux-pm] ehci_hcd related S3 lockup on ASUS laptops, again
Date: Wed, 18 Apr 2012 01:52:18 +0600
Message-ID: <20120417195218.GP11484@belkar.wrar.name>
References: <20120417185149.GO11484@belkar.wrar.name>
 <Pine.LNX.4.44L0.1204171513230.1163-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ubuMVesmirrCclZT"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1204171513230.1163-100000-IYeN2dnnYyZXsRXLowluHWD2FQJk+8+b@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Cc: Steven Rostedt <rostedt-nx8X9YLhiw1AfugRpC6u6w@public.gmane.org>, jrnieder-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-pm-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org


--ubuMVesmirrCclZT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 17, 2012 at 03:20:32PM -0400, Alan Stern wrote:
> > Unbound:
> >=20
> > pci 0000:00:1d.0: wake-up capability enabled by ACPI
> > pci 0000:00:1d.0: Refused to change power state, currently in D0
> > pci 0000:00:1d.0: cur 5 target 3 error 0
> > pci 0000:00:1a.0: wake-up capability enabled by ACPI
> > pci 0000:00:1a.0: Refused to change power state, currently in D0
> > pci 0000:00:1a.0: cur 5 target 3 error 0
> >=20
> > Bound:
> >=20
> > ehci_hcd 0000:00:1d.0: wake-up capability enabled by ACPI
> > ehci_hcd 0000:00:1d.0: Refused to change power state, currently in D0
> > ehci_hcd 0000:00:1d.0: cur 5 target 3 error 0
> > ehci_hcd 0000:00:1a.0: wake-up capability enabled by ACPI
> > ehci_hcd 0000:00:1a.0: Refused to change power state, currently in D0
> > ehci_hcd 0000:00:1a.0: cur 5 target 3 error 0
>=20
> Very good.  The two behaviors are the same.
>=20
> Now if you modify the patch by removing the change to hcd-pci.c, which=20
> will leave the EHCI code exactly the same as in the vanilla kernel, and=
=20
> set the pm_test value to "platform", what does the dmesg log show in=20
> the two cases?
The same for the unbound state. For the bound state, it still locks up.

--=20
WBR, wRAR

--ubuMVesmirrCclZT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBCAAGBQJPjcnyAAoJEDNi9wMaSZLh1FUP/1zDcfH5W97Floyyt40Fn96l
bsMqxYF0HFOnkd6jd/h+7vfdls+ztF4N7kdcjVP5KGIn7kMpk4yzZkzpZrhMqGGU
vVzDszcSIk8imd7WPzC3VHK/jkoWCDfllUXR55Tp9Jw/pOoqFdv9J1vmDYiORxuT
HXX6Pg3YByQus4TSjXzietOiK8FiJ8VJT8U/C2fDfXdv4sQ0nD2TMF0ftNaLfYrp
JhuXRBmTzsEg42pEtkdoRh1otMHJ0W1Qro2+MB5EjwqAYK8T0l9FBr6ETRWjc1lK
qkNuUSFK4dBicTNeBghN9FslJc9++2HoAGHiDbdzwoSJO7Btndzv1uXo5HV2/71R
R+dQt521lyFzEmTC6xgILj2y8prc7PARydJqBfejeSIUtYKQuV3kUfUWy4h1WyYw
llTFYfBbQ+f0wvfwjRM0j5+k8bfzFGqoEFCI5tR3Hc8f6ZK1cxaRosIZauw950R3
CjX5FzW8os7lHUdsUXpSlaIa8CGl7vxIS+WEP4c2lMsdMcmMWzaRrnKM4hXRq9oY
rkszHoufBDUhGtu0Q4cpCotaQO+NeLJV9mjHZ3M5t2U1hQlgj+a4o4R1FuPxmBkT
6ipDT8jOwUK8aVg2T0gnK42OfsQbjtrtFnsELefxVpMeZsxxYXOkOdW8p9KSp/H8
cbECJqmC+RklW3VKwCsd
=G80i
-----END PGP SIGNATURE-----

--ubuMVesmirrCclZT--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
