From: Prarit Bhargava <prarit@redhat.com>
Subject: Re: [PATCH 1/2] cpufreq: serialize calls to __cpufreq_governor()
Date: Fri, 10 Oct 2014 07:38:29 -0400
Message-ID: <5437C535.3070707@redhat.com>
References: <CAKohpo=rEYgH+PSmkP8X8J0u69Kyp1W7JzBFOiOsiCOFSdyAiw@mail.gmail.com> <54353223.7080704@redhat.com> <CAKohpok+z+bPySa+Kzh2zW+2L8CCG29q6wANe3jd+o80+PnASA@mail.gmail.com> <5437C12D.1070803@redhat.com> <CAKohpokDG1_r7eJ5Yykea4orcuEicCUFCrnSo1uTgKW1iJGwRA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:58649 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751905AbaJJLim (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 10 Oct 2014 07:38:42 -0400
In-Reply-To: <CAKohpokDG1_r7eJ5Yykea4orcuEicCUFCrnSo1uTgKW1iJGwRA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: =?UTF-8?B?Um9iZXJ0IFNjaMO2bmU=?= <robert.schoene@tu-dresden.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Saravana Kannan <skannan@codeaurora.org>



On 10/10/2014 07:30 AM, Viresh Kumar wrote:
> On 10 October 2014 16:51, Prarit Bhargava <prarit@redhat.com> wrote:
>> Yep, I get that panic doing a very simple
>>
>> #!/bin/bash
>>
>> i=0
>> while [ True ]; do
>>         i=$((i+1))
>>         echo "ondemand" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor &
>>         echo "performance" > /sys/devices/system/cpu/cpu1/cpufreq/scaling_governor &
>>         echo "ondemand" > /sys/devices/system/cpu/cpu1/cpufreq/scaling_governor &
>>         echo "performance" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor &
>>         if [ $((i % 100)) = 0 ]; then
>>                 echo $i
>>         fi
>> done
>>
>> The blocking issue that I have (soon to be resolved I hope) is
>>
>> http://marc.info/?l=linux-kernel&m=141286895623716&w=2
>>
>> which is preventing me from doing any LOCKDEP analysis on this system.
>>
>> I'm working on all of the above right now ...
> 
> I have updated my patchset a bit now, the new branch is:
> cpufreq/governor-fixes-v2.
> But have you tried this on 3.17 without my patches?

Yes, I unfortunately have a different set of issues with vanilla 3.17
(previously mentioned locking issue).  I've done a quick and dirty hack to get
around that, and everything seems okay.

I apply your patches and I get a panic the first time I read sysfs

P.

> 
> --
> viresh
> 
