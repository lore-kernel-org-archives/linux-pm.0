From: Bhumika Goyal <bhumirks@gmail.com>
Subject: Re: [PATCH] thermal/intel_powerclamp: add const to
 thermal_cooling_device_ops structure
Date: Thu, 29 Jun 2017 10:41:29 +0530
Message-ID: <CAOH+1jGUxFVakQxBnr2Hm+8aY2fFTGLrJ2WEi8d-YHAmrFiZsw@mail.gmail.com>
References: <1498028988-12916-1-git-send-email-bhumirks@gmail.com> <1498705219.2510.4.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-io0-f196.google.com ([209.85.223.196]:33402 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751544AbdF2FLb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 29 Jun 2017 01:11:31 -0400
In-Reply-To: <1498705219.2510.4.camel@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Julia Lawall <julia.lawall@lip6.fr>, Eduardo Valentin <edubezval@gmail.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Jacob Pan <jacob.jun.pan@linux.intel.com>

On Thu, Jun 29, 2017 at 8:30 AM, Zhang Rui <rui.zhang@intel.com> wrote:
> On Wed, 2017-06-21 at 12:39 +0530, Bhumika Goyal wrote:
>> Declare thermal_cooling_device_ops structure as const as it is only
>> passed
>> as an argument to the function thermal_cooling_device_register and
>> this
>> argument is of type const. So, declare the structure as const.
>>
> I checked the source and the code is written in this way as well in
> some other drivers, why not fix them altogether?
>

Hey,

I have already sent the patches for the drivers requiring this change.
Some of them got applied as well.

Thanks,
Bhumika

> thanks,
> rui
>> Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
>> ---
>>  drivers/thermal/intel_powerclamp.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/thermal/intel_powerclamp.c
>> b/drivers/thermal/intel_powerclamp.c
>> index d718cd1..e4c68b7 100644
>> --- a/drivers/thermal/intel_powerclamp.c
>> +++ b/drivers/thermal/intel_powerclamp.c
>> @@ -659,7 +659,7 @@ static int powerclamp_set_cur_state(struct
>> thermal_cooling_device *cdev,
>>  }
>>
>>  /* bind to generic thermal layer as cooling device*/
>> -static struct thermal_cooling_device_ops powerclamp_cooling_ops = {
>> +static const struct thermal_cooling_device_ops
>> powerclamp_cooling_ops = {
>>       .get_max_state = powerclamp_get_max_state,
>>       .get_cur_state = powerclamp_get_cur_state,
>>       .set_cur_state = powerclamp_set_cur_state,
