From: Abhilash Kesavan <kesavan.abhilash@gmail.com>
Subject: Re: [PATCH] thermal: exynos: fix: Check if data->tmu_read callback is
 present before read
Date: Thu, 19 Feb 2015 17:53:16 +0530
Message-ID: <CAM4voamBf4p6KG0GT3=vc9TcDz_XhoaPMUsfgaMa0mLgdSdV8g@mail.gmail.com>
References: <1423228030-18708-1-git-send-email-l.majewski@samsung.com>
	<20150216105359.1b39fac8@amdc2363>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qc0-f179.google.com ([209.85.216.179]:65382 "EHLO
	mail-qc0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753091AbbBSMXQ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 19 Feb 2015 07:23:16 -0500
In-Reply-To: <20150216105359.1b39fac8@amdc2363>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lukasz Majewski <l.majewski@samsung.com>
Cc: Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>, Linux PM list <linux-pm@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Lukasz Majewski <l.majewski@majess.pl>, Chanwoo Choi <cw00.choi@samsung.com>

Hi Lukasz,

On Mon, Feb 16, 2015 at 3:23 PM, Lukasz Majewski <l.majewski@samsung.com> wrote:
> Hi Eduardo,
>
>> The exynos_tmu_data() function should on entrance test not only for
>> valid data pointer, but also for data->tmu_read one.
>> It is important, since afterwards it is dereferenced to get
>> temperature code.
>>
>> Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
>> ---
>>  drivers/thermal/samsung/exynos_tmu.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/thermal/samsung/exynos_tmu.c
>> b/drivers/thermal/samsung/exynos_tmu.c index 3a19353..a86e0495e 100644
>> --- a/drivers/thermal/samsung/exynos_tmu.c
>> +++ b/drivers/thermal/samsung/exynos_tmu.c
>> @@ -717,7 +717,7 @@ static int exynos_get_temp(void *p, long *temp)
>>  {
>>       struct exynos_tmu_data *data = p;
>>
>> -     if (!data)
>> +     if (!data || !data->tmu_read)
>>               return -EINVAL;
>>
>>       mutex_lock(&data->lock);
>
> This fix shall be added to v3.20.

Thanks for looking into this. This fixes the incorrect temperature at
boot-up I was seeing on Exynos7 and Exynos5420.

Tested-by: Abhilash Kesavan <a.kesavan@samsung.com>

Test HW: Peach-Pit (Exynos5420 based chromebook) and Exynos7 based
Espresso board.

Regards,
Abhilash
>
> --
> Best regards,
>
> Lukasz Majewski
>
> Samsung R&D Institute Poland (SRPOL) | Linux Platform Group
