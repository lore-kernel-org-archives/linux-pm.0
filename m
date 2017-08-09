From: Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v2 17/18] cpufreq: add support for CPU DVFS based on SCMI
 message protocol
Date: Wed, 9 Aug 2017 11:15:49 +0100
Message-ID: <d98703ce-7e66-4172-8d36-03c5200e3208@arm.com>
References: <1501857104-11279-1-git-send-email-sudeep.holla@arm.com>
 <1501857104-11279-18-git-send-email-sudeep.holla@arm.com>
 <20170809041840.GH28857@vireshk-i7>
 <97497123-2c24-6297-2d12-4f407d101b66@arm.com>
 <20170809100651.GA29383@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170809100651.GA29383@vireshk-i7>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>, ALKML <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, DTML <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Roy Franz <roy.franz-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>, Harb Abdulhamid <harba-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Loc Ho <lho-qTEPVZfXA3Y@public.gmane.org>, Alexey Klimov <alexey.klimov-5wv7dgnIgG8@public.gmane.org>, Ryan Harkin <Ryan.Harkin-5wv7dgnIgG8@public.gmane.org>, Jassi Brar <jassisinghbrar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org



On 09/08/17 11:06, Viresh Kumar wrote:
> On 09-08-17, 10:59, Sudeep Holla wrote:
>> On 09/08/17 05:18, Viresh Kumar wrote:
> 
>>> This stores the same handle pointer which is stored in the global variable
>>> below. Right? Why keep a local variable here at all ?
>>
>> Yes, you are right. Initially, started with just private pointers and
>> then added global. I was thinking of calling devm_scmi_handle_get per
>> policy to reflect the refcount correctly and drop global variable. Let
>> me know what you think.
> 
> A refcount of 1 should be fine as well, i.e. For the cpufreq driver. Why would
> SCMI care if we manage multiple policies here ? Unless it makes something within
> SCMI core better.
> 

Not really, just we can get rid of global pointer which may be need in
system with multiple scmi instances, but that's long way to go.

>>> This is something special which is used only when we are returning indexes and
>>> I am not sure if this will have benefit here. I will rather return 0 here.
>>> That's what other drivers are doing.
>>
>> Indeed had 0 initially but changed as per Juri's suggestion.
> 
> Maybe he suggested doing that in the fast switch routine ? As that's the normal
> protocol there. Though I have sent a patch today to propose using 0 there as
> well (you cc'd).
> 

Yes, saw that. I have changed both to 0 for now. I will watch that
thread and update if necessary before next posting.

>> But is 0
>> treated as failure and still running at current OPP ?
> 
> You have used that in the ->get() routine. So the OPP isn't changing, but we are
> just trying to fetch it. cpufreq core doesn't do a lot with the value returned
> from here, but at one place we break early if 0 is returned. And so all drivers
> are returning that.
>

Agreed, I assumed _INVALID is new thing and changed at both target_indes
and fast_switch.

>> and not 0KHz I assume.
> 
> Yeah, 0 KHz is dead CPU really :)
> 

:)

>>> I suppose any CPU can change the frequency of any other CPU here, right? You
>>> must set policy->dvfs_possible_from_any_cpu = true, from ->init() then.
>>>
>>
>> OK, I missed to see something like that exists, will do.
> 
> Fairly recent stuff, present in pm/linux-next only.
> 

Oh OK.

>>>> +	/*
>>>> +	 * But we need OPP table to function so if it is not there let's
>>>> +	 * give platform code chance to provide it for us.
>>>> +	 */
>>>
>>> How are we getting the OPPs? DT or non DT ?
>>>
>>
>> Non DT :), from the firmware.
> 
> I would improve the above comment in that case to clearly say that OPPs are
> added by the platform, lets wait for it.
> 

Done

-- 
Regards,
Sudeep
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
