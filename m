From: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH 6/6] freezer: kill unused
	set_freezable_with_signal()
Date: Mon, 5 Sep 2011 18:20:12 +0200
Message-ID: <20110905162012.GA4445__20033.9323528626$1315239899$gmane$org@redhat.com>
References: <1314988070-12244-1-git-send-email-tj@kernel.org>
	<1314988070-12244-7-git-send-email-tj@kernel.org>
	<20110904184626.GA30101@redhat.com>
	<20110905023315.GB9807@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20110905023315.GB9807@htj.dyndns.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Tejun Heo <tj@kernel.org>
Cc: containers@lists.linux-foundation.org, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org, paul@paulmenage.org
List-Id: linux-pm@vger.kernel.org

On 09/05, Tejun Heo wrote:
>
> Hello, Oleg.
>
> On Sun, Sep 04, 2011 at 08:46:26PM +0200, Oleg Nesterov wrote:
> > > @@ -72,10 +72,6 @@ bool __refrigerator(bool check_kthr_stop)
> > >  		schedule();
> > >  	}
> > >
> > > -	spin_lock_irq(&current->sighand->siglock);
> > > -	recalc_sigpending(); /* We sent fake signal, clean it up */
> > > -	spin_unlock_irq(&current->sighand->siglock);
> > > -
> >
> > Why? This recalc_sigpending() makes sense imho. Otherwise the user-space
> > tasks (almost) always return with TIF_SIGPENDING. May be we can do this
> > under "if (PF_KTRHREAD)".
>
> PF_KTHREAD no longer gets TIF_SIGPENDING set, so...

Yes,

> > For example. Suppose the user-space task does wait_event_freezable()...
> >
> > Hmm. OTOH, wait_event_freezable() looks wrong anyway... So probably
> > this doesn't matter. ptrace_stop/get_signal_to_deliver doesn't need
> > this, probably we do not care about the other callers.
>
> Can you elaborate on it being wrong?  Do you mean the possibility of
> leaking spurious TIF_SIGPENDING?

Perhaps it is correct... Just I do not understand what it should do.
I thought it is "wait_for_event && do_not_block_freezer". And at first
glance the code looks as if it tries to do this. Say, in the "likely"
case we restart wait_event_interruptible() after refrigerator().

But this looks racy. Suppose that freezing() is already false when
try_to_freeze() or __refrigerator() is called. Say, cgroup_freezer does
freeze_task() + __thaw_task(). Why it returns -ERESTARTSYS in this case?

And if it can be used by the userspace thread, then we should probably
do recalc_sigpending() somewhere, otherwise wait_event_freezable() will
always return -ERESTARTSYS after __refrigerator().

Oleg.
