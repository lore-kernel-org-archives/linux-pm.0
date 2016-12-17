From: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 00/11] add support for VBUS max current and min
 voltage limits AXP20X and AXP22X PMICs
Date: Sat, 17 Dec 2016 16:54:31 +0100
Message-ID: <20161217155431.jlkxxdgxzu5aiuke@earth>
References: <20161209110419.28981-1-quentin.schulz@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="d7wkknmodmutt4up"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20161209110419.28981-1-quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Quentin Schulz <quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
List-Id: linux-pm@vger.kernel.org


--d7wkknmodmutt4up
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Quentin,

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
>=20
> Quentin Schulz (11):
>   power: supply: axp20x_usb_power: use of_device_id data field instead
>     of device_is_compatible
>   mfd: axp20x: add volatile and writeable reg ranges for VBUS power
>     supply driver
>   power: supply: axp20x_usb_power: set min voltage and max current from
>     sysfs
>   Documentation: DT: binding: axp20x_usb_power: add axp223 compatible
>   power: supply: axp20x_usb_power: add 100mA max current limit for
>     AXP223
>   mfd: axp20x: add separate MFD cell for AXP223
>   ARM: dtsi: add DTSI for AXP223
>   ARM: dts: sun8i-a33-olinuxino: use AXP223 DTSI
>   ARM: dts: sun8i-a33-sinlinx-sina33: use AXP223 DTSI
>   ARM: dts: sun8i-r16-parrot: use AXP223 DTSI
>   ARM: dtsi: sun8i-reference-design-tablet: use AXP223 DTSI

Thanks for your patchset. We are currently in the merge
window and patches 1 & 3-5 will appear in linux-next once
4.10-rc1 has been tagged by Linus Torvalds.

Until then I queued them into this branch:

https://git.kernel.org/cgit/linux/kernel/git/sre/linux-power-supply.git/log=
/?h=3Dfor-next-next

-- Sebastian

-- Sebastian

--d7wkknmodmutt4up
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlhVX7QACgkQ2O7X88g7
+pppjA/+JxL7PUScCRUohft1CvgxMqJFpuVYaJ4H5F0BKkYmOHJg6FQNLSryGffK
VXaGNQ2f20NY5H4gWHUndnp7PssqOXrULkLL3VS5UCYbPkmqeOYrmnRKpuyGWVJy
PEvsYW6MFwQ96D57CJspQifYMJfxZm4gq4SAlpurwgc4WhbNe9wg+d9nDss8rkgI
SNDU7fxkpzfSA+vG8aL6h1JBQbzLTls1zqoSUqzBalgkZNXTMEeoltIdH5zHmIqx
IQ3qunxTAUVNxeugiJAuEktwdTKkDgztvD+SQNJmbJCGlyc/P3gPkgGkv7O1CY0E
U9CI0CEiBgTQ/CW8a+HI9WakU3NxwFL/KFlLcIWUqxyTrj5jtdR/5tSIeNU60q4u
6wA8/DT/yc07vRhIF7Cr1nHKva88i+hnkIdEpaqlHuy0xqx2BShKfFsza08Xr6gX
FFjc5lCcG3FTf73Mp2wJ4wujAFcShIKBaCLFPUv6QGHpqHIEOgg96SxJ6B/llGsy
92ACA1UREHoO/3w/eZPNe7tFJGTUYxYZZkD2niFIKJ0xcrn9YMRrGRzJJ6lE9Z1e
leTi5W/Zh5pPncd+7D3/LVGV+v7jmR8K2ALtl6Q2ThUm33TKiVP3FXPFx1gL/LuT
FFWlFURolO9Ilt/wM/Y7mnB3aPGV9cmCZMS9LTHNJ/fX59et0MM=
=ResL
-----END PGP SIGNATURE-----

--d7wkknmodmutt4up--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
