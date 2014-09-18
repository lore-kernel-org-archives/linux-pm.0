From: Caesar Wang <caesar.wang@rock-chips.com>
Subject: Re: [PATCH v5 2/4] dt-bindings: document Rockchip thermal
Date: Thu, 18 Sep 2014 10:33:05 +0800
Message-ID: <541A4461.4080101@rock-chips.com>
References: <1410926353-15674-1-git-send-email-caesar.wang@rock-chips.com> <1410926353-15674-3-git-send-email-caesar.wang@rock-chips.com> <CAD=FV=Vq4zSBv-=OxHD4sGbAgLh_ebe29PR6RU_sQe4XspsPsw@mail.gmail.com> <20140917201347.GD25297@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from regular1.263xmail.com ([211.150.99.131]:50465 "EHLO
	regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757377AbaIRCdO (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 17 Sep 2014 22:33:14 -0400
In-Reply-To: <20140917201347.GD25297@core.coreip.homeip.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Doug Anderson <dianders@chromium.org>
Cc: =?UTF-8?B?SGVpa28gU3TDvGJuZXI=?= <heiko@sntech.de>, Zhang Rui <rui.zhang@intel.com>, edubezval@gmail.com, Arnd Bergmann <arnd@arndb.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Tao Huang <huangtao@rock-chips.com>, Eddie Cai <cf@rock-chips.com>, Dmitry Torokhov <dtor@chromium.org>, Addy Ke <addy.ke@rock-chips.com>, zyf <zyf@rock-chips.com>, =?UTF-8?B?6ZmI5riQ6aOe?= <cjf@rock-chips.com>


=E5=9C=A8 2014=E5=B9=B409=E6=9C=8818=E6=97=A5 04:13, Dmitry Torokhov =E5=
=86=99=E9=81=93:
> On Wed, Sep 17, 2014 at 12:48:16PM -0700, Doug Anderson wrote:
>> Caesar,
>>
>> On Tue, Sep 16, 2014 at 8:59 PM, Caesar Wang <caesar.wang@rock-chips=
=2Ecom> wrote:
>>> This add the necessary binding documentation for the thermal
>>> found on Rockchip SoCs
>>>
>>> Signed-off-by: zhaoyifeng <zyf@rock-chips.com>
>>> Signed-off-by: Caesar Wang <caesar.wang@rock-chips.com>
>>> ---
>>>   .../bindings/thermal/rockchip-thermal.txt          | 41 +++++++++=
+++++++++++++
>>>   1 file changed, 41 insertions(+)
>>>   create mode 100644 Documentation/devicetree/bindings/thermal/rock=
chip-thermal.txt
>>>
>>> diff --git a/Documentation/devicetree/bindings/thermal/rockchip-the=
rmal.txt b/Documentation/devicetree/bindings/thermal/rockchip-thermal.t=
xt
>>> new file mode 100644
>>> index 0000000..6fc8bc3
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/thermal/rockchip-thermal.tx=
t
>>> @@ -0,0 +1,41 @@
>>> +* Temperature Sensor ADC (TSADC) on rockchip SoCs
>>> +
>>> +Required properties:
>>> +- compatible: "rockchip,rk3288-tsadc"
>>> +- reg: physical base address of the controller and length of memor=
y mapped
>>> +       region.
>>> +- interrupts: The interrupt number to the cpu. The interrupt speci=
fier format
>>> +             depends on the interrupt controller.
>>> +- clocks: Must contain an entry for each entry in clock-names.
>>> +- clock-names: Shall be "tsadc" for the converter-clock, and "apb_=
pclk" for
>>> +              the peripheral clock.
>>> +- num-trips:  number of total trip points, this is required, set i=
t 0 if none,
>>> +             if greater than 0, the following properties must be d=
efined;
>> nit: there is whitespace damage (space before tab) on the line befor=
e
>> this one.  It's more obvious in the patch you uploaded to gerrit whi=
ch
>> highlights this in red:
>>
>> https://chromium-review.googlesource.com/#/c/213967/5/Documentation/=
devicetree/bindings/thermal/rockchip-thermal.txt
>>
>> Did you run your patches through checkpatch before submitting?
> FWIW vim users like me can put the following in their .vimrc file to
> have whitespace damage visible right away:
>
> :highlight RedundantSpaces ctermbg=3Dred guibg=3Dred
> :match RedundantSpaces /\s\+$\| \+\ze\t/
>
> Thanks.

It's a very useful, Thank you  for sharing.


--=20
Best regards,
Caesar


