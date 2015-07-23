From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH V2] cpufreq: Fix double addition of sysfs links
Date: Thu, 23 Jul 2015 21:29:46 +0200
Message-ID: <CAJZ5v0jwZ7r_NG8yMW9kO6X4=P7ME9+gYES2d9yHsvV1ejWU3g@mail.gmail.com>
References: <20150718163149.GP7557@n2100.arm.linux.org.uk>
	<35d0bb6829c6c8a5fec7c55e45d9293946c0221b.1437566548.git.viresh.kumar@linaro.org>
	<20150722131539.GU7557@n2100.arm.linux.org.uk>
	<CAJZ5v0jGPHq0P90pTbWGSnydgCQ5TcSxQ-KFuRjZ=qT6gNp_cg@mail.gmail.com>
	<20150723060938.GD5322@linux>
	<CAJZ5v0g-f_80Cg2QV0_2vu5+PtOuvA60T7R5Vsxyf1vp9w-n1w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:38593 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752896AbbGWT3s (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 23 Jul 2015 15:29:48 -0400
In-Reply-To: <CAJZ5v0g-f_80Cg2QV0_2vu5+PtOuvA60T7R5Vsxyf1vp9w-n1w@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Rafael Wysocki <rjw@rjwysocki.net>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>

On Thu, Jul 23, 2015 at 7:22 PM, Rafael J. Wysocki <rafael@kernel.org> wrote:
> Hi Viresh,
>
> On Thu, Jul 23, 2015 at 8:09 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>> On 22-07-15, 18:42, Rafael J. Wysocki wrote:
>>> > 3. what happens when 'policy' is NULL at the point when the first (few) CPUs
>>> >    are added - how do the symlinks get created later if/when policy becomes
>>> >    non-NULL (can it?)
>>>
>>> Yes, it can, and we have a design issue here that bothers me a bit.
>>
>> I replied to Russell with a NO here as the first CPU should have
>> created the policy. BUT...
>>
>>> Namley, we need a driver's ->init callback to populate policy->cpus
>>> for us, but this is not the only thing it is doing, so the concern is
>>> that it may not be able to deal with CPUs that aren't online.
>>
>> ... the first few CPUs could have been offline and so we might not
>> have tried to add the policy at all.. Need to fix that for sure.
>
> Wait here.
>
> The current Linus' tree doesn't have that problem as far as I can say.
>
> Say cpufreq_interface->add_dev() is called for an offline CPU (say
> CPU2).  It points to cpufreq_add_dev(), so we see that the CPU is
> offline and call add_cpu_dev_symlink() for it.  But the first argument
> we pass to that is per_cpu(cpufreq_cpu_data, cpu) and that is NULL,
> because the policy is not there yet.  So we just return 0 (and the CPU
> has no policy and no link).
>
> Now say cpufreq_interface->add_dev() is called for an online CPU (say
> CPU3).  It goes and creates the policy for it and the driver's
> ->init() tells us that CPU2 is related to it.  So
> cpufreq_add_dev_interface() creates the link for CPU2 and we're fine.
>
> Now say CPU3 was offline too when cpufreq_interface->add_dev() was
> called for it.  We don't create a policy or a link for it.  Now say
> CPU2 becomes online.  cpufreq_cpu_callback() calls cpufreq_add_dev()
> for it and we land in the previous case.
>
> The *broken* case is when CPU2 is online to start with and it had
> created the link for CPU3, so when an offline CPU3 is now being added,
> we try to create the link for it again.  That is the case we need to
> address in -rc without introducing new problems.  The $subject patch
> adresses that issue, but it introduces the above problem.  On the
> other hand, my patch at https://patchwork.kernel.org/patch/6839151/
> should take care of this too (unless it is broken in a way I'm not
> seeing now).

It doesn't address the case when the CPU being removed is the policy owner.

Let me prepare a new version of it and we'll start over from there.

Thanks,
Rafael
