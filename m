From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC PATCH v2 1/4] dt-bindings: update the
 Allwinner GPADC device tree binding for H3
Date: Wed, 5 Apr 2017 14:04:02 -0500
Message-ID: <CAL_Jsq+iE97RbtY6PZ9nNDhdekK=P1wozC=vHkx3wj9-RQumsA@mail.gmail.com>
References: <20170402133304.56824-1-icenowy@aosc.io> <20170402133304.56824-2-icenowy@aosc.io>
 <20170404144715.fa5sy427u2cz4e6z@rob-hp-laptop> <bdc43a73-a2d6-01ae-8113-277f7174697c@aosc.io>
Reply-To: robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sunxi+bncBDJIP47K7MERBPP7STDQKGQEFKFOA3A-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <bdc43a73-a2d6-01ae-8113-277f7174697c-h8G6r0blFSE@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Icenowy Zheng <icenowy-h8G6r0blFSE@public.gmane.org>
Cc: "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Quentin Schulz <quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Apr 4, 2017 at 10:02 AM, Icenowy Zheng <icenowy-h8G6r0blFSE@public.gmane.org> wrote:
>
>
> =E5=9C=A8 2017=E5=B9=B404=E6=9C=8804=E6=97=A5 22:47, Rob Herring =E5=86=
=99=E9=81=93:
>>
>> On Sun, Apr 02, 2017 at 09:33:01PM +0800, Icenowy Zheng wrote:
>>>
>>> Allwinner H3 features a thermal sensor like the one in A33, but has its
>>> register re-arranged, the clock divider moved to CCU (originally the
>>> clock divider is in ADC) and added a pair of bus clock and reset.
>>>
>>> Update the binding document to cover H3.
>>>
>>> Signed-off-by: Icenowy Zheng <icenowy-h8G6r0blFSE@public.gmane.org>
>>> ---
>>>  .../devicetree/bindings/mfd/sun4i-gpadc.txt        | 23
>>> ++++++++++++++++++++--
>>>  1 file changed, 21 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/mfd/sun4i-gpadc.txt
>>> b/Documentation/devicetree/bindings/mfd/sun4i-gpadc.txt
>>> index badff3611a98..7753133ca0ff 100644
>>> --- a/Documentation/devicetree/bindings/mfd/sun4i-gpadc.txt
>>> +++ b/Documentation/devicetree/bindings/mfd/sun4i-gpadc.txt
>>> @@ -4,12 +4,20 @@ The Allwinner SoCs all have an ADC that can also act =
as
>>> a thermal sensor
>>>  and sometimes as a touchscreen controller.
>>>
>>>  Required properties:
>>> -  - compatible: "allwinner,sun8i-a33-ths",
>>> +  - compatible: must contain one of the following compatibles:
>>> +               - "allwinner,sun8i-a33-ths"
>>> +               - "allwinner,sun8i-h3-ths"
>>>    - reg: mmio address range of the chip,
>>>    - #thermal-sensor-cells: shall be 0,
>>>    - #io-channel-cells: shall be 0,
>>>
>>> -Example:
>>> +Required properties for the following compatibles:
>>> +               - "allwinner,sun8i-h3-ths"
>>> +  - clocks: the bus clock and the input clock of the ADC,
>>> +  - clock-names: should be "bus" and "ths",
>>> +  - resets: the bus reset of the ADC,
>>> +
>>> +Example for A33:
>>>         ths: ths@01c25000 {
>>>                 compatible =3D "allwinner,sun8i-a33-ths";
>>>                 reg =3D <0x01c25000 0x100>;
>>> @@ -17,6 +25,17 @@ Example:
>>>                 #io-channel-cells =3D <0>;
>>>         };
>>>
>>> +Example for H3:
>>> +       ths: ths@01c25000 {
>>
>>
>> adc@...
>
>
> It's a thermal sensor, so I think call it THS is more appropriate
> here. It's implemented as an ADC driver just because the internal
> code reusing of Linux. From device tree binding view I choose to
> call it ths.

There's numerous occurrences in this file and the filename that call it an =
ADC.

Furthermore, node names are supposed to be generic, not part #'s or
whatever you decide to make up. So pick from adc or temperature-sensor
as those are the standard names .

Rob

--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.
