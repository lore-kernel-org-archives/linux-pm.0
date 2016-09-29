From: Larry Finger <Larry.Finger@lwfinger.net>
Subject: Re: Regression in 4.8 - CPU speed set very low
Date: Thu, 29 Sep 2016 10:09:24 -0500
Message-ID: <940c2e2f-24c8-b2aa-9c9c-e24f0eae1b77@lwfinger.net>
References: <f89dffb9-cc78-9849-9539-74ce89e773cd@lwfinger.net>
 <CAJZ5v0j3fJ7pDoR+LhY6x1T0yQEhq6omFL7-BrBcMy68eFiMMg@mail.gmail.com>
 <5271ed6f-5798-e930-d7fd-17fe6bb7ea96@lwfinger.net>
 <16590757.26uEfRfeet@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f51.google.com ([209.85.218.51]:35932 "EHLO
        mail-oi0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932897AbcI2PJ1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 29 Sep 2016 11:09:27 -0400
In-Reply-To: <16590757.26uEfRfeet@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Zhang Rui <rui.zhang@intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Doug Smythies <dsmythies@telus.net>, LKML <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>

On 09/29/2016 07:19 AM, Rafael J. Wysocki wrote:
> On Wednesday, September 28, 2016 09:22:59 PM Larry Finger wrote:
>> On 09/27/2016 06:46 AM, Rafael J. Wysocki wrote:
>>> On Tue, Sep 27, 2016 at 10:48 AM, Larry Finger
>>> <Larry.Finger@lwfinger.net> wrote:
>>>> On 09/26/2016 10:12 PM, Doug Smythies wrote:
>>>>>
>>>>> On 2016.09.26 18:31 Srinivas Pandruvada wrote:
>>>>>>
>>>>>> On Mon, 2016-09-26 at 19:48 -0500, Larry Finger wrote:
>>>>>>>
>>>>>>> On 09/26/2016 07:21 PM, Rafael J. Wysocki wrote:
>>>>>>>>
>>>>>>>> On Tue, Sep 27, 2016 at 1:53 AM, Larry Finger wrote:
>>>>>>>> But for both we need a reproducer anyway.
>>>>>>>
>>>>>>> I do not have a reliable reproducer. The condition has always
>>>>>>> happened when
>>>>>>> running a high-compute job such as a 'make -j8' on the kernel, or
>>>>>>> building the
>>>>>>> RPM for openSUSE's implementation of VirtualBox. The latter is what
>>>>>>> I'm using
>>>>>>> for most of my testing.
>>>>>
>>>>>
>>>>> Run some CPU stressor and get all your CPU's going at 100% load.
>>>>> And watch your core temperatures while you do so.
>>>>
>>>>
>>>> for i in 1 2 3 4; do while : ; do : ; done & done
>>>>
>>>> triggered the fault in a few minutes.
>>>>>
>>>>>
>>>>>>
>>>>>>>> It also would be good to rule out the thermal throttling (as per
>>>>>>>> the Srinivas' comments).
>>>>>
>>>>>
>>>>> It is almost certainly thermal throttling, or similar causing
>>>>> Clock modulation, of it seems 50%.
>>>>
>>>>
>>>> While the infinite loops were running, the temps were:
>>>>
>>>> finger@linux-1t8h:~/rtlwifi_new> sensors
>>>> coretemp-isa-0000
>>>> Adapter: ISA adapter
>>>> Physical id 0:  +83.0°C  (high = +84.0°C, crit = +100.0°C)
>>>> Core 0:         +83.0°C  (high = +84.0°C, crit = +100.0°C)
>>>> Core 1:         +74.0°C  (high = +84.0°C, crit = +100.0°C)
>>>
>>> It looks like the trip point (high) temperature was exceeded causing
>>> thermal throttling to kick in.
>>>
>>>> After the fault occurs, I get
>>>>
>>>> finger@linux-1t8h:~/rtlwifi_new> sensors
>>>> coretemp-isa-0000
>>>> Adapter: ISA adapter
>>>> Physical id 0:  +44.0°C  (high = +84.0°C, crit = +100.0°C)
>>>> Core 0:         +43.0°C  (high = +84.0°C, crit = +100.0°C)
>>>> Core 1:         +41.0°C  (high = +84.0°C, crit = +100.0°C)
>>>
>>> So after that it stays at 400 MHz forever, right?
>>>
>>>>>>>>
>>>>>>>> For now, please tell me what's in
>>>>>>>> /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_min_freq
>>>>>>>
>>>>>>> 800000
>>>>>>
>>>>>> Your effective freq is lower than 800MHz. One of the possible reason is
>>>>>> thermal throttling.
>>>>>>
>>>>>> What distro you are using?
>>>>>
>>>>>
>>>>> And what make and model of LapTop?
>>>>
>>>>
>>>> Toshiba Tecra A50-A with CPU Model: 6.60.3 "Intel(R) Core(TM) i7-4600M CPU @
>>>> 2.90GHz. That is a dual-core unit with hyperthreading.
>>>>
>>>> @Rafael: As I write this, the system has been running the infinite loop test
>>>> for almost 5 hours with kernel 4.7. I will leave that running while I'm
>>>> gone, but I am certain that it is OK.
>>>
>>> OK, and what temperatures do you see while doing this?
>>
>> finger@linux-1t8h:~/linux-2.6> sensors
>> coretemp-isa-0000
>> Adapter: ISA adapter
>> Physical id 0:  +90.0°C  (high = +84.0°C, crit = +100.0°C)
>> Core 0:         +90.0°C  (high = +84.0°C, crit = +100.0°C)
>> Core 1:         +78.0°C  (high = +84.0°C, crit = +100.0°C)
>>
>> Once again, the CPU temp is greater than the "high" value; however, the clock
>> rate continues to hold near 3600 MHz.
>>
>> My laptop was inadvertently put to sleep while I was gone. I forgot to leave a
>> note for my wife and she quieted the noisy cpu fan. :)
>
> It looks like in 4.8-rc we made a change that caused the "high" trip point to
> be acted on.
>
> Srinivas, Rui, do you recall what that can be?
>
> One more question (I think I asked it previously): In the failing case
> (4.8-rc1 and later), when the frequency drops down to the 400 MHz, does it
> ever go back higher or is it stuck at that level forever?
>
> In any case, it may help to file a bug at bugzilla.kernel.org against
> CPU/thermal or similar and let me know the bug number.  We'll need to
> collect some tracepoint data to debug this and some place to put them
> into for easy reference.

Sorry if I missed that earlier question. The CPU is stuck at that lower 
frequency until I reboot.

Bug report at https://bugzilla.kernel.org/show_bug.cgi?id=173361. I tried to 
cover the main points of the discussion. Please add the ones that I missed.

Larry


