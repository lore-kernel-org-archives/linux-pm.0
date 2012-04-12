From: Andrey Rahmatullin <wrar-Bxt/JK/G85ezQB+pC5nmwQ@public.gmane.org>
Subject: Re: [linux-pm] ehci_hcd related S3 lockup on ASUS laptops, again
Date: Fri, 13 Apr 2012 01:24:06 +0600
Message-ID: <20120412192406.GG12852@belkar.wrar.name>
References: <1334255150.23924.342.camel@gandalf.stny.rr.com>
 <Pine.LNX.4.44L0.1204121504550.1496-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="HKEL+t8MFpg/ASTE"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1204121504550.1496-100000-IYeN2dnnYyZXsRXLowluHWD2FQJk+8+b@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Cc: Steven Rostedt <rostedt-nx8X9YLhiw1AfugRpC6u6w@public.gmane.org>, "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>, jrnieder-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-pm-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
List-Id: linux-pm@vger.kernel.org


--HKEL+t8MFpg/ASTE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 12, 2012 at 03:11:42PM -0400, Alan Stern wrote:
> Here's another rather drastic test you can do.  In=20
> drivers/usb/host/ehci-pci.c:ehci_pci_suspend(), call ehci_reset(ehci)=20
> just before the final return statement.  That should leave the hardware=
=20
> in exactly the same state as if ehci-hcd had been unbound.
What should we do with that? I tried to suspend and it locked up.

--=20
WBR, wRAR

--HKEL+t8MFpg/ASTE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBCAAGBQJPhyvWAAoJEDNi9wMaSZLh/3YP/3Z9Y2Z/B84iBnFLy/oXTOuq
wCUyMErhBMK9B6McPUhBADOzqyzIkJZmBzfMcsXApkGOR4IEFPYzBVh/+eBkoQ6M
ViAj2isuf7jlb56q9ILAHUVOd/71VPD2Q+xud1yMXnT45Hme1WyXlboTygrC7i19
ZDfr65K99wLS0BEs6zvhM6iKLVtZeLz940U/Q65Bf0H1g7EDvuX0Yu56yczsE8QR
CzMGW7MgErsBs3+fR7EWX+vryn7nT+qZK9JxCY7lo76dkGRCI0dxBiLJ9Vtw8ws9
XZTjU924Ju9gfXN0vR+I5CjhKjqJXWkvwpKAK4PvgFZlbcS1giFXON4XD6AWUcGt
ox6NHAa5vt7iEISM10Sxc4n5E7/uK9JR0nG3FKcsuXvCd7E4Y7R6ikDxWAbVlIJn
hQydkXbP20oiOAHN5SUCGy2M3xOMyeqWzvPJFFIFiS4+eWZG3jLsunRa4aZaAbO6
Ula6pX2/3S8vtynqymRuIPVWUynTOIrpz6m8Ipat01oA1WVtHXq+VzTJJPFbsW5x
ZjW7SJB5woqJzJhG/h3zWibvE5UodG0Xb62eNWEDb8TDEINbdhm1+aIqK9P42HWF
dtSAeuesHlXY6IXnG3mgPX7IXKlw9mP4RfhHlVmfwO3v/e+9vq1D8f15Y1e6Fpvh
6HmUehZnXfkxeUgdkce0
=iqzW
-----END PGP SIGNATURE-----

--HKEL+t8MFpg/ASTE--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
