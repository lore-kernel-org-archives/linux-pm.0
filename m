From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 0/3] cpufreq: schedutil: Fix 4.12 regressions
Date: Fri, 9 Jun 2017 15:25:01 +0200
Message-ID: <CAJZ5v0g30Mu2h1q0w5pQdYUko2=zrZcnyaCDE2ho-4QEPWP5ZQ@mail.gmail.com>
References: <cover.1497002895.git.viresh.kumar@linaro.org> <CAJZ5v0iO0x-fEgUjuSTj9hiyeBJo9QeNOEBrQ6b_bUt8XxM1rg@mail.gmail.com>
 <CAKohpomto068ZMjxBpGS-LpA-PgPCye4K-XTjtAKq-ibs=qDZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-it0-f65.google.com ([209.85.214.65]:33806 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751545AbdFINZD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Jun 2017 09:25:03 -0400
In-Reply-To: <CAKohpomto068ZMjxBpGS-LpA-PgPCye4K-XTjtAKq-ibs=qDZQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Rafael Wysocki <rjw@rjwysocki.net>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Juri Lelli <Juri.Lelli@arm.com>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Patrick Bellasi <patrick.bellasi@arm.com>, John <john.ettedgui@gmail.com>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Joel Fernandes <joelaf@google.com>, Morten Rasmussen <morten.rasmussen@arm.com>

On Fri, Jun 9, 2017 at 2:32 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 9 June 2017 at 17:54, Rafael J. Wysocki <rafael@kernel.org> wrote:
>> Hi,
>>
>> On Fri, Jun 9, 2017 at 12:15 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>>> Hi Rafael,
>>>
>>> I have identified some regressions with the schedutil governor which
>>> happen due to one of your patches that got merged in 4.12-rc1.
>>>
>>> This series fixes all the drivers which provide a ->target_index()
>>> callback but doesn't fix the drivers which provide ->target() callback.
>>>
>>> Such platforms need to implement the ->resolve_freq() callback in order
>>> to get this fixed and I only had hardware for testing intel_pstate,
>>> which I fixed in this series.
>>>
>>> I am wondering if there is another way to fix this issue (than what I
>>> tried) or if we should revert the offending commit (39b64aa1c007) and
>>> look for other solutions.
>>
>> To my eyes, patch [1/3] fixes the problem and then the remaining ones
>> deal with the issues resulting from that.
>
> So I saw the issue reported and fixed by 2/3 first and noticed 1/3 while
> doing code reviews. So, 1/3 isn't the culprit really as the problem happens
> without it as well.

I see.

OK, let me consider that.

Thanks,
Rafael
