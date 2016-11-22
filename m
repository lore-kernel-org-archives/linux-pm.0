From: Caesar Wang <caesar.upstream@gmail.com>
Subject: Re: [PATCH 2/3] thermal: rockchip: improve conversion error messages
Date: Tue, 22 Nov 2016 20:44:35 +0800
Message-ID: <39645265-8d1b-a32e-22bd-daf60b7dc551@gmail.com>
References: <1479513177-81504-1-git-send-email-briannorris@chromium.org>
 <1479513177-81504-2-git-send-email-briannorris@chromium.org>
 <b6da9490-9a27-4330-7988-cb25724ba345@rock-chips.com>
 <378ade3d-a980-58e4-5253-c16702c74bf3@gmail.com>
 <1479801436.2360.26.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:35192 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932436AbcKVMok (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 22 Nov 2016 07:44:40 -0500
In-Reply-To: <1479801436.2360.26.camel@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Brian Norris <briannorris@chromium.org>, Eduardo Valentin <edubezval@gmail.com>
Cc: Caesar Wang <caesar.upstream@gmail.com>, Caesar Wang <wxt@rock-chips.com>, linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, Stephen Barber <smbarber@chromium.org>, Heiko Stuebner <heiko@sntech.de>, linux-pm@vger.kernel.org

在 2016年11月22日 15:57, Zhang Rui 写道:
> On Tue, 2016-11-22 at 09:51 +0800, Caesar Wang wrote:
>> 在 2016年11月19日 11:31, Caesar Wang 写道:
>>> Brian,
>>>
>>> 在 2016年11月19日 07:52, Brian Norris 写道:
>>>> These error messages don't give much information about what went
>>>> wrong.
>>>> It would be nice, for one, to see what invalid temperature was
>>>> being
>>>> requested when conversion fails. It's also good to return an
>>>> error when
>>>> we can't handle a conversion properly.
>>>>
>>>> While we're at it, fix the grammar too.
>>>>
>>>> Signed-off-by: Brian Norris <briannorris@chromium.org>
>>>> ---
>>>> Note: it'd probably be even nicer to know which sensor this was,
>>>> but
>>>> we've
>>>> kinda abstracted that one away by this point...
>>>>
>>>>    drivers/thermal/rockchip_thermal.c | 7 +++++--
>>>>    1 file changed, 5 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/thermal/rockchip_thermal.c
>>>> b/drivers/thermal/rockchip_thermal.c
>>>> index e227a9f0acf7..35554d146b9d 100644
>>>> --- a/drivers/thermal/rockchip_thermal.c
>>>> +++ b/drivers/thermal/rockchip_thermal.c
>>>> @@ -424,7 +424,8 @@ static u32 rk_tsadcv2_temp_to_code(struct
>>>> chip_tsadc_table table,
>>>>        }
>>>>      exit:
>>>> -    pr_err("Invalid the conversion, error=%d\n", error);
>>>> +    pr_err("%s: invalid temperature, temp=%d error=%d\n",
>>>> +        __func__, temp, error);
>>> I have do some similar for rockchip inside thermal driver.  Forget
>>> to
>>> send for upstream. :(
>>> exit:
>>>      pr_err("%s: Invalid conversion table: code=%d,
>>> temperature=%d\n",
>>>             __func__, error, temp);
>>>
>>>>        return error;
>>>>    }
>>>>    @@ -475,7 +476,9 @@ static int rk_tsadcv2_code_to_temp(struct
>>>> chip_tsadc_table table, u32 code,
>>>>            }
>>>>            break;
>>>>        default:
>>>> -        pr_err("Invalid the conversion table\n");
>>>> +        pr_err("%s: invalid conversion table, mode=%d\n",
>>>> +            __func__, table.mode);
>>>> +        return -EINVAL;
>> CHECK: Alignment should match open parenthesis
>> #428: FILE: drivers/thermal/rockchip_thermal.c:428:
>> +    pr_err("%s: invalid temperature, temp=%d error=%d\n",
>> +        __func__, temp, error);
>>
>> CHECK: Alignment should match open parenthesis
>> #480: FILE: drivers/thermal/rockchip_thermal.c:480:
>> +        pr_err("%s: invalid conversion table, mode=%d\n",
>> +            __func__, table->mode);
>>
>>
>> I'm ready to resend all rockchip thermal patches. (contain them)
>>
> so I will ignore patch 2/3 and 3/3 for now and wait for your new patch
> set.

Posted the patch set on https://lkml.org/lkml/2016/11/22/250

>
> thanks,
> rui
>>>>        }
>>>>          /*
>>>
>>> _______________________________________________
>>> Linux-rockchip mailing list
>>> Linux-rockchip@lists.infradead.org
>>> http://lists.infradead.org/mailman/listinfo/linux-rockchip
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip

