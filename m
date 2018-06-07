From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: Re: [RFC PATCH v3 03/10] PM: Introduce an Energy Model management
 framework
Date: Thu, 7 Jun 2018 17:58:09 +0200
Message-ID: <2802df66-8947-dc2c-a99f-cf872ddaeddb@arm.com>
References: <20180521142505.6522-1-quentin.perret@arm.com>
 <20180521142505.6522-4-quentin.perret@arm.com>
 <b47cb1f1-6ca1-7674-903f-724be43a57a0@arm.com>
 <20180606143739.GF10870@e108498-lin.cambridge.arm.com>
 <20180606152000.GB15894@localhost.localdomain>
 <20180606152950.GH10870@e108498-lin.cambridge.arm.com>
 <20180606162647.GI10870@e108498-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180606162647.GI10870@e108498-lin.cambridge.arm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Quentin Perret <quentin.perret@arm.com>, Juri Lelli <juri.lelli@redhat.com>
Cc: peterz@infradead.org, rjw@rjwysocki.net, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, mingo@redhat.com, morten.rasmussen@arm.com, chris.redpath@arm.com, patrick.bellasi@arm.com, valentin.schneider@arm.com, vincent.guittot@linaro.org, thara.gopinath@linaro.org, viresh.kumar@linaro.org, tkjos@google.com, joelaf@google.com, smuckle@google.com, adharmap@quicinc.com, skannan@quicinc.com, pkondeti@codeaurora.org, edubezval@gmail.com, srinivas.pandruvada@linux.intel.com, currojerez@riseup.net, javi.merino@kernel.org
List-Id: linux-pm@vger.kernel.org

On 06/06/2018 06:26 PM, Quentin Perret wrote:
> On Wednesday 06 Jun 2018 at 16:29:50 (+0100), Quentin Perret wrote:
>> On Wednesday 06 Jun 2018 at 17:20:00 (+0200), Juri Lelli wrote:
>>>>> This brings me to another question. Let's say there are multiple users of
>>>>> the Energy Model in the system. Shouldn't the units of frequency and power
>>>>> not standardized, maybe Mhz and mW?
>>>>> The task scheduler doesn't care since it is only interested in power diffs
>>>>> but other user might do.
>>>>
>>>> So the good thing about specifying units is that we can probably assume
>>>> ranges on the values. If the power is in mW, assuming that we're talking
>>>> about a single CPU, it'll probably fit in 16 bits. 65W/core should be
>>>> a reasonable upper-bound ?
>>>> But there are also vendors who might not be happy with disclosing absolute
>>>> values ... These are sometimes considered sensitive and only relative
>>>> numbers are discussed publicly. Now, you can also argue that we already
>>>> have units specified in IPA for ex, and that it doesn't really matter if
>>>> a driver "lies" about the real value, as long as the ratios are correct.
>>>> And I guess that anyone can do measurement on the hardware and get those
>>>> values anyway. So specifying a unit (mW) for the power is probably a
>>>> good idea.
>>>
>>> Mmm, I remember we fought quite a bit while getting capacity-dmpis-mhz
>>> binding accepted, and one of the musts was that the values were going to
>>> be normalized. So, normalized power values again maybe?
>>
>> Hmmm, that's a very good point ... There should be no problems on the
>> scheduler side -- we're only interested in correct ratios. But I'm not
>> sure on the thermal side ... I will double check that.
> 
> So, IPA needs to compare the power of the CPUs with the power of other
> things (e.g. GPUs). So we can't normalize the power of the CPUs without
> normalizing in the same scale the power of the other devices. I see two
> possibilities:
> 
> 1) we don't normalize the CPU power values, we specify them in mW, and
>     we document (and maybe throw a warning if we see an issue at runtime)
>     the max range of values. The max expected power for a single core
>     could be 65K for ex (16bits). And based on that we can verify
>     overflow and precision issues in the algorithms, and we keep it easy
>     to compare the CPU power numbers with other devices.

I would say we need 1). 32bit values with units and proper documentation 
of the possible ranges.

[...]
