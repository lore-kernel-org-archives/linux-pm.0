From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 6/8] PM: Add suspend blocking work.
Date: Thu, 29 Apr 2010 23:09:06 +0200
Message-ID: <201004292309.06929.rjw@sisk.pl>
References: <1272429119-12103-1-git-send-email-arve@android.com>
	<201004290019.26381.rjw@sisk.pl>
	<s2rd6200be21004282047qc1b88ac5h1759f22f3c16ce85@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <s2rd6200be21004282047qc1b88ac5h1759f22f3c16ce85@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Arve =?iso-8859-1?q?Hj=F8nnev=E5g?= <arve@android.com>
Cc: Len Brown <len.brown@intel.com>, Oleg Nesterov <oleg@redhat.com>, linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Thursday 29 April 2010, Arve Hj=F8nnev=E5g wrote:
> 2010/4/28 Rafael J. Wysocki <rjw@sisk.pl>:
> > On Thursday 29 April 2010, Arve Hj=F8nnev=E5g wrote:
> >> 2010/4/28 Rafael J. Wysocki <rjw@sisk.pl>:
> >> > On Wednesday 28 April 2010, Oleg Nesterov wrote:
> >> >> On 04/27, Arve Hj=F8nnev=E5g wrote:
> >> >> >
> >> >> > Allow work to be queued that will block suspend while it is pendi=
ng
> >> >> > or executing. To get the same functionality in the calling code o=
ften
> >> >> > requires a separate suspend_blocker for pending and executing wor=
k, or
> >> >> > additional state and locking. This implementation does add additi=
onal
> >> >> > state and locking, but this can be removed later if we add suppor=
t for
> >> >> > suspend blocking work to the core workqueue code.
> >> >>
> >> >> I think this patch is fine.
> >> >>
> >> >> Just one silly question,
> >> >>
> >> >> > +int queue_suspend_blocking_work(struct workqueue_struct *wq,
> >> >> > +                           struct suspend_blocking_work *work)
> >> >> > +{
> >> >> > +   int ret;
> >> >> > +   unsigned long flags;
> >> >> > +
> >> >> > +   spin_lock_irqsave(&work->lock, flags);
> >> >> > +   suspend_block(&work->suspend_blocker);
> >> >> > +   ret =3D queue_work(wq, &work->work);
> >> >> > +   if (ret)
> >> >> > +           work->active++;
> >> >>
> >> >> why not
> >> >>
> >> >>       ret =3D queue_work(wq, &work->work);
> >> >>       if (ret) {
> >> >>               suspend_block(&work->suspend_blocker);
> >> >>               work->active++;
> >> >>       }
> >> >>
> >> >> ?
> >> >>
> >> >> Afaics, we can't race with work->func() doing unblock, we hold work=
-lock.
> >> >> And this way the code looks more clear.
> >> >
> >> > Agreed.  Arve, any objections to doing that?
> >> >
> >>
> >> I need to fix the race, but I can easily fix it in
> >> cancel_suspend_blocking_work_sync instead. If the suspend blocker is
> >> active for a long time, and DEBUG_SUSPEND_BLOCKER is enabled, we can
> >> tell if the work is constantly re-queued or if the workqueue is stuck.
> >
> > Well, perhaps that's worth adding a comment to the code.  The debug par=
t is not
> > immediately visible from the code itself.
> =

> On second thought, this only makes a difference if both conditions are
> true. If we are constantly re-queuing the work but it is not stuck,
> either method will show the debug message, so I used Oleg's
> suggestion.

OK, great.

Rafael
