From: Lukasz Luba <l.luba@partner.samsung.com>
Subject: Re: [PATCH v3 0/7] drivers: devfreq: fix and optimize workqueue
 mechanism
Date: Wed, 13 Feb 2019 15:52:47 +0100
Message-ID: <3ad228a9-71af-2604-a8b4-8c49f1ca1038@partner.samsung.com>
References: <CGME20190212222422eucas1p1624203db4db3e495035820dea542e23a@eucas1p1.samsung.com>
        <1550010238-24002-1-git-send-email-l.luba@partner.samsung.com>
        <d9245497-ec63-4a5d-6c00-0ec2954af735@samsung.com>
        <80cd346e-a0a3-ff66-40a6-c15fd23ba904@partner.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <80cd346e-a0a3-ff66-40a6-c15fd23ba904@partner.samsung.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Chanwoo Choi <cw00.choi@samsung.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: b.zolnierkie@samsung.com, myungjoo.ham@samsung.com, kyungmin.park@samsung.com, m.szyprowski@samsung.com, s.nawrocki@samsung.com, joel@joelfernandes.org, chris.diamand@arm.com, mka@chromium.org, rostedt@goodmis.org, mingo@redhat.com
List-Id: linux-pm@vger.kernel.org

Hi Matthias, Chanwoo,

Regarding some measurements data for our approximations.

I have found a comprehensive power consumption measurements
for i.MX6 dual/quad (Cortex-A9) boards.
https://cache.freescale.com/files/32bit/doc/app_note/AN4509.pdf

The boards have DDR3 memories not LPDDR3 PoP but it is also measured
and mentioned explicitly.
There are many use case scenarios covered, which use different devices
in the SoC.

Regards,
Lukasz


On 2/13/19 12:14 PM, Lukasz Luba wrote:
> Hi Chanwoo,
> 
> On 2/13/19 1:18 AM, Chanwoo Choi wrote:
>> On 19. 2. 13. 오전 7:23, Lukasz Luba wrote:
>>> This patch set changes workqueue related features in devfreq framework.
>>> First patch switches to delayed work instead of deferred.
>>> The second switches to regular system work and deletes custom 'devfreq'.
>>>
>>> Using deferred work in this context might harm the system performance.
>>> When the CPU enters idle, deferred work is not fired. The devfreq 
>>> device's
>>> utilization does not have to be connected with a particular CPU.
>>> The drivers for GPUs, Network on Chip, cache L3 rely on devfreq 
>>> governor.
>>> They all are missing opportunity to check the HW state and react when
>>> the deferred work is not fired.
>>> A corner test case, when Dynamic Memory Controller is utilized by 
>>> CPUs running
>>> on full speed, might show x5 worse performance if the crucial CPU is 
>>> in idle.
>>>
>>> There was a discussion regarding v2 that the power usage because of 
>>> waking up
>>
>> We have not yet finished the any discussion. We only just had a few reply
>> and you didn't wait for any reply from other. As I already commented
>> on exynos5422-dmc series, please don't send the next patch
>> without any final agreement.
>>
>> In this series, patch1/patch2 are same at version 2 patchset.
>> Even if we need to discuss more them, you just send same patches
>> without any agreement among reviewers. At least, you have to wait the 
>> reply
>> instead of just sending the new patchset. It is basic review rule on 
>> mailing list.
> I think you are blocking the fixes.
> Matthias is currently fixing devfreq governors which lack 'case SUSPEND'
> and he is interested in these v3. I have fixed a month ago issue with
> system suspend and OPP state of devfreq devices, which Tobias was rising
> and sending patches a few years ago, but you have blocked them.
> 
> These version is ready for comments regarding 'battery powered devices'.
> The v3 has introduced approach for 2 polling intervals similar to
> thermal framework.
> It also has trace events. The trace events are *really* important in
> this discussion because we need some measurements.
> 
> You said:
> 'When release the real mobile product like galaxy phone,
> it is very important issue to remove the unneeded wakeup on idle state.'
> Was it a real reason for profiling the devfreq framework and core
> workqueue mechanism? There are embedded devices which are not using
> battery and probably developers were not aware because there was no
> traces which could give any information about devfreq behavior.
> Power is important, performance is important but relaying on randomness
> is not the best solution. As I said earlier, your driver can stuck on
> highest OPP waiting for next callback which will not come...
> 
> Regards,
> Lukasz
>>
>>
>>> an idle CPU would be too high. In my opinion it won't and fixing bug 
>>> is more
>>> important than < 1% more power used [1].
>>> I have addressed also this issue. In this patch set there is a mechanism
>>> which prevents from to frequent checks when there is no need.
>>> When the device enters its lowest state (OPP) the framework sets polling
>>> interval to 'polling_idle_ms'. In default Kconfig it is 500ms, so 2 
>>> times per
>>> second.
>>> It is tunable from the sysfs interface per device, thus driver 
>>> developer can
>>> experiment and choose best intervals for the system.
>>>
>>> Changes:
>>> v3:
>>> - reordered first two patches
>>> - added functionality to lower power consumption when the device is 
>>> less busy;
>>>    there is a new polling interval enabled when device enters lowest 
>>> frequency;
>>> - added trace events to capture the behaviour of the system
>>> v2:
>>> - single patch split into two
>>> - added cover letter
>>>
>>> link for the previous version and discussion:
>>> https://marc.info/?l=linux-pm&m=154989907416072&w=2
>>> https://marc.info/?l=linux-pm&m=154904631226997&w=2
>>>
>>> Regards,
>>> Lukasz Luba
>>>
>>> [1] https://marc.info/?l=linux-kernel&m=155000641622443&w=2
>>>
>>> Lukasz Luba (7):
>>>    drivers: devfreq: change deferred work into delayed
>>>    drivers: devfreq: change devfreq workqueue mechanism
>>>    Kconfig: drivers: devfreq: add default idle polling
>>>    include: devfreq: add polling_idle_ms to 'profile'
>>>    drivers: devfreq: add longer polling interval in idle
>>>    trace: events: add devfreq trace event file
>>>    drivers: devfreq: add tracing for scheduling work
>>>
>>>   MAINTAINERS                               |   1 +
>>>   drivers/devfreq/Kconfig                   |  13 +++
>>>   drivers/devfreq/devfreq.c                 | 184 
>>> ++++++++++++++++++++++++------
>>>   drivers/devfreq/governor.h                |   3 +-
>>>   drivers/devfreq/governor_simpleondemand.c |   6 +-
>>>   include/linux/devfreq.h                   |   6 +
>>>   include/trace/events/devfreq.h            |  39 +++++++
>>>   7 files changed, 218 insertions(+), 34 deletions(-)
>>>   create mode 100644 include/trace/events/devfreq.h
>>>
>>
>>
