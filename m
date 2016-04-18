From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [RESEND PATCH 1/3] power: charger-manager: Replace deprecatd API
 of extcon
Date: Tue, 19 Apr 2016 08:31:02 +0900
Message-ID: <57156E36.5090800@samsung.com>
References: <1460681016-2770-1-git-send-email-cw00.choi@samsung.com>
 <1460681016-2770-2-git-send-email-cw00.choi@samsung.com>
 <20160415141318.GA24087@earth> <20160418172406.GA27979@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <20160418172406.GA27979@rob-hp-laptop>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>, Sebastian Reichel <sre@kernel.org>
Cc: dbaryshkov@gmail.com, dwmw2@infradead.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Rob,

On 2016=EB=85=84 04=EC=9B=94 19=EC=9D=BC 02:24, Rob Herring wrote:
> On Fri, Apr 15, 2016 at 04:13:18PM +0200, Sebastian Reichel wrote:
>> Hi,
>>
>> On Fri, Apr 15, 2016 at 09:43:34AM +0900, Chanwoo Choi wrote:
>>> This patch removes the deprecated notifier API of extcon framework =
and then use
>>> the new extcon API[2] with the unique id[1] to indicate the each ex=
ternal
>>> connector. Alter deprecated API as following:
>>> - extcon_register_interest() -> extcon_register_notifier()
>>> - extcon_unregister_interest() -> extcon_unregister_notifier()
>>>
>>> And, extcon alters the name of USB charger connector in patch[3] as=
 following:
>>> - EXTCON_CHG_USB_SDP /* Standard Downstream Port */
>>> - EXTCON_CHG_USB_DCP /* Dedicated Charging Port */
>>> - EXTCON_CHG_USB_CDP /* Charging Downstream Port */
>>> - EXTCON_CHG_USB_ACA /* Accessory Charger Adapter */
>>>
>>> So, the name of external charger connector are changed as following=
:
>>> - "USB" -> "SDP"
>>> - "TA" -> "DCP"
>>>
>>> [1] Commit 2a9de9c0f08d61
>>> - ("extcon: Use the unique id for external connector instead of str=
ing)
>>> [2] Commit 046050f6e623e4
>>> - ("extcon: Update the prototype of extcon_register_notifier() with=
 enum extcon
>>> [3] Commit 11eecf910bd81d
>>> - ("extcon: Modify the id and name of external connector")
>>>
>>> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
>>> ---
>>>  .../bindings/power_supply/charger-manager.txt      |  4 +--
>>>  drivers/power/charger-manager.c                    | 31 ++++++++++=
++++--------
>>>  include/linux/power/charger-manager.h              |  4 +--
>>>  3 files changed, 24 insertions(+), 15 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/power_supply/charger=
-manager.txt b/Documentation/devicetree/bindings/power_supply/charger-m=
anager.txt
>>> index ec4fe9de3137..73193e380dc2 100644
>>> --- a/Documentation/devicetree/bindings/power_supply/charger-manage=
r.txt
>>> +++ b/Documentation/devicetree/bindings/power_supply/charger-manage=
r.txt
>>> @@ -65,13 +65,13 @@ Example :
>>>  		regulator@0 {
>>>  			cm-regulator-name =3D "chg-reg";
>>>  			cable@0 {
>>> -				cm-cable-name =3D "USB";
>>> +				cm-cable-id =3D 5; /* EXTCON_CHG_USB_SDP */
>>>  				cm-cable-extcon =3D "extcon-dev.0";
>>>  				cm-cable-min =3D <475000>;
>>>  				cm-cable-max =3D <500000>;
>>>  			};
>>>  			cable@1 {
>>> -				cm-cable-name =3D "TA";
>>> +				cm-cable-id =3D 6; /* EXTCON_CHG_USB_DCP */
>>>  				cm-cable-extcon =3D "extcon-dev.0";
>>>  				cm-cable-min =3D <650000>;
>>>  				cm-cable-max =3D <675000>;
>>
>> This breaks DT ABI. Looks like charger-manager is not used in
>> mainline, but I guess ther should be an explicit Acked-By from
>> a DT binding maintainer. Also I think the defines should be in
>> some header includable from DTS, so that something like this
>> can be done:
>=20
> I already commented that the binding to start with looks like crap=20
> (For starters, "extcon-dev.0" is a Linux device name?) and this does =
not=20
> appear to be an improvement.

I already replied for your comment on other mail[1].
[1] https://lkml.org/lkml/2016/3/31/199

This patch never update the charger-manager.
Just remove the deprecated EXTCON API to prevent build error.

Thanks,
Chanwoo Choi
