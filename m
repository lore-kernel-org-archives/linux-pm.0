From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 2/4] sched: cpufreq: Keep track of cpufreq utilization
 update flags
Date: Sat, 16 Dec 2017 22:17:07 +0530
Message-ID: <CAKohpomHfV=2CQj0_D=PsoMvbCu5v_ensJqaZmxUURzr27+yhA@mail.gmail.com>
References: <cover.1513158452.git.viresh.kumar@linaro.org> <17ff0b5d83a1275a98f0d1b87daf275f3e964af3.1513158452.git.viresh.kumar@linaro.org>
 <CAJZ5v0jLQ7v5u+OUpK0gSAHvR90K=agvUSuFNzJXMnk+YkKyzQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-it0-f66.google.com ([209.85.214.66]:39800 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756728AbdLPQrI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 16 Dec 2017 11:47:08 -0500
Received: by mail-it0-f66.google.com with SMTP id 68so23323644ite.4
        for <linux-pm@vger.kernel.org>; Sat, 16 Dec 2017 08:47:08 -0800 (PST)
In-Reply-To: <CAJZ5v0jLQ7v5u+OUpK0gSAHvR90K=agvUSuFNzJXMnk+YkKyzQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Linux PM <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Juri Lelli <juri.lelli@redhat.com>, Todd Kjos <tkjos@android.com>, Joel Fernandes <joelaf@google.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On 16 December 2017 at 22:10, Rafael J. Wysocki <rafael@kernel.org> wrote:
> On Wed, Dec 13, 2017 at 10:53 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:

>> +#define SCHED_CPUFREQ_CLEAR    (1U << 31)
>
> I'm not thrilled by this, because schedutil is not the only user of
> the flags and it's totally unclear what the other user(s) should do
> when this is set.

intel-pstate is the only other user of the IOWAIT flag, right? In order
not to change the current behavior, we can update that to return early
for now ?

--
viresh
