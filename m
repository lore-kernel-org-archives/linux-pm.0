From: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH v2] exec: make de_thread() freezable
Date: Wed, 14 Nov 2018 15:29:13 +0100
Message-ID: <20181114142913.GA13885@redhat.com>
References: <1541994885-20059-1-git-send-email-chanho.min@lge.com>
 <20181113145339.GD16182@dhcp22.suse.cz>
 <20181113161858.GE30990@redhat.com>
 <20181113180058.GT15120@dhcp22.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181113180058.GT15120@dhcp22.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Michal Hocko <mhocko@kernel.org>
Cc: Chanho Min <chanho.min@lge.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Andrew Morton <akpm@linux-foundation.org>, "Eric W. Biederman" <ebiederm@xmission.com>, Christian Brauner <christian@brauner.io>, Anna-Maria Gleixner <anna-maria@linutronix.de>, Alexander Viro <viro@zeniv.linux.org.uk>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, Seungho Park <seungho1.park@lge.com>, Inkyu Hwang <inkyu.hwang@lge.com>, Donghwan Jung <donghwan.jung@lge.com>, Jongsung Kim <neidhard.kim@lge.com>
List-Id: linux-pm@vger.kernel.org

On 11/13, Michal Hocko wrote:
>
> > > >
> > > > To fix this, make de_thread() freezable. It looks safe and works fine.
> > >
> > > It's been some time since I have looked into this code so bear with me.
> > > One thing is not really clear to me. Why does it help to exclude this
> > > particular task from the freezer
> >
> > we don't exclude it,
> >
> > > when it is not sleeping in the freezer.
> >
> > Yes, it is not sleeping in __refrigerator(), but it does
> >
> > 	schedule();
> > 	freezer_count();
> >
> > so it will enter __refrigerator() right after wakeup. If it won't be woken
> > up we do not care, we can consider it "frozen".
>
> Right, but this is just silencing the freezing code to exclude this
> task, right?

Well yes... but I'd say this tells the freezing code that the caller is frozen,
because it can do nothing till thaw_processes(). Except it can actually call
__refrigerator() if, say, it is killed.

> > > I can see how other threads need to be zapped and TASK_WAKEKILL doesn't
> > > do that but shouldn't we fix that instead?
> >
> > Not sure I understand, but unlikely we can (or want) to make __refrigerator()
> > killable.
>
> Why would that be a problem. If the kill is fatal then why to keep the
> killed task in the fridge?

This is the question to Rafael, but I think that uninterruptible fridge
makes sense.

Because the exiting task can do a lot of things, say IO. So at least we need
to ensure that nobody can be killed after try_to_freeze_tasks() succeeds, and
this needs the changes in kernel/power/process.c and can lead to other problems.

And it is not clear to me why would we want to do this.

> > Otherwise, how can we fix that?
>
> We can mark all threads PF_NOFREEZE and wake them up.

We can't mark them PF_NOFREEZE but of course we could do something else
for de_thread() in particular, see the 1st version of Chanho's fix:
https://lore.kernel.org/lkml/1541671796-8725-1-git-send-email-chanho.min@lge.com/

> This would require
> some more changes of course

Yes,

> but wouldn't that be a more appropriate
> solution? Do we want to block exec for ever just because some threads
> are in the fridge?

Why not?

------------------------------------------------------------------------------
To clarify. speaking of de_thread() in particular, this change can not solve
all problems with freezer because de_thread() is called with cred_guard_mutex
held. And this obviously means that try_to_freeze_tasks() still can fail if
another task waits for this mutex.

But. freezable_schedule() doesn't make the thing worse, we have a lot more
problems (deadlocks) exactly because de_thread() sleeps wating for other threads
with this mutex held.

So I didn't even mention this problem, we need to narrow the scope of this mutex
in any case, so imo this has nothing to do with s/schedule/freezable_schedule/.

Oleg.
