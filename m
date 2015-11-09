From: Caesar Wang <caesar.upstream@gmail.com>
Subject: Re: [PATCH v2 5/9] thermal: rockchip: Add the flag for adc value
 increment or decrement
Date: Mon, 9 Nov 2015 11:29:12 +0800
Message-ID: <56401308.4060602@gmail.com>
References: <1446700685-18017-1-git-send-email-wxt@rock-chips.com>
 <1446700685-18017-6-git-send-email-wxt@rock-chips.com>
 <20151106191126.GC8202@localhost.localdomain> <563E1B07.4060108@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:34542 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752062AbbKID3T (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 8 Nov 2015 22:29:19 -0500
In-Reply-To: <563E1B07.4060108@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Caesar Wang <wxt@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, Zhang Rui <rui.zhang@intel.com>, linux-arm-kernel@lists.infradead.org



=E5=9C=A8 2015=E5=B9=B411=E6=9C=8807=E6=97=A5 23:38, Caesar Wang =E5=86=
=99=E9=81=93:
> Hello Eduardo,
>
> =E5=9C=A8 2015=E5=B9=B411=E6=9C=8807=E6=97=A5 03:11, Eduardo Valentin=
 =E5=86=99=E9=81=93:
>> On Thu, Nov 05, 2015 at 01:18:01PM +0800, Caesar Wang wrote:
>>> The conversion table has the adc value and temperature.
>>> In fact, the adc value only has the increment or decrement mode in
>>> conversion table.
>>>
>>> Moment, we can add the flag to be better support the *code_to_temp*
>>> for differenr SoCs.
>>>
>>> Signed-off-by: Caesar Wang <wxt@rock-chips.com>
>>> ---
>>>
>>> Changes in v2: None
>>> Changes in v1: None
>>>
>>>   drivers/thermal/rockchip_thermal.c | 64=20
>>> ++++++++++++++++++++++++++++++--------
>>>   1 file changed, 51 insertions(+), 13 deletions(-)
>>>
>>> diff --git a/drivers/thermal/rockchip_thermal.c=20
>>> b/drivers/thermal/rockchip_thermal.c
>>> index e828f18..9df027f 100644
>>> --- a/drivers/thermal/rockchip_thermal.c
>>> +++ b/drivers/thermal/rockchip_thermal.c
>>> @@ -53,6 +53,16 @@ enum sensor_id {
>>>   };
>>>     /**
>>> +* The conversion table has the adc value and temperature.
>>> +* ADC_DECREMENT is the adc value decremnet.(e.g. v2_code_table)
>>> +* ADC_INCREMNET is the adc value incremnet.(e.g. v3_code_table)
>>> +*/
>>> +enum adc_flag {
>>> +    ADC_DECREMENT =3D 0,
>>> +    ADC_INCREMENT,
>>> +};
>>> +
>>> +/**
>>>    * The max sensors is two in rockchip SoCs.
>>>    * Two sensors: CPU and GPU sensor.
>>>    */
>>> @@ -66,6 +76,9 @@ struct chip_tsadc_table {
>>>         /* that analogic mask data */
>>>       unsigned long data_mask;
>>> +
>>> +    /* adc value is increment or decrement */
>>> +    unsigned int flag;

Sorry, I think to use the enum type will be better.

Says:
enum adc_sort_flag sort_flag;
or
enum adc_sort_mode  mode;

>>
>> Maybe bool? And rename to something more meaningful?
>
> Sure, that should be a bool type.
> I guess the rename in sort_flag......(maybe will have a better name)
>
>
>>
>> Or do you plan to have more conditions to test in your flag?
>
> Moment, the flag (increment or decrement) can support all the rockchi=
p=20
> series SoCs have thermal function.
>
>>>   };
>>>     struct rockchip_tsadc_chip {
>>> @@ -223,19 +236,43 @@ static int rk_tsadcv2_code_to_temp(struct=20
>>> chip_tsadc_table table, u32 code,
>>>         WARN_ON(table.length < 2);
>>>   -    code &=3D table.data_mask;
>>> -    if (code < table.id[high].code)
>>> +    switch (table.flag) {
>>> +    case ADC_DECREMENT:
>>> +        code &=3D table.data_mask;
>>> +        if (code < table.id[high].code)
>>>           return -EAGAIN;        /* Incorrect reading */
>> Add an indentation.
>
> Thanks, will be fixed in next patch.
>
>
>>>   -    while (low <=3D high) {
>>> -        if (code >=3D table.id[mid].code &&
>>> -            code < table.id[mid - 1].code)
>>> -            break;
>>> -        else if (code < table.id[mid].code)
>>> -            low =3D mid + 1;
>>> -        else
>>> -            high =3D mid - 1;
>>> -        mid =3D (low + high) / 2;
>>> +        while (low <=3D high) {
>>> +            if (code >=3D table.id[mid].code &&
>>> +                code < table.id[mid - 1].code)
>>> +                break;
>>> +            else if (code < table.id[mid].code)
>>> +                low =3D mid + 1;
>>> +            else
>>> +                high =3D mid - 1;
>>> +
>>> +            mid =3D (low + high) / 2;
>>> +        }
>>> +        break;
>>> +    case ADC_INCREMENT:
>>> +        code &=3D table.data_mask;
>>> +        if (code < table.id[low].code)
>>> +        return -EAGAIN;        /* Incorrect reading */
>>> +
>> add an indentation.
>
> Ditto.
>
> Thanks,
> Caesar
>>
>>> +        while (low <=3D high) {
>>> +            if (code >=3D table.id[mid - 1].code &&
>>> +                code < table.id[mid].code)
>>> +                break;
>>> +            else if (code > table.id[mid].code)
>>> +                low =3D mid + 1;
>>> +            else
>>> +                high =3D mid - 1;
>>> +
>>> +            mid =3D (low + high) / 2;
>>> +        }
>>> +        break;
>>> +    default:
>>> +        pr_err("Invalid the table conversion\n");
>>>       }
>>>         /*
>>> @@ -245,8 +282,8 @@ static int rk_tsadcv2_code_to_temp(struct=20
>>> chip_tsadc_table table, u32 code,
>>>        * to produce less granular result.
>>>        */
>>>       num =3D table.id[mid].temp - v2_code_table[mid - 1].temp;
>>> -    num *=3D table.id[mid - 1].code - code;
>>> -    denom =3D table.id[mid - 1].code - table.id[mid].code;
>>> +    num *=3D abs(table.id[mid - 1].code - code);
>>> +    denom =3D abs(table.id[mid - 1].code - table.id[mid].code);
>>>       *temp =3D table.id[mid - 1].temp + (num / denom);
>>>         return 0;
>>> @@ -367,6 +404,7 @@ static const struct rockchip_tsadc_chip=20
>>> rk3288_tsadc_data =3D {
>>>           .id =3D v2_code_table,
>>>           .length =3D ARRAY_SIZE(v2_code_table),
>>>           .data_mask =3D TSADCV2_DATA_MASK,
>>> +        .flag =3D ADC_DECREMENT,
>>>       },
>>>   };
>>>   --
>>> 1.9.1
>>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
>

--=20
Thanks,
Caesar

