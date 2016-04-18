From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [RESEND PATCH 2/3] power: axp288_charger: Replace deprecatd API of
 extcon
Date: Mon, 18 Apr 2016 14:31:41 +0900
Message-ID: <5714713D.7000903@samsung.com>
References: <1460681016-2770-1-git-send-email-cw00.choi@samsung.com>
 <1460681016-2770-3-git-send-email-cw00.choi@samsung.com>
 <20160415142053.GB24087@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:37844 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751413AbcDRFbu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 18 Apr 2016 01:31:50 -0400
In-reply-to: <20160415142053.GB24087@earth>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: dbaryshkov@gmail.com, dwmw2@infradead.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org

Hi Sebastian,

On 2016=EB=85=84 04=EC=9B=94 15=EC=9D=BC 23:20, Sebastian Reichel wrote=
:
> Hi,
>=20
> On Fri, Apr 15, 2016 at 09:43:35AM +0900, Chanwoo Choi wrote:
>> This patch removes the deprecated notifier API of extcon framework a=
nd then use
>> the new extcon API[2] with the unique id[1] to indicate the each ext=
ernal
>> connector. Alter deprecated API as following:
>> - extcon_register_interest() -> extcon_register_notifier()
>> - extcon_unregister_interest() -> extcon_unregister_notifier()
>> - extcon_get_cable_state() -> extcon_get_cable_state_()
>>
>> And, extcon alters the name of USB charger connector in patch[3] as =
following:
>> - EXTCON_CHG_USB_SDP /* Standard Downstream Port */
>> - EXTCON_CHG_USB_DCP /* Dedicated Charging Port */
>> - EXTCON_CHG_USB_CDP /* Charging Downstream Port */
>> - EXTCON_CHG_USB_ACA /* Accessory Charger Adapter */
>>
>> [1] Commit 2a9de9c0f08d61
>> - ("extcon: Use the unique id for external connector instead of stri=
ng)
>> [2] Commit 046050f6e623e4
>> - ("extcon: Update the prototype of extcon_register_notifier() with =
enum extcon
>> [3] Commit 11eecf910bd81d
>> - ("extcon: Modify the id and name of external connector")
>>
>> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
>> ---
>>  drivers/power/axp288_charger.c | 77 +++++++++++++++++++++++++++++--=
-----------
>>  1 file changed, 53 insertions(+), 24 deletions(-)
>>
>> diff --git a/drivers/power/axp288_charger.c b/drivers/power/axp288_c=
harger.c
>> index e4d569f57acc..e5c2569befa6 100644
>> --- a/drivers/power/axp288_charger.c
>> +++ b/drivers/power/axp288_charger.c
>> @@ -129,10 +129,6 @@
>> =20

[snip]

>>  	/* Register charger interrupts */
>>  	for (i =3D 0; i < CHRG_INTR_END; i++) {
>> @@ -905,11 +922,17 @@ static int axp288_charger_probe(struct platfor=
m_device *pdev)
>>  	return 0;
>> =20
>>  intr_reg_failed:
>> -	if (info->otg.cable.edev)
>> -		extcon_unregister_interest(&info->otg.cable);
>> +	if (info->otg.cable)
>> +		extcon_unregister_notifier(info->otg.cable, EXTCON_USB_HOST,
>> +					&info->otg.id_nb);
>>  	power_supply_unregister(info->psy_usb);
>>  psy_reg_failed:
>> -	extcon_unregister_notifier(info->cable.edev, EXTCON_NONE, &info->c=
able.nb);
>> +	extcon_unregister_notifier(info->cable.edev, EXTCON_CHG_USB_SDP,
>> +					&info->cable.nb);
>> +	extcon_unregister_notifier(info->cable.edev, EXTCON_CHG_USB_SDP,
>> +					&info->cable.nb);
>=20
> EXTCON_CHG_USB_SDP -> EXTCON_CHG_USB_CDP?

I was mistaken. I'll fix it.

>=20
>> +	extcon_unregister_notifier(info->cable.edev, EXTCON_CHG_USB_DCP,
>> +					&info->cable.nb);
>>  	return ret;
>>  }
>> =20
>> @@ -917,10 +940,16 @@ static int axp288_charger_remove(struct platfo=
rm_device *pdev)
>>  {
>>  	struct axp288_chrg_info *info =3D  dev_get_drvdata(&pdev->dev);
>> =20
>> -	if (info->otg.cable.edev)
>> -		extcon_unregister_interest(&info->otg.cable);
>> +	if (info->otg.cable)
>> +		extcon_unregister_notifier(info->otg.cable, EXTCON_USB_HOST,
>> +					&info->otg.id_nb);
>> =20
>> -	extcon_unregister_notifier(info->cable.edev, EXTCON_NONE, &info->c=
able.nb);
>> +	extcon_unregister_notifier(info->cable.edev, EXTCON_CHG_USB_SDP,
>> +					&info->cable.nb);
>> +	extcon_unregister_notifier(info->cable.edev, EXTCON_CHG_USB_SDP,
>> +					&info->cable.nb);
>=20
> EXTCON_CHG_USB_SDP -> EXTCON_CHG_USB_CDP?

ditto.

>=20
>> +	extcon_unregister_notifier(info->cable.edev, EXTCON_CHG_USB_DCP,
>> +					&info->cable.nb);
>>  	power_supply_unregister(info->psy_usb);
>> =20
>>  	return 0;
>=20
> Has this dependencies to your tree or are all dependencies already
> in torvalds tree?

This patch-set have the dependency on Linus torvalds tree[1].
[1] https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/

So, when picking this patch-set, someone make the immutable branch for =
this patchset
to prevent the merge conflict between power_supply and extcon tree.

Thanks,
Chanwoo Choi

