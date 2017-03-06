From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 3/3] cpufreq: schedutil: remove redundant code from sugov_next_freq_shared()
Date: Mon, 6 Mar 2017 13:24:11 +0100
Message-ID: <CAJZ5v0hov8Lz_MK9dxP9MyqSmPNRfWV9Wia4DtAZtOPmoTOqAw@mail.gmail.com>
References: <cover.1488437503.git.viresh.kumar@linaro.org> <639aad743bac7f3292146738f44dbd1480169c8e.1488437503.git.viresh.kumar@linaro.org>
 <1772276.4tCnP8C0XV@aspire.rjw.lan> <1668614.4zDQWLsnmH@aspire.rjw.lan> <20170306044553.GE8206@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f66.google.com ([209.85.218.66]:34195 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753009AbdCFMdf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 6 Mar 2017 07:33:35 -0500
In-Reply-To: <20170306044553.GE8206@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>

On Mon, Mar 6, 2017 at 5:45 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 04-03-17, 01:11, Rafael J. Wysocki wrote:
>> So one idea is that if SCHED_CPUFREQ_RT_DL is set in flags, we don't even
>> need to start the loop which is quite a cost to simply notice that there's
>> nothing to do.
>
> Hmm. Isn't the probability of this flag being set, same for all CPUs in the
> policy?

No, I don't think so.

> If yes, then why do we need to handle the current CPU specially?

We don't need to chase a pointer to get to the flags for the current
CPU (and same goes for util and max) and what if it is the last one in
the policy->cpus mask?

>> Also I don't quite agree with adding an extra pair of integer multiplications
>> to that loop just to get rid of the extra args.
>
> But that should be cheap enough as we would be multiplying with 1 in one of them
> and with 0 on the other.

I'm not sure it will be really that cheap.

> Isn't that better then keeping same code at two places?

Well, it isn't IMO, unless you have numbers to support your point.

> Also as I mentioned in the commit log, the number of extra comparisons for the
> current CPU will be balanced if we have three CPUs in the policy and with every
> other CPU in the policy, we will end up doing one comparison less. With
> Quad-core policies, we reduce the number of comparisons by 1 and for octa-core
> ones, we reduce it by 5.

So to the point, the code was written this way on purpose and not just
by accident as your changelog suggests and if you want to change it,
you need numbers.

Thanks,
Rafael
