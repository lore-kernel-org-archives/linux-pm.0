From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [RFC PATCH] ARM: zynq: cpuidle: convert to platform driver
Date: Fri, 27 Sep 2013 09:21:52 +0200
Message-ID: <52453210.6090606@linaro.org>
References: <1380212138-4020-1-git-send-email-daniel.lezcano@linaro.org> <22edc518-27ad-4dcf-918a-def23df93bcc@DB9EHSMHS022.ehs.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wg0-f51.google.com ([74.125.82.51]:33193 "EHLO
	mail-wg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751176Ab3I0HVz (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 27 Sep 2013 03:21:55 -0400
Received: by mail-wg0-f51.google.com with SMTP id c11so2287500wgh.30
        for <linux-pm@vger.kernel.org>; Fri, 27 Sep 2013 00:21:54 -0700 (PDT)
In-Reply-To: <22edc518-27ad-4dcf-918a-def23df93bcc@DB9EHSMHS022.ehs.local>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Michal Simek <michal.simek@xilinx.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org

On 09/27/2013 07:12 AM, Michal Simek wrote:
> Hi Daniel,
>
> On 09/26/2013 06:15 PM, Daniel Lezcano wrote:
>> As the ux500 and the kirkwood driver, make the zynq driver a platfor=
m driver
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> ---
>>   arch/arm/mach-zynq/common.c    |    7 +++++++
>>   drivers/cpuidle/cpuidle-zynq.c |   15 ++++++++++-----
>>   2 files changed, 17 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/arm/mach-zynq/common.c b/arch/arm/mach-zynq/common=
=2Ec
>> index 5f25256..0f0d88f 100644
>> --- a/arch/arm/mach-zynq/common.c
>> +++ b/arch/arm/mach-zynq/common.c
>> @@ -44,6 +44,10 @@ static struct of_device_id zynq_of_bus_ids[] __in=
itdata =3D {
>>   	{}
>>   };
>>
>> +static struct platform_device zynq_cpuidle_device =3D {
>> +	.name =3D "cpuidle-zynq",
>> +};
>> +
>>   /**
>>    * zynq_init_machine - System specific initialization, intended to=
 be
>>    *		       called from board specific initialization.
>> @@ -56,6 +60,9 @@ static void __init zynq_init_machine(void)
>>   	l2x0_of_init(0x02060000, 0xF0F0FFFF);
>>
>>   	of_platform_bus_probe(NULL, zynq_of_bus_ids, NULL);
>> +
>> +	if (of_machine_is_compatible("xlnx,zynq-7000"))
>
> This is not needed because all zynq platforms have this compatibility=
 string
> and there is no any other clone.

Ah, ok. So it is not needed in the current code. I will write its=20
removal in a separate patch.

Thanks
   -- Daniel


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

