From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: intel_pstate: Lower p-state when putting down CPU
Date: Thu, 13 Mar 2014 12:56:02 +0800
Message-ID: <CAKohponCJH4E0WUeqkKAhni49Jp+k4HbmiPd2cBZL63pBY+r3g@mail.gmail.com>
References: <CAKQMxzQhVz0QT6tV0PKFjXXpYpDbtnOBH=miARoeQhrvs2TKFQ@mail.gmail.com>
	<5320D05F.7050304@gmail.com>
	<5320D12B.4040303@gmail.com>
	<16035918.jZXKnQ3yiq@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:55855 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751117AbaCME4D (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 13 Mar 2014 00:56:03 -0400
Received: by mail-ob0-f174.google.com with SMTP id wo20so518005obc.19
        for <linux-pm@vger.kernel.org>; Wed, 12 Mar 2014 21:56:02 -0700 (PDT)
In-Reply-To: <16035918.jZXKnQ3yiq@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Dirk Brandewie <dirk.brandewie@gmail.com>, Patrick Marlier <patrick.marlier@gmail.com>, "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, Linux PM list <linux-pm@vger.kernel.org>

On 13 March 2014 08:07, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Wednesday, March 12, 2014 02:27:07 PM Dirk Brandewie wrote:

>> > I see two possibilities:
>> >   1. Move the exit() callback to __cpufreq_remove_dev_prepare().  I don't
>> >      have a good understanding of what carnage this would cause in the core
>> >      or other scaling drivers.
>> >
>> >   2. Add another callback to the cpufreq_driver interface that would be call
>> >      from __cpufreq_remove_dev_prepare() if the callback was set.
>
> I prefer 2, the reason being that it pretty much is guaranteed not to break
> anything.  For the record, I'm not a fan of adding new cpufreq driver callbacks,
> but in this particular case it seems we can't really do anything better.

I haven't thought a lot about which one of these two looks better, probably
Rafael might be correct. But I can see another way out here as this is very
much driver specific. Why can't we do a register_hotcpu_notifier() from
pstate driver alone?

And by that time I will think a bit more about it.
