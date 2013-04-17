From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: bltk-game regressions on snb laptop
Date: Wed, 17 Apr 2013 22:16:19 +0530
Message-ID: <CAKohponOVZgAxdX5yv9qmn_56mgTdXEBPr-7o7_pA5GRF09J0w@mail.gmail.com>
References: <516CFA57.3060709@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f178.google.com ([209.85.214.178]:60810 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752314Ab3DQQqU (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 17 Apr 2013 12:46:20 -0400
Received: by mail-ob0-f178.google.com with SMTP id ni5so1596553obc.23
        for <linux-pm@vger.kernel.org>; Wed, 17 Apr 2013 09:46:19 -0700 (PDT)
In-Reply-To: <516CFA57.3060709@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Alex Shi <alex.shi@intel.com>
Cc: Linux PM list <linux-pm@vger.kernel.org>, "Brown, Len" <len.brown@intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, Arjan van de Ven <arjan@linux.intel.com>, LKP ML <lkp@linux.intel.com>

On 16 April 2013 12:44, Alex Shi <alex.shi@intel.com> wrote:
> LKP found a performance and performance/watt regression on commit
> aa77a52764a92216b61, acpi-cpufreq: Don't set policy->related_cpus from
> .init.
>
> The commit removed the related_cpus setting, plus Our laptop has no
> coordinate type setting in BIOS. So the related_cpus is only include the
> cpu self, then the policy->cpus are impacted and only has self too.
>
> With ondemand governor, the bad commit cause bltk-game benchmark drop to
> 18fps from 50fps, the performance/watt value also dropped a lot.
> bltk-game runs 9 thread on the 4core*HT laptop.
>
> As Arjan and Len mentioned, the commit is correct in logical,
> policy->cpus should only include the cpu self.
> So I don't know where is the problem, maybe ondemand or some place
> others. Anyway, I just report the issue to you.

I really don't believe the commit you are pointing to should have any impact
on performance. Because before i changed definitions of affected and
related cpus, related_cpus was just not used at all (leaving some hotplug cases
to identify the last governor).. And so even if we set related_cpus from driver
earlier, it shouldn't be doing anything.

And now after it is being removed from acpi driver, i believe
situation should still
be the same.
