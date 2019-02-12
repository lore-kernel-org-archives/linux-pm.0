From: Lukasz Luba <l.luba@partner.samsung.com>
Subject: Re: [PATCH v2 0/2] drivers: devfreq: fix and optimize workqueue
 mechanism
Date: Tue, 12 Feb 2019 13:05:33 +0100
Message-ID: <f60efa88-cf43-faed-55be-f90ce8f44f9e@partner.samsung.com>
References: <CGME20190211153030eucas1p19bd9a7eca565ca066ab00dc2243cfb46@eucas1p1.samsung.com>
        <1549899005-7760-1-git-send-email-l.luba@partner.samsung.com>
        <26e38213-630f-94bc-ff80-1cad708c7f83@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <26e38213-630f-94bc-ff80-1cad708c7f83@samsung.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Chanwoo Choi <cw00.choi@samsung.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: b.zolnierkie@samsung.com, myungjoo.ham@samsung.com, kyungmin.park@samsung.com, m.szyprowski@samsung.com, s.nawrocki@samsung.com, joel@joelfernandes.org, chris.diamand@arm.com, mka@chromium.org
List-Id: linux-pm@vger.kernel.org

Hi Chanwoo

On 2/12/19 6:46 AM, Chanwoo Choi wrote:
> Hi Lukasz,
> 
> On 19. 2. 12. 오전 12:30, Lukasz Luba wrote:
>> This patch set changes workqueue related features in devfreq framework.
>> First patch switches to delayed work instead of deferred.
>> The second switches to regular system work and deletes custom 'devfreq'.
>>
>> Using deferred work in this context might harm the system performance.
>> When the CPU enters idle, deferred work is not fired. The devfreq device's
>> utilization does not have to be connected with a particular CPU.
>> The drivers for GPUs, Network on Chip, cache L3 rely on devfreq governor.
>> They all are missing opportunity to check the HW state and react when
>> the deferred work is not fired.
>> A corner test case, when Dynamic Memory Controller is utilized by CPUs running
>> on full speed, might show x5 worse performance if the crucial CPU is in idle.
> 
> The devfreq framework keeps the balancing between performance
> and power-consumption. It is wrong to focus on only either
> performance or power.
IMO it just does not work, please see my explanation below.
> 
> This cover-letter focus on the only performance without any power-consumption
> disadvantages. It is easy to raise the performance with short sampling rate
> with polling modes. To get the performance, it is good as short as possible
> of period.
The cover-letter mentioned about missing functionality. The interface
has 'polling_ms' field, which driver developer would assume works.
I have test cases where it would not be called for seconds or even
never.
In your driver drivers/devfreq/exynos-bus.c polling_ms = 50
The driver is controlling many devices including Network-on-Chip (NOC).
It is using 'simple_ondemand' governor. When it is missing opportunity
to change the frequency, it can either harm the performance or power
consumption, depending of the frequency the device stuck on.

> 
> Sometimes, when cpu is idle, the device might require the busy state.
> It is very difficult to catch the always right timing between them.
I will try to address them in the next patch set.
> 
> Also, this patch cannot prevent the unneeded wakeup from idle state.
> Apparently, it only focuses on performance without considering
> the power-consumption disadvantage. In the embedded device,
> the power-consumption is very important point. We can not ignore
> the side effect.
Power consumption is important, but we cannot rely on randomness
when we develop core features in a framework.
> 
> Always, I hope to improve the devfreq framwork more that older.
> But, frankly, it is difficult to agree because it only consider
> the performance without considering the side-effect.
> 
> The power management framework always have to consider
> the power-consumption issue. This point is always true.
I do agree that the power vs. performance trade-off must be considered
in the devfreq framework. I have developed 2 additional patches and
I am going to post them today (you can now check them on Tizen gerrit,
change 198160).

We cannot simply pin the *device* load with *CPU* load or idle state.
It is not an implication.
The device like GPU, NoC or Dynamic Memory Controller can have
completely different utilization (i.e in Exynos the GPU is connected
to DDR memory through NoC and DMC).
Some developers who use OpenCL on GPU might be interested in this
improvement.

Thank you for participating in the discussion on this issue.
It will need more development and iterations.
In my opinion currently there is one bug in the devfreq and one missing
feature to solve.

Regards,
Lukasz

> 
>>
>> Changes:
>> v2:
>> - single patch split into two
>> - added cover letter
>>
>> link for the previous version and discussion:
>> https://marc.info/?l=linux-pm&m=154904631226997&w=2
>>
>> Regards,
>> Lukasz Luba
>>
>> Lukasz Luba (2):
>>    drivers: devfreq: change devfreq workqueue mechanism
>>    drivers: devfreq: change deferred work into delayed
>>
>>   drivers/devfreq/devfreq.c | 27 +++++++--------------------
>>   1 file changed, 7 insertions(+), 20 deletions(-)
>>
> 
> 
