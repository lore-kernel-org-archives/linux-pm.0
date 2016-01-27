From: Steve Muckle <steve.muckle@linaro.org>
Subject: Re: sched-freq locking
Date: Tue, 26 Jan 2016 17:54:13 -0800
Message-ID: <56A82345.8080709@linaro.org>
References: <56984C30.8040402@linaro.org> <5334719.Agh48cz3NL@vostro.rjw.lan>
 <20160121104958.GX8573@e106622-lin> <2223980.TtBr1NiYl7@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2223980.TtBr1NiYl7@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Juri Lelli <Juri.Lelli@arm.com>
Cc: Michael Turquette <mturquette@baylibre.com>, Vincent Guittot <vincent.guittot@linaro.org>, Patrick Bellasi <patrick.bellasi@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Viresh Kumar <viresh.kumar@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Javi Merino <Javi.Merino@arm.com>, Punit Agrawal <punit.agrawal@arm.com>
List-Id: linux-pm@vger.kernel.org

On 01/21/2016 05:21 PM, Rafael J. Wysocki wrote:
> On Thursday, January 21, 2016 10:49:58 AM Juri Lelli wrote:
>> [+Punit, Javi]
>>
>> Hi Rafael,
>>
>> On 21/01/16 02:46, Rafael J. Wysocki wrote:
>>> On Wednesday, January 20, 2016 05:39:14 PM Steve Muckle wrote:
>>>> On 01/20/2016 05:22 PM, Rafael J. Wysocki wrote:
>>>>> One comment here (which may be a bit off in which case please ignore it).
>>>>>
>>>>> You seem to be thinking that sched-freq needs to be a cpufreq governor
>>>>> and thus be handled in the same way as ondemand, for example.
>>>>
>>>> That's true, I hadn't really given much thought to the alternative you
>>>> mention below.
>>>>
>>>>>
>>>>> However, this doesn't have to be the case in principle.  For example,
>>>>> if we have a special driver callback specifically to work with sched-freq,
>>>>> it may just use that callback and bypass (almost) all of the usual
>>>>> cpufreq mechanics.  This way you may avoid worrying about the governor
>>>>> locking and related ugliness entirely.
>>>>
>>>> That sounds good but I'm worried about other consequences of taking
>>>> cpufreq out of the loop. For example wouldn't we need a new way for
>>>> something like thermal to set frequency limits?
>>>
>>> I don't know from the top of my head, but that's at least worth investigating.
>>>
>>
>> Yes, that's an interesting alternative that we have to think through.
>>
>>> Maybe we can keep the interface for those things unchanged, but handle it
>>> differently under the hood?
>>>
>>
>> Let me see if I understand what you are proposing :). If we don't want
>> to duplicate too many things, maybe it is still feasible to just use
>> existing cpufreq mechanics to handle hotplug, sysfs, thermal, etc. (with
>> possibly minor modifications to be notified of events) and only create a
>> new method to ask the driver for frequency changes, since we will have
>> replicated policy and freq_table information inside sched-freq.  Is that
>> what you were also thinking of by saying "bypass (almost) all the usual
>> cpufreq mechanics"? :)
> 
> Yes, it is.

I've been working on the locking in schedfreq (governor) and believe it
is now functionally correct. It'll get sent out in another RFC soon.

Having wrestled with that locking a bit I can appreciate the value of
potentially deprecating some or all of the cpufreq core. I'm also
fearful though of making the current task (creating a scheduler-based
CPU frequency scaling algorithm) more complex than it is already.

For that reason my preference would be to get the thing to a viable
state as a governor first, assuming that's possible, and then take on
restructuring to eliminate/deprecate unnecessary infrastructure. Does
this seem reasonable?

thanks,
Steve
