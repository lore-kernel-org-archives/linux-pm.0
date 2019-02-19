From: Lukasz Luba <l.luba@partner.samsung.com>
Subject: Re: [PATCH v3 5/7] drivers: devfreq: add longer polling interval in
 idle
Date: Tue, 19 Feb 2019 09:33:46 +0100
Message-ID: <e5e9c6f0-5a1e-8ba1-556a-74edb1782980@partner.samsung.com>
References: <1550010238-24002-6-git-send-email-l.luba@partner.samsung.com>
        <1550010238-24002-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190212222436eucas1p21eebc80796406787a2ebf9a84ee5b868@epcms1p3>
        <20190218043311epcms1p33ccb2c312e871294025171d97bb87ac6@epcms1p3>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190218043311epcms1p33ccb2c312e871294025171d97bb87ac6@epcms1p3>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: myungjoo.ham@samsung.com, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, "tkjos@google.com" <tkjos@google.com>, "joel@joelfernandes.org" <joel@joelfernandes.org>, "chris.diamand@arm.com" <chris.diamand@arm.com>, "mka@chromium.org" <mka@chromium.org>, "rostedt@goodmis.org" <rostedt@goodmis.org>, "mingo@redhat.com" <mingo@redhat.com>
List-Id: linux-pm@vger.kernel.org

Hi MyungJoo,

Thank you for taking part in the discussion.
Please check my comments below.

On 2/18/19 5:33 AM, MyungJoo Ham wrote:
>> This patch adds new mechanism for devfreq devices which changes polling
>> interval. The system should sleep longer when the devfreq device is almost
>> not used. The devfreq framework will not schedule the work too often.
>> This low-load state is recognised when the device is operating at the lowest
>> frequency and has low busy_time/total_time factor (< 30%).
>> When the frequency is different then min, the device is under normal polling
>> which is the value defined in driver's 'polling_ms'.
>> When the device is getting more pressure, the framework is able to catch it
>> based on 'load' in lowest frequency and will start polling more frequently.
>> The second scenario is when the governor recognised heavy load at minimum
>> frequency and increases the frequency. The devfreq framework will start
>> polling in shorter intervals.
>> The polling interval, when the device is not heavily, can also be changed
>> from userspace of defined by the driver's author.
>>
>> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
>> ---
>>   drivers/devfreq/devfreq.c                 | 151 +++++++++++++++++++++++++++---
>>   drivers/devfreq/governor.h                |   3 +-
>>   drivers/devfreq/governor_simpleondemand.c |   6 +-
>>   3 files changed, 145 insertions(+), 15 deletions(-)
>>
> 
> There are some requirements that you need to consider:
> 
> Is 30% really applicable to ALL devfreq devices?
The 30% load while the device is on lowest OPP is to filter some noise.
It might be tunable over sysfs for each device if you like.
>      - What if some devices do not want such behaviors?
They can set polling_idle_ms and polling_ms the same value.
>      - What if some devices want different values (change behavors)?
Need of sysfs tunable here.
>      - What if some manufactures want different default values?
Like above (sysfs).
>      - What if some devices want to let the framework know that it's in idle?
There might be a filed in devfreq->state which could handle this.
>      - What if some other kernel context, device (drivers),
>      or userspace process want to notify that it's no more idling?This issue is more related to the new movement in the 'interconnect'
development. They have a goal for this kind of interactions and QoS
between devices or their clients. In devfreq it would be possible
to tackle this, but would require a lot of changes (notification chain,
state machines in devices,

> 
> As mentioned in the internal thread (tizen.org),
> I'm not convinced by the idea of assuming that a device can be considered "idling"
> if it has simply "low" utilization.
> 
> You are going to deteriorate the UI response time of mobile devices significantly.
Current devfreq wake-up also does not guarantee that, maybe on a single
CPU platform does.

I will try to address your and Chanwoo's comments that the devfreq still
needs deferred polling in some platforms.
Would it be OK if we have two options: deferred and delayed work while
registering a wakeup for a device?
That would be a function like: polling_mode_init(devfreq) instead of
simple INIT_DEFERRED_WORK(), which will check the device's preference.
The device driver could set a filed in 'polling_mode' to enum:
POWER_EFFICIENT or RELIABLE_INTERVAL. For compatibility with old drivers
where the polling_mode = 0, SYSTEM_DEFAULT_POLLING_MODE (which is one
of these two) would be used.
Then the two-phase-polling-interval from this patch could only be used
for the RELIABLE_INTERVAL configuration or even dropped.

Regards,
Lukasz
> 
> Cheers,
> MyungJoo.
> 
> 
