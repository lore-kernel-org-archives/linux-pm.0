From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: mutex warning in cpufreq + RFC patch
Date: Thu, 29 Aug 2013 14:09:37 +0530
Message-ID: <CAKohpokyja6nGdkgNx82d0_ktKPP=tDthJ0VJBZGkfXnxGVLkQ@mail.gmail.com>
References: <20130828025721.GA19754@codeaurora.org>
	<CAKohpomLL0rCYngM81iaTV37TTsrYE+f3ouGuT2D6TRE5E4W5A@mail.gmail.com>
	<521E2ADE.4070401@codeaurora.org>
	<CAKohpoke5BHypqKcLjPK5eHHvvfRTjCz36FMQNT1OGTVnueRkw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oa0-f47.google.com ([209.85.219.47]:44241 "EHLO
	mail-oa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755888Ab3H2Iji (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 29 Aug 2013 04:39:38 -0400
Received: by mail-oa0-f47.google.com with SMTP id g12so157634oah.6
        for <linux-pm@vger.kernel.org>; Thu, 29 Aug 2013 01:39:38 -0700 (PDT)
In-Reply-To: <CAKohpoke5BHypqKcLjPK5eHHvvfRTjCz36FMQNT1OGTVnueRkw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: "Rafael J . Wysocki" <rjw@sisk.pl>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Kukjin Kim <kgene.kim@samsung.com>

On 29 August 2013 14:07, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 28 August 2013 22:22, Stephen Boyd <sboyd@codeaurora.org> wrote:
>> On 08/27/13 23:58, Viresh Kumar wrote:
>>> I haven't gone through the hack yet, but I am trying to understand the
>>> problem first.. There had been some work in the past around this
>>> kind of scenarios..
>>>
>>> commit 95731ebb114c5f0c028459388560fc2a72fe5049
>>> Author: Xiaoguang Chen <chenxg@marvell.com>
>>> Date:   Wed Jun 19 15:00:07 2013 +0800
>>>
>>>     cpufreq: Fix governor start/stop race condition
>>>
>>>
>>> The problem probably is poor error checking which is still present at
>>> few places, in __cpufreq_set_policy() routine..
>>>
>>> Can you try after fixing them? Something similar has to be done..
>>>
>>> commit 3de9bdeb28638e164d1f0eb38dd68e3f5d2ac95c
>>> Author: Viresh Kumar <viresh.kumar@linaro.org>
>>> Date:   Tue Aug 6 22:53:13 2013 +0530
>>>
>>>     cpufreq: improve error checking on return values of __cpufreq_governor()
>>
>> No the problem isn't poor error checking. The problem is between
>> gov_stop and gov_start userspace can come in and write scaling_min_freq
>> which will try to acquire the mutex (sorry the copy paste of the error
>> got messed up so I've repasted it).

I forgot to answer here :(

I would still say this could be a problem.. Suppose one thread tried to STOP
governor and stopped it.. Now other one came and tried to STOP it, it failed
but due to poor error checking, went ahead to next step.. and then they
got into issues..

I still see this as an potential issue in this case..
