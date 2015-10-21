From: Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v1 1/2] dt-bindings: Sync the dts to this document
Date: Wed, 21 Oct 2015 11:48:00 -0500
Message-ID: <CAL_JsqJcwWkMXQzo6PbO2kfv3h7hkqtq6CJW0+W4Wc3eh6RTuQ@mail.gmail.com>
References: <1445395380-5365-1-git-send-email-wxt@rock-chips.com>
 <1445395380-5365-2-git-send-email-wxt@rock-chips.com> <CAL_JsqJ6ZRjZbtc7dqo-g=CzO+H_FWcRqs2gBGH2HMBBM1xU3g@mail.gmail.com>
 <5627B309.9080309@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:41433 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752016AbbJUQsW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 21 Oct 2015 12:48:22 -0400
In-Reply-To: <5627B309.9080309@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Caesar Wang <caesar.upstream@gmail.com>
Cc: Caesar Wang <wxt@rock-chips.com>, Mark Rutland <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Heiko Stuebner <heiko@sntech.de>, Pawel Moll <pawel.moll@arm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Doug Anderson <dianders@chromium.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>, linux-rockchip@lists.infradead.org, Kumar Gala <galak@codeaurora.org>, Zhang Rui <rui.zhang@intel.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Wed, Oct 21, 2015 at 10:45 AM, Caesar Wang <caesar.upstream@gmail.co=
m> wrote:
> Hi Rob,
>
> =E5=9C=A8 2015=E5=B9=B410=E6=9C=8821=E6=97=A5 23:18, Rob Herring =E5=86=
=99=E9=81=93:
>>
>> On Tue, Oct 20, 2015 at 9:42 PM, Caesar Wang <wxt@rock-chips.com> wr=
ote:
>>>
>>> Add the OTP gpio state, we need switch the pin to gpio state
>>> before the TSADC controller is reset.
>>>
>>> Signed-off-by: Caesar Wang <wxt@rock-chips.com>
>>> ---
>>>
>>> Changes in v1:
>>>    - As the Doug comments, add the 'init' property to sync document=
=2E
>>>
>>>   Documentation/devicetree/bindings/thermal/rockchip-thermal.txt | =
5
>>> +++--
>>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>>
>>> diff --git
>>> a/Documentation/devicetree/bindings/thermal/rockchip-thermal.txt
>>> b/Documentation/devicetree/bindings/thermal/rockchip-thermal.txt
>>> index ef802de..28e84f7 100644
>>> --- a/Documentation/devicetree/bindings/thermal/rockchip-thermal.tx=
t
>>> +++ b/Documentation/devicetree/bindings/thermal/rockchip-thermal.tx=
t
>>> @@ -27,8 +27,9 @@ tsadc: tsadc@ff280000 {
>>>          clock-names =3D "tsadc", "apb_pclk";
>>>          resets =3D <&cru SRST_TSADC>;
>>>          reset-names =3D "tsadc-apb";
>>> -       pinctrl-names =3D "default";
>>> -       pinctrl-0 =3D <&otp_out>;
>>> +       pinctrl-names =3D "init", "default";
>>> +       pinctrl-0 =3D <&otp_gpio>;
>>> +       pinctrl-1 =3D <&otp_out>;
>>
>> Are these optional or required? They only appear in the example.
>
>
> Yep,
> These are required for TSADC.

Then list them that way.

>
> I=E2=80=98m assumed that's right,
> I think we don't need to introduce the pinctrl in this document.

You need to state that you use them and what valid names are. That is
a contract with the driver.

The example is extra information and should not be required to write a
dts entry.

Rob
