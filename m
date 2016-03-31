From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH 1/3] power: charger-manager: Replace deprecatd API of extcon
Date: Thu, 31 Mar 2016 17:35:16 +0900
Message-ID: <56FCE144.1070800@samsung.com>
References: <1459121142-3768-1-git-send-email-cw00.choi@samsung.com>
 <1459121142-3768-2-git-send-email-cw00.choi@samsung.com>
 <20160328210737.GA21044@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <20160328210737.GA21044@rob-hp-laptop>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, myungjoo.ham@samsung.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Rob,

On 2016=EB=85=84 03=EC=9B=94 29=EC=9D=BC 06:07, Rob Herring wrote:
> On Mon, Mar 28, 2016 at 08:25:40AM +0900, Chanwoo Choi wrote:
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
>=20
> Sorry, but delete the charger-manager binding and start over. It look=
s=20
> designed around the needs of Linux, not what the h/w looks like. You'=
re=20

I agree. The charger-manager didn't express the h/w. IMHO, charging
framework may be included in the power_supply core such as fuel-gauge d=
evice.
Just it is my opinion.

=46or example, fuel-gauge device may include the connected device such =
as
charger device (battery charging), extcon device(detect the type of cha=
rger cable)
and rtc device (check the battery state periodically with sample rate) =
for battery charging.

I agree that we should handle the charger-manager binding.

But now,
this patch just removes the dependency of deprecated API of extcon.
So, I think that the issue of charger-manager binding should be handled
in other patches.

> changing the driver and having to change the DT in a non-compatible w=
ay=20
> is the first clue.
>=20
>>  				cm-cable-extcon =3D "extcon-dev.0";
>=20
> What is this!? The linux device name?

Just the name of extcon device to detect the type of charger cable.
But, extcon framekwork has the extcon_get_edev_by_phandle() to get the
instance by using the phandle in Device Tree.

>=20
>>  				cm-cable-min =3D <475000>;
>>  				cm-cable-max =3D <500000>;
>=20
> This is set by the USB spec...

I agree. we need to modify it.

>=20
>>  			};
>>  			cable@1 {
>> -				cm-cable-name =3D "TA";
>> +				cm-cable-id =3D 6; /* EXTCON_CHG_USB_DCP */
>>  				cm-cable-extcon =3D "extcon-dev.0";
>>  				cm-cable-min =3D <650000>;
>>  				cm-cable-max =3D <675000>;
>=20
>=20
>=20


Best Regards,
Chanwoo Choi
