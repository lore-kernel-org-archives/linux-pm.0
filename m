From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V7 2/6] cpufreq: Stop migrating sysfs files on hotplug
Date: Wed, 10 Jun 2015 07:49:12 +0530
Message-ID: <20150610021912.GA26105@linux>
References: <cover.1433767914.git.viresh.kumar@linaro.org>
 <6922a02c439f353c7c2bc3f09f7eae6dfbc3ea25.1433767914.git.viresh.kumar@linaro.org>
 <557782C5.2030305@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f178.google.com ([209.85.192.178]:35699 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752671AbbFJCTR (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 9 Jun 2015 22:19:17 -0400
Received: by pdbnf5 with SMTP id nf5so26772966pdb.2
        for <linux-pm@vger.kernel.org>; Tue, 09 Jun 2015 19:19:17 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <557782C5.2030305@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Saravana Kannan <skannan@codeaurora.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, sboyd@codeaurora.org, prarit@redhat.com, Srivatsa Bhat <srivatsa@mit.edu>

On 09-06-15, 17:20, Saravana Kannan wrote:
> >[ Something similar attempted by Saravana earlier ]
> Full name and email would be nice.

Sure. @Rafael can you please hand edit this in case I am not required
to resend the patch ?

[ Something similar attempted by Saravana Kannan <skannan@codeaurora.org> earlier ]

> >+static void update_policy_cpu(struct cpufreq_policy *policy, unsigned int cpu)
> >  {
> >-	int ret;
> >-
> >  	if (WARN_ON(cpu == policy->cpu))
> Can you remind me again why this is a warning? Would we still need
> this check?

Its removed in a later commit. Its a warning because we are updating
policy->cpu here and that must have been done only if policy->cpu !=
cpu.

> >+	bool recover_policy = !sif;
> The policy is always going to be there, so calling it
> "recover_policy" is kinda confusing. But I can't suggest a better
> name now.

Not always. Its created as well sometimes :)

> >
> >  	pr_debug("adding CPU %u\n", cpu);
> >
> >+	/*
> >+	 * Only possible if 'cpu' wasn't physically present earlier and we are
> >+	 * here from subsys_interface add callback. A hotplug notifier will
> >+	 * follow and we will handle it like logical CPU hotplug then. For now,
> >+	 * just create the sysfs link.
> >+	 */
> >+	if (cpu_is_offline(cpu)) {
> My changes were on an older code base, so things might have changed
> by now. But at this location, there was definitely a case where I
> had to check for "sif" before creating symlinks. I need to think a

cpu will be offline here only for sif==true.

> bit more to remember what that reason was and see if you have to do
> it too.
> 
> I'll try to respond more later. But I just wanted to send out what I
> could when I have little time to review this.

Okay. Good to see you again.

-- 
viresh
