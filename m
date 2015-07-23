From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH V2] cpufreq: Fix double addition of sysfs links
Date: Thu, 23 Jul 2015 19:22:17 +0200
Message-ID: <CAJZ5v0g-f_80Cg2QV0_2vu5+PtOuvA60T7R5Vsxyf1vp9w-n1w@mail.gmail.com>
References: <20150718163149.GP7557@n2100.arm.linux.org.uk>
	<35d0bb6829c6c8a5fec7c55e45d9293946c0221b.1437566548.git.viresh.kumar@linaro.org>
	<20150722131539.GU7557@n2100.arm.linux.org.uk>
	<CAJZ5v0jGPHq0P90pTbWGSnydgCQ5TcSxQ-KFuRjZ=qT6gNp_cg@mail.gmail.com>
	<20150723060938.GD5322@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:38580 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753746AbbGWRWT (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 23 Jul 2015 13:22:19 -0400
In-Reply-To: <20150723060938.GD5322@linux>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Rafael Wysocki <rjw@rjwysocki.net>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>

Hi Viresh,

On Thu, Jul 23, 2015 at 8:09 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 22-07-15, 18:42, Rafael J. Wysocki wrote:
>> > 3. what happens when 'policy' is NULL at the point when the first (few) CPUs
>> >    are added - how do the symlinks get created later if/when policy becomes
>> >    non-NULL (can it?)
>>
>> Yes, it can, and we have a design issue here that bothers me a bit.
>
> I replied to Russell with a NO here as the first CPU should have
> created the policy. BUT...
>
>> Namley, we need a driver's ->init callback to populate policy->cpus
>> for us, but this is not the only thing it is doing, so the concern is
>> that it may not be able to deal with CPUs that aren't online.
>
> ... the first few CPUs could have been offline and so we might not
> have tried to add the policy at all.. Need to fix that for sure.

Wait here.

The current Linus' tree doesn't have that problem as far as I can say.

Say cpufreq_interface->add_dev() is called for an offline CPU (say
CPU2).  It points to cpufreq_add_dev(), so we see that the CPU is
offline and call add_cpu_dev_symlink() for it.  But the first argument
we pass to that is per_cpu(cpufreq_cpu_data, cpu) and that is NULL,
because the policy is not there yet.  So we just return 0 (and the CPU
has no policy and no link).

Now say cpufreq_interface->add_dev() is called for an online CPU (say
CPU3).  It goes and creates the policy for it and the driver's
->init() tells us that CPU2 is related to it.  So
cpufreq_add_dev_interface() creates the link for CPU2 and we're fine.

Now say CPU3 was offline too when cpufreq_interface->add_dev() was
called for it.  We don't create a policy or a link for it.  Now say
CPU2 becomes online.  cpufreq_cpu_callback() calls cpufreq_add_dev()
for it and we land in the previous case.

The *broken* case is when CPU2 is online to start with and it had
created the link for CPU3, so when an offline CPU3 is now being added,
we try to create the link for it again.  That is the case we need to
address in -rc without introducing new problems.  The $subject patch
adresses that issue, but it introduces the above problem.  On the
other hand, my patch at https://patchwork.kernel.org/patch/6839151/
should take care of this too (unless it is broken in a way I'm not
seeing now).

>> I was thinking about an additional driver callback that would *only*
>> populate a mask of CPUs that should use the same policy as the given
>> one.
>
> Why so ? Drivers today are required to set policy->cpus with all CPUs
> that should be managed by that policy. i.e. all online+offline. So,
> actually ->init() fills policy->cpus with the value of
> policy->related_cpus.

So the problem is that the setting of policy->cpus is not the *only*
thing that ->init() is supposed to do.  It can go and write to
registers etc and is that guaranteed to work with offline CPUs?  I
honestly don't think so.

> Yes, I thought earlier to change that by setting policy->related_cpus
> from drivers, instead of policy->cpus and wasn't sure if I should do
> that :)
>
>> We'd be able to call that from cpufreq_add_dev() for offline
>> CPUs too and this way the policy object could be created for the first
>> CPU using the policy that is registered instead of being added for the
>> first CPU using that policy that becomes online (which happens today).
>
> Creating policy for offline CPUs doesn't look that great to me.

Then we have a problem that CPUs that are not initially online do not
have policies, but if they go online and *then* offline subsequently,
the policies will be there.  So there are two different "offline"
statuses for a CPU as far as cpufreq is concerned, depending on
whether or not the CPU has ever been online.  That's weird and IMO we
should avoid it.

> What we can do to fix the problem in hand, is to update a global mask
> of CPUs (with policy == NULL) which were offline when
> cpufreq_add_dev() was called for them. And when we create the policy,
> we can add links for all such CPUs.

For -rc, why don't we have a mask of CPUs that are both "related" and
present and create links only for those?  Which is what the patch at
https://patchwork.kernel.org/patch/6839151/ is doing?

And then we can target a major rework at the next merge window.

Thanks,
Rafael
