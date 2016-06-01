From: Chanwoo Choi <cwchoi00@gmail.com>
Subject: Re: [PATCH] devfreq: fix double call put_device
Date: Wed, 1 Jun 2016 20:31:34 +0900
Message-ID: <CAGTfZH3HhSwzdAdZWgcVj6qOt1piiVU4joH_1fvXv5V0GAsjdA@mail.gmail.com>
References: <C3050A4DBA34F345975765E43127F10F6381E593@SZXEMA512-MBS.china.huawei.com>
	<573C4CD9.5050200@samsung.com>
Reply-To: cw00.choi@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <573C4CD9.5050200@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chanwoo Choi <cw00.choi@samsung.com>
Cc: Caizhiyong <caizhiyong@hisilicon.com>, Andrew Morton <akpm@linux-foundation.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "kyungmin.park@samsung.com" <kyungmin.park@samsung.com>, "myungjoo.ham@samsung.com" <myungjoo.ham@samsung.com>, lkml <linux-kernel@vger.kernel.org>, "Wanli (welly)" <welly.wan@hisilicon.com>, "Wangming (Wonder)" <mingwonder.wang@hisilicon.com>, Quyaxin <quyaxin@hisilicon.com>
List-Id: linux-pm@vger.kernel.org

Dear Myungjoo,

I reivewed this patch. But the merged patch[1] don't include the my
reviewed-by tag.

[1] https://git.kernel.org/cgit/linux/kernel/git/mzx/devfreq.git/commit=
/?h=3Dfixes&id=3Dd90ea94c8f33dcda631885a3dbb2df063ba39efd

Regards,
Chanwoo Choi

On Wed, May 18, 2016 at 8:07 PM, Chanwoo Choi <cw00.choi@samsung.com> w=
rote:
> Hi Cai,
>
> On 2016=EB=85=84 05=EC=9B=94 14=EC=9D=BC 15:28, Caizhiyong wrote:
>> From: Cai Zhiyong <caizhiyong@huawei.com>
>> Date: Sat, 14 May 2016 14:13:30 +0800
>> Subject: [PATCH] devfreq: fix double call put_device
>
> The patch description don't need to include the 'Date/Subject'.
> You need to delete them.
>
>>
>> 1295  */
>> 1296 void device_unregister(struct device *dev)
>> 1297 {
>> 1298         pr_debug("device: '%s': %s\n", dev_name(dev), __func__)=
;
>> 1299         device_del(dev);
>> 1300         put_device(dev);
>> 1301 }
>> 1302 EXPORT_SYMBOL_GPL(device_unregister);
>> 1303
>
> Also, you don't need to include the source code of device_unregister(=
)
> because below description explains the why this patch is needed.
>
>>
>> device_unregister is called put_device, there is no need to call
>> put_device(&devfreq->dev) again.
>>
>> Signed-off-by: Cai Zhiyong <caizhiyong@huawei.com>
>> ---
>>  drivers/devfreq/devfreq.c |    1 -
>>  1 file changed, 1 deletion(-)
>>
>> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
>> index 1d6c803..8de22c0 100644
>> --- a/drivers/devfreq/devfreq.c
>> +++ b/drivers/devfreq/devfreq.c
>> @@ -621,7 +621,6 @@ int devfreq_remove_device(struct devfreq *devfre=
q)
>>               return -EINVAL;
>>
>>       device_unregister(&devfreq->dev);
>> -     put_device(&devfreq->dev);
>>
>>       return 0;
>>  }
>>
>
> If you modify the patch description, Looks good to me.
>
> Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
>
> Thanks,
> Chanwoo Choi
