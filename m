From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 2/2] power: supply: axp288_charger: Only wait for INT3496
 device if present
Date: Mon, 20 Mar 2017 02:30:39 +0100
Message-ID: <20170320013039.vyi3zd5cc5ujqd5o@earth>
References: <20170316161736.339-1-hdegoede@redhat.com>
 <20170316161736.339-3-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hgrpwmbr5f7hjg2l"
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170316161736.339-3-hdegoede@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Chen-Yu Tsai <wens@csie.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--hgrpwmbr5f7hjg2l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Mar 16, 2017 at 05:17:36PM +0100, Hans de Goede wrote:
> On some devices with an axp288 pmic setting vbus path based on the
> id-pin is handled by an ACPI _AIE interrupt on the gpio and the
> INT3496 device is disabled.
>=20
> Instead of returning -EPROBE_DEFER on these devices waiting for the
> never to show up INT3496 device, check for its presence and only
> request and monitor the matching extcon if the device is there,
> otherwise let the firmware handle the vbus path control.
>=20
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/power/supply/axp288_charger.c | 24 +++++++++++++++---------
>  1 file changed, 15 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/power/supply/axp288_charger.c b/drivers/power/supply=
/axp288_charger.c
> index d3bf4b2..6c4ad66 100644
> --- a/drivers/power/supply/axp288_charger.c
> +++ b/drivers/power/supply/axp288_charger.c
> @@ -14,6 +14,7 @@
>   * GNU General Public License for more details.
>   */
> =20
> +#include <linux/acpi.h>
>  #include <linux/module.h>
>  #include <linux/device.h>
>  #include <linux/regmap.h>
> @@ -114,7 +115,8 @@
>  #define ILIM_3000MA			3000	/* 3000mA */
> =20
>  #define AXP288_EXTCON_DEV_NAME		"axp288_extcon"
> -#define USB_HOST_EXTCON_DEV_NAME	"INT3496:00"
> +#define USB_HOST_EXTCON_HID		"INT3496"
> +#define USB_HOST_EXTCON_NAME		"INT3496:00"
> =20
>  static const unsigned int cable_ids[] =3D
>  	{ EXTCON_CHG_USB_SDP, EXTCON_CHG_USB_CDP, EXTCON_CHG_USB_DCP };
> @@ -808,10 +810,12 @@ static int axp288_charger_probe(struct platform_dev=
ice *pdev)
>  		return -EPROBE_DEFER;
>  	}
> =20
> -	info->otg.cable =3D extcon_get_extcon_dev(USB_HOST_EXTCON_DEV_NAME);
> -	if (info->otg.cable =3D=3D NULL) {
> -		dev_dbg(dev, "EXTCON_USB_HOST is not ready, probe deferred\n");
> -		return -EPROBE_DEFER;
> +	if (acpi_dev_present(USB_HOST_EXTCON_HID)) {

I may have missed something, but as far as I can see axp288 also
supports DT based init, so that should be handled here.

-- Sebastian

--hgrpwmbr5f7hjg2l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAljPMLwACgkQ2O7X88g7
+ppIyBAAnD/XKKdSdVH+rBlAWZWrIM9KHWbAbgmPD/65HsnI5sZBK4UiqALBGlAN
eO88+TFKWPL3QBvsuVmicox0GZ2q25BZ3conLz9SWEDInpYm89jEyq2ywYFsrY+u
sm+5qP72dZ5OMUe9m9uoyG46d78snKu6b7eGgYBNpoR6A28F3olvyrWwsFaaLlAi
71k6JwfvxD/XTQBrsZ7ClU8+ea+1gAgHvPeSRfBApM28rbUYho6QxvKM2/ofAqdP
lMxn3o4nuReIny9s9Uz7QK/9hzNL4fMTVMNKRlJSRMfLZnD2CB3T9l3cpwzVe6KA
5KUuGkvfdX+Q23uDGF1TyV4omZ/ZeZMvMs8Ex+bEKammwFsQBRWgdbCzibcX6UAj
qlUlYgVeoijkQtAzQ+kzXLBu3P6rw+GEL5Aw7vGiUML4R0yWSx29hvQaRoSV3XdW
0RR4EidL55N/4q0w3zrw1n2wxyvHR2aidFbMGNg6/GXmNNzOCTIUU3q+bYH/3HKa
OgRef4XM2bfgFMY5xvMVfUOgYWxwiAXUPecd3A9nWq6ktAeMR7QHdveZd2t8Io2w
cOjh14PfRBDjFgpsZTLFO86x0ISNHwNlX3JTU+BfGok7Sy0MYrt7KI/QGUYGX5/S
mtqvdlQ/4CsYnpoE6MbeLZouNosQ9lRTC15Pd0BHeM20p1w4SGk=
=zC6s
-----END PGP SIGNATURE-----

--hgrpwmbr5f7hjg2l--
