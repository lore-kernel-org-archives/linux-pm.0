From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 2/4] sched: cpufreq: Keep track of cpufreq utilization
 update flags
Date: Mon, 18 Dec 2017 17:29:43 +0530
Message-ID: <20171218115943.GL19815@vireshk-i7>
References: <cover.1513158452.git.viresh.kumar@linaro.org>
 <CAJZ5v0jLQ7v5u+OUpK0gSAHvR90K=agvUSuFNzJXMnk+YkKyzQ@mail.gmail.com>
 <CAKohpomHfV=2CQj0_D=PsoMvbCu5v_ensJqaZmxUURzr27+yhA@mail.gmail.com>
 <20456740.6R3DDKEUDv@aspire.rjw.lan>
 <20171218045945.GG19815@vireshk-i7>
 <CAJZ5v0h+bvbe6DbMn+9DXbbctKG4POTsvEf_eL8R0nLajKXBTA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJZ5v0h+bvbe6DbMn+9DXbbctKG4POTsvEf_eL8R0nLajKXBTA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Linux PM <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Juri Lelli <juri.lelli@redhat.com>, Todd Kjos <tkjos@android.com>, Joel Fernandes <joelaf@google.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 18-12-17, 12:35, Rafael J. Wysocki wrote:
> Well, if SCHED_CPUFRREQ_CLEAR means "this CPU is going to enter the
> idle loop" really, then it is better to call it
> SCHED_CPUFRREQ_ENTER_IDLE, for example.
> 
> SCHED_CPUFRREQ_CLEAR meaning basically "you should clear these flags
> now" doesn't seem to convey any information to whoever doesn't
> squirrel the flags in the first place.

Right, but when all the flags are cleared, then we can infer that we
are going to idle in the most probable case.

Anyway, I will implement RT and DL clear flags as you suggested in the
next version.

-- 
viresh
