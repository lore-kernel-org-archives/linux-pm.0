From: keita kobayashi <keita.kobayashi.ym@renesas.com>
Subject: Re: [RFC/PATCH 1/4] ARM: cpuidle: Add cpuidle support for R-Car Gen2
 series
Date: Tue, 7 Apr 2015 14:48:04 +0900
Message-ID: <55236F94.40909@renesas.com>
References: <1428292244-2160-1-git-send-email-keita.kobayashi.ym@renesas.com> <1428292244-2160-2-git-send-email-keita.kobayashi.ym@renesas.com> <20150407014407.GC27486@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from relmlor3.renesas.com ([210.160.252.173]:46371 "EHLO
	relmlie2.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750940AbbDGFsV (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 7 Apr 2015 01:48:21 -0400
In-Reply-To: <20150407014407.GC27486@verge.net.au>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Simon Horman <horms@verge.net.au>
Cc: rjw@rjwysocki.net, daniel.lezcano@linaro.org, linux-sh@vger.kernel.org, linux-pm@vger.kernel.org, magnus.damm@gmail.com

Hi Simon

Thank you for your feedback.

(2015/04/07 10:44), Simon Horman wrote:

> On Mon, Apr 06, 2015 at 12:50:41PM +0900, Keita Kobayashi wrote:
>> Define ARM_RCAR_CPUIDLE config item to enable cpuidle
>> support for Renesas R-Car Gen2 SoCs.
>>
>> Signed-off-by: Keita Kobayashi <keita.kobayashi.ym@renesas.com>
>> ---
>>  drivers/cpuidle/Kconfig.arm | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> diff --git a/drivers/cpuidle/Kconfig.arm b/drivers/cpuidle/Kconfig.arm
>> index 21340e0..ea9d61e 100644
>> --- a/drivers/cpuidle/Kconfig.arm
>> +++ b/drivers/cpuidle/Kconfig.arm
>> @@ -74,3 +74,11 @@ config ARM_MVEBU_V7_CPUIDLE
>>  	depends on ARCH_MVEBU && !ARM64
>>  	help
>>  	  Select this to enable cpuidle on Armada 370, 38x and XP processors.
>> +
>> +config ARM_RCAR_CPUIDLE
>> +	bool "CPU Idle Driver for the R-Car SoCs"
>> +	depends on ARCH_RCAR_GEN2
>> +	select ARM_CPUIDLE
>> +	select ARM_CPU_SUSPEND
>> +	help
>> +	  Select this to enable cpuidle for R-Car SoCs
> 
> I hate to be the harbinger of bad news but I don't believe this will
> reliably work because ARM_CPUIDLE selects DT_IDLE_STATES and I believe that
> Kconfig does not support recursive selection[1].
> 
> [1] http://lkml.iu.edu/hypermail/linux/kernel/1412.0/04004.html
> 
> I suggest changing select ARM_CPUIDLE to depends on ARM_CPUIDLE.
> I would be tempted to make the same change for ARM_CPU_SUSPEND too.

I will fix it with V2 patch.

Regards.
Keita Kobayashi
