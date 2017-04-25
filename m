From: Lukasz Luba <lukasz.luba@arm.com>
Subject: Re: [PATCH V3 11/17] thermal: cpu_cooling: get rid of 'allowed_cpus'
Date: Tue, 25 Apr 2017 11:19:50 +0100
Message-ID: <8de3d4a9-a9dd-6116-267a-ce2493f1f44b@arm.com>
References: <cover.1492579345.git.viresh.kumar@linaro.org>
 <4da549d2565a75420633850b6963fe50b3f02bad.1492579345.git.viresh.kumar@linaro.org>
 <78b14ec9-e107-95dc-03b6-194b00834d6a@arm.com>
 <20170425045713.GU26900@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:39002 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1167803AbdDYKTx (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 25 Apr 2017 06:19:53 -0400
In-Reply-To: <20170425045713.GU26900@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Javi Merino <javi.merino@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Amit Daniel Kachhap <amit.kachhap@gmail.com>, linaro-kernel@lists.linaro.org, Rafael Wysocki <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Punit Agrawal <punit.agrawal@arm.com>

Hi Viresh,

I have run the newest version (6a883ddf73cd).
It looks correct (tests are passing so far).
Feel free to add
Tested-by: Lukasz Luba <lukasz.luba@arm.com>

I would like to go through the code before
it got merged, though.

If you are planing to post v4, I can test and review it
this week.

Regards,
Lukasz


On 25/04/17 05:57, Viresh Kumar wrote:
> On 24-04-17, 17:53, Lukasz Luba wrote:
>> The policy pointer forwarded from cpufreq_update_policy()
>> is a local variable 'new_policy' so cannot be compared with pinned
>> policy pointer in the cooling device.
>> You should do the cpumask test like before:
>> 	if (!cpumask_test_cpu(policy->cpu,
>> 			      cpufreq_cdev->policy->related_cpus))
>
> Right. I have fixed it a bit differently now.
>
>> But there is something still in the patch set...
>> I will try to check it tomorrow.
>
> I reviewed all the patches very carefully again, trying to find out the culprit
> (I don't have the right hardware to test it like you have).
>
> Found out that max_level isn't used properly at few places, fixed and pushed my
> branch now. See if it works fine now.
>
> HEAD: 6a883ddf73cd
>
