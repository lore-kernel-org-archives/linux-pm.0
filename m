From: Andrey Rahmatullin <wrar-Bxt/JK/G85ezQB+pC5nmwQ@public.gmane.org>
Subject: Re: [linux-pm] ehci_hcd related S3 lockup on ASUS laptops, again
Date: Wed, 18 Apr 2012 21:24:55 +0600
Message-ID: <20120418152455.GT11484@belkar.wrar.name>
References: <20120417195218.GP11484@belkar.wrar.name>
 <Pine.LNX.4.44L0.1204181048340.1548-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="cqG5pBpskktEuCrX"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1204181048340.1548-100000-IYeN2dnnYyZXsRXLowluHWD2FQJk+8+b@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Cc: Steven Rostedt <rostedt-nx8X9YLhiw1AfugRpC6u6w@public.gmane.org>, jrnieder-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-pm-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org


--cqG5pBpskktEuCrX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 18, 2012 at 10:51:38AM -0400, Alan Stern wrote:
> > > Now if you modify the patch by removing the change to hcd-pci.c, whic=
h=20
> > > will leave the EHCI code exactly the same as in the vanilla kernel, a=
nd=20
> > > set the pm_test value to "platform", what does the dmesg log show in=
=20
> > > the two cases?
> > The same for the unbound state. For the bound state, it still locks up.
>=20
> That's odd.  Didn't you say earlier that after "echo platform=20
> >/sys/power/pm_test", the bound case worked?  Or was that just Steve?
I've forgot to do that %)

Unbound:

pci 0000:00:1d.0: wake-up capability enabled by ACPI
pci 0000:00:1d.0: Refused to change power state, currently in D0
pci 0000:00:1d.0: cur 5 target 3 error 0
pci 0000:00:1a.0: wake-up capability enabled by ACPI
pci 0000:00:1a.0: Refused to change power state, currently in D0
pci 0000:00:1a.0: cur 5 target 3 error 0

Bound:

ehci_hcd 0000:00:1d.0: wake-up capability enabled by ACPI
ehci_hcd 0000:00:1d.0: cur 0 target 3 error 0
ehci_hcd 0000:00:1a.0: wake-up capability enabled by ACPI
ehci_hcd 0000:00:1a.0: cur 0 target 3 error 0


--=20
WBR, wRAR

--cqG5pBpskktEuCrX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBCAAGBQJPjtzGAAoJEDNi9wMaSZLhpYIP/REYKI98DaiT5bVinoN8Ubjj
gdC5g7NhztcIDLIsYKcxVxLwjk0V6gz7ZLWPTi17jgtB2JS2lK4YV7wd9U71wJzK
mI8ogTm+DUO/4V4aB2avAX63y+6IVJrbol4aCx/T+i5hbq8TBiONK7/Bcehpg9Xq
n1Ad32G+HlQK8g91cwzS86zHU5lZuCPqdAD9UgDHh7FhnhN2fOwI/+NDr/bdBIEK
M68QhrzHKAy2M20IhbEORgbs/HtWpr06SHMAnZ1AdRRnAB+X2EZAz41NqyyPT4YH
5OqlEmFbUvkU6IGCsPHT8d9LjzMUVpFtfNrELKnhf9R99NDGMJJw3HCJI39arpMk
AF0S5wo0A4OhHJYNoHYk7q2dXAN7CoYLHG//JvIMmsW9sN9LEhkK4hy9Fz7KS4fQ
FY7w63qxN6yw+0xF6A2GkeBB5WBZI34qLV7Yw7pz3iiHiCeRTzz+pTw5hgHtFSt4
ADJYZKEvZ6y6OxaH0BgM2xTXuHu4dIllfCS6HaSX1bPYFc2hC+tYaA4CQD8sjnfF
CTlk+JjCry1EP+P8bY+nIlf5J1m6VMWYaIpNWZc7kgJXNvJa01DQXw6eugrJ6V5M
EwJIubX/A5T0zREB+oaTH3115ZaX+hzLWi0pRg+wFZsvTvTK+P2yZjBaYz4x538o
YU+B4ue4czlN9/U0nYvK
=VNRb
-----END PGP SIGNATURE-----

--cqG5pBpskktEuCrX--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
