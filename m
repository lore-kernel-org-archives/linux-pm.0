From: Caesar Wang <caesar.wang-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: Re: [PATCH v3 1/4] thermal: rockchip: add driver for thermal
Date: Fri, 29 Aug 2014 03:36:36 +0800
Message-ID: <53FF84C4.9080902@rock-chips.com>
References: <1409187562-12370-1-git-send-email-caesar.wang@rock-chips.com> <20140828143733.GA18084@developer> <3440260.edal29kzlR@diego> <4488604.oBeB6it8Vr@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4488604.oBeB6it8Vr@wuerfel>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, =?UTF-8?B?SGVpa28gU3TDvGJuZXI=?= <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
Cc: Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, huangtao-TNX95d0MmH7DzftRWevZcw@public.gmane.org, cf-TNX95d0MmH7DzftRWevZcw@public.gmane.org, dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, dtor-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, zyw-TNX95d0MmH7DzftRWevZcw@public.gmane.org, addy.ke-TNX95d0MmH7DzftRWevZcw@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, zhaoyifeng <zyf-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Arnd & Heiko & Eduardo,

OK. Maybe you are right.

This driver should be put into drivers/iio/adc/* ,
Anyway,I will re-edit it ASAP.


=E5=9C=A8 2014/8/29 0:16, Arnd Bergmann =E5=86=99=E9=81=93:
> On Thursday 28 August 2014 18:11:43 Heiko St=C3=BCbner wrote:
>> Am Donnerstag, 28. August 2014, 10:37:35 schrieb Eduardo Valentin:
>>>> On the driver side, I believe the correct way to deal with this se=
tup
>>>> is to split your driver into a generic drivers/iio/adc/rockchips-t=
sadc.c
>>>> file, and a smaller thermal driver that uses the iio in-kernel int=
erfaces,
>>>> ideally one that is independent of the underlying hardware and can
>>>> work on any ADC implementation.
>>> Agreed. If you can write such interface and make your driver to wor=
k in
>>> such way, that would be great.
>> But I currently don't see how you would model the temperature handli=
ng parts
>> from a generic thermal driver to a generic adc driver for the rk3288=
-tsadc.
>>
>> I guess the general temperature irq handling would use iio-triggers?=
 But how
>> does the target temperature get into the TSADC_COMP1_INT register.
>>
>> Also when getting the temperature, Caesar's driver compares it to it=
s trip
>> points and sets the next trip point depending on the current tempera=
ture
>> (passive <-> critical) in rockchip_get_temp.
>>
>> Maybe there is some completely easy way for this, but currently I do=
n't see
>> it.
> Eduardo earlier today replied to an email about a generic driver for
> thermal, which was posted in February but hasn't been merged.
> See https://lkml.org/lkml/2014/2/5/810
>
> There may be a newer version of this patch, which I haven't found.
>
> 	Arnd
>
>
>

--=20
Best regards,
Caesar


--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
