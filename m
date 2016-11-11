From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 1/3] cpufreq: schedutil: enable fast switch earlier
Date: Fri, 11 Nov 2016 22:52:27 +0100
Message-ID: <CAJZ5v0jem_tAOJM-zHyQ4kAmF+gmv85E3KnG9M1=1qi6vVQitA@mail.gmail.com>
References: <cover.1478858983.git.viresh.kumar@linaro.org> <1acfffe798c0371e69ec1171f485499e7b49ed6d.1478858983.git.viresh.kumar@linaro.org>
 <20161111141952.GJ3117@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qk0-f172.google.com ([209.85.220.172]:36237 "EHLO
        mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934979AbcKKVxK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 11 Nov 2016 16:53:10 -0500
In-Reply-To: <20161111141952.GJ3117@twins.programming.kicks-ass.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Rafael Wysocki <rjw@rjwysocki.net>, Ingo Molnar <mingo@redhat.com>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Juri Lelli <Juri.Lelli@arm.com>, Robin Randhawa <robin.randhawa@arm.com>

On Fri, Nov 11, 2016 at 3:19 PM, Peter Zijlstra <peterz@infradead.org> wrote:
> On Fri, Nov 11, 2016 at 03:52:21PM +0530, Viresh Kumar wrote:
>> @@ -456,8 +460,6 @@ static int sugov_init(struct cpufreq_policy *policy)
>>
>>   out:
>>       mutex_unlock(&global_tunables_lock);
>> -
>> -     cpufreq_enable_fast_switch(policy);
>>       return 0;
>>
>>   fail:
>> @@ -468,6 +470,10 @@ static int sugov_init(struct cpufreq_policy *policy)
>>       mutex_unlock(&global_tunables_lock);
>>
>>       sugov_policy_free(sg_policy);
>> +
>> + disable_fast_switch:
>> +     cpufreq_disable_fast_switch(policy);
>> +
>>       pr_err("initialization failed (error %d)\n", ret);
>>       return ret;
>>  }
>
> Argh, no indented labels please. Please fix the 3 that snuck in while
> you're there.

Well, you didn't tell me you didn't like them. :-)

Anyway, I can fix this up easily enough.

Any other concerns regarding the patch?

Thanks,
Rafael
