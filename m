From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH v2 00/25] add support for AXP20X and AXP22X power supply
 drivers
Date: Fri, 27 Jan 2017 10:19:53 +0100
Message-ID: <20170127091953.i3nhfsekzycmlefu@lukather>
References: <20170127085458.18270-1-quentin.schulz@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3966434554763799517=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170127085458.18270-1-quentin.schulz@free-electrons.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Quentin Schulz <quentin.schulz@free-electrons.com>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, lars@metafoo.de, linux-pm@vger.kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, sre@kernel.org, linux@armlinux.org.uk, wens@csie.org, robh+dt@kernel.org, icenowy@aosc.xyz, pmeerw@pmeerw.net, knaack.h@gmx.de, bonbons@linux-vserver.org, lee.jones@linaro.org, thomas.petazzoni@free-electrons.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org


--===============3966434554763799517==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="b3ypkqvahx4wz6hi"
Content-Disposition: inline


--b3ypkqvahx4wz6hi
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 27, 2017 at 09:54:33AM +0100, Quentin Schulz wrote:
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
> VBUS driver has intentionally not been modified to use the ADC channels
> because a DT binding already exists for this driver. Migrating the
> driver would mean to add an iio_map to map the ADC channels to the VBUS
> driver (so we can use iio_channel_get and iio_read_channel_processed
> functions). This slightly complexifies the VBUS driver only for
> "cosmetic" changes. Feel free to give your two cents on the matter.
>=20
> This series of patch is based on a previous upstreaming attempt done by
> Bruno Pr=E9mont few months ago. It differs in three points: the ADC
> driver does not tell the battery temperature (TS_IN) as I do not have a
> board to test it with, it does not tell the instantaneous battery power
> as it returns crazy values for me and finally no support for OCV curves
> for the battery.
>=20
> You can test these patches from this repo and branch:
> https://github.com/QSchulz/linux/tree/axp2xx_adc_batt_ac_v2

For the whole serie,
Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--b3ypkqvahx4wz6hi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYixC1AAoJEBx+YmzsjxAg5CsP/RzqJfR3TS4bRCh2ELe/H3zA
J1iiCEirozS5y9CxxQunTutEgCRjxL//6Hb77FCuqKNmmRwHPzRWU9ynyGVJ+eJR
ScUY4qvFe6gfkXSSqlh7Xn4Cf7tJ1fCiVYwsBdW/yyjdBXit3fm05Gw/vmY09M+/
Cid11oclorX6+VxI0ZGBGtHxHkTczpKDBho5G81TQUmUDIIYrqDBOmX6eXzUNZBy
98u0WAaI80BEf2F8BMw9y9zImccKpZEd80o78gogpYFe3MoTYx8RcmnLXVUxKlZn
y/YvFVqlS6u6Rl17DTaeyCQ4BOvtCYUb5S11v38/I+tVH/qPkor/MrxgDutjCzOi
L1yKNLeH3oHu6WGYxSQrOleeS78ewcsySX7X4UYIchLwDQOGn9JGpAQ6lUQwoUh+
8wiIwxWpMDpzO2SvSAkts34QXGBKdzsOrSZdf5eKbCDglCOM9z6otA+ln8n23jGy
y/5o9zDAwBHcaf4Ybi6nw15XhDYlocXhyOFh7saj2mjiA+OifyJMnL2kCueCM1Gr
qyBZsCRrHL8yYf7tVQHUV+Tfqhrwt5BqZGqTjBF3y04n3rr4EiD21JRYDXUFP6BA
nYN7eZL5EfxEQEbnB5WkjnnqbAAgjz46ecZ0w0okW/FXAiDJMmAFPBBzGihipr1H
Ch7dHiLYZ4FwocJ05j97
=hEK6
-----END PGP SIGNATURE-----

--b3ypkqvahx4wz6hi--


--===============3966434554763799517==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============3966434554763799517==--
