From: Daniel Kurtz <djkurtz@chromium.org>
Subject: Re: [PATCH v3] thermal: rockchip: make temperature reporting much
 more accurate
Date: Thu, 22 Jan 2015 12:25:00 +0800
Message-ID: <CAGS+omDdbUBn5swOZ23K3MpjzV3UMk3xABLWxj1SFE+s=FcHQA@mail.gmail.com>
References: <1421861370-19422-1-git-send-email-wxt@rock-chips.com>
 <1421861370-19422-2-git-send-email-wxt@rock-chips.com> <CAGS+omAi+F1_1-8wmDMf9oUq6GCjXu8N4kyeNmKRWv8m3eaCrA@mail.gmail.com>
 <54C07AD7.9020102@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-vc0-f171.google.com ([209.85.220.171]:54101 "EHLO
	mail-vc0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754509AbbAVEZW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 21 Jan 2015 23:25:22 -0500
Received: by mail-vc0-f171.google.com with SMTP id hq11so6232640vcb.2
        for <linux-pm@vger.kernel.org>; Wed, 21 Jan 2015 20:25:21 -0800 (PST)
In-Reply-To: <54C07AD7.9020102@rock-chips.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Caesar Wang <caesar.wang@rock-chips.com>
Cc: Caesar Wang <wxt@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, linux-pm@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Thu, Jan 22, 2015 at 12:21 PM, Caesar Wang
<caesar.wang@rock-chips.com> wrote:
>
> =E5=9C=A8 2015=E5=B9=B401=E6=9C=8822=E6=97=A5 12:01, Daniel Kurtz =E5=
=86=99=E9=81=93:
>
>> On Thu, Jan 22, 2015 at 1:29 AM, Caesar Wang <wxt@rock-chips.com> wr=
ote:
>>>
>>> In general, the kernel should report temperature readings exactly a=
s
>>> reported by the hardware. The cpu / gpu thermal driver works in 5 d=
egree
>>> increments,but we ought to do more accurate. The temperature will d=
o
>>> linear interpolation between the entries in the table.
>>>
>>> Test=3D $md5sum /dev/zero &
>>> $while true; do grep "" /sys/class/thermal/thermal_zone[1-2]/temp;
>>> sleep .5; done
>>>
>>> e.g. We can get the result as follows:
>>>      /sys/class/thermal/thermal_zone1/temp:39994
>>>      /sys/class/thermal/thermal_zone2/temp:39086
>>>      /sys/class/thermal/thermal_zone1/temp:39994
>>>      /sys/class/thermal/thermal_zone2/temp:39540
>>>      /sys/class/thermal/thermal_zone1/temp:39540
>>>      /sys/class/thermal/thermal_zone2/temp:39540
>>>      /sys/class/thermal/thermal_zone1/temp:39540
>>>      /sys/class/thermal/thermal_zone2/temp:39994
>>>
>>> Signed-off-by: Caesar Wang <wxt@rock-chips.com>
>>> Reviewed-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>>>
>>> ---
>>>
>>> Changes in v3:
>>> Suggested-by Daniel Kurtz,
>>> the check doesn't reject "code =3D=3D 0xfff"
>>> Fixed in rk_tsadcv2_code_to_temp(u32 code)
>>>
>>> Changes in v2:
>>> Reviewed-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>>>
>>>   drivers/thermal/rockchip_thermal.c | 32
>>> ++++++++++++++++++++++----------
>>>   1 file changed, 22 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/drivers/thermal/rockchip_thermal.c
>>> b/drivers/thermal/rockchip_thermal.c
>>> index 1bcddfc..ce18007 100644
>>> --- a/drivers/thermal/rockchip_thermal.c
>>> +++ b/drivers/thermal/rockchip_thermal.c
>>> @@ -193,19 +193,22 @@ static u32 rk_tsadcv2_temp_to_code(long temp)
>>>
>>>   static long rk_tsadcv2_code_to_temp(u32 code)
>>>   {
>>> -       int high, low, mid;
>>> -
>>> -       low =3D 0;
>>> -       high =3D ARRAY_SIZE(v2_code_table) - 1;
>>> -       mid =3D (high + low) / 2;
>>> +       unsigned int low =3D 0;
>>> +       unsigned int high =3D ARRAY_SIZE(v2_code_table) - 1;
>>> +       unsigned int mid =3D (low + high) / 2;
>>> +       unsigned int num;
>>> +       unsigned long denom;
>>>
>>> +       /* No code available, return callback */
>>>          if (code > v2_code_table[low].code || code <
>>> v2_code_table[high].code)
>>> -               return 125000; /* No code available, return max
>>> temperature */
>>> +               return rk_tsadcv2_code_to_temp(code);
>>
>> Isn't this an infinite recursion?
>
>
> No, I think we can try check if it  is happened.
> Maybe we can return a warning/error for it.

I mean, if the 'if' condition is true, then this will just call the
same function again with the same code, and again, and again...
Just return an error code here, -ENOENT maybe?
I am not sure what error code is appropriate.


>
>>>          while (low <=3D high) {
>>> -               if (code >=3D v2_code_table[mid].code && code <
>>> -                   v2_code_table[mid - 1].code)
>>> -                       return v2_code_table[mid].temp;
>>> +               if (code >=3D v2_code_table[mid].code &&
>>> +                   code < v2_code_table[mid - 1].code)
>>> +                       break;
>>> +               else if (code =3D=3D TSADCV2_DATA_MASK)
>>> +                       break;
>>>                  else if (code < v2_code_table[mid].code)
>>>                          low =3D mid + 1;
>>>                  else
>>> @@ -213,7 +216,16 @@ static long rk_tsadcv2_code_to_temp(u32 code)
>>>                  mid =3D (low + high) / 2;
>>>          }
>>>
>>> -       return 125000;
>>> +       /*
>>> +        * The 5C granularity provided by the table is too much. Le=
t's
>>> +        * assume that the relationship between sensor readings and
>>> +        * temperature between 2 table entries is linear and interp=
olate
>>> +        * to produce less granular result.
>>> +        */
>>> +       num =3D v2_code_table[mid].temp - v2_code_table[mid - 1].te=
mp;
>>> +       num *=3D v2_code_table[mid - 1].code - code;
>>> +       denom =3D v2_code_table[mid - 1].code - v2_code_table[mid].=
code;
>>> +       return v2_code_table[mid - 1].temp + (num / denom);
>>>   }
>>>
>>>   /**
>>> --
>>> 1.9.1
>>>
>>>
>>
>>
>
> --
> Best regards
> Caesar Wang (=E7=8E=8B=E6=99=93=E8=85=BE)
> =E7=A6=8F=E5=B7=9E=E7=91=9E=E8=8A=AF=E5=BE=AE=E7=94=B5=E5=AD=90=E6=9C=
=89=E9=99=90=E5=85=AC=E5=8F=B8
> Fuzhou Rockchip Electronics Co.Ltd
> =E7=A6=8F=E5=BB=BA=E7=9C=81=E7=A6=8F=E5=B7=9E=E5=B8=82=E9=93=9C=E7=9B=
=98=E8=B7=AF=E8=BD=AF=E4=BB=B6=E5=A4=A7=E9=81=9389=E5=8F=B7=E8=BD=AF=E4=
=BB=B6=E5=9B=ADA=E5=8C=BA18=E5=8F=B7=E6=A5=BC(350003)
> Addr:No.18 Building, A District, No.89, software Boulevard Fuzhou,
> Fujian,PRC
> Email:wxt@rock-chips.com
> Tel:+86-591-83991906/07->8221
>
>
