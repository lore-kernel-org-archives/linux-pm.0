From: Lukasz Luba <l.luba@partner.samsung.com>
Subject: Re: [PATCH v3 5/7] drivers: devfreq: add longer polling interval in
 idle
Date: Fri, 22 Feb 2019 17:03:02 +0100
Message-ID: <dbde3366-a115-3fe0-abb4-65ef0d8b760d@partner.samsung.com>
References: <e5e9c6f0-5a1e-8ba1-556a-74edb1782980@partner.samsung.com>
        <1550010238-24002-6-git-send-email-l.luba@partner.samsung.com>
        <1550010238-24002-1-git-send-email-l.luba@partner.samsung.com>
        <20190218043311epcms1p33ccb2c312e871294025171d97bb87ac6@epcms1p3>
        <CGME20190212222436eucas1p21eebc80796406787a2ebf9a84ee5b868@epcms1p7>
        <20190221055601epcms1p7b87bba9a878683453f7e46c84ed032b9@epcms1p7>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190221055601epcms1p7b87bba9a878683453f7e46c84ed032b9@epcms1p7>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: myungjoo.ham@samsung.com, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, "tkjos@google.com" <tkjos@google.com>, "joel@joelfernandes.org" <joel@joelfernandes.org>, "chris.diamand@arm.com" <chris.diamand@arm.com>, "mka@chromium.org" <mka@chromium.org>, "rostedt@goodmis.org" <rostedt@goodmis.org>, "mingo@redhat.com" <mingo@redhat.com>
List-Id: linux-pm@vger.kernel.org

Hi MyungJoo,

On 2/21/19 6:56 AM, MyungJoo Ham wrote:
>>>
>>> There are some requirements that you need to consider:
>>>
>>> Is 30% really applicable to ALL devfreq devices?
>> The 30% load while the device is on lowest OPP is to filter some noise.
>> It might be tunable over sysfs for each device if you like.
>>>       - What if some devices do not want such behaviors?
>> They can set polling_idle_ms and polling_ms the same value.
>>>       - What if some devices want different values (change behavors)?
>> Need of sysfs tunable here.
>>>       - What if some manufactures want different default values?
>> Like above (sysfs).
>>>       - What if some devices want to let the framework know that it's in idle?
>> There might be a filed in devfreq->state which could handle this.
>>>       - What if some other kernel context, device (drivers),
>>>       or userspace process want to notify that it's no more idling?This issue is more related to the new movement in the 'interconnect'
>> development. They have a goal for this kind of interactions and QoS
>> between devices or their clients. In devfreq it would be possible
>> to tackle this, but would require a lot of changes (notification chain,
>> state machines in devices,
>>
>>>
>>> As mentioned in the internal thread (tizen.org),
>>> I'm not convinced by the idea of assuming that a device can be considered "idling"
>>> if it has simply "low" utilization.
>>>
>>> You are going to deteriorate the UI response time of mobile devices significantly.
>> Current devfreq wake-up also does not guarantee that, maybe on a single
>> CPU platform does.
> 
> Yes, the current devfreq does not enhance UI response time in the sense
> that it would keep the same reponse time anyway.
> 
> However, your current approach will surely deteriorate it by lengthen
> the polling latency.
> 
> For mobile and wearable devices, in many cases I've been witnessing,
> the device idles right before the user's input (launching an app,
> scrolling messages or web pages, or press a play button).
> For mitigation, we often relay UI inputs to DVFS mechanisms so that
> we either increase frequency for any UI inputs for a short period or
> shorten the polling latency for a short period.
> When a highly user-interactive device is idling or operating a low frequency,
> we should assume that it's going to be highly performing anytime;
> loosening the checking period is not a good solution in that sense
> although it is probable for servers or workstations.
> But, I don't think servers/workstations do care power consumption of
> DVFS checking loops anyway.
It is not just mobiles or servers (I agree servers are not in scope).
Devices like TVs, set-top-boxes, IP cameras, car IVI, they might care
about DVFS, but they do not have batteries (maybe a big car battery...).
They probably have more than 1 CPU and have some accelerators, which
they might register devfreq devices.
> 
> 
> 
>>
>> I will try to address your and Chanwoo's comments that the devfreq still
>> needs deferred polling in some platforms.
>> Would it be OK if we have two options: deferred and delayed work while
>> registering a wakeup for a device?
>> That would be a function like: polling_mode_init(devfreq) instead of
>> simple INIT_DEFERRED_WORK(), which will check the device's preference.
>> The device driver could set a filed in 'polling_mode' to enum:
>> POWER_EFFICIENT or RELIABLE_INTERVAL. For compatibility with old drivers
>> where the polling_mode = 0, SYSTEM_DEFAULT_POLLING_MODE (which is one
>> of these two) would be used.
>> Then the two-phase-polling-interval from this patch could only be used
>> for the RELIABLE_INTERVAL configuration or even dropped.
> 
> One thing I want to add is: let's not over-complicate it.
> Do you have any experimental results on how much power is saved by doing this?
> (and user response time losses)
No I don't have such results. Maybe it is not even worth to add this
two-phase-polling because the polling using DELAYED does not increase
the power consumption too much. Like for the device mentioned above.

Simplest first step.
What would you say to add just the possibility of choosing between:
INIT_DEFERRED_WORK() and INIT_DELAYED_WORK() in runtime via sysfs?
There would be also Kconfig which sets default.
No additional code for different custom polling modes.

Regards,
Lukasz
> 
> 
> Cheers,
> MyungJoo
> 
> 
> 
