From: Andrey Rahmatullin <wrar-Bxt/JK/G85ezQB+pC5nmwQ@public.gmane.org>
Subject: Re: [linux-pm] ehci_hcd related S3 lockup on ASUS laptops, again
Date: Sat, 14 Apr 2012 04:43:37 +0600
Message-ID: <20120413224336.GA5585@belkar.wrar.name>
References: <Pine.LNX.4.44L0.1204122103230.10558-100000@netrider.rowland.org>
 <Pine.LNX.4.44L0.1204131008010.1185-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="C7zPtVaVf+AK4Oqc"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1204131008010.1185-100000-IYeN2dnnYyZXsRXLowluHWD2FQJk+8+b@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Cc: Steven Rostedt <rostedt-nx8X9YLhiw1AfugRpC6u6w@public.gmane.org>, jrnieder-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-pm-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org


--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 13, 2012 at 10:10:30AM -0400, Alan Stern wrote:
> Second, if you do
>=20
> 	echo 0 >/sys/bus/usb/devices/usb1/bConfigurationValue
> 	echo 0 >/sys/bus/usb/devices/usb2/bConfigurationValue
>=20
> before suspending (using a vanilla kernel and no script), does it=20
> change the behavior?  I expect it won't, but we should check just to be=
=20
> thorough.
No, it still locks up.

--=20
WBR, wRAR

--C7zPtVaVf+AK4Oqc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBCAAGBQJPiKwTAAoJEDNi9wMaSZLh+CQP+gIsn6F9DmnT3n94tqOQRliK
nxRZ7iTY1NZnw4bYHjYoOl6NrTosELLd0r9x8BzOPv0glni3MbezzdTV2YSPTUVh
xP0b+/gn2TZxKhb9E6R0oQBSHreqGuU0yTHuNi+FMJiQOKJtjGiQPgXTePa6N9eM
uhzk3Uf8sWQKmOUpNn0GRruzV8GH6w/IyjEShdoDRItQYFbil3crAmDIV+WjGIwY
rbrniLcH3UWTajPtnU1UCIeiipMWb/LZWJzRyv9DEVrgBRjcGSLPIe/LmRYefeKQ
rsrv+qfq+mQN1XFHg1fQPLgH55Rzj1SmZpHDM/UdbYJUgRJW+XJWUVzuh2oXalp1
u2aMlsXlc2Lp5o/+Su/pXbWlHQDMW4YfVL2Smtzn4ZFR9I2VXyU3dxqW4I+iCSPI
01dFZ0oM6SVwqFwROKMpwL8kyu7lGKD5h89VBYBp0H67HJ08tlV1gEuQmYDPfQNC
hHyHIRNxFLStPtGpyGjpzpM/UQ2geOdYXhU4QSjHtGR3stg2UXRoEp4WcsMWeCBt
PPo7ow4v6Z7PrC/tnZ7E95UJ3mb9x+6H0YCOG25VUfj60tBzxUap0/CZnhptsCqc
ClI/BsC0pCE/SrWSH4tX1R2FWXAG/LnIBB4nEsxGF6YRDjf9X66H/Uuaq+ePTNv+
P+KsTxVhxr3NvxyZnCqp
=05oQ
-----END PGP SIGNATURE-----

--C7zPtVaVf+AK4Oqc--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
