From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v5 20/20] cpufreq: scmi: add support for fast frequency
 switching
Date: Fri, 5 Jan 2018 10:45:50 +0000
Message-ID: <f9c3f16a-f33a-4d28-0893-3507af0732c4@arm.com>
References: <1514904162-11201-1-git-send-email-sudeep.holla@arm.com>
 <1514904162-11201-21-git-send-email-sudeep.holla@arm.com>
 <CALW4P++xNXWUYoAEjV2=zfj-ps+JSD3kkkKRAeED08UF3Gabfw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:43310 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750927AbeAEKp4 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 5 Jan 2018 05:45:56 -0500
In-Reply-To: <CALW4P++xNXWUYoAEjV2=zfj-ps+JSD3kkkKRAeED08UF3Gabfw@mail.gmail.com>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Alexey Klimov <klimov.linux@gmail.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>, ALKML <linux-arm-kernel@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, DTML <devicetree@vger.kernel.org>, Roy Franz <roy.franz@cavium.com>, Harb Abdulhamid <harba@codeaurora.org>, Nishanth Menon <nm@ti.com>, Arnd Bergmann <arnd@arndb.de>, Loc Ho <lho@apm.com>, Ryan Harkin <Ryan.Harkin@arm.com>, Jassi Brar <jassisinghbrar@gmail.com>, linux-pm@vger.kernel.org



On 04/01/18 22:10, Alexey Klimov wrote:
> Hi Sudeep,
> 
> On Tue, Jan 2, 2018 at 2:42 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:
>> The cpufreq core provides option for drivers to implement fast_switch
>> callback which is invoked for frequency switching from interrupt context.
>>
>> This patch adds support for fast_switch callback in SCMI cpufreq driver
>> by making use of polling based SCMI transfer. It also sets the flag
>> fast_switch_possible.
>>
>> Cc: linux-pm@vger.kernel.org
>> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
>> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
>> ---
>>  drivers/cpufreq/scmi-cpufreq.c | 15 +++++++++++++++
>>  1 file changed, 15 insertions(+)
>>
>> diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
>> index 0ee9335d0063..d0a82d7c6fd4 100644
>> --- a/drivers/cpufreq/scmi-cpufreq.c
>> +++ b/drivers/cpufreq/scmi-cpufreq.c
>> @@ -64,6 +64,19 @@ scmi_cpufreq_set_target(struct cpufreq_policy *policy, unsigned int index)
>>         return perf_ops->freq_set(handle, priv->domain_id, freq, false);
>>  }
>>
>> +static unsigned int scmi_cpufreq_fast_switch(struct cpufreq_policy *policy,
>> +                                            unsigned int target_freq)
>> +{
>> +       struct scmi_data *priv = policy->driver_data;
>> +       struct scmi_perf_ops *perf_ops = handle->perf_ops;
>> +
>> +       if (!perf_ops->freq_set(handle, priv->domain_id,
>> +                               target_freq * 1000, true))
>> +               return target_freq;
>> +
>> +       return 0;
>> +}
> 
> Could you please explain how it's supposed to work for purpose of fast
> frequency switching?
> 
> I am trying to track down ->freq_set.
> So it looks like this will fire an scmi perf level set command and
> will poll for this command to complete without asking for firmware to
> send command completion irq.
> 
> scmi_perf_level_set() will call the following functions:
> 
> scmi_one_xfer_init();
> scmi_do_xfer(handle, t);
> scmi_one_xfer_put(handle, t);
> 
> 
> The first function in the list calls scmi_one_xfer_get() which has
> this in the description (I guess because of down_timeout()):
> "This function can sleep depending on pending requests already in the system
> for the SCMI entity. Further, this also holds a spinlock to maintain
> integrity of internal data structures."
> 
> So it can sleep.
> 

Indeed, I can drop the whole semaphore story and expect the caller to
retry in case buffer is full which is very rare condition.

> As far as I see description of fast frequency switching it's required
> for fast_switch to not sleep:
> (file Documentation/cpu-freq/cpu-drivers.txt)
> 
> "This function is used for frequency switching from scheduler's context.
> Not all drivers are expected to implement it, as sleeping from within
> this callback isn't allowed. This callback must be highly optimized to
> do switching as fast as possible."
> 
> 
> The other questions to this implementation of fast switching:
> 
> 1) Fast switching callback must be highly optimized. Is it now? I see
> few spinlocks (in scmi mbox client and in the mailbox framework) there
> and polling functionality with udelay(5) inside that will timeout (if
> my calculations are correct) after 0.5 ms.

Do you have any alternate ideas to avoid that and still achieve fast
switching ?

> 2) Is it highly dependent on transport? If mailbox transport
> ->send_data() may sleep or hrtimer-based polling in mailbox framework
> will be used, then this fast switch won't work, right?
> 

Yes.

> I am still looking into that: I can be wrong and just trying to
> understand if it is all okay.
> 

Thanks for taking a look at this.

-- 
Regards,
Sudeep
