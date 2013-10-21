From: Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>
Subject: Re: [PATCH 5/5] ARM: vexpress/TC2: register vexpress-spc cpufreq
 device
Date: Mon, 21 Oct 2013 10:19:30 +0100
Message-ID: <5264F1A2.8040802@arm.com>
References: <1381931563-16785-1-git-send-email-Sudeep.KarkadaNagesha@arm.com> <1381931563-16785-6-git-send-email-Sudeep.KarkadaNagesha@arm.com> <alpine.LFD.2.03.1310181457010.1951@syhkavp.arg>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:35584 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753802Ab3JUJTN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 21 Oct 2013 05:19:13 -0400
In-Reply-To: <alpine.LFD.2.03.1310181457010.1951@syhkavp.arg>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Nicolas Pitre <nicolas.pitre@linaro.org>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Pawel Moll <Pawel.Moll@arm.com>, Viresh Kumar <viresh.kumar@linaro.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>

Hi Nico,

On 18/10/13 19:58, Nicolas Pitre wrote:
> On Wed, 16 Oct 2013, Sudeep KarkadaNagesha wrote:
> 
>> From: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
>>
>> This patch adds vexpress-spc platform device to enables the vexpress
>> SPC cpufreq interface driver.
>>
>> Signed-off-by: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
>> Cc: Pawel Moll <Pawel.Moll@arm.com>
>> Cc: Viresh Kumar <viresh.kumar@linaro.org>
>> ---
>>  arch/arm/mach-vexpress/spc.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/arch/arm/mach-vexpress/spc.c b/arch/arm/mach-vexpress/spc.c
>> index a8b8310..4ddfbfe 100644
>> --- a/arch/arm/mach-vexpress/spc.c
>> +++ b/arch/arm/mach-vexpress/spc.c
>> @@ -25,6 +25,7 @@
>>  #include <linux/interrupt.h>
>>  #include <linux/io.h>
>>  #include <linux/opp.h>
>> +#include <linux/platform_device.h>
>>  #include <linux/slab.h>
>>  #include <linux/semaphore.h>
>>  
>> @@ -532,6 +533,7 @@ static int __init ve_spc_clk_init(void)
>>  			pr_warn("failed to initialise cpu%d opp table\n", cpu);
>>  	}
>>  
>> +	platform_device_register_simple("vexpress-spc-cpufreq", -1, NULL, 0);
>>  	return 0;
>>  }
>>  module_init(ve_spc_clk_init);
> 
> OK... this solves my concern about initcall ordering.  Please just 
> disregard my suggestions on patch #3.  I'd suggest folding this patch 
> into patch 3/5 though.
>
Thanks for the review. All the comments provided in other patches are fixed.
Since this would not cause any ordering issue, do you still think it needs to be
folded in PATCH 3/5. One concern I have with that is we will be adding device
first and then the driver. Either I will have to reorder patch 3 and 4 after
folding this patch or leave it as it is now.

Regards,
Sudeep

