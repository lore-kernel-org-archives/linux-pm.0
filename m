From: Patrick Bellasi <patrick.bellasi@arm.com>
Subject: Re: [PATCH 2/4] sched: cpufreq: Keep track of cpufreq utilization
 update flags
Date: Mon, 18 Dec 2017 12:14:53 +0000
Message-ID: <20171218121453.GH19821@e110439-lin>
References: <cover.1513158452.git.viresh.kumar@linaro.org>
 <CAJZ5v0jLQ7v5u+OUpK0gSAHvR90K=agvUSuFNzJXMnk+YkKyzQ@mail.gmail.com>
 <CAKohpomHfV=2CQj0_D=PsoMvbCu5v_ensJqaZmxUURzr27+yhA@mail.gmail.com>
 <20456740.6R3DDKEUDv@aspire.rjw.lan>
 <20171218045945.GG19815@vireshk-i7>
 <CAJZ5v0h+bvbe6DbMn+9DXbbctKG4POTsvEf_eL8R0nLajKXBTA@mail.gmail.com>
 <20171218115943.GL19815@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:49522 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751529AbdLRMO7 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 18 Dec 2017 07:14:59 -0500
Content-Disposition: inline
In-Reply-To: <20171218115943.GL19815@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Linux PM <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Juri Lelli <juri.lelli@redhat.com>, Todd Kjos <tkjos@android.com>, Joel Fernandes <joelaf@google.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On 18-Dec 17:29, Viresh Kumar wrote:
> On 18-12-17, 12:35, Rafael J. Wysocki wrote:
> > Well, if SCHED_CPUFRREQ_CLEAR means "this CPU is going to enter the
> > idle loop" really, then it is better to call it
> > SCHED_CPUFRREQ_ENTER_IDLE, for example.
> > 
> > SCHED_CPUFRREQ_CLEAR meaning basically "you should clear these flags
> > now" doesn't seem to convey any information to whoever doesn't
> > squirrel the flags in the first place.
> 
> Right, but when all the flags are cleared, then we can infer that we
> are going to idle in the most probable case.
> 
> Anyway, I will implement RT and DL clear flags as you suggested in the
> next version.

I think Rafael is right, the current API is a big odd since we cannot
really set the CLEAR flags by itself. I mean, you can but it will not
have effects.

Thus, it's probably better from an API standpoint to have a dedicated
single clear flag... unfortunately it has to be one per class, which
is still not optimal and will likely make the policy code a bit odd.

What about extending the signature of the callback method?

For example, swithing from:

 - void (*func)(struct update_util_data *data, u64 time,
 -              unsigned int flags))
 + void (*func)(struct update_util_data *data, u64 time,
 +              unsigned int flags, bool set))

Where the additional boolean is actually used to define which
operation we wanna perform on the flags?

-- 
#include <best/regards.h>

Patrick Bellasi
