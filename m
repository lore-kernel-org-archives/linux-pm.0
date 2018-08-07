From: Todd Kjos <tkjos@google.com>
Subject: [RFC] vruntime updated incorrectly when rt_mutex boots prio?
Date: Tue, 7 Aug 2018 10:40:42 -0700
Message-ID: <CAHRSSEwdWhUurOkviS0WdcGKj3374r-nCXH3BkQfwFiObyq+4w@mail.gmail.com>
References: <CA+njcd3z7-jqLvhsBjNWUO9bDrMr_zd13CD2cPdCS0+_kXdc4g@mail.gmail.com>
 <CAHRSSEwd0Ma+wn3WYCvfWMwg3E8vzYx9CDOOiY63EzH42FZQvg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHRSSEwd0Ma+wn3WYCvfWMwg3E8vzYx9CDOOiY63EzH42FZQvg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Paul Turner <pjt@google.com>
Cc: John Dias <joaodias@google.com>, Quentin Perret <quentin.perret@arm.com>, Patrick Bellasi <Patrick.Bellasi@arm.com>, Chris Redpath <Chris.Redpath@arm.com>, Morten Rasmussen <Morten.Rasmussen@arm.com>, Android Kernel Team <kernel-team@android.com>
List-Id: linux-pm@vger.kernel.org

This issue was discovered on a 4.9-based android device, but the
relevant mainline code appears to be the same. The symptom is that
over time the some workloads become sluggish resulting in missed
frames or sluggishness. It appears to be the same issue described in
http://lists.infradead.org/pipermail/linux-arm-kernel/2018-March/567836.html.

Here is the scenario: A task is deactivated while still in the fair
class. The task is then boosted to RT, so rt_mutex_setprio() is
called. This changes the task to RT and calls check_class_changed(),
which eventually calls detach_task_cfs_rq(), which is where
vruntime_normalized() sees that the task's state is TASK_WAKING, which
results in skipping the subtraction of the rq's min_vruntime from the
task's vruntime. Later, when the prio is deboosted and the task is
moved back to the fair class, the fair rq's min_vruntime is added to
the task's vruntime, resulting in vruntime inflation.

When investigating the problem, it was found that the change below
fixes the problem by forcing vruntime_normalized() to return false if
the sched_class is not CFS (though we're concerned that it might
introduce other issues):

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 91f7b3322a15..267056f2e2ca 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -11125,7 +11125,7 @@ static inline bool vruntime_normalized(struct
task_struct *p)
         * - A task which has been woken up by try_to_wake_up() and
         *   waiting for actually being woken up by sched_ttwu_pending().
         */
-       if (!se->sum_exec_runtime || p->state == TASK_WAKING)
+       if (!se->sum_exec_runtime || (p->state == TASK_WAKING &&
p->sched_class == &fair_sched_class))
                return true;

        return false;

Do folks agree that this is incorrect behavior? Does this fix look
appropriate and safe? Other ideas?

-Todd
