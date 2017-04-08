From: =?UTF-8?Q?Giedrius_Statkevi=C4=8Dius?=
        <giedrius.statkevicius@gmail.com>
Subject: Re: [PATCH] power: supply: lp8788: prevent out of bounds array access
Date: Sat, 8 Apr 2017 13:55:24 +0300
Message-ID: <CABNMmsBFUoY99JOB-qPR7Dbxn6tOU5ZRcnQc8LqctEW3P=HwUw@mail.gmail.com>
References: <20170325160049.18943-1-giedrius.statkevicius@gmail.com> <84e9b377-30c6-d0f2-b869-6382d6c9f770@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-io0-f194.google.com ([209.85.223.194]:33951 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751447AbdDHKz0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 8 Apr 2017 06:55:26 -0400
In-Reply-To: <84e9b377-30c6-d0f2-b869-6382d6c9f770@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Kim, Milo" <milo.kim@ti.com>
Cc: sre@kernel.org, linux-pm@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>

Ping.

On Tue, Mar 28, 2017 at 2:23 AM, Kim, Milo <milo.kim@ti.com> wrote:
> On 3/26/2017 1:00 AM, Giedrius Statkevi=C4=8Dius wrote:
>>
>> val might become 7 in which case stime[7] (array of length 7) would be
>> accessed during the scnprintf call later and that will cause issues.
>> Obviously, string concatenation is not intended here so just a comma nee=
ds
>> to be added to fix the issue.
>>
>> Signed-off-by: Giedrius Statkevi=C4=8Dius <giedrius.statkevicius@gmail.c=
om>
>
>
> Acked-by: Milo Kim <milo.kim@ti.com>
>
>
>> ---
>>  drivers/power/supply/lp8788-charger.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/power/supply/lp8788-charger.c
>> b/drivers/power/supply/lp8788-charger.c
>> index 509e2b341bd6..677f7c40b25a 100644
>> --- a/drivers/power/supply/lp8788-charger.c
>> +++ b/drivers/power/supply/lp8788-charger.c
>> @@ -651,7 +651,7 @@ static ssize_t lp8788_show_eoc_time(struct device
>> *dev,
>>  {
>>         struct lp8788_charger *pchg =3D dev_get_drvdata(dev);
>>         char *stime[] =3D { "400ms", "5min", "10min", "15min",
>> -                       "20min", "25min", "30min" "No timeout" };
>> +                       "20min", "25min", "30min", "No timeout" };
>>         u8 val;
>>
>>         lp8788_read_byte(pchg->lp, LP8788_CHG_EOC, &val);
>>
>
