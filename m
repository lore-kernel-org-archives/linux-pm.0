From: skannan@codeaurora.org
Subject: Re: [PATCH 05/18] cpufreq: Manage governor usage history with
 'policy->last_governor'
Date: Thu, 12 Feb 2015 08:00:55 -0000
Message-ID: <a0d981c970a45d59bae727789a8b7834.squirrel@www.codeaurora.org>
References: <cover.1422346933.git.viresh.kumar@linaro.org>
    <bc7154266269beb8c6b9b3d56b529b64db33d2e2.1422346933.git.viresh.kumar@linaro.org>
    <54DC1806.9040001@codeaurora.org>
    <CAKohpomFvGXacyc-huavSyGxasrcKY19591OLMnAWY4hJHo9ow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:47339 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751617AbbBLIA4 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 12 Feb 2015 03:00:56 -0500
In-Reply-To: <CAKohpomFvGXacyc-huavSyGxasrcKY19591OLMnAWY4hJHo9ow@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Saravana Kannan <skannan@codeaurora.org>, Rafael Wysocki <rjw@rjwysocki.net>, Linaro Kernel Mailman List <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Stephen Boyd <sboyd@codeaurora.org>, Prarit Bhargava <prarit@redhat.com>


Viresh Kumar wrote:
> On 12 February 2015 at 11:03, Saravana Kannan <skannan@codeaurora.org>
> wrote:
>>> -       gov = find_governor(per_cpu(cpufreq_cpu_governor,
>>> policy->cpu));
>>> +       gov = find_governor(policy->last_governor);
>>
>> Just change this to:
>>
>> gov = policy->governor;
>>
>> No need to search for the governor again. It should already be valid for
>> policy that's being restored. For new policies, it would be NULL and
>> would
>> get defaulted correctly.
>
> No. Apart from the fact that one of my patches is making it NULL
> intentionally,
> here are the problems that I see with reusing the pointer:
> - All CPUs of a policy are down
> - The last used governor is removed (was built in as a module)
> - Now if we online the CPUs again, it wouldn't work as the pointer
> insn't usable.
> - Or if we insert the governor again, pointers would change and then
> onlining the
> CPUs wouldn't work..

I think for logical hotplug we should lock the governor from being
removed. Or, if you don't want that, go set the pointer to NULL lazily
when/if that happens.

>
>> 2. For physical hotplug of CPUs, the policies are getting freed (I
>> assume
>> and hope so). So, the "last_governor" field is going to be empty.
>
> Its not about it being empty. Its more about when we don't remove them
> physically..
>
>> 3. Even if we continue storing the last_governor outside of the policy,
>> for
>> physical hotplug of CPUs where the policy is getting recreated, I'm not
>> sure
>> restoring the governor is the right thing to do anyway. I'll explain
>> various
>> possible configurations below for the physical hotplug case:
>
> We do it today as this is part of the per-cpu stuff now and my patch would
> fix
> it then :)
>

I'm not sure if you read rest of my email. Unless you added some patches
recently, restoring the last_governor is definitely functionally broken as
of at least 3.12. Probably 3.14 too (I need to check again). It just
restores the governor with the default tunables. So, it's kinda useless in
the real world. You might as well set it to default governor because it's
just as helpful as using the last governor with different tunables.

-Saravana

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation

