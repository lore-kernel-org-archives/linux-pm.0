From: Lina Iyer <lina.iyer@linaro.org>
Subject: Re: [PATCH RFC 13/27] ARM: cpuidle: Add runtime PM support for CPU
 idle
Date: Wed, 18 Nov 2015 07:17:49 -0700
Message-ID: <20151118141749.GA893@linaro.org>
References: <1447799871-56374-1-git-send-email-lina.iyer@linaro.org>
 <1447799871-56374-14-git-send-email-lina.iyer@linaro.org>
 <CAN2waFuepGZW8DdA3HqkddCH4oBo1Lpoyn7kQXh0wiKTj3xTXg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:36699 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755252AbbKRORx (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 18 Nov 2015 09:17:53 -0500
Received: by pacdm15 with SMTP id dm15so46322046pac.3
        for <linux-pm@vger.kernel.org>; Wed, 18 Nov 2015 06:17:52 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAN2waFuepGZW8DdA3HqkddCH4oBo1Lpoyn7kQXh0wiKTj3xTXg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhaoyang Huang <zhaoyang.huang@linaro.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@linaro.org>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, geert@linux-m68k.org, Krzysztof =?utf-8?Q?Koz=C5=82owski?= <k.kozlowski@samsung.com>, msivasub@codeaurora.org, Andy Gross <agross@codeaurora.org>, sboyd@codeaurora.org, linux-arm-msm@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Axel Haslam <ahaslam@baylibre.com>, Marc Titinger <mtitinger@baylibre.com>, Daniel Lezcano <daniel.lezcano@linaro.org>

On Wed, Nov 18 2015 at 01:50 -0700, Zhaoyang Huang wrote:
>On 18 November 2015 at 06:37, Lina Iyer <lina.iyer@linaro.org> wrote:
>> Notify runtime PM when the CPU is going to be powered off in the idle
>> state. This allows for runtime PM suspend/resume of the CPU as well as
>> its PM domain.
>>
>> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
>> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>> Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
>> ---
>>  drivers/cpuidle/cpuidle-arm.c | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> diff --git a/drivers/cpuidle/cpuidle-arm.c b/drivers/cpuidle/cpuidle-arm.c
>> index 545069d..8e72a23 100644
>> --- a/drivers/cpuidle/cpuidle-arm.c
>> +++ b/drivers/cpuidle/cpuidle-arm.c
>> @@ -11,13 +11,16 @@
>>
>>  #define pr_fmt(fmt) "CPUidle arm: " fmt
>>
>> +#include <linux/cpu.h>
>>  #include <linux/cpuidle.h>
>>  #include <linux/cpumask.h>
>>  #include <linux/cpu_pm.h>
>>  #include <linux/kernel.h>
>>  #include <linux/module.h>
>>  #include <linux/of.h>
>> +#include <linux/pm_runtime.h>
>>  #include <linux/slab.h>
>> +#include <linux/rcupdate.h>
>>
>>  #include <asm/cpuidle.h>
>>
>> @@ -45,6 +48,10 @@ static int arm_enter_idle_state(struct cpuidle_device *dev,
>>
>>         ret = cpu_pm_enter();
>>         if (!ret) {
>> +               struct device *cpu_dev = get_cpu_device(dev->cpu);
>> +
>> +               RCU_NONIDLE(pm_runtime_put_sync_suspend(cpu_dev));
>By my test, it seems that the usage_count of cpu device will be
>decrease to -1 and the code never runs here. If it need a runtime_put
>somewhere?

You shouldn't have to. Pls make sure all the patches are pulled in and
compiles successfully.

Let me know if you still run into issues.

Thanks,
Lina

>> +
>>                 /*
>>                  * Pass idle state index to cpu_suspend which in turn will
>>                  * call the CPU ops suspend protocol with idle index as a
>> @@ -52,6 +59,7 @@ static int arm_enter_idle_state(struct cpuidle_device *dev,
>>                  */
>>                 arm_cpuidle_suspend(idx);
>>
>> +               RCU_NONIDLE(pm_runtime_get_sync(cpu_dev));
>>                 cpu_pm_exit();
>>         }
>>
>> --
>> 2.1.4
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
