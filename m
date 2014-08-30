From: Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH v3 1/4] thermal: rockchip: add driver for thermal
Date: Sat, 30 Aug 2014 10:30:37 +0100
Message-ID: <540199BD.7000504@kernel.org>
References: <1409187562-12370-1-git-send-email-caesar.wang@rock-chips.com>	<2852853.mfRZfFVSev@wuerfel>	<20140828143733.GA18084@developer>	<3440260.edal29kzlR@diego>	<2014082909531345696848@rock-chips.com> <CAC-25o-winy6jVjh9_hQ-t2VO2UfxG67pW5DpOve8A2o39EJSw@mail.gmail.com> <54006D4C.2070404@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <54006D4C.2070404@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Huang Tao <huangtao@rock-chips.com>, "edubezval@gmail.com" <edubezval@gmail.com>, =?UTF-8?B?6LW15Luq5bOw?= <zyf@rock-chips.com>
Cc: =?UTF-8?B?SGVpa29TdMO8Ym5lcg==?= <heiko@sntech.de>, Arnd Bergmann <arnd@arndb.de>, Caesar Wang <caesar.wang@rock-chips.com>, "rui.zhang" <rui.zhang@intel.com>, "grant.likely" <grant.likely@linaro.org>, robh+dt <robh+dt@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-pm <linux-pm@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, devicetree <devicetree@vger.kernel.org>, linux-doc <linux-doc@vger.kernel.org>, =?UTF-8?B?6JSh5p6r?= <cf@rock-chips.com>, dianders <dianders@chromium.org>, dtor <dtor@chromium.org>, =?UTF-8?B?6ZKf5YuH5rGq?= <zyw@rock-chips.com>, "addy.ke@rock-chips.com" <addy.ke@rock-chips.com>, "dmitry.torokhov" <dmitry.torokhov@gmail.com>, linux-iio <linux-iio@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 29/08/14 13:08, Huang Tao wrote:
> Dear Eduardo Bezerra Valentin:
>=20
> =E5=9C=A8 2014=E5=B9=B408=E6=9C=8829=E6=97=A5 19:39, edubezval@gmail.=
com =E5=86=99=E9=81=93:
>> Hello Zhao,
>>
>> On Thu, Aug 28, 2014 at 9:54 PM, =E8=B5=B5=E4=BB=AA=E5=B3=B0 <zyf@ro=
ck-chips.com> wrote:
>>> Hi Heiko=EF=BC=8C
>>>
>>>    The TS-ADC on RK3288 has two component, a tsadc and a tsadc cont=
roller.
>>> The tsadc controller is similar like the thermal manager unit on ot=
her SOCs.
>>> We followed the naming of 3066, but not named as the Thermal Manage=
r.
>>>
>>>    Moreover,there is only one set of apb registers to access the ts=
adc
>>> controller,and the tsadc is controlled by the tsadc controller,coul=
d not
>>> access directly. If we write a general tsadc driver by accessed tsa=
dc
>>> controller registers, and it hardly to write a driver for the tsadc
>>> controller.
>> As suggested by Arnd, you can use the generic driver as interface
>> between thermal framework and IIO layer. The driver you are going to
>> write to your ADC is going to be in the IIO subsystem. The only
>> difference is that the generic driver would work for any ADC driver =
in
>> the IIO subsystem.
>> https://lkml.org/lkml/2014/2/5/810
>>
>> In fact, there is already a generic driver. We just need to get it u=
p
>> to date.  I see some testing has been already done, and results soun=
d
>> promising.
> This iio_thermal driver only support get temperature from the ADC IIO
> channel.
> It dose not support any advanced feature such as configure the
> temperature when system should be reset.
> So if we adapt it, we will access the register form both TSADC IIO
> driver and  thermal driver.
> I don't thank this is a good ideal.

Interesting bit of functionality.  I agree this doesn't fit overwelming=
ly well
into an iio consumer driver as things currently stand.

Looking briefly at your code, this is basically a threshold interrupt?
If so then we do have threshold type event handling in IIO (simply term=
ed
events).  The snag is that it is the one area that doesn't currently ha=
ve
any in kernel interfaces.

Such an interface would be similar to that used for the buffered data a=
ccess (raw
data stream - we should probably rename that as it isn't always buffere=
d anymore).
The nasty bit (as it was with the buffered interface) is writing a reas=
onably
efficient demux that can split out the data to those devices that have =
registered
their interest in it. It would involve some additional code in iio_push=
_event and
some indirection in the code that controls what events are enabled.
Actually, you could probably skip this an just squirt all events reciev=
ed out through
the direct IIO to userspace interface (nothing prevents another process=
 turning
more on anyway!).  We could event for now specify that any in kernel us=
ers might
get other events and it is up to them to sanity check them.

We'd also need to add some basic access functions to set limits etc.

I'm afraid the 'events' bit of IIO is one of our least developed elemen=
ts and is
lagging way behind the work done on the main data flows. It's been on t=
he
list for a while, particularly as we need it to finish separating the
userspace interfaces of IIO from the backend.

So, looking at the wider picture, with a few additions to IIO we can su=
pport
some ADC based thermal drivers - whether all of them is a bit dependent=
 on
whether they have weird and wonderful domain specific hardware (which I=
 might
have missed here, but does not seem to be present).

Note this is based on a rather brief scan read so I may well have misse=
d some
important details!
>=20
> In fact, we should ignore the "ADC" stuff. This sensor use ADC intern=
al,
> but it is transparent to software, especially in automatic mode.
Is this adc ever used for anything else?  If so, then there is your rea=
son to
go through the pain of a generic driver.

Jonathan

p.s. I'd never seen the driver Arnd highlighted.  Could anyone working =
on
IIO clients cc linux-iio@vger.kernel.org as it's useful to know what pe=
ople
are using the interfaces for (particularly as they might change so it i=
s
good to know what is in the pipeline).
>>
>>>    So, I do not agree to write a generic adc driver for the rk3288-=
tsadc.
>>>
>>> ________________________________
>>> Yifeng Zhao
>>>
>>>
>=20
>=20
