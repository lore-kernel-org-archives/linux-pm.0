From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 0/3] cpufreq: schedutil: Fix 4.12 regressions
Date: Fri, 9 Jun 2017 18:02:30 +0530
Message-ID: <CAKohpomto068ZMjxBpGS-LpA-PgPCye4K-XTjtAKq-ibs=qDZQ@mail.gmail.com>
References: <cover.1497002895.git.viresh.kumar@linaro.org> <CAJZ5v0iO0x-fEgUjuSTj9hiyeBJo9QeNOEBrQ6b_bUt8XxM1rg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ua0-f175.google.com ([209.85.217.175]:34658 "EHLO
        mail-ua0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751519AbdFIMcb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Jun 2017 08:32:31 -0400
Received: by mail-ua0-f175.google.com with SMTP id m31so32472508uam.1
        for <linux-pm@vger.kernel.org>; Fri, 09 Jun 2017 05:32:31 -0700 (PDT)
In-Reply-To: <CAJZ5v0iO0x-fEgUjuSTj9hiyeBJo9QeNOEBrQ6b_bUt8XxM1rg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Juri Lelli <Juri.Lelli@arm.com>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Patrick Bellasi <patrick.bellasi@arm.com>, John <john.ettedgui@gmail.com>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Joel Fernandes <joelaf@google.com>, Morten Rasmussen <morten.rasmussen@arm.com>

On 9 June 2017 at 17:54, Rafael J. Wysocki <rafael@kernel.org> wrote:
> Hi,
>
> On Fri, Jun 9, 2017 at 12:15 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>> Hi Rafael,
>>
>> I have identified some regressions with the schedutil governor which
>> happen due to one of your patches that got merged in 4.12-rc1.
>>
>> This series fixes all the drivers which provide a ->target_index()
>> callback but doesn't fix the drivers which provide ->target() callback.
>>
>> Such platforms need to implement the ->resolve_freq() callback in order
>> to get this fixed and I only had hardware for testing intel_pstate,
>> which I fixed in this series.
>>
>> I am wondering if there is another way to fix this issue (than what I
>> tried) or if we should revert the offending commit (39b64aa1c007) and
>> look for other solutions.
>
> To my eyes, patch [1/3] fixes the problem and then the remaining ones
> deal with the issues resulting from that.

So I saw the issue reported and fixed by 2/3 first and noticed 1/3 while
doing code reviews. So, 1/3 isn't the culprit really as the problem happens
without it as well.

--
viresh
