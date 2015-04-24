From: Rajendra Nayak <rnayak@codeaurora.org>
Subject: Re: [RFC/RFT 2/6] clk: qcom: Add runtime support to handle clocks
 using PM clocks
Date: Fri, 24 Apr 2015 16:28:15 +0530
Message-ID: <553A21C7.4060506@codeaurora.org>
References: <1429778744-13352-1-git-send-email-rnayak@codeaurora.org>	<1429778744-13352-3-git-send-email-rnayak@codeaurora.org> <CAPDyKFpVXWGeO_kbOvPbdy83aN6wxkC77ydH_2C3Bo=5QsspoA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFpVXWGeO_kbOvPbdy83aN6wxkC77ydH_2C3Bo=5QsspoA@mail.gmail.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org


On 04/24/2015 03:33 PM, Ulf Hansson wrote:
> On 23 April 2015 at 10:45, Rajendra Nayak <rnayak@codeaurora.org> wrote:
>> Add runtime PM support to handle (core and iface) clocks for devices
>> without a controllable power domain. Once the drivers for these devices
>> are converted to use runtime PM apis, all clock handling (for core and
>> iface) from these drivers can then be removed.
>>
>> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
>> ---
>>   drivers/clk/qcom/gdsc.c | 20 ++++++++++++++++++++
>>   1 file changed, 20 insertions(+)
>>
>> diff --git a/drivers/clk/qcom/gdsc.c b/drivers/clk/qcom/gdsc.c
>> index 480ebf6..92b0f6d 100644
>> --- a/drivers/clk/qcom/gdsc.c
>> +++ b/drivers/clk/qcom/gdsc.c
>> @@ -15,6 +15,7 @@
>>   #include <linux/err.h>
>>   #include <linux/jiffies.h>
>>   #include <linux/pm_clock.h>
>> +#include <linux/platform_device.h>
>>   #include <linux/slab.h>
>>   #include "gdsc.h"
>>
>> @@ -226,3 +227,22 @@ void gdsc_unregister(struct device *dev)
>>   {
>>          of_genpd_del_provider(dev->of_node);
>>   }
>> +
>> +static struct dev_pm_domain default_qcom_pm_domain = {
>> +       .ops = {
>> +               USE_PM_CLK_RUNTIME_OPS
>> +               USE_PLATFORM_PM_SLEEP_OPS
>> +       },
>> +};
>> +
>> +static struct pm_clk_notifier_block qcom_pm_notifier = {
>> +       .pm_domain      = &default_qcom_pm_domain,
>> +       .con_ids        = { "core", "iface" },
>> +};
>> +
>> +static int __init qcom_pm_runtime_init(void)
>> +{
>> +       pm_clk_add_notifier(&platform_bus_type, &qcom_pm_notifier);
>> +       return 0;
>> +}
>> +core_initcall(qcom_pm_runtime_init);
>
> First, I don't follow how this code is related to GDSC.

Actually its not. I should probably move it to a pm_runtime.c someplace
in drivers/soc/qcom maybe.

>
> Second, I want to see less users of pm_clk_add_notifier() since it's
> not the proper/long-term way of how to assign PM domain pointers to a
> device. Instead that shall be done at device registration point. In
> your case while parsing the DT nodes and adding devices onto to their
> buses.

but these are devices which do not really have a controllable power
domain, they just have controllable clocks.

>
> Yes, I understand that it will requires quite some work to adopt to
> this behaviour - but that how it shall be done.
>
> Finally, an important note, you don't need to use PM domains for these
> devices at all and thus you don't need to fix what I propose. Instead
> you only have to implement the runtime PM callbacks for each driver
> and manage the clocks from there. That is probably also a easier
> solution.

But that would mean I repeat the same code in all drivers to do a
clk_get/prepare/enable/disable/unprepare of the same "core" and "iface"
clocks. I thought we have clock_ops.c just to avoid that (atleast up
until we have a better way of doing it)
And there are atleast a few architecture which have used it to avoid the
duplication across all drivers (omap1/davinci/sh/keystone)
