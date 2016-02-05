From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 2/11] cpufreq: governor: Use common mutex for dbs_data protection
Date: Fri, 5 Feb 2016 04:15:13 +0100
Message-ID: <CAJZ5v0iHX0OO+dJRJvT=8Q7YixCK1bySCfUmYJrLJGfA-6XFdQ@mail.gmail.com>
References: <3705929.bslqXH980s@vostro.rjw.lan>
	<1529283.0IedZktI9q@vostro.rjw.lan>
	<20160204050954.GU3469@vireshk>
	<CAJZ5v0hWj4JgCh76Fg48ex3Svv7BUHR=9+RoA728R9aYU+12Pw@mail.gmail.com>
	<20160205025948.GE3068@vireshk>
	<CAJZ5v0iyJSuWkqrL8VuSbX8G5s2X+fYngQqi+eVrfVMkLrkmeA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f65.google.com ([209.85.215.65]:34169 "EHLO
	mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750722AbcBEDPP (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 4 Feb 2016 22:15:15 -0500
In-Reply-To: <CAJZ5v0iyJSuWkqrL8VuSbX8G5s2X+fYngQqi+eVrfVMkLrkmeA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Juri Lelli <juri.lelli@arm.com>, Steve Muckle <steve.muckle@linaro.org>, Saravana Kannan <skannan@codeaurora.org>

On Fri, Feb 5, 2016 at 4:06 AM, Rafael J. Wysocki <rafael@kernel.org> wrote:
> On Fri, Feb 5, 2016 at 3:59 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>> On 04-02-16, 17:46, Rafael J. Wysocki wrote:
>>> On Thu, Feb 4, 2016 at 6:09 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>>> > On 04-02-16, 00:16, Rafael J. Wysocki wrote:
>>> >> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>> >>
>>> >> Every governor relying on the common code in cpufreq_governor.c
>>> >> has to provide its own mutex in struct common_dbs_data.  However,
>>> >> those mutexes are never used at the same time
>>> >
>>> > Why do you think so? I thought they can always be used in parallel.
>>> >
>>> > Consider 2 or more policies, one can have ondemand as the governor,
>>> > whereas other one can have conservative.
>>> >
>>> > If CPUs go online/offline or if governors are switching in parallel,
>>> > then cpufreq_governor_dbs() can very much run in parallel for ondemand
>>> > and conservative.
>>> >
>>> > Or am I missing something here ?
>>>
>>> Well, so perhaps the changelog is inaccurate.
>>>
>>> However, what's wrong with using a single mutex then?
>>
>> You are killing the possibility of running the code faster. Consider
>> this:
>> - A 16 policy system with N CPUs in every policy (IBM has something
>>   similar only :) )..
>> - 4 policies using ondemand, 4 using conservative, 4 using powersave
>>   and 4 with performance.
>> - Now if we try to change governors for all of them in parallel, only
>>   one will be done at a time and others have to wait for this
>>   BIG-kernel lock.
>
> And why is this a big problem, actually?  Why do we want the switching
> of governors to be that efficient?

In any case, we're talking about having one lock instead of two, mind
you (out of the tree things don't count), because performance and
powersave don't even use the code in question.

I'm not really sure how much of a difference that would make on a
really big system.

Thanks,
Rafael
