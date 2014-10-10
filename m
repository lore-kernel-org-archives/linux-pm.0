From: Prarit Bhargava <prarit@redhat.com>
Subject: Re: [PATCH 1/2] cpufreq: serialize calls to __cpufreq_governor()
Date: Fri, 10 Oct 2014 07:21:17 -0400
Message-ID: <5437C12D.1070803@redhat.com>
References: <CAKohpo=rEYgH+PSmkP8X8J0u69Kyp1W7JzBFOiOsiCOFSdyAiw@mail.gmail.com> <54353223.7080704@redhat.com> <CAKohpok+z+bPySa+Kzh2zW+2L8CCG29q6wANe3jd+o80+PnASA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:57829 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755172AbaJJLVb (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 10 Oct 2014 07:21:31 -0400
In-Reply-To: <CAKohpok+z+bPySa+Kzh2zW+2L8CCG29q6wANe3jd+o80+PnASA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: =?UTF-8?B?Um9iZXJ0IFNjaMO2bmU=?= <robert.schoene@tu-dresden.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Saravana Kannan <skannan@codeaurora.org>



On 10/10/2014 05:04 AM, Viresh Kumar wrote:
> On 8 October 2014 18:16, Prarit Bhargava <prarit@redhat.com> wrote:
>> On 10/08/2014 03:04 AM, Viresh Kumar wrote:
> 
>>> The last state of my branch: cpufreq/governor-fixes you tested had
>>> few bugs in it and so you weren't able to even tests things up.
>>>
>>> I couldn't manage to test my patches on a multi-cluster system
>>> (couldn't get it up yet :( ), but was able to do that on a dual-core
>>> ARM-cortexA15 board. And could simply find the bugs there.
>>>
>>> I have updated my branch with the changes now and it would be
>>> great if you can confirm if they fix your issues or not.
>>>
>>> git://git.linaro.org/people/viresh.kumar/linux.git cpufreq/governor-fixes
> 
> Robert/Prarit,
> 
> I thought you guys would test this very quickly as it had been hanging since
> long time. What happened ?
> 
>> Hey Viresh, this is on my plate for today.  It does look like the panic I sent
>> you yesterday in email does occur when your patches are put into the latest
>> upstream kernel :(.
> 
> I have tested my patches over mainline only, i.e. v3.17 .
> 
> Even the branch I mentioned above is based on that.
> 

Yep, I get that panic doing a very simple

#!/bin/bash

i=0
while [ True ]; do
        i=$((i+1))
        echo "ondemand" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor &
        echo "performance" > /sys/devices/system/cpu/cpu1/cpufreq/scaling_governor &
        echo "ondemand" > /sys/devices/system/cpu/cpu1/cpufreq/scaling_governor &
        echo "performance" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor &
        if [ $((i % 100)) = 0 ]; then
                echo $i
        fi
done

The blocking issue that I have (soon to be resolved I hope) is

http://marc.info/?l=linux-kernel&m=141286895623716&w=2

which is preventing me from doing any LOCKDEP analysis on this system.

I'm working on all of the above right now ...

P.
