From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [RFC PATCH 5/7] power: supply: Add type for USB PD PPS chargers
Date: Mon, 6 Nov 2017 14:25:42 +0100
Message-ID: <20171106132542.xe5hyfryxljmepaz@earth>
References: <cover.1509554370.git.Adam.Thomson.Opensource@diasemi.com>
 <d1fcc24b60933b590fc6c8e8946e9ccb44364306.1509554370.git.Adam.Thomson.Opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yxpx3fnfdllnbufj"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <d1fcc24b60933b590fc6c8e8946e9ccb44364306.1509554370.git.Adam.Thomson.Opensource@diasemi.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>, Guenter Roeck <linux@roeck-us.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Hans de Goede <hdegoede@redhat.com>, Yueyao Zhu <yueyao.zhu@gmail.com>, Rui Miguel Silva <rmfrfs@gmail.com>, linux-usb@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, support.opensource@diasemi.com
List-Id: linux-pm@vger.kernel.org


--yxpx3fnfdllnbufj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Nov 01, 2017 at 05:03:13PM +0000, Adam Thomson wrote:
> This adds a type to represent USB PPS chargers as defined in the
> USB Power Delivery Specification Revision 3.0 V1.1
>=20
> Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>

-- Sebastian

>  drivers/power/supply/power_supply_sysfs.c | 2 +-
>  include/linux/power_supply.h              | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/su=
pply/power_supply_sysfs.c
> index 5204f11..efd2469 100644
> --- a/drivers/power/supply/power_supply_sysfs.c
> +++ b/drivers/power/supply/power_supply_sysfs.c
> @@ -43,7 +43,7 @@
>  static const char * const power_supply_type_text[] =3D {
>  	"Unknown", "Battery", "UPS", "Mains", "USB",
>  	"USB_DCP", "USB_CDP", "USB_ACA", "USB_C",
> -	"USB_PD", "USB_PD_DRP", "BrickID"
> +	"USB_PD", "USB_PD_DRP", "USB_PD_PPS", "BrickID"
>  };
> =20
>  static const char * const power_supply_status_text[] =3D {
> diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
> index 79e90b3..3a79c75 100644
> --- a/include/linux/power_supply.h
> +++ b/include/linux/power_supply.h
> @@ -167,6 +167,7 @@ enum power_supply_type {
>  	POWER_SUPPLY_TYPE_USB_TYPE_C,		/* Type C Port */
>  	POWER_SUPPLY_TYPE_USB_PD,		/* Power Delivery Port */
>  	POWER_SUPPLY_TYPE_USB_PD_DRP,		/* PD Dual Role Port */
> +	POWER_SUPPLY_TYPE_USB_PD_PPS,		/* PD Programmable Power Supply */
>  	POWER_SUPPLY_TYPE_APPLE_BRICK_ID,	/* Apple Charging Method */
>  };
> =20
> --=20
> 1.9.1
>=20

--yxpx3fnfdllnbufj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAloAYtEACgkQ2O7X88g7
+prkhg//aJiW69K/n9C0dN9enoIuwfVjubZllY69mFdrVgr8s8r4kJAQu/jDwu91
otRflvjzyNx2XgpBAORibso36Wm7MdAngraCo9N8iaHNmFtQUtt1atkSw6t705eg
JyWL0OxQDZYSWTefvhozRvDD5wVSofoFyja6mtywgQvXamLN66IMfQ6rGvP1z44M
lPBQrDA8+sqfxVNDhMhqtgXF62XN2bYtN6EIeX/CU/oBfyrj5nzY4FTLbvj8Vp2c
fsxhH6J9M6msChPmhEaV4Yz8Y9hpdG0NfQ1SfuJEcnnom8gVHhR3EdrAlG80Kdfw
9mRfYl0pRDldOvvHAELSaMWynTB4VGFSj87KDyae2yZfgdHZThs1J1XPsCxxEiAX
EXcbMQ0kGpc1tuy3VZee//E9n3WGJhH+1LdcCpSp04mdPoHswNV6c47dPA3CepoF
m6DfhyQ0f/DkN5vMkKCmdUHI8no+HxJThf8tUk6s0ILuttoQu5/0LGMUQDh3g3dD
15PnVb4IBO38DG5E1bq0sZVHSnCSDVgJrlaos5H5hX1k8Fiunap40v6XMBbAaDl0
7L/vXt1h7ER08krrqqzdCMPEsK0jDT3Uti6wIPS0sBllPotNAHvhFwRp8WqdzDdu
te1taP5SG2CwuffpQvNXXJ6VCrWnFOeim99DkLOfCyLfdIKbFYU=
=8Hm1
-----END PGP SIGNATURE-----

--yxpx3fnfdllnbufj--
