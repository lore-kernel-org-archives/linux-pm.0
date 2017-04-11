From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v2] power: supply: axp288_charger: Only wait for INT3496
 device if present
Date: Tue, 11 Apr 2017 16:34:26 +0200
Message-ID: <20170411143426.tyqhi2qefv56bf5t@earth>
References: <20170331110125.27006-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jaqzwywslem7xtpb"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:43736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752485AbdDKOeb (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 11 Apr 2017 10:34:31 -0400
Content-Disposition: inline
In-Reply-To: <20170331110125.27006-1-hdegoede@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Chen-Yu Tsai <wens@csie.org>, linux-pm@vger.kernel.org


--jaqzwywslem7xtpb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Mar 31, 2017 at 01:01:25PM +0200, Hans de Goede wrote:
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
> Acked-by: Sebastian Reichel <sre@kernel.org>
> ---
> Changes in v2:
> -Do not schedule otg.work to sync the id-pin state when we don't have
>  the extcon, this avoids turning off charging as soon as the driver loads
>  on devices without the extcon
> ---

Does not apply due to missing acpi_dev_present(). I'm fine with this
going through the ACPI tree.

-- Sebastian

>  drivers/power/supply/axp288_charger.c | 26 ++++++++++++++++----------
>  1 file changed, 16 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/power/supply/axp288_charger.c b/drivers/power/supply=
/axp288_charger.c
> index 7d4e64c..a64c720 100644
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
> +		info->otg.cable =3D extcon_get_extcon_dev(USB_HOST_EXTCON_NAME);
> +		if (info->otg.cable =3D=3D NULL) {
> +			dev_dbg(dev, "EXTCON_USB_HOST is not ready, probe deferred\n");
> +			return -EPROBE_DEFER;
> +		}
>  	}
> =20
>  	platform_set_drvdata(pdev, info);
> @@ -850,13 +854,15 @@ static int axp288_charger_probe(struct platform_dev=
ice *pdev)
>  	/* Register for OTG notification */
>  	INIT_WORK(&info->otg.work, axp288_charger_otg_evt_worker);
>  	info->otg.id_nb.notifier_call =3D axp288_charger_handle_otg_evt;
> -	ret =3D devm_extcon_register_notifier(&pdev->dev, info->otg.cable,
> +	if (info->otg.cable) {
> +		ret =3D devm_extcon_register_notifier(&pdev->dev, info->otg.cable,
>  					EXTCON_USB_HOST, &info->otg.id_nb);
> -	if (ret) {
> -		dev_err(dev, "failed to register EXTCON_USB_HOST notifier\n");
> -		return ret;
> +		if (ret) {
> +			dev_err(dev, "failed to register EXTCON_USB_HOST notifier\n");
> +			return ret;
> +		}
> +		schedule_work(&info->otg.work);
>  	}
> -	schedule_work(&info->otg.work);
> =20
>  	/* Register charger interrupts */
>  	for (i =3D 0; i < CHRG_INTR_END; i++) {
> --=20
> 2.9.3
>=20

--jaqzwywslem7xtpb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAljs6XIACgkQ2O7X88g7
+pqwqA//efpRtMqNKUvYWHu8vbebhAcsPWZ80ruyMsgkIq1D9NwT8GqLhuTUzWuD
6QDYLNo7bXohwWTgupRd5r4XrWUpZoM13cdK/LizjkB8TQdcnyEVvmmfLSHPdgtK
B9pD4e121qi1ph3Evc07B6NUImfWdQmynyWOwvS3gXjun8voDzcEPmHj1ULra2zo
fFlwFKPxXmeA65ERr82oGxvlTcHfzvb3s8hmVThSx19agZHWwBTXliLQYppVCP5R
QeVYcKwcZQ/ZvCJJe6DEDiND/4fZ9Zt4rkuCszJDX23kJVFvQ69hDYAv94vfHZ8T
Qz8tULRuhu7gm3CmHRhY8NBTLdS/chWpxeYRPlXVOmpyTJxG2+bd2KntDFOvsPc9
V49iqunGjtuybTpoOhrCuRAE0ucvTWvEcGEdsvc+Yn7A+jIV0yKdm4ZZW7J7MCNz
a+xsLWm89HITsFI7ZA/MSC0jh4HVGedIA8DRxxbAKYgNgut/URDvBp4+ActTUjHO
GQMMgWGalehs85z1gNPp/2cUtzPKIbEMDzuSotAXQ2aU7RQEMFogzsRWrnL9xFF6
4vvBTFSEkDVKY+GhKCDfH/buvbkY2HOJoL9Rgudso2KkH8SQVpJMtgi/mNrTSoPQ
s6nDUuIfYD5+xmVI1YOh330P6IJkOQoycVmfBrIqswUYCTNfHpY=
=4Hif
-----END PGP SIGNATURE-----

--jaqzwywslem7xtpb--
