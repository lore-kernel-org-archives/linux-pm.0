From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH v3 1/2] power: axp288_charger: Replace deprecatd API of
 extcon
Date: Thu, 09 Jun 2016 10:18:01 +0900
Message-ID: <5758C3C9.4030006@samsung.com>
References: <1464687280-8155-1-git-send-email-cw00.choi@samsung.com>
 <CGME20160531093442epcas1p340a2a3136db757b2bdf7eab2b23603a8@epcas1p3.samsung.com>
 <1464687280-8155-2-git-send-email-cw00.choi@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:44105 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423920AbcFIBSM (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 8 Jun 2016 21:18:12 -0400
In-reply-to: <1464687280-8155-2-git-send-email-cw00.choi@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, wens@csie.org
Cc: myungjoo.ham@samsung.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

Ping.

Hi Sebastian,

This patch just remove the deprecated extcon API without any improvemen=
t.
Could you just review this patch?

Thanks,
Chanwoo Choi

On 2016=EB=85=84 05=EC=9B=94 31=EC=9D=BC 18:34, Chanwoo Choi wrote:
> This patch removes the deprecated notifier API of extcon framework an=
d then use
> the new extcon API[2] with the unique id[1] to indicate the each exte=
rnal
> connector. Alter deprecated API as following:
> - extcon_register_interest() -> extcon_register_notifier()
> - extcon_unregister_interest() -> extcon_unregister_notifier()
> - extcon_get_cable_state() -> extcon_get_cable_state_()
>=20
> And, extcon alters the name of USB charger connector in patch[3] as f=
ollowing:
> - EXTCON_CHG_USB_SDP /* Standard Downstream Port */
> - EXTCON_CHG_USB_DCP /* Dedicated Charging Port */
> - EXTCON_CHG_USB_CDP /* Charging Downstream Port */
> - EXTCON_CHG_USB_ACA /* Accessory Charger Adapter */
>=20
> [1] Commit 2a9de9c0f08d61
> - ("extcon: Use the unique id for external connector instead of strin=
g)
> [2] Commit 046050f6e623e4
> - ("extcon: Update the prototype of extcon_register_notifier() with e=
num extcon
> [3] Commit 11eecf910bd81d
> - ("extcon: Modify the id and name of external connector")
>=20
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> ---
>  drivers/power/axp288_charger.c | 77 +++++++++++++++++++++++++++++---=
----------
>  1 file changed, 53 insertions(+), 24 deletions(-)
>=20
> diff --git a/drivers/power/axp288_charger.c b/drivers/power/axp288_ch=
arger.c
> index e4d569f57acc..4030eeb7cf65 100644
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
> @@ -586,17 +582,15 @@ static void axp288_charger_extcon_evt_worker(st=
ruct work_struct *work)
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
> @@ -692,8 +686,8 @@ static int axp288_charger_handle_otg_evt(struct n=
otifier_block *nb,
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
> @@ -848,10 +842,33 @@ static int axp288_charger_probe(struct platform=
_device *pdev)
>  	/* Register for extcon notification */
>  	INIT_WORK(&info->cable.work, axp288_charger_extcon_evt_worker);
>  	info->cable.nb.notifier_call =3D axp288_charger_handle_cable_evt;
> -	ret =3D extcon_register_notifier(info->cable.edev, EXTCON_NONE, &in=
fo->cable.nb);
> +	ret =3D extcon_register_notifier(info->cable.edev, EXTCON_CHG_USB_S=
DP,
> +					&info->cable.nb);
> +	if (ret) {
> +		dev_err(&info->pdev->dev,
> +			"failed to register extcon notifier for SDP %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret =3D extcon_register_notifier(info->cable.edev, EXTCON_CHG_USB_C=
DP,
> +					&info->cable.nb);
> +	if (ret) {
> +		dev_err(&info->pdev->dev,
> +			"failed to register extcon notifier for CDP %d\n", ret);
> +		extcon_unregister_notifier(info->cable.edev,
> +				EXTCON_CHG_USB_SDP, &info->cable.nb);
> +		return ret;
> +	}
> +
> +	ret =3D extcon_register_notifier(info->cable.edev, EXTCON_CHG_USB_D=
CP,
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
> @@ -871,14 +888,14 @@ static int axp288_charger_probe(struct platform=
_device *pdev)
>  	/* Register for OTG notification */
>  	INIT_WORK(&info->otg.work, axp288_charger_otg_evt_worker);
>  	info->otg.id_nb.notifier_call =3D axp288_charger_handle_otg_evt;
> -	ret =3D extcon_register_interest(&info->otg.cable, NULL, "USB-Host"=
,
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
> @@ -905,11 +922,17 @@ static int axp288_charger_probe(struct platform=
_device *pdev)
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
> -	extcon_unregister_notifier(info->cable.edev, EXTCON_NONE, &info->ca=
ble.nb);
> +	extcon_unregister_notifier(info->cable.edev, EXTCON_CHG_USB_SDP,
> +					&info->cable.nb);
> +	extcon_unregister_notifier(info->cable.edev, EXTCON_CHG_USB_CDP,
> +					&info->cable.nb);
> +	extcon_unregister_notifier(info->cable.edev, EXTCON_CHG_USB_DCP,
> +					&info->cable.nb);
>  	return ret;
>  }
> =20
> @@ -917,10 +940,16 @@ static int axp288_charger_remove(struct platfor=
m_device *pdev)
>  {
>  	struct axp288_chrg_info *info =3D  dev_get_drvdata(&pdev->dev);
> =20
> -	if (info->otg.cable.edev)
> -		extcon_unregister_interest(&info->otg.cable);
> +	if (info->otg.cable)
> +		extcon_unregister_notifier(info->otg.cable, EXTCON_USB_HOST,
> +					&info->otg.id_nb);
> =20
> -	extcon_unregister_notifier(info->cable.edev, EXTCON_NONE, &info->ca=
ble.nb);
> +	extcon_unregister_notifier(info->cable.edev, EXTCON_CHG_USB_SDP,
> +					&info->cable.nb);
> +	extcon_unregister_notifier(info->cable.edev, EXTCON_CHG_USB_CDP,
> +					&info->cable.nb);
> +	extcon_unregister_notifier(info->cable.edev, EXTCON_CHG_USB_DCP,
> +					&info->cable.nb);
>  	power_supply_unregister(info->psy_usb);
> =20
>  	return 0;
>=20

