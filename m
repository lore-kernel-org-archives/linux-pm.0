From: Saravana Kannan <skannan@codeaurora.org>
Subject: Re: [RFC PATCH 11/19] cpufreq: assert policy->rwsem is held in __cpufreq_governor
Date: Tue, 02 Feb 2016 21:06:19 -0800
Message-ID: <56B18ACB.5070704@codeaurora.org>
References: <20160112102025.GC1084@ubuntu> <56AC04E3.8090900@codeaurora.org> <1703921.2AHaiQoggk@vostro.rjw.lan> <20160201060943.GH13476@vireshk> <CAJZ5v0gzKkoKsbv_KG0qL-7=j4a3DU-nOTCG71fZcoumQ0UZUw@mail.gmail.com> <56AFBEE5.70501@codeaurora.org> <20160202063449.GF31828@vireshk> <56B12191.8020407@codeaurora.org> <20160203021359.GL31828@vireshk> <56B17C56.1030504@codeaurora.org> <20160203050256.GQ31828@vireshk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:45209 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750821AbcBCFGW (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 3 Feb 2016 00:06:22 -0500
In-Reply-To: <20160203050256.GQ31828@vireshk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Juri Lelli <juri.lelli@arm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Michael Turquette <mturquette@baylibre.com>, Steve Muckle <steve.muckle@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, dietmar.eggemann@arm.com

On 02/02/2016 09:02 PM, Viresh Kumar wrote:
> On 02-02-16, 20:04, Saravana Kannan wrote:
>> What's the s_active lock in CPU1 coming from?
>
> That's taken by sysfs core while removing the files.
>
>> The only reason it's there
>> today is because of the sysfs dir remove. If you move it before the
>> policy->rwsem, you won't have it after the policy->rwsem too. So, I think it
>> will fix the issue.
>
> Its complex and we will end up making ugly..

I disagree. I think it's way better and simpler than this patch set. It 
also doesn't tie into cpufreq_governor.* which is a good thing IMO since 
it keeps things simpler for sched-dvfs too.

> For example, EXIT can be called while switching governors. The
> policy->rwsem is taken at the beginning cpufreq_set_policy(). To
> decide if we should remove the governor sysfs directory so early (i.e.
> before taking rwsem) in the call, is going to be difficult.

Just check if the governor is changing. And if it is, you just need to 
remove the policy specific stuff.

> Over that the same directory might be shared across multiple policies,
> and all that information is present only with the governor-core.

That's why I said the gov needs to register the per pol and system wide 
attrs list separately.

This will also remove the need for ever governor to do this crap.

-Saravana

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
