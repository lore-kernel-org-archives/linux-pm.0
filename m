From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [RESEND PATCH 2/3] power: axp288_charger: Replace deprecatd API
 of extcon
Date: Fri, 15 Apr 2016 16:20:53 +0200
Message-ID: <20160415142053.GB24087@earth>
References: <1460681016-2770-1-git-send-email-cw00.choi@samsung.com>
 <1460681016-2770-3-git-send-email-cw00.choi@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="eAbsdosE1cNLO4uF"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1460681016-2770-3-git-send-email-cw00.choi@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chanwoo Choi <cw00.choi@samsung.com>
Cc: dbaryshkov@gmail.com, dwmw2@infradead.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--eAbsdosE1cNLO4uF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Apr 15, 2016 at 09:43:35AM +0900, Chanwoo Choi wrote:
> This patch removes the deprecated notifier API of extcon framework and th=
en use
> the new extcon API[2] with the unique id[1] to indicate the each external
> connector. Alter deprecated API as following:
> - extcon_register_interest() -> extcon_register_notifier()
> - extcon_unregister_interest() -> extcon_unregister_notifier()
> - extcon_get_cable_state() -> extcon_get_cable_state_()
>=20
> And, extcon alters the name of USB charger connector in patch[3] as follo=
wing:
> - EXTCON_CHG_USB_SDP /* Standard Downstream Port */
> - EXTCON_CHG_USB_DCP /* Dedicated Charging Port */
> - EXTCON_CHG_USB_CDP /* Charging Downstream Port */
> - EXTCON_CHG_USB_ACA /* Accessory Charger Adapter */
>=20
> [1] Commit 2a9de9c0f08d61
> - ("extcon: Use the unique id for external connector instead of string)
> [2] Commit 046050f6e623e4
> - ("extcon: Update the prototype of extcon_register_notifier() with enum =
extcon
> [3] Commit 11eecf910bd81d
> - ("extcon: Modify the id and name of external connector")
>=20
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> ---
>  drivers/power/axp288_charger.c | 77 +++++++++++++++++++++++++++++-------=
------
>  1 file changed, 53 insertions(+), 24 deletions(-)
>=20
> diff --git a/drivers/power/axp288_charger.c b/drivers/power/axp288_charge=
r.c
> index e4d569f57acc..e5c2569befa6 100644
> --- a/drivers/power/axp288_charger.c
> +++ b/drivers/power/axp288_charger.c
> @@ -129,10 +129,6 @@
> =20
>  #define AXP288_EXTCON_DEV_NAME		"axp288_extcon"
> =20
> -#define AXP288_EXTCON_SLOW_CHARGER		"SLOW-CHARGER"
> -#define AXP288_EXTCON_DOWNSTREAM_CHARGER	"CHARGE-DOWNSTREAM"
> -#define AXP288_EXTCON_FAST_CHARGER		"FAST-CHARGER"
> -
>  enum {
>  	VBUS_OV_IRQ =3D 0,
>  	CHARGE_DONE_IRQ,
> @@ -158,7 +154,7 @@ struct axp288_chrg_info {
>  	/* OTG/Host mode */
>  	struct {
>  		struct work_struct work;
> -		struct extcon_specific_cable_nb cable;
> +		struct extcon_dev *cable;
>  		struct notifier_block id_nb;
>  		bool id_short;
>  	} otg;
> @@ -586,17 +582,15 @@ static void axp288_charger_extcon_evt_worker(struct=
 work_struct *work)
>  	bool old_connected =3D info->cable.connected;
> =20
>  	/* Determine cable/charger type */
> -	if (extcon_get_cable_state(edev, AXP288_EXTCON_SLOW_CHARGER) > 0) {
> +	if (extcon_get_cable_state_(edev, EXTCON_CHG_USB_SDP) > 0) {
>  		dev_dbg(&info->pdev->dev, "USB SDP charger  is connected");
>  		info->cable.connected =3D true;
>  		info->cable.chg_type =3D POWER_SUPPLY_TYPE_USB;
> -	} else if (extcon_get_cable_state(edev,
> -				AXP288_EXTCON_DOWNSTREAM_CHARGER) > 0) {
> +	} else if (extcon_get_cable_state_(edev, EXTCON_CHG_USB_CDP) > 0) {
>  		dev_dbg(&info->pdev->dev, "USB CDP charger is connected");
>  		info->cable.connected =3D true;
>  		info->cable.chg_type =3D POWER_SUPPLY_TYPE_USB_CDP;
> -	} else if (extcon_get_cable_state(edev,
> -					AXP288_EXTCON_FAST_CHARGER) > 0) {
> +	} else if (extcon_get_cable_state_(edev, EXTCON_CHG_USB_DCP) > 0) {
>  		dev_dbg(&info->pdev->dev, "USB DCP charger is connected");
>  		info->cable.connected =3D true;
>  		info->cable.chg_type =3D POWER_SUPPLY_TYPE_USB_DCP;
> @@ -692,8 +686,8 @@ static int axp288_charger_handle_otg_evt(struct notif=
ier_block *nb,
>  {
>  	struct axp288_chrg_info *info =3D
>  	    container_of(nb, struct axp288_chrg_info, otg.id_nb);
> -	struct extcon_dev *edev =3D param;
> -	int usb_host =3D extcon_get_cable_state(edev, "USB-Host");
> +	struct extcon_dev *edev =3D info->otg.cable;
> +	int usb_host =3D extcon_get_cable_state_(edev, EXTCON_USB_HOST);
> =20
>  	dev_dbg(&info->pdev->dev, "external connector USB-Host is %s\n",
>  				usb_host ? "attached" : "detached");
> @@ -848,10 +842,33 @@ static int axp288_charger_probe(struct platform_dev=
ice *pdev)
>  	/* Register for extcon notification */
>  	INIT_WORK(&info->cable.work, axp288_charger_extcon_evt_worker);
>  	info->cable.nb.notifier_call =3D axp288_charger_handle_cable_evt;
> -	ret =3D extcon_register_notifier(info->cable.edev, EXTCON_NONE, &info->=
cable.nb);
> +	ret =3D extcon_register_notifier(info->cable.edev, EXTCON_CHG_USB_SDP,
> +					&info->cable.nb);
> +	if (ret) {
> +		dev_err(&info->pdev->dev,
> +			"failed to register extcon notifier for SDP %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret =3D extcon_register_notifier(info->cable.edev, EXTCON_CHG_USB_CDP,
> +					&info->cable.nb);
> +	if (ret) {
> +		dev_err(&info->pdev->dev,
> +			"failed to register extcon notifier for CDP %d\n", ret);
> +		extcon_unregister_notifier(info->cable.edev,
> +				EXTCON_CHG_USB_SDP, &info->cable.nb);
> +		return ret;
> +	}
> +
> +	ret =3D extcon_register_notifier(info->cable.edev, EXTCON_CHG_USB_DCP,
> +					&info->cable.nb);
>  	if (ret) {
>  		dev_err(&info->pdev->dev,
> -			"failed to register extcon notifier %d\n", ret);
> +			"failed to register extcon notifier for DCP %d\n", ret);
> +		extcon_unregister_notifier(info->cable.edev,
> +				EXTCON_CHG_USB_SDP, &info->cable.nb);
> +		extcon_unregister_notifier(info->cable.edev,
> +				EXTCON_CHG_USB_CDP, &info->cable.nb);
>  		return ret;
>  	}
> =20
> @@ -871,14 +888,14 @@ static int axp288_charger_probe(struct platform_dev=
ice *pdev)
>  	/* Register for OTG notification */
>  	INIT_WORK(&info->otg.work, axp288_charger_otg_evt_worker);
>  	info->otg.id_nb.notifier_call =3D axp288_charger_handle_otg_evt;
> -	ret =3D extcon_register_interest(&info->otg.cable, NULL, "USB-Host",
> +	ret =3D extcon_register_notifier(info->otg.cable, EXTCON_USB_HOST,
>  				       &info->otg.id_nb);
>  	if (ret)
>  		dev_warn(&pdev->dev, "failed to register otg notifier\n");
> =20
> -	if (info->otg.cable.edev)
> -		info->otg.id_short =3D extcon_get_cable_state(
> -					info->otg.cable.edev, "USB-Host");
> +	if (info->otg.cable)
> +		info->otg.id_short =3D extcon_get_cable_state_(
> +					info->otg.cable, EXTCON_USB_HOST);
> =20
>  	/* Register charger interrupts */
>  	for (i =3D 0; i < CHRG_INTR_END; i++) {
> @@ -905,11 +922,17 @@ static int axp288_charger_probe(struct platform_dev=
ice *pdev)
>  	return 0;
> =20
>  intr_reg_failed:
> -	if (info->otg.cable.edev)
> -		extcon_unregister_interest(&info->otg.cable);
> +	if (info->otg.cable)
> +		extcon_unregister_notifier(info->otg.cable, EXTCON_USB_HOST,
> +					&info->otg.id_nb);
>  	power_supply_unregister(info->psy_usb);
>  psy_reg_failed:
> -	extcon_unregister_notifier(info->cable.edev, EXTCON_NONE, &info->cable.=
nb);
> +	extcon_unregister_notifier(info->cable.edev, EXTCON_CHG_USB_SDP,
> +					&info->cable.nb);
> +	extcon_unregister_notifier(info->cable.edev, EXTCON_CHG_USB_SDP,
> +					&info->cable.nb);

EXTCON_CHG_USB_SDP -> EXTCON_CHG_USB_CDP?

> +	extcon_unregister_notifier(info->cable.edev, EXTCON_CHG_USB_DCP,
> +					&info->cable.nb);
>  	return ret;
>  }
> =20
> @@ -917,10 +940,16 @@ static int axp288_charger_remove(struct platform_de=
vice *pdev)
>  {
>  	struct axp288_chrg_info *info =3D  dev_get_drvdata(&pdev->dev);
> =20
> -	if (info->otg.cable.edev)
> -		extcon_unregister_interest(&info->otg.cable);
> +	if (info->otg.cable)
> +		extcon_unregister_notifier(info->otg.cable, EXTCON_USB_HOST,
> +					&info->otg.id_nb);
> =20
> -	extcon_unregister_notifier(info->cable.edev, EXTCON_NONE, &info->cable.=
nb);
> +	extcon_unregister_notifier(info->cable.edev, EXTCON_CHG_USB_SDP,
> +					&info->cable.nb);
> +	extcon_unregister_notifier(info->cable.edev, EXTCON_CHG_USB_SDP,
> +					&info->cable.nb);

EXTCON_CHG_USB_SDP -> EXTCON_CHG_USB_CDP?

> +	extcon_unregister_notifier(info->cable.edev, EXTCON_CHG_USB_DCP,
> +					&info->cable.nb);
>  	power_supply_unregister(info->psy_usb);
> =20
>  	return 0;

Has this dependencies to your tree or are all dependencies already
in torvalds tree?

-- Sebastian

--eAbsdosE1cNLO4uF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJXEPjFAAoJENju1/PIO/qa+3sP/RxuG61UNxxLAKwV6PN6tIjK
g3Tz9Jye8AaUMGuZc7F/a1XH0SSgYMe+1Mk0XmezYQPNL89WFOFtdbUzDmvn4O8Z
28JXQkCzp9hP4HytVbc6TXFoQso5vB8JIL/8BGK7V631VF+x7LmWr0GSuiDKq0yP
ph1wVC3FzPtyl1zfE3NMeCfkDlah4PNArFC5YsI3o3ny2pCcriqwf82zzyOovBUt
WjnuVo9gyBbxYNLIpMRZUlIshznn3zOM3F0FLQyIdtkKqYdAf/KskupOmvv9Owk/
XfOHQw5xVJcVBnVZsPxGjblRbTO424G6QfSf7UdcZDilwXujelO8uHuEvO8MkPqK
gw0kDMf6UQ2/ZSo+ajLempapyyThim3YJyGr4DzPMH1fcHhn+XmGFlK594NjbDjQ
c3zYKJ5ZgbbW3i4qMdsRb17YhtrIo0FTHREM8nhQGmRobGN++S0of68LjTSijsjN
Zw1TnQoWNuC53CvRMmbNPhprMLMXQaIbepCKZTWN/pFM6FtiNoh2VpSEk0uWfq22
hwM7h/CBR3SShT6TBJsE5+hSWPC5kU7mM5cNS6OlO5gSMUMJWUUnNicGdPtjuEvm
MqlKtMm4Dqs26wZNdP+q2cjQBIhh5pHb5haZJgYxDEsx1WT+S8T5Bz1P74d6gV7/
7COWxEFOapLPimIlIuQi
=TZZY
-----END PGP SIGNATURE-----

--eAbsdosE1cNLO4uF--
