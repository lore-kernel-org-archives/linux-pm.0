From: Saravana Kannan <skannan@codeaurora.org>
Subject: Re: [RFC PATCH 11/19] cpufreq: assert policy->rwsem is held in __cpufreq_governor
Date: Tue, 02 Feb 2016 13:37:21 -0800
Message-ID: <56B12191.8020407@codeaurora.org>
References: <1452533760-13787-1-git-send-email-juri.lelli@arm.com> <20160112102025.GC1084@ubuntu> <56AC04E3.8090900@codeaurora.org> <1703921.2AHaiQoggk@vostro.rjw.lan> <20160201060943.GH13476@vireshk> <CAJZ5v0gzKkoKsbv_KG0qL-7=j4a3DU-nOTCG71fZcoumQ0UZUw@mail.gmail.com> <56AFBEE5.70501@codeaurora.org> <20160202063449.GF31828@vireshk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:56259 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752063AbcBBVhY (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 2 Feb 2016 16:37:24 -0500
In-Reply-To: <20160202063449.GF31828@vireshk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Juri Lelli <juri.lelli@arm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Michael Turquette <mturquette@baylibre.com>, Steve Muckle <steve.muckle@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, dietmar.eggemann@arm.com

On 02/01/2016 10:34 PM, Viresh Kumar wrote:
> On 01-02-16, 12:24, Saravana Kannan wrote:
>> On 02/01/2016 02:22 AM, Rafael J. Wysocki wrote:
>> I'm not sure whose idea you are referring to. Viresh's (I don't think I saw
>> his proposal) or mine.
>
> http://git.linaro.org/people/viresh.kumar/linux.git/commit/57714d5b1778f2f610bcc5c74d85b29ba1cc1995
>
>> Anyway, to explain my suggestion better, I'm proposing to make it so that we
>> don't have a need for the AB BA locking. The only reason the governor needs
>> to even grab the sysfs lock is to add/remove the sysfs attribute files.
>>
>> That can be easily achieved if the policy struct has some "gov_attrs"
>> field(s) that each governor populates. Then the framework just has to create
>> them after POLICY_INIT is processed by the governor and remove them before
>> POILICY_EXIT is sent to the governor.
>
> What will that solve? It will stay exactly same then as well, as we
> would be adding/removing these attributes from within the same
> policy->rwsem ..

The problem isn't that you are holding the policy rwsem. The problem is 
that we are trying to grab the same locks in different order. This is 
trying to fix that.
>
>> That way, we also avoid having to worry about the gov attributes accessed by
>> the show/store disappearing while the files are being accessed.
>
> It can't happen. S_active lock should be taking care of that, isn't
> it?

You are right. That can't happen because we have the s_active lock. I 
meant to say that in general we don't have to worry about the races 
between a show/store needing some policy specific data within the 
governor to be valid but racing with governor change where it ends up 
being invalid. The releasing of the policy rwsem across POLICY_EXIT 
allows this to happen today.

-Saravana


-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
