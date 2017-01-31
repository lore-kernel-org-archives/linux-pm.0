From: Quentin Schulz <quentin.schulz@free-electrons.com>
Subject: Re: [PATCH v2 16/25] dt-bindings: power: supply: add AXP20X/AXP22X
 battery DT binding
Date: Tue, 31 Jan 2017 08:59:19 +0100
Message-ID: <2dc8ffb5-af22-8224-f0b8-e2d6d8ab8ca3@free-electrons.com>
References: <20170127085458.18270-1-quentin.schulz@free-electrons.com>
 <20170127085458.18270-17-quentin.schulz@free-electrons.com>
 <20170129164719.eulijkfarzrm2o6j@earth>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7567171177955439062=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170129164719.eulijkfarzrm2o6j@earth>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Sebastian Reichel <sre@kernel.org>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, lars@metafoo.de, linux-pm@vger.kernel.org, linux-iio@vger.kernel.org, linux@armlinux.org.uk, linux-kernel@vger.kernel.org, wens@csie.org, robh+dt@kernel.org, icenowy@aosc.xyz, pmeerw@pmeerw.net, knaack.h@gmx.de, maxime.ripard@free-electrons.com, bonbons@linux-vserver.org, lee.jones@linaro.org, thomas.petazzoni@free-electrons.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============7567171177955439062==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="6xHDwn8BHIhCNE1D21EOLgvK8qNDeCCl3"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6xHDwn8BHIhCNE1D21EOLgvK8qNDeCCl3
Content-Type: multipart/mixed; boundary="98eEUvKTflTQSpavOKabwwiMuVvoTbRUi";
 protected-headers="v1"
From: Quentin Schulz <quentin.schulz@free-electrons.com>
To: Sebastian Reichel <sre@kernel.org>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net, robh+dt@kernel.org,
 mark.rutland@arm.com, wens@csie.org, linux@armlinux.org.uk,
 maxime.ripard@free-electrons.com, lee.jones@linaro.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, thomas.petazzoni@free-electrons.com,
 icenowy@aosc.xyz, bonbons@linux-vserver.org
Message-ID: <2dc8ffb5-af22-8224-f0b8-e2d6d8ab8ca3@free-electrons.com>
Subject: Re: [PATCH v2 16/25] dt-bindings: power: supply: add AXP20X/AXP22X
 battery DT binding
References: <20170127085458.18270-1-quentin.schulz@free-electrons.com>
 <20170127085458.18270-17-quentin.schulz@free-electrons.com>
 <20170129164719.eulijkfarzrm2o6j@earth>
In-Reply-To: <20170129164719.eulijkfarzrm2o6j@earth>

--98eEUvKTflTQSpavOKabwwiMuVvoTbRUi
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hi,

On 29/01/2017 17:47, Sebastian Reichel wrote:
> Hi,
>=20
> On Fri, Jan 27, 2017 at 09:54:49AM +0100, Quentin Schulz wrote:
>>  - added x-powers,constant-charge-current property to set the
>>  maximal default constant current charge of the battery,
>=20
> Since this is information about the battery and not the fuel-gauge,
> it should use the WIP "framework" for information about batteries.
>=20
> Have a look at the following patchset:
>=20
> http://marc.info/?l=3Dlinux-pm&m=3D148411561025684&w=3D2
>=20

OK. So what you propose is to have a fourth property in this new
structure named design-max-constant-charge-current that gives the
maximal input amperage the battery can receive?

Then, I set the charger to output a maximum of this amperage by default
and let the user the possibility to choose between the minimum allowed
by the PMIC and the maximum allowed by the battery from sysfs. That
makes more sense than what I do here in the way that I didn't protect a
possible over-amperage of the battery, thing that Chen-Yu was afraid
some users would do.

I've a comment on the linked patches however. Though the three
properties are listed as optional in the binding-dt, the implementation
is saying the opposite:

http://marc.info/?l=3Dlinux-pm&m=3D148411561725693&w=3D2

If I'm not mistaken, if `nominal-microvolt' or `design-microwatt-hours'
is not a property of the DT node, power_supply_get_battery_info will
return without parsing the other properties and even return a negative
error.

Thanks,
Quentin
--=20
Quentin Schulz, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com


--98eEUvKTflTQSpavOKabwwiMuVvoTbRUi--

--6xHDwn8BHIhCNE1D21EOLgvK8qNDeCCl3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYkEPaAAoJEIS4mnU+4PGjFTQP/RcQ0aqiGSO+9mN4NPCdW6Tb
hLPEo7sCViig7jr5FRyTLFxtgQ4js7j53v2HAL2F9+LM0IETNVwye9WgvCx4IL5Y
LuSJGp4s+fEG5veWv714YYoJI34CSQccc2VnBBAGSeg+df8Q/8VIDXSeFzz4gOSh
du0HvDO/lJTLYez/tkZ3ktEc/XTa+qIgD2YEe3yzEdLDGmrdtWoUSLnnIAug9iU+
OkG5rQWgsLzmtEYTGcZY+ti0Bin3E03L+tNhlaZoLQ5VMC2GXFZjx/Drvf5UX5vh
6RDvqFKNIkUJpB5Frv9AnsX7xwiHNNsbgditZ68xcqhnhxoHkBDYvaor/swv7Wge
xOvCGdeXfbaPd35cEnVJDzGp/2Ialhw4egFOKpimgq4Gv0zs8jH/pm2x4BP8NxIg
vfpGbobV+TIrWd+O0Zfm9i4ii3MBR9Wx2JYHUtrVBtTNJXmjmRKwvr/c6b1t1YZd
5FULv6MePJt7C5Bx2kwNKWV5Jfy1ntaZ21dvyUS8OKKtfHGt+z61eKqnKEpOffo4
fD19FPdcLorOLS/qUV/2FViU/O2JcC5mFUbubmweYb7KWitasiRmo2EvqS0mn/Ci
DgjdsrBQH8BjNBfdq84uFSXs+Z9bDNU6yr1uKmP7355Ofx4vKAC8uLbut7L3tu3E
3zA3G6t5VCHU3wACjWNs
=RQ3s
-----END PGP SIGNATURE-----

--6xHDwn8BHIhCNE1D21EOLgvK8qNDeCCl3--


--===============7567171177955439062==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============7567171177955439062==--
