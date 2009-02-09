From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 01/13] PM: Add wake lock api.
Date: Mon, 9 Feb 2009 01:15:10 +0100
Message-ID: <200902090115.10896.rjw@sisk.pl>
References: <1233802226-23386-1-git-send-email-arve@android.com>
	<200902080025.40789.rjw@sisk.pl>
	<d6200be20902071620o2012e80es272745f98345b656@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <d6200be20902071620o2012e80es272745f98345b656@mail.gmail.com>
Content-Disposition: inline
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
Cc: ncunningham@crca.org.au, u.luckas@road.de, swetland@google.com, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Sunday 08 February 2009, Arve Hj=F8nnev=E5g wrote:
> On Sat, Feb 7, 2009 at 3:25 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > On Saturday 07 February 2009, Arve Hj=F8nnev=E5g wrote:
> >> On Sat, Feb 7, 2009 at 10:56 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> >> > If my understanding is correct, a wakelock is a mechanism that, if h=
eld, will
> >> > prevent the system from (automatically) entering a sleep state, but =
why do we
> >> > need a number of such wakelocks instead of just one reference counte=
r with the
> >> > rule that (automatic) suspend can only happen if the counter is zero?
> >>
> >> Using wakelocks instead of a global reference count ensures that your
> >> request cannot be cleared by someone else.
> >
> > Decreasing the refcount without increasing it would have been a bug, IM=
O.
> =

> Yes, but if all you have is a global reference count, you can't tell
> where the bug is.

Still, in the kernel we use reference counts all over the place.

> >> It means that you can, without knowing the current state of the lock, =
safely
> >> call wake_lock when you know that you need the wakelock, and
> >> wake_unlock when you are done.
> >
> > You can do the same with a reference counter IMO.
> =

> Not without some per lock state.

What prevents me from increasing the reference counter when necessary and
decreasing it when I'm done, actually?

> >> It allows wakelocks with timeouts
> >
> > OK
> >
> > What for?
> =

> So we do not have to change everything at once, and so we can allow
> code that we do not really trust a chance to run.

Well, are you sure this is the best way of achieving this goal?

> >> and detailed stats.
> >
> > Well, I'm not sure how this is useful in the long run.
> =

> You may want to know which app drained your battery.
> =

> >> > Then, code paths wanting to prevent the suspend from happening would=
 only need
> >> > to increase the counter and it shouldn't be difficult to provide a u=
ser space
> >> > interface for that.
> >>
> >> No, but you would also need to provide way to decrement it, which
> >> would allow user-space to override a request to stay awake in the
> >> kernel or from another client.
> >
> > OK, that's a good reason.
> >
> > However, it might be better to use a refcount along with some mechanism
> > allowing user space processes to increase it only once before decreasin=
g.
> > That would require a per-task flag, but I think you can reuse one of the
> > freezer flags for that (the freezer is not going to run as long as a wa=
kelock
> > is held, right?).
> =

> How would this be better?

Simpler code, less overhead.  But I'm not insisting, just showing you anoth=
er
possible approach.

> >> >> +This works whether the wakelock is already held or not. It is usef=
ul if the
> >> >> +driver woke up other parts of the system that do not use wakelocks=
 but
> >> >> +still need to run. Avoid this when possible, since it will waste p=
ower
> >> >> +if the timeout is long or may fail to finish needed work if the ti=
meout is
> >> >> +short.
> >> >
> >> > And what's this call needed for?
> >
> > Please don't remove the context.  This makes reading your reply difficu=
lt.
> =

>  +It can also call wake_lock_timeout to release the wakelock after a dela=
y:
>  +     wake_lock_timeout(&state->wakelock, HZ);
>  +
> =

> >
> >> It is needed to give code that do not use wakelocks a chance to run.
> >> For instance we have not added wakelocks to the network stack. We also
> >> use it in some places when passing data to untrusted userspace code.
> >
> > Do you mean to take a wakelock with a timeout in one code path so that =
some
> > other code path can run knowing that suspend will not happen?
> >
> > If this is correct, I don't like it, because it's inherently unreliable=
 (you
> > really never know how long it will take the other code path to run, so =
you
> > can't choose the timeout 100% accurately).
> =

> I agree, but without wakelock support you have two options. Do not
> user suspend at all, or use a global timeout that you reset everywhere
> we lock a wakelock. By using wakelocks with timeouts we can at least
> make some events 100% reliable.

I'm not convinced.

Sorry to say that, but IMO the "wakelock with timeout" mechanism looks more
like a (poor) workaround than a solution of the problem.  Surely, I woulnd't
have tried to introduce anything similar into the kernel.

> >
> > I really would use a refcount and make sure it's increased (and obvious=
ly
> > decreased) by _every_ code path that needs to prevent suspend from happ=
ening,
> > including networking and so on.
> >
> >> > Is there a mechanism allowing us to see what wakelocks have been cre=
ated by
> >> > the user land?  Something like this would be useful for debugging.
> >>
> >> /proc/wakelocks shows all wakelocks. It does not currently indicate if
> >> a wakelock is from userspace, but if you are looking for a specific
> >> lock it is easy to find. I can add a prefix to the name of all user
> >> space wakelocks of you want.
> >
> > Well, actually, do the wakelocks have to have the names?
> =

> If you want to debug the system or provide stats, yes.

Care to elaborate?

> >> >> +/* wake_lock_active returns a non-zero value if the wake_lock is c=
urrently
> >> >> + * locked. If the wake_lock has a timeout, it does not check the t=
imeout,
> >> >> + * but if the timeout had already expired when it was checked else=
where
> >> >> + * this function will return 0.
> >> >> + */
> >> >> +int wake_lock_active(struct wake_lock *lock);
> >> >
> >> > What's the purpose of this function?
> >>
> >> It is used by our alarm driver to abort suspend.
> >
> > In what way, exactly?
> =

> The alarm driver sets an rtc alarm on suspend. After grabbing its
> state lock it, checks if the wakelock is active. Since the wakelock
> implementation now prevents suspend in a suspend_late hook when
> wakelocks are held, this may not be strictly necessary anymore, but
> prevents the alarm driver from having to deal with the state of being
> suspended while an alarm is pending.

OK, thanks.

> >> >> +/* has_wake_lock returns 0 if no wake locks of the specified type =
are active,
> >> >> + * and non-zero if one or more wake locks are held. Specifically i=
t returns
> >> >> + * -1 if one or more wake locks with no timeout are active or the
> >> >> + * number of jiffies until all active wake locks time out.
> >> >> + */
> >> >> +long has_wake_lock(int type);
> >
> > Well, it should be called max_wake_lock_timeout() or something like thi=
s.
> =

> I called it has_wake_lock since most of the clients do not care about
> the timeout. I think "if(has_wake_lock(" is easier to read than
> "if(max_wake_lock_timeout(".
> =

> >
> >> > And this?
> >>
> >> It is used to abort suspend. Currently when freezing processes, but it
> >> could also be called between each driver suspend call to improve
> >> wakeup latency when a wakelock is locked while suspending.
> >>
> >> We also use it (with WAKE_LOCK_IDLE) to select the idle sleep mode.
> >
> > OK, but it is not supposed to be used by device drivers, right?
> =

> No, it is only used by generic or machine specific power management code.

Your original description seemed to imply that it was a part of the API
available to device drivers.

Thanks,
Rafael
