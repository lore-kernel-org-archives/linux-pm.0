From: Caesar Wang <caesar.upstream@gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: Add the "init" pinctrl in this
 document
Date: Thu, 22 Oct 2015 09:46:55 +0800
Message-ID: <5628400F.4000901@gmail.com>
References: <1445477130-17065-1-git-send-email-wxt@rock-chips.com>
 <1445477130-17065-2-git-send-email-wxt@rock-chips.com>
 <CAL_JsqJHov0AcwHprU8wtjH4uX5QBYKsCVVsDqhEy9vSMGZPYQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:33578 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754517AbbJVBrK (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 21 Oct 2015 21:47:10 -0400
In-Reply-To: <CAL_JsqJHov0AcwHprU8wtjH4uX5QBYKsCVVsDqhEy9vSMGZPYQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>
Cc: Caesar Wang <wxt@rock-chips.com>, Mark Rutland <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Heiko Stuebner <heiko@sntech.de>, Pawel Moll <pawel.moll@arm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Doug Anderson <dianders@chromium.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>, linux-rockchip@lists.infradead.org, Kumar Gala <galak@codeaurora.org>, Zhang Rui <rui.zhang@intel.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>



=E5=9C=A8 2015=E5=B9=B410=E6=9C=8822=E6=97=A5 09:34, Rob Herring =E5=86=
=99=E9=81=93:
> On Wed, Oct 21, 2015 at 8:25 PM, Caesar Wang <wxt@rock-chips.com> wro=
te:
>> The "init" pinctrl is defined we'll set
>> pinctrl to this state before probe and then "default" after probe.
>>
>> Add the "init" pinctrl as the OTP gpio state, since we need switch
>> the pin to gpio state before the TSADC controller is reset.
>>
>> As I know, the TSADC controller is reset, the tshut polarity will be
>> a *low* signal in a short period of time for some devices.
>>
>> Says:
>> The TSADC get the temperature on rockchip thermal.
>>
>> If T(current temperature) < (setting temperature), the OTP output th=
e
>> *high* signal.
>> If T(current temperature) > (setting temperature), the OTP output th=
e
>> *low* Signal.
>>
>> In some cases, the OTP pin is connected to the PMIC, maybe the
>> PMIC can accept the reset response time to avoid this issue.
>>
>> In other words, the system will be always reboot if we make the
>> OTP pin is connected the others IC to control the power.
>>
>> Signed-off-by: Caesar Wang <wxt@rock-chips.com>
>> Reviewed-by: Douglas Anderson <dianders@chromium.org>
>> ---
>>
>> Changes in v2:
>>    - As the Rob comments, add the 'init' pinctrl more decription in =
document.
> Where?

Okay,  Mr, Rob
That strictly speaking only in commit.:-(


>
>>    - fix the subject to make more obvious in PATCH[1/2]
>> Series-changes: 1
>>    - As the Doug comments, add the 'init' property to sync document.
>>
>> Changes in v1: None
>>
>>   Documentation/devicetree/bindings/thermal/rockchip-thermal.txt | 5=
 +++--
>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/thermal/rockchip-ther=
mal.txt b/Documentation/devicetree/bindings/thermal/rockchip-thermal.tx=
t
>> index ef802de..28e84f7 100644
>> --- a/Documentation/devicetree/bindings/thermal/rockchip-thermal.txt
>> +++ b/Documentation/devicetree/bindings/thermal/rockchip-thermal.txt
>> @@ -27,8 +27,9 @@ tsadc: tsadc@ff280000 {
>>          clock-names =3D "tsadc", "apb_pclk";
>>          resets =3D <&cru SRST_TSADC>;
>>          reset-names =3D "tsadc-apb";
>> -       pinctrl-names =3D "default";
>> -       pinctrl-0 =3D <&otp_out>;
>> +       pinctrl-names =3D "init", "default";
>> +       pinctrl-0 =3D <&otp_gpio>;
>> +       pinctrl-1 =3D <&otp_out>;
>>          #thermal-sensor-cells =3D <1>;
>>          rockchip,hw-tshut-temp =3D <95000>;
>>          rockchip,hw-tshut-mode =3D <0>;
>> --
>> 1.9.1
>>
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip


--=20
Thanks,
Caesar

