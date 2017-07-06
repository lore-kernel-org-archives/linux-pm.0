From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2 0/6] cpufreq: schedutil: fixes for flags updates
Date: Fri, 07 Jul 2017 00:26:18 +0200
Message-ID: <1922385.Uty99Stho4@aspire.rjw.lan>
References: <1499189651-18797-1-git-send-email-patrick.bellasi@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1499189651-18797-1-git-send-email-patrick.bellasi@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Juri Lelli <juri.lelli@arm.com>, Joel Fernandes <joelaf@google.com>, Andres Oportus <andresoportus@google.com>, Todd Kjos <tkjos@android.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>
List-Id: linux-pm@vger.kernel.org

On Tuesday, July 04, 2017 06:34:05 PM Patrick Bellasi wrote:
> Each time a CPU utilisation update is issued by the scheduler a flag, which
> mainly defines which scheduling class is asking for the update, is used by the
> frequency selection policy to support the selection of the most appropriate
> OPP.
>  
> In the current implementation, CPU flags are overridden each time the scheduler
> calls schedutil for an update. Such a behavior seems to be sub-optimal,
> especially on systems where frequency domains span across multiple CPUs.
>  
> Indeed, assuming CPU1 and CPU2 share the same frequency domain, there can be
> the following issues:
>  
>  A) Small FAIR task running at MAX OPP.
>     A RT task, which just executed on CPU1, can keep the domain at the
>     max frequency for a prolonged period of time after its completion,
>     even if there are no longer RT tasks running on CPUs of its domain.
>  
>  B) FAIR wakeup reducing the OPP of the current RT task.
>     A FAIR task enqueued in a CPU where a RT task is running overrides the flag
>     configured by the RT task thus potentially causing an unwanted frequency
>     drop.
>  
>  C) RT wakeup not running at max OPP.
>     An RT task waking up on a CPU which has recently updated its OPP can
>     be forced to run at a lower frequency because of the throttling
>     enforced by schedutil, even if there are not OPP transitions
>     currently in progress.
> 
> .:: Patches organization
> ========================
>  
> This series proposes a set of fixes for the aforementioned issues and it's an
> update addressing all the main comments collected from the previous posting
> [1].

It seems to me that there is a nonzero overlap between this and the Juri's work.

If that's correct, I'd like this series to go on top of the Juri's one.

Thanks,
Rafael
