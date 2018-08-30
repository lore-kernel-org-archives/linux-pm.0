From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [RFD] Add debugfs for cpuidle ?
Date: Thu, 30 Aug 2018 10:24:53 +0200
Message-ID: <aafd9a8a-9007-fca4-6ef8-a72920513d5c@linaro.org>
References: <516d8599-8038-7b47-a3f5-640bf13856c2@linaro.org>
 <2682482.uFPN0cxrGI@aspire.rjw.lan>
 <bcdbf067-4213-18ed-6d30-dc0dd2376c02@linaro.org>
 <CAPDyKFrOoJam38Nc05DTo09HbY964bGaw+27GuikYuEz3o=UWw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFrOoJam38Nc05DTo09HbY964bGaw+27GuikYuEz3o=UWw@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM mailing list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 30/08/2018 10:22, Ulf Hansson wrote:
> On 24 May 2018 at 10:47, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>> On 24/05/2018 10:28, Rafael J. Wysocki wrote:
>>> On Thursday, May 24, 2018 10:14:31 AM CEST Daniel Lezcano wrote:
>>>>
>>>> Hi all,
>>>
>>> Hi,
>>>
>>>> would it be interesting to add debugfs metrics for cpuidle in order
>>>> to read some statistics from there and investigate the behavior ?
>>>
>>> What exactly would you like to see in there?
>>
>> It could be interesting to have statistics on a per cpu and global basis
>> for:
>>
>> - prediction accuracy:
>>
>> /sys/kernel/debug/cpuidle/prediction/[good|over|under]
>> /sys/kernel/debug/cpuidle/cpu*/state*/prediction/[good|over|under]
>>
>>  - exit latency
>>
>> In addition, it is often the case the idle states values are dropped
>> randomly, it is interesting to see the average exit latency for the
>> states. That could give also an indication the cluster idle state success.
>>
>> /sys/kernel/debug/cpuidle/state*/latency/[min|max|avg|stddev]
>> /sys/kernel/debug/cpuidle/cpu*/state*/prediction/[min|max|avg|stddev]
>>
>> And perhaps more information like the tick stopped stat ?
>>
> 
> Daniel,
> 
> Any chance that you have some draft version of actual code implementing this?
> 
> I would be very interested to try then - or help out to implement
> this, in case you haven't started yet.

Yes, I have a draft version, a bit incomplete but easy to fill. I'm just
not fully convinced about the metrics we need yet.


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
