From: Anup Limbu <anuplimbu14@gmail.com>
Subject: Re: [PATCH] tools/thermal: tmon: cleanup function init_thermal_controller
Date: Mon, 30 Nov 2015 16:27:37 +0530
Message-ID: <CABYr-okNuXLcygWR5szmNgz8KowtQWuQampATqwgMNB8KL87_g@mail.gmail.com>
References: <1448625407-12791-1-git-send-email-anuplimbu14@gmail.com>
	<CANAwSgSd1G=x2zahEX1i8U-HRchyfR+4Zf46JKghFJp4Ee1KgQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yk0-f177.google.com ([209.85.160.177]:35224 "EHLO
	mail-yk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750983AbbK3K5i (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 30 Nov 2015 05:57:38 -0500
In-Reply-To: <CANAwSgSd1G=x2zahEX1i8U-HRchyfR+4Zf46JKghFJp4Ee1KgQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Anand Moon <linux.amoon@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, Florian Fainelli <f.fainelli@gmail.com>, Brian Norris <computersforpeace@gmail.com>, acme@redhat.com, olaf@aepfle.de, Arjun Sreedharan <arjun024@gmail.com>, linux-pm@vger.kernel.org, Linux-kernel@vger.kernel.org

 +Linux-kernel@vger.kernel.org +linux-pm@vger.kernel.org

On Sun, Nov 29, 2015 at 9:08 PM, Anand Moon <linux.amoon@gmail.com> wrote:
> Hi Anup,
>
> On 27 November 2015 at 17:26, Anup Limbu <anuplimbu14@gmail.com> wrote:
>> Replacing return type of function as void from int and removing
>> unused variable ret.
>>
>> Signed-off-by: Anup Limbu <anuplimbu14@gmail.com>
>> ---
>>  tools/thermal/tmon/pid.c  | 5 +----
>>  tools/thermal/tmon/tmon.h | 2 +-
>>  2 files changed, 2 insertions(+), 5 deletions(-)
>>
>> diff --git a/tools/thermal/tmon/pid.c b/tools/thermal/tmon/pid.c
>> index fd7e9e9..c034bf3 100644
>> --- a/tools/thermal/tmon/pid.c
>> +++ b/tools/thermal/tmon/pid.c
>> @@ -63,10 +63,8 @@ static double xk_1, xk_2; /* input temperature x[k-#] */
>>   *
>>   * add a flag for tuning PID
>>   */
>> -int init_thermal_controller(void)
>> +void init_thermal_controller(void)
>>  {
>> -       int ret = 0;
>> -
>>         /* init pid params */
>>         p_param.ts = ticktime;
>>         /* TODO: get it from TUI tuning tab */
>> @@ -76,7 +74,6 @@ int init_thermal_controller(void)
>>
>>         p_param.t_target = target_temp_user;
>>
>> -       return ret;
>>  }
>>
>>  void controller_reset(void)
>> diff --git a/tools/thermal/tmon/tmon.h b/tools/thermal/tmon/tmon.h
>> index 9e3c49c..016569d 100644
>> --- a/tools/thermal/tmon/tmon.h
>> +++ b/tools/thermal/tmon/tmon.h
>> @@ -139,7 +139,7 @@ struct pid_params {
>>         double y_k;
>>  };
>>
>> -extern int init_thermal_controller(void);
>> +extern void init_thermal_controller(void);
>>  extern void controller_handler(const double xk, double *yk);
>>
>>  extern struct tmon_platform_data ptdata;
>> --
>> 1.9.1
>>
>
> BTW, next time when sending a thermal related change, please cc
> linux-pm@vger.kernel.org, or else the change may got because we usually
> rely on https://patchwork.kernel.org/project/linux-pm/list/ to review
> and scrub the patches. :)
>
> ---Zhang Rui <rui.zhang@intel.com>
>
> Tested-by: Anand Moon <linux.amoon@gmail.com>
>
> -Anand Moon
