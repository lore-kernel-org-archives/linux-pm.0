From: Steve Muckle <steve.muckle@linaro.org>
Subject: Re: [PATCH v2 6/10] cpufreq: Support for fast frequency switching
Date: Fri, 4 Mar 2016 15:56:48 -0800
Message-ID: <56DA20C0.1070803@linaro.org>
References: <2495375.dFbdlAZmA6@vostro.rjw.lan>
 <2409306.qzzMXcm4dm@vostro.rjw.lan> <15684081.T4iOMUSHCY@vostro.rjw.lan>
 <56DA09B1.4010005@linaro.org>
 <CAJZ5v0jENyu8j0fq1-BhU64QwRHAjvcjQktYc2sa9QmhktoEnQ@mail.gmail.com>
 <CAJZ5v0jd6sXQnvZ87=_L1MQgu2QsBJtYb8jwn=0=m7eRdKVvhA@mail.gmail.com>
 <CAJZ5v0jh7qcmYjDXCdO3Pid4XyuuxQfsKAmWDLXYcrkx0t-phw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0jh7qcmYjDXCdO3Pid4XyuuxQfsKAmWDLXYcrkx0t-phw@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Juri Lelli <juri.lelli@arm.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Ingo Molnar <mingo@kernel.org>
List-Id: linux-pm@vger.kernel.org

On 03/04/2016 03:18 PM, Rafael J. Wysocki wrote:
> In fact, the mechanism may be relatively simple if I'm not mistaken.
> 
> In the "fast switch" case, the governor may spawn a work item that
> will just execute cpufreq_get() on policy->cpu.  That will notice that
> policy->cur is different from the real current frequency and will
> re-adjust.
> 
> Of course, cpufreq_driver_fast_switch() will need to be modified so it
> doesn't update policy->cur then perhaps with a comment that the
> governor using it will be responsible for that.
> 
> And the governor will need to avoid spawning that work item too often
> (basically, if one has been spawned already and hasn't completed, no
> need to spawn a new one, and maybe rate-limit it?), but all that looks
> reasonably straightforward.

It is another option though definitely a compromise. The semantics seem
different since you'd potentially have multiple freq changes before a
single notifier went through, so stuff might still break. The fast path
would also be more expensive given the workqueue activity that could
translate into additional task wakeups.

Honestly I wonder if it's better to just try the "no notifiers with fast
drivers" approach to start. The notifiers could always be added if
platform owners complain that they absolutely require them.

thanks,
Steve


