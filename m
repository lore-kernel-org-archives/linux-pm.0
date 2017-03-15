From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RFC v3 0/5] Add capacity capping support to the CPU controller
Date: Wed, 15 Mar 2017 12:41:54 +0100
Message-ID: <1831216.C7tcY13Jiv@aspire.rjw.lan>
References: <1488292722-19410-1-git-send-email-patrick.bellasi@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1488292722-19410-1-git-send-email-patrick.bellasi@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Tejun Heo <tj@kernel.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Paul Turner <pjt@google.com>, Vincent Guittot <vincent.guittot@linaro.org>, John Stultz <john.stultz@linaro.org>, Todd Kjos <tkjos@android.com>, Tim Murray <timmurray@google.com>, Andres Oportus <andresoportus@google.com>, Joel Fernandes <joelaf@google.com>, Juri Lelli <juri.lelli@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>
List-Id: linux-pm@vger.kernel.org

On Tuesday, February 28, 2017 02:38:37 PM Patrick Bellasi wrote:
> Was: SchedTune: central, scheduler-driven, power-perfomance control
> 
> This series presents a possible alternative design for what has been presented
> in the past as SchedTune. This redesign has been defined to address the main
> concerns and comments collected in the LKML discussion [1] as well at the last
> LPC [2].
> The aim of this posting is to present a working prototype which implements
> what has been discussed [2] with people like PeterZ, PaulT and TejunH.
> 
> The main differences with respect to the previous proposal [1] are:
>  1. Task boosting/capping is now implemented as an extension on top of
>     the existing CGroup CPU controller.
>  2. The previous boosting strategy, based on the inflation of the CPU's
>     utilization, has been now replaced by a more simple yet effective set
>     of capacity constraints.
> 
> The proposed approach allows to constrain the minimum and maximum capacity
> of a CPU depending on the set of tasks currently RUNNABLE on that CPU.
> The set of active constraints are tracked by the core scheduler, thus they
> apply across all the scheduling classes. The value of the constraints are
> used to clamp the CPU utilization when the schedutil CPUFreq's governor
> selects a frequency for that CPU.
> 
> This means that the new proposed approach allows to extend the concept of
> tasks classification to frequencies selection, thus allowing informed
> run-times (e.g. Android, ChromeOS, etc.) to efficiently implement different
> optimization policies such as:
>  a) Boosting of important tasks, by enforcing a minimum capacity in the
>     CPUs where they are enqueued for execution.
>  b) Capping of background tasks, by enforcing a maximum capacity.
>  c) Containment of OPPs for RT tasks which cannot easily be switched to
>     the usage of the DL class, but still don't need to run at the maximum
>     frequency.

Do you have any practical examples of that, like for example what exactly
Android is going to use this for?

I gather that there is some experience with the current EAS implementation
there, so I wonder how this work is related to that.

Thanks,
Rafael
