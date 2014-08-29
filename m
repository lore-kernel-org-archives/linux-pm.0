From: "edubezval@gmail.com" <edubezval@gmail.com>
Subject: Re: Re: [PATCH v3 1/4] thermal: rockchip: add driver for thermal
Date: Fri, 29 Aug 2014 07:39:19 -0400
Message-ID: <CAC-25o-winy6jVjh9_hQ-t2VO2UfxG67pW5DpOve8A2o39EJSw@mail.gmail.com>
References: <1409187562-12370-1-git-send-email-caesar.wang@rock-chips.com>
	<2852853.mfRZfFVSev@wuerfel>
	<20140828143733.GA18084@developer>
	<3440260.edal29kzlR@diego>
	<2014082909531345696848@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <2014082909531345696848@rock-chips.com>
Sender: linux-doc-owner@vger.kernel.org
To: =?UTF-8?B?6LW15Luq5bOw?= <zyf@rock-chips.com>
Cc: =?UTF-8?Q?HeikoSt=C3=BCbner?= <heiko@sntech.de>, Arnd Bergmann <arnd@arndb.de>, Caesar Wang <caesar.wang@rock-chips.com>, "rui.zhang" <rui.zhang@intel.com>, "grant.likely" <grant.likely@linaro.org>, robh+dt <robh+dt@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-pm <linux-pm@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, devicetree <devicetree@vger.kernel.org>, linux-doc <linux-doc@vger.kernel.org>, =?UTF-8?B?6buE5rab?= <huangtao@rock-chips.com>, =?UTF-8?B?6JSh5p6r?= <cf@rock-chips.com>, dianders <dianders@chromium.org>, dtor <dtor@chromium.org>, =?UTF-8?B?6ZKf5YuH5rGq?= <zyw@rock-chips.com>, "addy.ke@rock-chips.com" <addy.ke@rock-chips.com>, "dmitry.torokhov" <dmitry.torokhov@gmail.com>, linux-iio <linux-iio@vger.kernel.org>, Jonathan Cameron <jic23@kernel.org>
List-Id: linux-pm@vger.kernel.org

Hello Zhao,

On Thu, Aug 28, 2014 at 9:54 PM, =E8=B5=B5=E4=BB=AA=E5=B3=B0 <zyf@rock-=
chips.com> wrote:
> Hi Heiko=EF=BC=8C
>
>    The TS-ADC on RK3288 has two component, a tsadc and a tsadc contro=
ller.
> The tsadc controller is similar like the thermal manager unit on othe=
r SOCs.
> We followed the naming of 3066, but not named as the Thermal Manager.
>
>    Moreover,there is only one set of apb registers to access the tsad=
c
> controller,and the tsadc is controlled by the tsadc controller,could =
not
> access directly. If we write a general tsadc driver by accessed tsadc
> controller registers, and it hardly to write a driver for the tsadc
> controller.

As suggested by Arnd, you can use the generic driver as interface
between thermal framework and IIO layer. The driver you are going to
write to your ADC is going to be in the IIO subsystem. The only
difference is that the generic driver would work for any ADC driver in
the IIO subsystem.
https://lkml.org/lkml/2014/2/5/810

In fact, there is already a generic driver. We just need to get it up
to date.  I see some testing has been already done, and results sound
promising.

>
>    So, I do not agree to write a generic adc driver for the rk3288-ts=
adc.
>
> ________________________________
> Yifeng Zhao
>
> =E5=8F=91=E4=BB=B6=E4=BA=BA=EF=BC=9A HeikoSt=C3=BCbner
> =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4=EF=BC=9A 2014-08-29 00:11
> =E6=94=B6=E4=BB=B6=E4=BA=BA=EF=BC=9A Eduardo Valentin
> =E6=8A=84=E9=80=81=EF=BC=9A Arnd Bergmann; Caesar Wang; rui.zhang; gr=
ant.likely; robh+dt;
> linux-kernel; linux-pm; linux-arm-kernel; devicetree; linux-doc; huan=
gtao;
> cf; dianders; dtor; zyw; addy.ke; dmitry.torokhov; zhaoyifeng; linux-=
iio;
> Jonathan Cameron
> =E4=B8=BB=E9=A2=98=EF=BC=9A Re: [PATCH v3 1/4] thermal: rockchip: add=
 driver for thermal
>
> Am Donnerstag, 28. August 2014, 10:37:35 schrieb Eduardo Valentin:
>> Ceasar and Arnd,
>>
>> On Thu, Aug 28, 2014 at 10:48:23AM +0200, Arnd Bergmann wrote:
>> > On Thursday 28 August 2014 08:59:19 Caesar Wang wrote:
>> > > Thermal is TS-ADC Controller module supports user-defined mode a=
nd
>> > > automatic mode.
>> > >
>> > > User-defined mode refers,TSADC all the control signals entirely =
by
>> > > software
>> > > writing to register for direct control.
>> > >
>> > > Automaic mode refers to the module automatically poll TSADC outp=
ut,and
>> > > the results Were checked.
>> > >
>> > > If you find that the temperature High in a period of time, an
>> > > interrupt
>> > > is generated to the processor down-measures taken;if the tempera=
ture
>> > > over a period of time High, the resulting TSHUT gave CRU module,=
let it
>> > > reset the entire chip, or via GPIO give PMIC.
>> > >
>> > > Signed-off-by: zhaoyifeng <zyf@rock-chips.com>
>> > > Signed-off-by: Caesar Wang <caesar.wang@rock-chips.com>
>> >
>> > Hi Caesar,
>> >
>> > After looking at the driver (last time I only received the patch f=
or
>> > the binding), I have a more general comment:
>> >
>> > This looks like a general-purpose ADC device, not an IP block that=
 is
>> > specific to thermal management. The binding looks ok for that purp=
ose
>> > but should probably be moved into
>> > Documentation/devicetree/bindings/iio/adc/ as a minor change.
>>
>> I agree with Arnd's point here. It makes sense to me to have this dr=
iver
>> under the IIO umbrella.
>
> interesting suggestion :-)
>
> I've just taken another look at the registers of the ts-adc on the rk=
3066
> which is completely different from the rk3288 one. Interestingly the =
rk3066
> one
> is "just" another saradc IP, so for this one it would really make sen=
se.
>
>
>> > On the driver side, I believe the correct way to deal with this se=
tup
>> > is to split your driver into a generic drivers/iio/adc/rockchips-t=
sadc.c
>> > file, and a smaller thermal driver that uses the iio in-kernel
>> > interfaces,
>> > ideally one that is independent of the underlying hardware and can
>> > work on any ADC implementation.
>>
>> Agreed. If you can write such interface and make your driver to work=
 in
>> such way, that would be great.
>
> But I currently don't see how you would model the temperature handlin=
g parts
> from a generic thermal driver to a generic adc driver for the rk3288-=
tsadc.
>
> I guess the general temperature irq handling would use iio-triggers? =
But how
> does the target temperature get into the TSADC_COMP1_INT register.
>
> Also when getting the temperature, Caesar's driver compares it to its=
 trip
> points and sets the next trip point depending on the current temperat=
ure
> (passive <-> critical) in rockchip_get_temp.
>
> Maybe there is some completely easy way for this, but currently I don=
't see
> it.
>
>
> Heiko
>
>



--=20
Eduardo Bezerra Valentin
