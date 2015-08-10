From: Caesar Wang <wxt@rock-chips.com>
Subject: Re: [PATCH] thermal: rockchip: fix handling of invalid readings
Date: Mon, 10 Aug 2015 18:22:40 +0800
Message-ID: <55C87B70.5050805@rock-chips.com>
References: <20150807205923.GA33949@dtor-ws>	<55C84521.5040007@rock-chips.com> <CAE_wzQ_xhh17tsVj28W5Z=mgomnz1nOMPMN15Sozb8KcMjo=wA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from regular1.263xmail.com ([211.150.99.130]:59487 "EHLO
	regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934342AbbHJKWy (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 10 Aug 2015 06:22:54 -0400
In-Reply-To: <CAE_wzQ_xhh17tsVj28W5Z=mgomnz1nOMPMN15Sozb8KcMjo=wA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Dmitry Torokhov <dtor@chromium.org>
Cc: Heiko Stuebner <heiko@sntech.de>, Eduardo Valentin <edubezval@gmail.com>, Doug Anderson <dianders@chromium.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>



=E5=9C=A8 2015=E5=B9=B408=E6=9C=8810=E6=97=A5 15:59, Dmitry Torokhov =E5=
=86=99=E9=81=93:
> Hi Caesar,
>
> On Sun, Aug 9, 2015 at 11:30 PM, Caesar Wang <wxt@rock-chips.com> wro=
te:
>> Dear Dmitry,
>>
>> Thanks your patch.
>>
>> The code looks like fine,but I don't think the TS-ADC will work on r=
k3288
>> SoC.
> What do you mean? It seems to work when I ran it...

Making a mistake.:-(

>>
>> =E5=9C=A8 2015=E5=B9=B408=E6=9C=8808=E6=97=A5 04:59, Dmitry Torokhov=
 =E5=86=99=E9=81=93:
>>> We attempted to signal invalid code by returning -EAGAIN from
>>> rk_tsadcv2_code_to_temp(), unfortunately the return value was stuff=
ed
>>> directly into the temperature pointer, potentially confusing upper
>>> layers with temperature of -EINVAL.
>>>
>>> Let's split temperature from error/success indicator to avoid such
>>> confusion.
>>>
>>> Also change the way we scan the temperature table to start with the=
 2nd
>>> element so that we do not need to worry that we may reference out o=
f
>>> bounds element while doing binary search and keep checking that we =
end
>>> up with 'mid' equal to 0 (since we are looking for the temperature =
that
>>> would fall into interval between the 'mid' and 'mid - 1') .
>>>
>>> Signed-off-by: Dmitry Torokhov <dtor@chromium.org>
>>> ---
>>>    drivers/thermal/rockchip_thermal.c | 28 +++++++++++++-----------=
----
>>>    1 file changed, 13 insertions(+), 15 deletions(-)
>>>
>>> diff --git a/drivers/thermal/rockchip_thermal.c
>>> b/drivers/thermal/rockchip_thermal.c
>>> index c89ffb2..93ee307 100644
>>> --- a/drivers/thermal/rockchip_thermal.c
>>> +++ b/drivers/thermal/rockchip_thermal.c
>>> @@ -124,7 +124,7 @@ struct rockchip_thermal_data {
>>>    #define TSADCV2_AUTO_PERIOD_HT_TIME           50  /* msec */
>>>      struct tsadc_table {
>>> -       unsigned long code;
>>> +       u32 code;
>>>          long temp;
>>>    };
>>>    @@ -164,7 +164,6 @@ static const struct tsadc_table v2_code_tabl=
e[] =3D {
>>>          {3452, 115000},
>>>          {3437, 120000},
>>>          {3421, 125000},
>>> -       {0, 125000},
>>>    };
>>>      static u32 rk_tsadcv2_temp_to_code(long temp)
>>> @@ -191,19 +190,21 @@ static u32 rk_tsadcv2_temp_to_code(long temp)
>>>          return 0;
>>>    }
>>>    -static int rk_tsadcv2_code_to_temp(u32 code)
>>> +static int rk_tsadcv2_code_to_temp(u32 code, int *temp)

It's wired that can't git-am this patch.

I search the Eduardo'branch[0] for rockchip-thermal.c driver. The=20
function is "static long rk_tsadcv2_code_to_temp(u32 code)"

Maybe i'm missing something, I verified this patch on my board but this=
=20
fixed.

So you can free add it:
Tested-by: Caesar Wang <wxt@rock-chips.com>

[0]:
url =3D=20
git://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-therma=
l.git



---
Thanks,
Caesar



>>>    {
>>> -       unsigned int low =3D 0;
>>> +       unsigned int low =3D 1;
>>>          unsigned int high =3D ARRAY_SIZE(v2_code_table) - 1;
>>>          unsigned int mid =3D (low + high) / 2;
>>>          unsigned int num;
>>>          unsigned long denom;
>>>    -     /* Invalid code, return -EAGAIN */
>>> -       if (code > TSADCV2_DATA_MASK)
>>> -               return -EAGAIN;
>>> +       BUILD_BUG_ON(ARRAY_SIZE(v2_code_table) < 2);
>>>    -     while (low <=3D high && mid) {
>>> +       code &=3D TSADCV2_DATA_MASK;
>>> +       if (code < v2_code_table[high].code)
>>> +               return -EAGAIN;         /* Incorrect reading */
>>> +
>>> +       while (low <=3D high) {
>>>                  if (code >=3D v2_code_table[mid].code &&
>>>                      code < v2_code_table[mid - 1].code)
>>>                          break;
>>> @@ -223,7 +224,9 @@ static int rk_tsadcv2_code_to_temp(u32 code)
>>>          num =3D v2_code_table[mid].temp - v2_code_table[mid - 1].t=
emp;
>>>          num *=3D v2_code_table[mid - 1].code - code;
>>>          denom =3D v2_code_table[mid - 1].code - v2_code_table[mid]=
=2Ecode;
>>> -       return v2_code_table[mid - 1].temp + (num / denom);
>>> +       *temp =3D v2_code_table[mid - 1].temp + (num / denom);
>>> +
>>> +       return 0;
>>>    }
>>>      /**
>>> @@ -281,14 +284,9 @@ static int rk_tsadcv2_get_temp(int chn, void _=
_iomem
>>> *regs, int *temp)
>>>    {
>>>          u32 val;
>>>    -     /* the A/D value of the channel last conversion need some =
time */
>>>          val =3D readl_relaxed(regs + TSADCV2_DATA(chn));
>>> -       if (val =3D=3D 0)
>>> -               return -EAGAIN;
>>> -
>>
>> if we reserve the above code, that will get the ADC value.
> But if we pass  0 into rk_tsadcv2_code_to_temp() it will trigger:
>
>>> +       if (code < v2_code_table[high].code)
>>> +               return -EAGAIN;         /* Incorrect reading */
> and still return -EAGAIN, as it was. There is no behavior change as
> far as I can see.
Yup, that's ok for me.

>>
>>> -       *temp =3D rk_tsadcv2_code_to_temp(val);
>>>    -     return 0;
>>> +       return rk_tsadcv2_code_to_temp(val, temp);
>>>    }
>>>      static void rk_tsadcv2_tshut_temp(int chn, void __iomem *regs,=
 long
>>> temp)
>>
> Thanks,
> Dmitry
>
>
>


