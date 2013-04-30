From: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH 09/10] sigtimedwait: use freezable blocking call
Date: Tue, 30 Apr 2013 18:56:13 +0200
Message-ID: <20130430165613.GA27962@redhat.com>
References: <1367271946-7239-1-git-send-email-ccross@android.com> <1367271946-7239-10-git-send-email-ccross@android.com> <20130430163817.GA27304@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20130430163817.GA27304@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Colin Cross <ccross@android.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, arve@android.com, Al Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, "Eric W. Biederman" <ebiederm@xmission.com>, Serge Hallyn <serge.hallyn@canonical.com>
List-Id: linux-pm@vger.kernel.org

On 04/30, Oleg Nesterov wrote:
>
> On 04/29, Colin Cross wrote:
> >
> > Avoid waking up every thread sleeping in a sigtimedwait call during
> > suspend and resume by calling a freezable blocking call.
>
> This doesn't explain why do want this change...
>
> OK, probably to avoid -EAGAIN from sigtimedwait() if the freezer wakes
> up the caller.
>
> > --- a/kernel/signal.c
> > +++ b/kernel/signal.c
> > @@ -2845,7 +2845,7 @@ int do_sigtimedwait(const sigset_t *which, siginfo_t *info,
> >  		recalc_sigpending();
> >  		spin_unlock_irq(&tsk->sighand->siglock);
> >
> > -		timeout = schedule_timeout_interruptible(timeout);
> > +		timeout = freezable_schedule_timeout_interruptible(timeout);
>
> And I guess freezable_schedule_timeout_interruptible() is added by
> http://marc.info/?l=linux-kernel&m=136727195719575 ...
>
> 	+#define freezable_schedule_timeout_interruptible(timeout)		\
> 	+({									\
> 	+	long __retval;							\
> 	+	freezer_do_not_count();						\
> 	+	__retval = schedule_timeout_interruptible(timeout);		\
> 	+	freezer_count();						\
> 	+	__retval;							\
> 	+})
>
> How this can help?
>
> The task will be interrupted anyway and the syscall will return
> -EAGAIN, this only changes the time when try_to_freeze() is called.

OK, I wasn't cced, I have found another patch
http://marc.info/?l=linux-kernel&m=136727200519602 which should make
a difference, it won't be woken if PF_FREEZER_SKIP was already set.

This is racy, but it seems that "avoid -EAGAIN" was not your goal...

> For what? The task will call do_signal/try_to_freeze really "soon".

It seems that you want to speed up the freezing.

Oleg.
