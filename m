From: Caesar Wang <caesar.upstream@gmail.com>
Subject: Re: [RESEND PATCH v2 1/2] dt-bindings: rockchip-thermal: Add the
 "init" pinctrl in this document
Date: Thu, 22 Oct 2015 11:55:25 +0800
Message-ID: <56285E2D.2040707@gmail.com>
References: <1445481048-20789-1-git-send-email-wxt@rock-chips.com>
 <1445481048-20789-2-git-send-email-wxt@rock-chips.com>
 <CAD=FV=XdN_Lie9bjbr0M4-=neVGrLiahAAxyUEuE0kO2ZsusfQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:34116 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752952AbbJVDzg (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 21 Oct 2015 23:55:36 -0400
In-Reply-To: <CAD=FV=XdN_Lie9bjbr0M4-=neVGrLiahAAxyUEuE0kO2ZsusfQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Doug Anderson <dianders@chromium.org>
Cc: Caesar Wang <wxt@rock-chips.com>, Mark Rutland <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Heiko Stuebner <heiko@sntech.de>, Pawel Moll <pawel.moll@arm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, Rob Herring <robh+dt@kernel.org>, Kumar Gala <galak@codeaurora.org>, Zhang Rui <rui.zhang@intel.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>



=E5=9C=A8 2015=E5=B9=B410=E6=9C=8822=E6=97=A5 11:45, Doug Anderson =E5=86=
=99=E9=81=93:
> Caesar,
>
> On Wed, Oct 21, 2015 at 7:30 PM, Caesar Wang <wxt@rock-chips.com> wro=
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
>>    - Add the 'init' pinctrl more decription in commit.
>>    - Fix the subject to make more obvious in PATCH[1/2]
>>    - Resend this patch v2 since fix the subject to be specific.
>>
>> Changes in v1:
>>    - As the Doug comments, add the 'init' property to sync document.
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
> I think Rob wanted something more in the "rockchip-thermal.txt"
> document itself.  Like:
>
> Pinctrl states:
> - During device probe a driver may glitch the output line.  If this i=
s
> not acceptable for your board, you can use the standard "init" and
> "default" pinctrl states.  The "init" state will be set before device
> probe and "default" after.

Sound resonable.
Thanks Doug to explain!

>
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip


--=20
Thanks,
Caesar

