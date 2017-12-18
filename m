From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 2/4] sched: cpufreq: Keep track of cpufreq utilization
 update flags
Date: Mon, 18 Dec 2017 18:34:19 +0100
Message-ID: <CAJZ5v0jfd6JsnSsk2SPv3AT=gjMyWFby3q32YcJrMuCK1ZoK8w@mail.gmail.com>
References: <cover.1513158452.git.viresh.kumar@linaro.org> <CAJZ5v0jLQ7v5u+OUpK0gSAHvR90K=agvUSuFNzJXMnk+YkKyzQ@mail.gmail.com>
 <CAKohpomHfV=2CQj0_D=PsoMvbCu5v_ensJqaZmxUURzr27+yhA@mail.gmail.com>
 <20456740.6R3DDKEUDv@aspire.rjw.lan> <20171218045945.GG19815@vireshk-i7>
 <CAJZ5v0h+bvbe6DbMn+9DXbbctKG4POTsvEf_eL8R0nLajKXBTA@mail.gmail.com> <20171218115943.GL19815@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ot0-f193.google.com ([74.125.82.193]:43235 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934957AbdLRReU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 Dec 2017 12:34:20 -0500
In-Reply-To: <20171218115943.GL19815@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Linux PM <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Juri Lelli <juri.lelli@redhat.com>, Todd Kjos <tkjos@android.com>, Joel Fernandes <joelaf@google.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Mon, Dec 18, 2017 at 12:59 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 18-12-17, 12:35, Rafael J. Wysocki wrote:
>> Well, if SCHED_CPUFRREQ_CLEAR means "this CPU is going to enter the
>> idle loop" really, then it is better to call it
>> SCHED_CPUFRREQ_ENTER_IDLE, for example.
>>
>> SCHED_CPUFRREQ_CLEAR meaning basically "you should clear these flags
>> now" doesn't seem to convey any information to whoever doesn't
>> squirrel the flags in the first place.
>
> Right, but when all the flags are cleared, then we can infer that we
> are going to idle in the most probable case.
>
> Anyway, I will implement RT and DL clear flags as you suggested in the
> next version.

Cool, thanks!
