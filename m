From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V2 08/20] cpufreq: Don't clear cpufreq_cpu_data and policy
 list for inactive policies
Date: Thu, 2 Apr 2015 10:41:59 +0530
Message-ID: <CAKohpomZTBrjUiJbtLayVPa_QQvg9mqonOaG_bWnQ-=Rmg2iOg@mail.gmail.com>
References: <cover.1424345053.git.viresh.kumar@linaro.org>
	<7bf6a7ce048290ec871c608883f9c9908adc5345.1424345053.git.viresh.kumar@linaro.org>
	<551CC23F.2030504@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f171.google.com ([209.85.214.171]:36258 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751023AbbDBFMA (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 2 Apr 2015 01:12:00 -0400
Received: by obbec2 with SMTP id ec2so112075474obb.3
        for <linux-pm@vger.kernel.org>; Wed, 01 Apr 2015 22:11:59 -0700 (PDT)
In-Reply-To: <551CC23F.2030504@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Saravana Kannan <skannan@codeaurora.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Linaro Kernel Mailman List <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Stephen Boyd <sboyd@codeaurora.org>, Prarit Bhargava <prarit@redhat.com>

On 2 April 2015 at 09:44, Saravana Kannan <skannan@codeaurora.org> wrote:
> When you say unmanaged CPUs, do you mean offline CPUs? If so, could you use
> that term instead? The term unmanaged is kinda ambiguous. This comment
> applies to the entire series.

Hmm, will take a note of that.

>> +               write_lock_irqsave(&cpufreq_driver_lock, flags);
>> +               for_each_cpu(j, policy->related_cpus)
>> +                       per_cpu(cpufreq_cpu_data, j) = policy;
>> +               write_unlock_irqrestore(&cpufreq_driver_lock, flags);
>> +       }
>
> Why not do this is cpufreq_policy_alloc() to be consistent/symmetric with
> cpufreq_policy_free()? You had to set cpufreq_cpu_data/add to the list this
> late in cpufreq_add_dev before because you shouldn't be adding a unfinished
> policy to the cpufreq_cpu_data/list. But now that you check for policy->cpus
> before returning it, you may be do all of this in cpufreq_policy_alloc()?

We don't know related_cpus until the time ->init() is called and that happens
after alloc()..

>> +               write_lock_irqsave(&cpufreq_driver_lock, flags);
>> +               list_add(&policy->policy_list, &cpufreq_policy_list);
>> +               write_unlock_irqrestore(&cpufreq_driver_lock, flags);
>> +       }
>
> You could probably do this as part of policy alloc too?

I wouldn't like to add a unfinished policy (which may or maynot be
simultaneously referred by other parts of code) to the list.
