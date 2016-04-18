From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [RESEND PATCH 1/3] power: charger-manager: Replace deprecatd API
 of extcon
Date: Mon, 18 Apr 2016 14:42:12 +0900
Message-ID: <571473B4.6010406@samsung.com>
References: <1460681016-2770-1-git-send-email-cw00.choi@samsung.com>
 <1460681016-2770-2-git-send-email-cw00.choi@samsung.com>
 <20160415141318.GA24087@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:58125 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751418AbcDRFmQ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 18 Apr 2016 01:42:16 -0400
In-reply-to: <20160415141318.GA24087@earth>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: dbaryshkov@gmail.com, dwmw2@infradead.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org

Hi Sebastian,

On 2016=EB=85=84 04=EC=9B=94 15=EC=9D=BC 23:13, Sebastian Reichel wrote=
:
> Hi,
>=20
> On Fri, Apr 15, 2016 at 09:43:34AM +0900, Chanwoo Choi wrote:
>> This patch removes the deprecated notifier API of extcon framework a=
nd then use
>> the new extcon API[2] with the unique id[1] to indicate the each ext=
ernal
>> connector. Alter deprecated API as following:
>> - extcon_register_interest() -> extcon_register_notifier()
>> - extcon_unregister_interest() -> extcon_unregister_notifier()
>>
>> And, extcon alters the name of USB charger connector in patch[3] as =
following:
>> - EXTCON_CHG_USB_SDP /* Standard Downstream Port */
>> - EXTCON_CHG_USB_DCP /* Dedicated Charging Port */
>> - EXTCON_CHG_USB_CDP /* Charging Downstream Port */
>> - EXTCON_CHG_USB_ACA /* Accessory Charger Adapter */
>>
>> So, the name of external charger connector are changed as following:
>> - "USB" -> "SDP"
>> - "TA" -> "DCP"
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
>>  .../bindings/power_supply/charger-manager.txt      |  4 +--
>>  drivers/power/charger-manager.c                    | 31 +++++++++++=
+++--------
>>  include/linux/power/charger-manager.h              |  4 +--
>>  3 files changed, 24 insertions(+), 15 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/power_supply/charger-=
manager.txt b/Documentation/devicetree/bindings/power_supply/charger-ma=
nager.txt
>> index ec4fe9de3137..73193e380dc2 100644
>> --- a/Documentation/devicetree/bindings/power_supply/charger-manager=
=2Etxt
>> +++ b/Documentation/devicetree/bindings/power_supply/charger-manager=
=2Etxt
>> @@ -65,13 +65,13 @@ Example :
>>  		regulator@0 {
>>  			cm-regulator-name =3D "chg-reg";
>>  			cable@0 {
>> -				cm-cable-name =3D "USB";
>> +				cm-cable-id =3D 5; /* EXTCON_CHG_USB_SDP */
>>  				cm-cable-extcon =3D "extcon-dev.0";
>>  				cm-cable-min =3D <475000>;
>>  				cm-cable-max =3D <500000>;
>>  			};
>>  			cable@1 {
>> -				cm-cable-name =3D "TA";
>> +				cm-cable-id =3D 6; /* EXTCON_CHG_USB_DCP */
>>  				cm-cable-extcon =3D "extcon-dev.0";
>>  				cm-cable-min =3D <650000>;
>>  				cm-cable-max =3D <675000>;
>=20
> This breaks DT ABI. Looks like charger-manager is not used in
> mainline,but I guess ther should be an explicit Acked-By from
> a DT binding maintainer.

As I mentioned on other mail to Rob, the purpose of this patch
removes the deprecated the EXTCON APIs. So, I touched the DT binding.

About DT ABI about charger-manager, we should handle it on separate pat=
ches.

Also I think the defines should be in
> some header includable from DTS, so that something like this
> can be done:
>=20
> cm-cable-id =3D <CHARGER_USB_DCP>;


I agree to use some definition for the kind of charger cable.
But, Not yet. I'm preparing the EXTCON update to use the definitions
on Device Tree file. I'll send some separate patches in the near future=
=2E
>=20
> Apart from that:
>=20
> Acked-By: Sebastian Reichel <sre@kernel.org>

Thanks for review.

Best Regards,
Chanwoo Choi

