From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 3/3] cpufreq: Remove unnecessary use of policy->shared_type
Date: Fri, 1 Feb 2013 13:03:25 +0530
Message-ID: <510B6FC5.8030309@ti.com>
References: <1bf82454ab1f16b13212548d7c9605067c8b7a0d.1359700705.git.viresh.kumar@linaro.org> <902bed453159832925df76e24806f3b919fdfc74.1359700706.git.viresh.kumar@linaro.org> <510B6510.6060608@ti.com> <CAKohponEsSrwLWbi4WJ19i8XkzEiL0De2ShLePBdygunmGEo5g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:50107 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752518Ab3BAHc0 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 1 Feb 2013 02:32:26 -0500
In-Reply-To: <CAKohponEsSrwLWbi4WJ19i8XkzEiL0De2ShLePBdygunmGEo5g@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: rjw@sisk.pl, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-dev@lists.linaro.org, robin.randhawa@arm.com, Steve.Bannister@arm.com, Liviu.Dudau@arm.com, Linus Walleij <linus.walleij@linaro.org>, Stephen Warren <swarren@nvidia.com>, Shawn Guo <shawn.guo@linaro.org>

On Friday 01 February 2013 12:43 PM, Viresh Kumar wrote:
> On 1 February 2013 12:17, Santosh Shilimkar <santosh.shilimkar@ti.com> wrote:
>> I haven't looked at the cpufreq code recently but remember
>> that it was needed to ensure that all the CPU which
>> share clock/voltage gets updated (affected cpus) on
>> freq change. The CPUs which needs SW co-ordination, should
>> have this flag enabled and OMAP was falling in that category.
>
> Freq change are done by the target routines of platform cpufreq drivers
> and they do something like:
>
> 	for_each_cpu(freqs.cpu, policy->cpus)
> 		cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
>
> The only requirement from cpufreq core is to keep cpus sharing clock
> in policy->cpus.
>
I am not talking about just notifiers. This is for external users who
has subscribed for notifiers. The point is whether the core CPUFReq
gets updated without that flag for all affected CPU.

>> May be I miss-understood its use, but can you confirm that
>> SW co-ordination logic continues to work without this flag ?
>
> I believe it should work. It works for the systems i worked on:
>
> SPEAr13xx: Dual Cortex A9
> ARM TC2: two clusters of A15s and A7s.
>
I will give a try some time next week on OMAP.

Regards
Santosh
