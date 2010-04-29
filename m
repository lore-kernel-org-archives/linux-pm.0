From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: [PATCH 6/8] PM: Add suspend blocking work.
Date: Wed, 28 Apr 2010 20:47:14 -0700
Message-ID: <s2rd6200be21004282047qc1b88ac5h1759f22f3c16ce85__19534.8146757626$1272513371$gmane$org@mail.gmail.com>
References: <1272429119-12103-1-git-send-email-arve@android.com>
	<201004282309.42188.rjw@sisk.pl>
	<x2id6200be21004281509j84c29664m60068e7bfc86f64f@mail.gmail.com>
	<201004290019.26381.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201004290019.26381.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Len Brown <len.brown@intel.com>, Oleg Nesterov <oleg@redhat.com>, linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

2010/4/28 Rafael J. Wysocki <rjw@sisk.pl>:
> On Thursday 29 April 2010, Arve Hj=F8nnev=E5g wrote:
>> 2010/4/28 Rafael J. Wysocki <rjw@sisk.pl>:
>> > On Wednesday 28 April 2010, Oleg Nesterov wrote:
>> >> On 04/27, Arve Hj=F8nnev=E5g wrote:
>> >> >
>> >> > Allow work to be queued that will block suspend while it is pending
>> >> > or executing. To get the same functionality in the calling code oft=
en
>> >> > requires a separate suspend_blocker for pending and executing work,=
 or
>> >> > additional state and locking. This implementation does add addition=
al
>> >> > state and locking, but this can be removed later if we add support =
for
>> >> > suspend blocking work to the core workqueue code.
>> >>
>> >> I think this patch is fine.
>> >>
>> >> Just one silly question,
>> >>
>> >> > +int queue_suspend_blocking_work(struct workqueue_struct *wq,
>> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct suspen=
d_blocking_work *work)
>> >> > +{
>> >> > + =A0 int ret;
>> >> > + =A0 unsigned long flags;
>> >> > +
>> >> > + =A0 spin_lock_irqsave(&work->lock, flags);
>> >> > + =A0 suspend_block(&work->suspend_blocker);
>> >> > + =A0 ret =3D queue_work(wq, &work->work);
>> >> > + =A0 if (ret)
>> >> > + =A0 =A0 =A0 =A0 =A0 work->active++;
>> >>
>> >> why not
>> >>
>> >> =A0 =A0 =A0 ret =3D queue_work(wq, &work->work);
>> >> =A0 =A0 =A0 if (ret) {
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 suspend_block(&work->suspend_blocker);
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 work->active++;
>> >> =A0 =A0 =A0 }
>> >>
>> >> ?
>> >>
>> >> Afaics, we can't race with work->func() doing unblock, we hold work-l=
ock.
>> >> And this way the code looks more clear.
>> >
>> > Agreed. =A0Arve, any objections to doing that?
>> >
>>
>> I need to fix the race, but I can easily fix it in
>> cancel_suspend_blocking_work_sync instead. If the suspend blocker is
>> active for a long time, and DEBUG_SUSPEND_BLOCKER is enabled, we can
>> tell if the work is constantly re-queued or if the workqueue is stuck.
>
> Well, perhaps that's worth adding a comment to the code. =A0The debug par=
t is not
> immediately visible from the code itself.

On second thought, this only makes a difference if both conditions are
true. If we are constantly re-queuing the work but it is not stuck,
either method will show the debug message, so I used Oleg's
suggestion.

-- =

Arve Hj=F8nnev=E5g
