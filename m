From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: Add sfi based cpufreq driver support
Date: Fri, 10 Oct 2014 16:41:29 +0530
Message-ID: <CAKohpon-RyY+QYSkv5oVKX2o=CdtTRDUraOxOpNbeOq7cWzjhQ@mail.gmail.com>
References: <20141008191454.GA6504@intel-desktop>
	<CAKohpom+Ey75QStm_xsVeC7arN_5a3+q_Nf8pvadTxNaLBKCEw@mail.gmail.com>
	<20141009180826.GA32265@intel-desktop>
	<CAKohpok9d4AK4qmERqtnGYBtZx=wnP5fdECOT6t1NFEGfAQ_2g@mail.gmail.com>
	<20141009190747.GA31674@intel-desktop>
	<CAKohponaW8i1as_w-cyrFoyY8PN7VwiRr=mE454Xhhe1C48mng@mail.gmail.com>
	<20141010165126.GA14463@intel-desktop>
	<CAKohponh_1zBPZ9PxNACUZ-3WzPnbkpQCwmCmiTDEwGEW5D=Rg@mail.gmail.com>
	<20141010171401.GA27359@intel-desktop>
	<CAKohpo=feG4cgKU265X6bVBXTbPX7sAvTbqj=Q1WNF=rehCKEg@mail.gmail.com>
	<20141010104756.GA11415@intel-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f42.google.com ([209.85.218.42]:65212 "EHLO
	mail-oi0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753783AbaJJLL3 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 10 Oct 2014 07:11:29 -0400
Received: by mail-oi0-f42.google.com with SMTP id a141so6249364oig.29
        for <linux-pm@vger.kernel.org>; Fri, 10 Oct 2014 04:11:29 -0700 (PDT)
In-Reply-To: <20141010104756.GA11415@intel-desktop>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Kasagar, Srinidhi" <srinidhi.kasagar@intel.com>
Cc: "Brandewie, Dirk J" <dirk.j.brandewie@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Rudramuni, Vishwesh M" <vishwesh.m.rudramuni@intel.com>

On 10 October 2014 16:17, Kasagar, Srinidhi <srinidhi.kasagar@intel.com> wrote:
> # cat /sys/devices/system/cpu/cpu*/cpufreq/affected_cpus
> 0 1
> 0 1
> 2 3
> 2 3
>
> # cat /sys/devices/system/cpu/cpu*/cpufreq/related_cpus
> 0 1
> 0 1
> 2 3
> 2 3
>
>>
>> And then also tell me which CPU are you trying to remove ?
>
> cpu1

So when to remove CPU1, you get a call for freq change for CPU0. Right ?

There are few things worth noticing here:
- Freq change is only requested for policy->cpu. In your case there will be two
policies present in system. For the first one policy->cpu will be 0,
for the second
one 2.
- So target_index() will always be called for 0 and 2. Unless
policy->cpu is changed
by hotplugging out policy->cpu, i.e. 0 or 2.
-  This whole thread started because you said target_index() is called
for policy->cur
frequency. So even if ->target_index() is called (which might happen
due to governor
requesting a new freq), it shouldn't be called for the same freq.

> BTW, I had to switch to my own tree to get the issue back (where
> I have my legacy custom cpufreq/core changes. So I suspect my changes
> not the upstream tree)

That's another side of the story :)
