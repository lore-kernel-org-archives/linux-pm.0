From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V2 11/20] cpufreq: Manage governor usage history with 'policy->last_governor'
Date: Thu, 2 Apr 2015 10:56:46 +0530
Message-ID: <CAKohpo=wa+JChF+2MzqYUftmPP16WDrquU6B8++-PoLq9tmsjA@mail.gmail.com>
References: <cover.1424345053.git.viresh.kumar@linaro.org>
	<073c66088540954706ba5ffc0e4c2efa4759d197.1424345053.git.viresh.kumar@linaro.org>
	<551CC6C3.2000102@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f177.google.com ([209.85.214.177]:36658 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750973AbbDBF0r (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 2 Apr 2015 01:26:47 -0400
Received: by obbec2 with SMTP id ec2so112425762obb.3
        for <linux-pm@vger.kernel.org>; Wed, 01 Apr 2015 22:26:46 -0700 (PDT)
In-Reply-To: <551CC6C3.2000102@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Saravana Kannan <skannan@codeaurora.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Linaro Kernel Mailman List <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Stephen Boyd <sboyd@codeaurora.org>, Prarit Bhargava <prarit@redhat.com>

On 2 April 2015 at 10:04, Saravana Kannan <skannan@codeaurora.org> wrote:
> This governor restore code actually has bug -- at least in 3.12 (I think)
> but probably has a bug in this kernel too. So, this patch actually also
> fixes a bug.
>
> The bug has to do with restoring the wrong governor (as in, not the governor
> that was last picked by userspace) for a particular hot plug sequence.
>
> Assume one cluster has CPUs 2, 3.
> Assume default governor is performance.
> CPU2 is first brought online.
> Governor is changed to ondemand.
> CPU2 is taken offline.
> CPU3 is brought online.
> Governor gets set to performance.
> So, governor for the cluster is now not what was last picked by userspace.

Wasn't aware of that, you are right. Updated my logs for this.

>> -       for_each_present_cpu(cpu) {
>> -               if (cpu_online(cpu))
>> -                       continue;
>> -               if (!strcmp(per_cpu(cpufreq_cpu_governor, cpu),
>> governor->name))
>> -                       strcpy(per_cpu(cpufreq_cpu_governor, cpu), "\0");
>> +       /* clear last_governor for all inactive policies */
>> +       read_lock_irqsave(&cpufreq_driver_lock, flags);
>
>
> You are writing to a variable that's protected. This should be a write lock.

cpufreq_driver_lock isn't responsible for protecting policy fields, but
the list of policies. And so was a read lock here.

>> +       for_each_inactive_policy(policy, tpolicy) {
>> +               if (!strcmp(policy->last_governor, governor->name))
>> +                       strcpy(policy->last_governor, "\0");
>>         }
>> +       read_unlock_irqrestore(&cpufreq_driver_lock, flags);

And we don't need to take writelock to policy->rwsem here as the
policy is already inactive.

> Nack due to lock.

Just to clear the concepts, and not fighting with you :)

I don't think you used Nack correctly here. You have raised some
mistakes in the patch here, and its not that the patch and the idea
behind it is not acceptable.

So, probably Nack was a bit harsh :)
