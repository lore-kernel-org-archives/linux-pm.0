From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v6 0/6] add support for AXP20X and AXP22X
 battery power supply driver
Date: Fri, 21 Apr 2017 09:43:17 +0200
Message-ID: <20170421074317.rqk253sblxjaayzz@lukather>
References: <20170418073421.31351-1-quentin.schulz@free-electrons.com>
Reply-To: maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="xjq4nn73ddpedtbk"
Return-path: <linux-sunxi+bncBDSJBYGBRIMBBH7Q43DQKGQEMEP64ZY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Content-Disposition: inline
In-Reply-To: <20170418073421.31351-1-quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Quentin Schulz <quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, icenowy-ymACFijhrKM@public.gmane.org, liam-RYWXG+zxWwBdeoIcmNTgJF6hYfS7NtTn@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-pm@vger.kernel.org


--xjq4nn73ddpedtbk
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 18, 2017 at 09:34:15AM +0200, Quentin Schulz wrote:
> This is a series for AXP20X and AXP22X battery power supply without the
> support for changing constant charge current from the DT. The patches for
> supporting the constant charge current from DT are ready and will be sent
> once the battery framework required to make this work has been merged.
>=20
> v6:
>   - removed mention to fixed battery in DT-binding documentation,
>=20
> Quote from v4 cover letter:
>=20
> The X-Powers AXP20X and AXP22X PMICs have multiple ADCs. They expose
> information and data of the various power supplies they support such as
> ACIN, battery and VBUS. For example, they expose the current battery
> voltage, charge or discharge, as well as ACIN and VBUS current voltages
> and currents, internal PMIC temperature and ADC on 2 different GPIOs
> when in the right mode (for the AXP209 only).
>=20
> The ACIN power supply driver is added by this patch. The AXP20X and
> AXP22X can both read the status and the "usability" of the power supply
> but only the AXP209 will be able to tell the current current and voltage
> of the power supply by reading ADC channels. It is simply not supported
> by the AXP22X PMICs.
>=20
> The battery power supply driver is also added by this patch. The AXP20X
> and AXP22X share most of their behaviour but have slight variations. The
> allowed target voltages for battery charging are not the same, the
> AXP22X PMIC are able to tell if the battery percentage computed by the
> PMIC is trustworthy and they have different formulas for computing max
> current for battery power supply. The driver is able to give the current
> voltage and current of the battery (be it charging or discharging), the
> maximal and minimal voltage and maximal current allowed for the battery,
> whether the battery is present and usable and its capacity. It will get
> the battery current current and voltage by reading the ADC channels. The
> PMIC allows maximal voltages (4.36V for AXP20X and 4.22V and 4.24V for
> AXP22X) that should not be used with Lithium-based batteries and since
> this PMIC is supposed to be used with Lithium-based batteries, they have
> been disabled. The values returned by the ADC driver are multipled by
> 1000 to scale from the mV returned by the ADC to the uV expected by the
> power supply framework.
>=20
> This series of patch adds DT bindings for ACIN power supply, ADC and
> battery power supply drivers for AXP20X and AXP22X PMICs and their
> documentation. It also enables the supported power supplies for the
> Nextthing Co. CHIP and Sinlinx SinA33 boards.
>=20
> The different drivers are also added to the MFD cells of the AXP20X and
> AXP22X cells and the writeable and volatile regs updated to work with
> the newly added drivers.
>=20
> This series of patch is based on a previous upstreaming attempt done by
> Bruno Pr=C3=A9mont few months ago. It differs in three points: the ADC
> driver does not tell the battery temperature (TS_IN) as I do not have a
> board to test it with, it does not tell the instantaneous battery power
> as it returns crazy values for me and finally no support for OCV curves
> for the battery.
>=20
> You can test these patches from this repo and branch:
> https://github.com/QSchulz/linux/tree/axp2xx_adc_batt_ac_v4
>=20
> v4:
>  - added the ability to set maximum constant charge current from sysfs,
>  - added a warning when setting a higher than current maximum constant ch=
arge
>  current,
>  - set default to minimum possible value for current and maximum constant=
 charge
>  current when no battery DT is present or invalid battery DT,
>  - fixed a forgotten custom formula to compute maximum constant charge cu=
rrent
>  for AXP22X,
>  - automatically lower the current constant charge current when it is hig=
her
>  than the maximum constant charge current about to be set,
>=20
> v3:
>  - Removed DT property for constant charge current in favor of the WIP
>  battery framework as requested by Sebastian Reichel,
>  - Using a simple if condition instead of a switch in the ADC driver,
>  - Fixed error handling in ADC driver's probe,
>  - Fixed missing call to iio_map_array_unregister in the ADC driver's
>  remove,
>  - Removed ADC driver's DT node and documentation,
>  - Merged IIO channel mapping patches into the original ADC driver
>  patch,
>  - Removed `adding V-OFF to writeable reg' patch as it's already in
>  writeable reg range,
>=20
> v2:
>  - Some registers' name have been changed to better reflect their
>  purpose,
>  - Make VBUS power supply driver use IIO channels when AXP ADC driver is
>  enabled, but fall back on previous behavior when disabled. This is made
>  to avoid the ADC driver overwritting registers for VBUS power supply
>  ADC when removed,
>  - Removed useless adding of data registers to volatile registers,
>  - Reordered IIO channels, now grouped by same part of the PMIC (e.g.
>  voltage and current of the battery have the same index in different
>  IIO types),
>  - Added structures for specific data instead of matching on IDs,
>  - Switched from DT IIO channels mapping to iio_map structures IIO
>  channels mapping,
>=20
> Quentin
>=20
> Quentin Schulz (6):
>   dt-bindings: power: supply: add AXP20X/AXP22X battery DT binding
>   power: supply: add battery driver for AXP20X and AXP22X PMICs
>   ARM: dtsi: axp209: add battery power supply subnode
>   ARM: dtsi: axp22x: add battery power supply subnode
>   ARM: dts: sun8i: sina33: enable battery power supply subnode
>   ARM: sun5i: chip: enable battery power supply subnode

Applied the last 4 patches.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.

--xjq4nn73ddpedtbk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABCAAGBQJY+bgUAAoJEBx+YmzsjxAgnmAQALYEqWtiPNKBGNjLL4HOtKZt
xAVTCl6qIRq850NN08DDPOJu2hoXyxi5o+yjab9KJhx0cEW7ui26IQ2abgLtt1cM
e+uqJL4XtqbW0LzTVAjnKvuNS+gukAlDeH2FMJXp0dbpzlEpDjswyLdubHHMueOn
LxNT7Ocpm2EvXqFR7Im+jQDkm4JUD6BtChyGpZ9MfWmrLYz1v6X5AAeVNnbm1SDT
UswgmO43ZSNv68/mVQoaMXoaOKnkiutXaCU1A96hIbwnjB2+szC5jSxEBCs8ro0Z
uPytWnJFOirx8V/aekjgMw5VTKugSR9ZJlR0J1EHI5n6VdLCyAxc9q1sGRnMJE8+
HxZNFa+E+B8lvvi5H2XgakGiZKML+gX0DS6DIWYXfc7PkAzN4ib3h3ofVHhXTyEH
HvxkR5Klx07hZoIkzzsTkK68kfkPWVyS+DisUTTrNlr/bHwOyUspVbAk/By43G//
CHNMtVe4UMwx4FtgfS2MDf2yX9cA4EZNM3mjNzpswehSpB1cfQtANdbXS1eCKhxz
LXxrTMxRZ+yP0a+llzmoLED++YzgZthUMsi/PcAV6jNolSBgjPg024lIPWix66jH
N1lji7dh8OrpL99e7dc06T8+Z/hdHL6fuQtlR0ekB/1DsJyTBhJzfQh/ACUIOhMZ
ma8bIvo/VVpsJfikw81X
=Ea2Z
-----END PGP SIGNATURE-----

--xjq4nn73ddpedtbk--
