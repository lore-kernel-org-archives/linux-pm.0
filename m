From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [RFC PATCH 11/19] cpufreq: assert policy->rwsem is held in __cpufreq_governor
Date: Mon, 1 Feb 2016 22:00:50 +0100
Message-ID: <CAJZ5v0iTZqk-Rokiq_C0bmwYEy+mPxZCGS6MarEPFp=A=wuchg@mail.gmail.com>
References: <1452533760-13787-1-git-send-email-juri.lelli@arm.com>
	<20160112102025.GC1084@ubuntu>
	<56AC04E3.8090900@codeaurora.org>
	<1703921.2AHaiQoggk@vostro.rjw.lan>
	<20160201060943.GH13476@vireshk>
	<CAJZ5v0gzKkoKsbv_KG0qL-7=j4a3DU-nOTCG71fZcoumQ0UZUw@mail.gmail.com>
	<56AFBEE5.70501@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f193.google.com ([209.85.217.193]:35155 "EHLO
	mail-lb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932096AbcBAVAw (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 1 Feb 2016 16:00:52 -0500
In-Reply-To: <56AFBEE5.70501@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Saravana Kannan <skannan@codeaurora.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Juri Lelli <juri.lelli@arm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Michael Turquette <mturquette@baylibre.com>, Steve Muckle <steve.muckle@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, dietmar.eggemann@arm.com

On Mon, Feb 1, 2016 at 9:24 PM, Saravana Kannan <skannan@codeaurora.org> wrote:
> On 02/01/2016 02:22 AM, Rafael J. Wysocki wrote:
>>
>> On Mon, Feb 1, 2016 at 7:09 AM, Viresh Kumar <viresh.kumar@linaro.org>
>> wrote:
>>>
>>> On 30-01-16, 12:49, Rafael J. Wysocki wrote:
>>>>
>>>> On Friday, January 29, 2016 04:33:39 PM Saravana Kannan wrote:
>>>>>
>>>>> AFAIR, the ABBA issue was between the sysfs lock and the policy lock.
>>>
>>>
>>> Yeah, to be precise here it is:
>>>
>>> CPU0 (sysfs read)               CPU1 (exit governor)
>>>
>>> sysfs-read                      set_policy()-> lock policy->rwsem
>>> sysfs-active lock               Remove sysfs files
>>> lock policy->rwsem              sysfs-active lock
>>> Actual read
>>>
>>>>> The fix for that issue should not be dropping the lock around
>>>>> POLICY_EXIT.
>>>>
>>>>
>>>> Right.  Dropping the lock is a mistake (which I overlooked, sadly).
>>>
>>>
>>> I joined the party at around time of 3.10, and we had this problem and
>>> hacky solution then as well. We tried to get rid of it multiple times,
>>> but sadly failed.
>>
>>
>> I kind of like your idea of accessing governor attributes without
>> holding the policy rwsem.
>
>
> I'm not sure whose idea you are referring to. Viresh's (I don't think I saw
> his proposal) or mine.

I meant a Viresh's idea that he discussed with Preeti Murthy a while
ago (or maybe just pointed her to a message where it was outlined, I
can't recall ATM).

>> I looked at that code and it seems doable to me.  The problem to solve
>> there would be to ensure that the dbs_data pointer is valid when
>> show/store runs for those attributes.
>>
>> The fact that we make the distinction between global and policy
>> governors in there doesn't really help, but it looks like getting rid
>> of that bit wouldn't be too much effort.  Let me take a deeper look at
>> that.
>>
>
> Anyway, to explain my suggestion better, I'm proposing to make it so that we
> don't have a need for the AB BA locking. The only reason the governor needs
> to even grab the sysfs lock is to add/remove the sysfs attribute files.

I'm not sure what you mean by "the sysfs lock" here?  The policy rwsem
or something else?

> That can be easily achieved if the policy struct has some "gov_attrs"
> field(s) that each governor populates. Then the framework just has to create
> them after POLICY_INIT is processed by the governor and remove them before
> POILICY_EXIT is sent to the governor.
>
> That way, we also avoid having to worry about the gov attributes accessed by
> the show/store disappearing while the files are being accessed. Since we
> remove those files before we even ask the gov to clean up, that situation
> can never happen.
>
> The current problem is that there is no good place for the governor to
> populate this "gov_attrs" field(s). Maybe the governor register might be one
> place for it to provide the data to the framework and the framework can
> later fill it up itself when switching governors.

Well, as I said, let me see what can be done to avoid holding the
policy rwsem around governor attributes access.

Thanks,
Rafael
