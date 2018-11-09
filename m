From: "Chanho Min" <chanho.min@lge.com>
Subject: RE: [PATCH] freezer: fix freeze timeout on exec
Date: Fri, 9 Nov 2018 09:29:42 +0900
Message-ID: <02ce01d477c3$4ebec440$ec3c4cc0$@lge.com>
References: <1541671796-8725-1-git-send-email-chanho.min@lge.com> <20181108105030.GB9939@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181108105030.GB9939@redhat.com>
Content-Language: ko
Sender: linux-kernel-owner@vger.kernel.org
To: 'Oleg Nesterov' <oleg@redhat.com>
Cc: "'Rafael J. Wysocki'" <rjw@rjwysocki.net>, 'Pavel Machek' <pavel@ucw.cz>, 'Len Brown' <len.brown@intel.com>, 'Andrew Morton' <akpm@linux-foundation.org>, "'Eric W. Biederman'" <ebiederm@xmission.com>, 'Christian Brauner' <christian@brauner.io>, 'Anna-Maria Gleixner' <anna-maria@linutronix.de>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 'Seungho Park' <seungho1.park@lge.com>, 'Jongsung Kim' <neidhard.kim@lge.com>, 'Inkyu Hwang' <inkyu.hwang@lge.com>, "'donghwan.jung'" <donghwan.jung@lge.com>
List-Id: linux-pm@vger.kernel.org

> >
> > To fix this, I suggest a patch by emboding the mentioned solution.
> > First, revive and rework cancel_freezing_and_thaw() function whitch
> > stops the task from sleeping in refrigirator reliably. And, The task
> > to be killed does not allow to freeze.
> 
> Can't we simply change de_thread() to use freezable_schedule() ?
> 
> Oleg.

We need to change freezable_schedule_timeout() instead.
freezable_schedule also can't be frozen if sub-threads can't stop
schedule().
Furthermore, I'm not sure if it is safe to freeze it at de_thread().

diff --git a/fs/exec.c b/fs/exec.c
index 9c5ee2a..291cbd6 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -942,7 +942,7 @@ static int de_thread(struct task_struct *tsk)
        while (sig->notify_count) {
                __set_current_state(TASK_KILLABLE);
                spin_unlock_irq(lock);
-               schedule();
+               while (!freezable_schedule_timeout(HZ));
                if (unlikely(__fatal_signal_pending(tsk)))
                        goto killed;
                spin_lock_irq(lock);

Chanho
