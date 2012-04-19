From: Andrey Rahmatullin <wrar-Bxt/JK/G85ezQB+pC5nmwQ@public.gmane.org>
Subject: Re: [linux-pm] ehci_hcd related S3 lockup on ASUS laptops, again
Date: Thu, 19 Apr 2012 21:44:53 +0600
Message-ID: <20120419154453.GZ11484@belkar.wrar.name>
References: <Pine.LNX.4.44L0.1204181729400.1149-100000@iolanthe.rowland.org>
 <Pine.LNX.4.44L0.1204190934500.2070-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="iRomnA/8S0UoJbe2"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1204190934500.2070-100000-IYeN2dnnYyZXsRXLowluHWD2FQJk+8+b@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Cc: jrnieder-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-pm-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Steven Rostedt <rostedt-nx8X9YLhiw1AfugRpC6u6w@public.gmane.org>
List-Id: linux-pm@vger.kernel.org


--iRomnA/8S0UoJbe2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 19, 2012 at 09:43:45AM -0400, Alan Stern wrote:
> But before going any farther, I'd like to test if USB wakeup works. =20
> So after booting with this patch, make sure that the power/wakeup file
> says "enabled" in the sysfs path for each controller as well as the
> usb1, usb2, 1-2, and 2-2 paths under /sys/bus/usb/devices/.
Should I change them if they say "disabled"?

--=20
WBR, wRAR

--iRomnA/8S0UoJbe2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBCAAGBQJPkDL1AAoJEDNi9wMaSZLhonAQAJuBWsTFybZ5VH0ePqVwvX1p
IFhoP13d4Vew1Ii16Zm1iPKKxvu7+umdriULtMnTnuZjHUZs8WrYayDK41o7ukEp
iqMs4pdIBtFf7wUycGqsQNvgUo6GfoITmrDWtW86KEeDh+wZLCR9Pifh2oUxKPcs
4XLGDBE3EfLUXTpHJ/Y3sMZu0fgagrPv8SIGb2YoGEPD1sd5PokHE0ZyD+7YrJpo
JMIOjMRm4tJ3FOP/C85R3ZB5pHAp6uiMaAJYISnGbSusGjZkTvrpCf1DMs4R9wiy
oJRCBvbXhGwqywWf66qCzQLoEngzGRS6Aq6SMWzW+kRF+agcPoZJDNuUVEmwiytY
x+Lf3EIL3cCBbBjVOiRrAi0xx1iKpshGmK85AUmAk+GTBzQb1E8Bjyakj4+m5wFS
QA9eCwyWyEm0dK7D5UkeNhgXOHnxjrS+N2jnxkblURbbpz8HqHj1ntOang9JXVjz
jb0z0iGhrjGI4al0Z7TY2bM55oqaSS8nH8zcjIGFqE6imLOiVL04w6cZ0mcbfkYp
KF96UKw8i9Z8xtdHnXIkpGh5rFwHUFKrD95RMqzz9IsopLbICNmThEFjauzHkxjV
92BV9kE4Bzql+5cGHgjcCwwBhjM/zYvEyw/e7hLMhu1ZODanQgALN+EGkDGks5U8
ux7918LVt+qarXCld6Jo
=qy4a
-----END PGP SIGNATURE-----

--iRomnA/8S0UoJbe2--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
