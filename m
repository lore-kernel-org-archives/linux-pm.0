From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 05/18] cpufreq: Manage governor usage history with 'policy->last_governor'
Date: Thu, 12 Feb 2015 15:44:13 +0800
Message-ID: <CAKohpomFvGXacyc-huavSyGxasrcKY19591OLMnAWY4hJHo9ow@mail.gmail.com>
References: <cover.1422346933.git.viresh.kumar@linaro.org>
	<bc7154266269beb8c6b9b3d56b529b64db33d2e2.1422346933.git.viresh.kumar@linaro.org>
	<54DC1806.9040001@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f42.google.com ([209.85.218.42]:40643 "EHLO
	mail-oi0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750902AbbBLHoO (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 12 Feb 2015 02:44:14 -0500
Received: by mail-oi0-f42.google.com with SMTP id h136so1851574oig.1
        for <linux-pm@vger.kernel.org>; Wed, 11 Feb 2015 23:44:13 -0800 (PST)
In-Reply-To: <54DC1806.9040001@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Saravana Kannan <skannan@codeaurora.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Linaro Kernel Mailman List <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Stephen Boyd <sboyd@codeaurora.org>, Prarit Bhargava <prarit@redhat.com>

On 12 February 2015 at 11:03, Saravana Kannan <skannan@codeaurora.org> wrote:
>> -       gov = find_governor(per_cpu(cpufreq_cpu_governor, policy->cpu));
>> +       gov = find_governor(policy->last_governor);
>
> Just change this to:
>
> gov = policy->governor;
>
> No need to search for the governor again. It should already be valid for
> policy that's being restored. For new policies, it would be NULL and would
> get defaulted correctly.

No. Apart from the fact that one of my patches is making it NULL intentionally,
here are the problems that I see with reusing the pointer:
- All CPUs of a policy are down
- The last used governor is removed (was built in as a module)
- Now if we online the CPUs again, it wouldn't work as the pointer
insn't usable.
- Or if we insert the governor again, pointers would change and then
onlining the
CPUs wouldn't work..

> 2. For physical hotplug of CPUs, the policies are getting freed (I assume
> and hope so). So, the "last_governor" field is going to be empty.

Its not about it being empty. Its more about when we don't remove them
physically..

> 3. Even if we continue storing the last_governor outside of the policy, for
> physical hotplug of CPUs where the policy is getting recreated, I'm not sure
> restoring the governor is the right thing to do anyway. I'll explain various
> possible configurations below for the physical hotplug case:

We do it today as this is part of the per-cpu stuff now and my patch would fix
it then :)
