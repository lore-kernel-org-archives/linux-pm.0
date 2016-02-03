From: Saravana Kannan <skannan@codeaurora.org>
Subject: Re: [RFC PATCH 11/19] cpufreq: assert policy->rwsem is held in __cpufreq_governor
Date: Tue, 02 Feb 2016 20:04:38 -0800
Message-ID: <56B17C56.1030504@codeaurora.org>
References: <1452533760-13787-1-git-send-email-juri.lelli@arm.com> <20160112102025.GC1084@ubuntu> <56AC04E3.8090900@codeaurora.org> <1703921.2AHaiQoggk@vostro.rjw.lan> <20160201060943.GH13476@vireshk> <CAJZ5v0gzKkoKsbv_KG0qL-7=j4a3DU-nOTCG71fZcoumQ0UZUw@mail.gmail.com> <56AFBEE5.70501@codeaurora.org> <20160202063449.GF31828@vireshk> <56B12191.8020407@codeaurora.org> <20160203021359.GL31828@vireshk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:43386 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755181AbcBCEEm (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 2 Feb 2016 23:04:42 -0500
In-Reply-To: <20160203021359.GL31828@vireshk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Juri Lelli <juri.lelli@arm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Michael Turquette <mturquette@baylibre.com>, Steve Muckle <steve.muckle@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, dietmar.eggemann@arm.com

On 02/02/2016 06:13 PM, Viresh Kumar wrote:
> On 02-02-16, 13:37, Saravana Kannan wrote:
>> On 02/01/2016 10:34 PM, Viresh Kumar wrote:
>>> What will that solve? It will stay exactly same then as well, as we
>>> would be adding/removing these attributes from within the same
>>> policy->rwsem ..
>>
>> The problem isn't that you are holding the policy rwsem. The problem is that
>> we are trying to grab the same locks in different order. This is trying to
>> fix that.
>
> That's exactly what I was trying to say, sorry for not being very
> clear.
>
> Even if you would move the sysfs file creation thing into the cpufreq
> core, instead of governor, we will have locks this way:
>
> CPU0                            CPU1
> (sysfs read)                    (sysfs dir remove)
> s_active lock                   policy->rwsem
> policy->rwsem
>                                  s_active lock (hang)
>
>
> And so I said, nothing will change.
>

What's the s_active lock in CPU1 coming from? The only reason it's there 
today is because of the sysfs dir remove. If you move it before the 
policy->rwsem, you won't have it after the policy->rwsem too. So, I 
think it will fix the issue.

-Saravana

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
