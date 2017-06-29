From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] cpufreq: Find transition latency dynamically
Date: Thu, 29 Jun 2017 22:34:22 +0200
Message-ID: <CAJZ5v0gOq-XPcXFfbycQkWzobBktoH5=eLxYAdh_G33fu8L1cg@mail.gmail.com>
References: <8041a965fcca71231576ae77a141b1e4333a81cc.1496402967.git.viresh.kumar@linaro.org>
 <20170629042836.GI29665@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-io0-f195.google.com ([209.85.223.195]:32865 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751661AbdF2UeX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 29 Jun 2017 16:34:23 -0400
In-Reply-To: <20170629042836.GI29665@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>

On Thu, Jun 29, 2017 at 6:28 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 02-06-17, 16:59, Viresh Kumar wrote:
>> The transition_latency_ns represents the maximum time it can take for
>> the hardware to switch from/to any frequency for a CPU.
>>
>> The transition_latency_ns is used currently for two purposes:
>>
>> o To check if the hardware latency is over the maximum allowed for a
>>   governor (only for ondemand and conservative (why not schedutil?)) and
>>   to decide if the governor can be used or not.
>>
>> o To calculate the sampling_rate or rate_limit for the governors by
>>   multiplying transition_latency_ns with a constant.
>>
>> The platform drivers can also set this value to CPUFREQ_ETERNAL if they
>> don't know this number and in that case we disallow use of ondemand and
>> conservative governors as the latency would be higher than the maximum
>> allowed for the governors.
>>
>> In many cases this number is forged by the driver authors to get the
>> default sampling rate to a desired value. Anyway, the actual latency
>> values can differ from what is received from the hardware designers.
>>
>> Over that, what is provided by the drivers is most likely the time it
>> takes to change frequency of the hardware, which doesn't account the
>> software overhead involved.
>>
>> In order to have guarantees about this number, this patch tries to
>> calculate the latency dynamically at cpufreq driver registration time by
>> first switching to min frequency, then to the max and finally back to
>> the initial frequency. And the maximum of all three is used as the
>> target_latency. Specifically the time it takes to go from min to max
>> frequency (when the software runs the slowest) should be good enough,
>> and even if there is a delta involved then it shouldn't be a lot.
>>
>> For now this patch limits this feature only for platforms which have set
>> the transition latency to CPUFREQ_ETERNAL. Maybe we can convert everyone
>> to use it in future, but lets see.
>>
>> This is tested over ARM64 Hikey platform which currently sets
>> "clock-latency" as 500 us from DT, while with this patch the actualy
>> value increased to 800 us.
>>
>> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
>> ---
>>  drivers/cpufreq/cpufreq.c | 63 +++++++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 63 insertions(+)
>
> Hi Rafael,
>
> Any inputs on this one ?

Shouldn't drivers do that really?

Thanks,
Rafael
