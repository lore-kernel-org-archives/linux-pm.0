From: "Joel Fernandes (Google)" <joel.opensrc@gmail.com>
Subject: Re: [RFC v3 5/5] sched/{core,cpufreq_schedutil}: add capacity
 clamping for RT/DL tasks
Date: Mon, 13 Mar 2017 03:08:18 -0700
Message-ID: <CAEi0qNkn8xS=8vzStXjtJVwYwiXiu4vefZwe3VQPUVqz72YiKw@mail.gmail.com>
References: <1488292722-19410-1-git-send-email-patrick.bellasi@arm.com> <1488292722-19410-6-git-send-email-patrick.bellasi@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f47.google.com ([74.125.82.47]:34862 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751809AbdCMKIV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 Mar 2017 06:08:21 -0400
In-Reply-To: <1488292722-19410-6-git-send-email-patrick.bellasi@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Joel Fernandes <joelaf@google.com>, Andres Oportus <andresoportus@google.com>

Hi Patrick,

On Tue, Feb 28, 2017 at 6:38 AM, Patrick Bellasi
<patrick.bellasi@arm.com> wrote:
> Currently schedutil enforce a maximum OPP when RT/DL tasks are RUNNABLE.
> Such a mandatory policy can be made more tunable from userspace thus
> allowing for example to define a reasonable max capacity (i.e.
> frequency) which is required for the execution of a specific RT/DL
> workload. This will contribute to make the RT class more "friendly" for
> power/energy sensible applications.
>
> This patch extends the usage of capacity_{min,max} to the RT/DL classes.
> Whenever a task in these classes is RUNNABLE, the capacity required is
> defined by the constraints of the control group that task belongs to.
>

We briefly discussed this at Linaro Connect that this works well for
sporadic RT tasks that run briefly and then sleep for long periods of
time - so certainly this patch is good, but its only a partial
solution to the problem of frequent and short-sleepers and something
is required to keep the boost active for short non-RUNNABLE as well.
The behavior with many periodic RT tasks is that they will sleep for
short intervals and run for short intervals periodically. In this case
removing the clamp (or the boost as in schedtune v2) on a dequeue will
essentially mean during a narrow window cpufreq can drop the frequency
and only to make it go back up again.

Currently for schedtune v2, I am working on prototyping something like
the following for Android:
- if RT task is enqueue, introduce the boost.
- When task is dequeued, start a timer for a  "minimum deboost delay
time" before taking out the boost.
- If task is enqueued again before the timer fires, then cancel the timer.

I don't think any "fix" to this particular issue should be to the
schedutil governor and should be sorted before going to cpufreq itself
(that is before making the request). What do you think about this?

Thanks,
Joel
