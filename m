From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 6/8] PM: Add suspend blocking work.
Date: Thu, 29 Apr 2010 00:19:26 +0200
Message-ID: <201004290019.26381.rjw__49929.7838811346$1272493150$gmane$org@sisk.pl>
References: <1272429119-12103-1-git-send-email-arve@android.com>
	<201004282309.42188.rjw@sisk.pl>
	<x2id6200be21004281509j84c29664m60068e7bfc86f64f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <x2id6200be21004281509j84c29664m60068e7bfc86f64f@mail.gmail.com>
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
> > On Wednesday 28 April 2010, Oleg Nesterov wrote:
> >> On 04/27, Arve Hj=F8nnev=E5g wrote:
> >> >
> >> > Allow work to be queued that will block suspend while it is pending
> >> > or executing. To get the same functionality in the calling code often
> >> > requires a separate suspend_blocker for pending and executing work, =
or
> >> > additional state and locking. This implementation does add additional
> >> > state and locking, but this can be removed later if we add support f=
or
> >> > suspend blocking work to the core workqueue code.
> >>
> >> I think this patch is fine.
> >>
> >> Just one silly question,
> >>
> >> > +int queue_suspend_blocking_work(struct workqueue_struct *wq,
> >> > +                           struct suspend_blocking_work *work)
> >> > +{
> >> > +   int ret;
> >> > +   unsigned long flags;
> >> > +
> >> > +   spin_lock_irqsave(&work->lock, flags);
> >> > +   suspend_block(&work->suspend_blocker);
> >> > +   ret =3D queue_work(wq, &work->work);
> >> > +   if (ret)
> >> > +           work->active++;
> >>
> >> why not
> >>
> >>       ret =3D queue_work(wq, &work->work);
> >>       if (ret) {
> >>               suspend_block(&work->suspend_blocker);
> >>               work->active++;
> >>       }
> >>
> >> ?
> >>
> >> Afaics, we can't race with work->func() doing unblock, we hold work-lo=
ck.
> >> And this way the code looks more clear.
> >
> > Agreed.  Arve, any objections to doing that?
> >
> =

> I need to fix the race, but I can easily fix it in
> cancel_suspend_blocking_work_sync instead. If the suspend blocker is
> active for a long time, and DEBUG_SUSPEND_BLOCKER is enabled, we can
> tell if the work is constantly re-queued or if the workqueue is stuck.

Well, perhaps that's worth adding a comment to the code.  The debug part is=
 not
immediately visible from the code itself.

Rafael
