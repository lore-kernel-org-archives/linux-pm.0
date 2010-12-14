From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH 2/4] PM: Remove redundant checks from
	core device resume routines
Date: Tue, 14 Dec 2010 20:58:04 +0100
Message-ID: <201012142058.04469.rjw__12260.5637800463$1292356804$gmane$org@sisk.pl>
References: <201012130128.31243.rjw@sisk.pl>
	<AANLkTi=UVOQb15EdpfSeD+Qh8x779pJpsSCTyGvf-gxG@mail.gmail.com>
	<AANLkTim+UoR+GeEK8T1_jgie3gwq6Pdt_=sRiSf8qx6K@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTim+UoR+GeEK8T1_jgie3gwq6Pdt_=sRiSf8qx6K@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Ming Lei <tom.leiming@gmail.com>
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tuesday, December 14, 2010, Ming Lei wrote:
> 2010/12/13 Linus Torvalds <torvalds@linux-foundation.org>:
> > So I really like this series not only because it implements what I
> > suggested, but also because each patch seems to remove more lines than
> > it adds. That's always nice, and much too unusual.
> >
> > But in this one, I really think you should simplify/clarify things further:
> >
> > On Sun, Dec 12, 2010 at 4:31 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> >>
> >> +++ linux-2.6/drivers/base/power/main.c
> >> @@ -485,20 +485,17 @@ void dpm_resume_noirq(pm_message_t state
> >>        transition_started = false;
> >>        while (!list_empty(&dpm_noirq_list)) {
> >>                struct device *dev = to_device(dpm_noirq_list.next);
> >> +               int error;
> >>
> >>                get_device(dev);
> >> -               if (dev->power.status > DPM_OFF) {
> >> -                       int error;
> >> -
> >> -                       dev->power.status = DPM_OFF;
> >> -                       mutex_unlock(&dpm_list_mtx);
> >> +               dev->power.status = DPM_OFF;
> >> +               mutex_unlock(&dpm_list_mtx);
> >
> > I think you should move the device to the dpm_suspended list _here_,
> > before dropping the mutex. That way the power.status thing matches the
> > list.
> >
> > So then you'd just remove the crazy conditional "if it's still on a
> > list, move it to the right list" thing, and these two lines:
> >
> >>                if (!list_empty(&dev->power.entry))
> >>                        list_move_tail(&dev->power.entry, &dpm_suspended_list);
> >
> > Would just be that plain
> >
> >        list_move_tail(&dev->power.entry, &dpm_suspended_list);
> >
> > before you even drop the lock. That look much simpler, and the list
> > movement seems a lot more obvious, no?
> >
> > If an unregister event (or whatever) happens while you had the mutex
> > unlocked, it will just remove it from the new list (the one that
> > matches the power state). So no need for that whole complexity with
> > "what happens with the list if somebody removed the device while we
> > were busy suspending/resuming it".
> >
> > Or am I missing something?
> >
> > (And same comment for that other identical case in dpm_complete())
> 
> Seems it may apply in other cases(dpm_prepare/dpm_suspend
> /dpm_suspend_noirq) too?

I thought about that, but in these cases the status is changed after the
callback has returned and only if it's succeeded.  Moreover, if the callback
hasn't been successful, the device is not moved to the new list, so I think
it's better to leave that as is.

Thanks,
Rafael
