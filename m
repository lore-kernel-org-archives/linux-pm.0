From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 1/2] ARM: zynq: cpuidle: Remove useless compatibility
 string
Date: Fri, 27 Sep 2013 10:35:14 +0200
Message-ID: <52454342.80706@linaro.org>
References: <1380269867-18336-1-git-send-email-daniel.lezcano@linaro.org> <31f13d14-2af7-4285-8770-3cc7ef7e7b09@AM1EHSMHS008.ehs.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:57817 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753268Ab3I0IfR (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 27 Sep 2013 04:35:17 -0400
Received: by mail-wi0-f171.google.com with SMTP id hm2so455087wib.16
        for <linux-pm@vger.kernel.org>; Fri, 27 Sep 2013 01:35:16 -0700 (PDT)
In-Reply-To: <31f13d14-2af7-4285-8770-3cc7ef7e7b09@AM1EHSMHS008.ehs.local>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Michal Simek <michal.simek@xilinx.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org

On 09/27/2013 10:19 AM, Michal Simek wrote:
> On 09/27/2013 10:17 AM, Daniel Lezcano wrote:
>> All zynq platforms have this compatibility string and there is no an=
y other
>> clone.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

The patchset is only compile-tested (I don't have the hardware).

Michal or someone else, if you have the time can you give it a try ?

Thanks in advance

   -- Daniel

>> ---
>>   drivers/cpuidle/cpuidle-zynq.c |    4 ----
>>   1 file changed, 4 deletions(-)
>>
>> diff --git a/drivers/cpuidle/cpuidle-zynq.c b/drivers/cpuidle/cpuidl=
e-zynq.c
>> index 38e03a1..ab6c4b4 100644
>> --- a/drivers/cpuidle/cpuidle-zynq.c
>> +++ b/drivers/cpuidle/cpuidle-zynq.c
>> @@ -28,7 +28,6 @@
>>   #include <linux/init.h>
>>   #include <linux/cpu_pm.h>
>>   #include <linux/cpuidle.h>
>> -#include <linux/of.h>
>>   #include <asm/proc-fns.h>
>>   #include <asm/cpuidle.h>
>>
>> @@ -72,9 +71,6 @@ static struct cpuidle_driver zynq_idle_driver =3D =
{
>>   /* Initialize CPU idle by registering the idle states */
>>   static int __init zynq_cpuidle_init(void)
>>   {
>> -	if (!of_machine_is_compatible("xlnx,zynq-7000"))
>> -		return -ENODEV;
>> -
>>   	pr_info("Xilinx Zynq CpuIdle Driver started\n");
>>
>>   	return cpuidle_register(&zynq_idle_driver, NULL);
>>
>
> Acked-by: Michal Simek <michal.simek@xilinx.com>
>
> Thx,
> M
>
>


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

