From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/3] cpufreq: schedutil: enable fast switch earlier
Date: Sat, 12 Nov 2016 10:49:41 +0530
Message-ID: <CAKohponvq3vuzNvaGE7_Pn8vM54AMPZu_E8yRyeytegh-bjuzQ@mail.gmail.com>
References: <cover.1478858983.git.viresh.kumar@linaro.org> <1acfffe798c0371e69ec1171f485499e7b49ed6d.1478858983.git.viresh.kumar@linaro.org>
 <CAJZ5v0gMDoLrdCqxnyUQqWydqj6Ot0ssf=P9=hOk_bOG9gCi0Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qk0-f170.google.com ([209.85.220.170]:35333 "EHLO
        mail-qk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751576AbcKLFTm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 12 Nov 2016 00:19:42 -0500
Received: by mail-qk0-f170.google.com with SMTP id n204so43255394qke.2
        for <linux-pm@vger.kernel.org>; Fri, 11 Nov 2016 21:19:42 -0800 (PST)
In-Reply-To: <CAJZ5v0gMDoLrdCqxnyUQqWydqj6Ot0ssf=P9=hOk_bOG9gCi0Q@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Juri Lelli <Juri.Lelli@arm.com>, Robin Randhawa <robin.randhawa@arm.com>

On 12 November 2016 at 03:28, Rafael J. Wysocki <rafael@kernel.org> wrote:

>> @@ -478,8 +484,6 @@ static void sugov_exit(struct cpufreq_policy *policy)
>>         struct sugov_tunables *tunables = sg_policy->tunables;
>>         unsigned int count;
>>
>> -       cpufreq_disable_fast_switch(policy);
>> -
>
> ->but why is this change necessary?
>
> sugov_stop() has been called already, so the ordering here shouldn't matter.

Because sugov_policy_free() would be using the flag fast_switch_enabled.

--
viresh
