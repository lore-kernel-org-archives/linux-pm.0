From: Huang Tao <huangtao-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: Re: [PATCH v3 1/4] thermal: rockchip: add driver for thermal
Date: Fri, 29 Aug 2014 20:08:44 +0800
Message-ID: <54006D4C.2070404@rock-chips.com>
References: <1409187562-12370-1-git-send-email-caesar.wang@rock-chips.com>	<2852853.mfRZfFVSev@wuerfel>	<20140828143733.GA18084@developer>	<3440260.edal29kzlR@diego>	<2014082909531345696848@rock-chips.com> <CAC-25o-winy6jVjh9_hQ-t2VO2UfxG67pW5DpOve8A2o39EJSw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAC-25o-winy6jVjh9_hQ-t2VO2UfxG67pW5DpOve8A2o39EJSw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, =?UTF-8?B?6LW15Luq5bOw?= <zyf-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Cc: =?UTF-8?B?SGVpa29TdMO8Ym5lcg==?= <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Caesar Wang <caesar.wang-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, "rui.zhang" <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "grant.likely" <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, robh+dt <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-pm <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-doc <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, =?UTF-8?B?6JSh5p6r?= <cf-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, dianders <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, dtor <dtor-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, =?UTF-8?B?6ZKf5YuH5rGq?= <zyw-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, "addy.ke-TNX95d0MmH7DzftRWevZcw@public.gmane.org" <addy.ke-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, "dmitry.torokhov" <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-iio <linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Dear Eduardo Bezerra Valentin:

=E5=9C=A8 2014=E5=B9=B408=E6=9C=8829=E6=97=A5 19:39, edubezval-Re5JQEeQqe8@public.gmane.org=
m =E5=86=99=E9=81=93:
> Hello Zhao,
>
> On Thu, Aug 28, 2014 at 9:54 PM, =E8=B5=B5=E4=BB=AA=E5=B3=B0 <zyf@roc=
k-chips.com> wrote:
>> Hi Heiko=EF=BC=8C
>>
>>    The TS-ADC on RK3288 has two component, a tsadc and a tsadc contr=
oller.
>> The tsadc controller is similar like the thermal manager unit on oth=
er SOCs.
>> We followed the naming of 3066, but not named as the Thermal Manager=
=2E
>>
>>    Moreover,there is only one set of apb registers to access the tsa=
dc
>> controller,and the tsadc is controlled by the tsadc controller,could=
 not
>> access directly. If we write a general tsadc driver by accessed tsad=
c
>> controller registers, and it hardly to write a driver for the tsadc
>> controller.
> As suggested by Arnd, you can use the generic driver as interface
> between thermal framework and IIO layer. The driver you are going to
> write to your ADC is going to be in the IIO subsystem. The only
> difference is that the generic driver would work for any ADC driver i=
n
> the IIO subsystem.
> https://lkml.org/lkml/2014/2/5/810
>
> In fact, there is already a generic driver. We just need to get it up
> to date.  I see some testing has been already done, and results sound
> promising.
This iio_thermal driver only support get temperature from the ADC IIO
channel.
It dose not support any advanced feature such as configure the
temperature when system should be reset.
So if we adapt it, we will access the register form both TSADC IIO
driver and  thermal driver.
I don't thank this is a good ideal.

In fact, we should ignore the "ADC" stuff. This sensor use ADC internal=
,
but it is transparent to software, especially in automatic mode.
>
>>    So, I do not agree to write a generic adc driver for the rk3288-t=
sadc.
>>
>> ________________________________
>> Yifeng Zhao
>>
>>


--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
