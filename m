From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v2 00/11] add support for VBUS max current and min
 voltage limits AXP20X and AXP22X PMICs
Date: Thu, 12 Jan 2017 10:28:21 +0100
Message-ID: <20170112092821.5xkgpsbbsxaz3s7h@lukather>
References: <20161209110419.28981-1-quentin.schulz@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2hkznrjrpqtzmxz7"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20161209110419.28981-1-quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Quentin Schulz <quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
List-Id: linux-pm@vger.kernel.org


--2hkznrjrpqtzmxz7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 09, 2016 at 12:04:08PM +0100, Quentin Schulz wrote:
> The X-Powers AXP209 and AXP20X PMICs are able to set a limit for the
> VBUS power supply for both max current and min voltage supplied. This
> series of patch adds the possibility to set these limits from sysfs.
>=20
> Also, the AXP223 PMIC shares most of its behaviour with the AXP221 but
> the former can set the VBUS power supply max current to 100mA, unlike
> the latter. The AXP223 VBUS power supply driver used to probe on the
> AXP221 compatible. This series of patch introduces a new compatible for
> the AXP223 to be able to set the current max limit to 100mA.
>=20
> With that new compatible, boards having the AXP223 see their DT updated
> to use the VBUS power supply driver with the correct compatible.
>=20
> This series of patch also migrates from of_device_is_compatible function
> to the data field of of_device_id to identify the compatible used to
> probe. This improves the code readability.
>=20
> Mostly cosmetic changes in v2 and adding volatile and writeable regs to
> AXP20X and AXP22X MFD cells for the VBUS power supply driver.

Applied all the DT patches. I also fixed all the prefixes. Please make
sure to look at what prefixes are used by a given subsystem next time.

Thanks!
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--2hkznrjrpqtzmxz7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYd0wxAAoJEBx+YmzsjxAgbF0P/1vHq7i3wdH65f4cQuhTC4Wr
Ab2X8ioNNguS+pD413sZ6g00q1+pt1ifvYb321PkgMe1NtOfaof6+qLoQIFb8IxA
N5+7hyGiTSuXoJnxwv7kWxCxOjIkmblSVKbyfdoY+/g3kx7zDUCdMzOo2fOnM/O6
M56n06h3UMNpirqSW+v6Mk2MCQP6KJiZtXuD3CJXT8X4L3+EO29FGhNgGAkVoZIu
sSKX7RpoAvfMkJ1rQ+Kt1wQpssbWcACtgbzfLnYu9fOI9ybr0LxU2Z3uOc8bWleL
MfVnhhYUJkaSovNkSO13++ZIHOhhPJqzucbyYCv79w5BKRvYBgpcYrarjtMZqbOr
y1xnfSlJRQ+rpEPCQeDqCWBbmgFlvqSzJ4vro3aKhcwSlKflYPZ5cBAAv9AX6Q/0
QSgGt6CWQoDuU72VPzk5BV2vOjDcfWaL7X9ZtVASWBqwz59pDRpxCKLRy9/Lhg66
GuceOmrXNmJnbr+6+rUdmt+037ObFALC0i7B6NDLl76j0p3Cfpp2r/ZzrIyZhp4m
ANmZ9HuaaEa0Iq4lu+Cb8Uxj8OTdsQrJmM570zqsOD48MmBCGDi8/rjV8wpzYv/I
fHveEFBuJauIC/qUx/hKqxnlaXmN7R3tEiUDe5S2v3HCwIv5ZWMKa5bp6TKjqd/I
IzeP8ufvJgkD22ZfrMu0
=T7Yu
-----END PGP SIGNATURE-----

--2hkznrjrpqtzmxz7--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
