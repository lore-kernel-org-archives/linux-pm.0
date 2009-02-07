From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 01/13] PM: Add wake lock api.
Date: Sun, 8 Feb 2009 00:25:40 +0100
Message-ID: <200902080025.40789.rjw@sisk.pl>
References: <1233802226-23386-1-git-send-email-arve@android.com>
	<200902071956.32964.rjw@sisk.pl>
	<d6200be20902071451k48dc7a13ybb8251b014a091b0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <d6200be20902071451k48dc7a13ybb8251b014a091b0@mail.gmail.com>
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

On Saturday 07 February 2009, Arve Hj=F8nnev=E5g wrote:
> On Sat, Feb 7, 2009 at 10:56 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > If my understanding is correct, a wakelock is a mechanism that, if held=
, will
> > prevent the system from (automatically) entering a sleep state, but why=
 do we
> > need a number of such wakelocks instead of just one reference counter w=
ith the
> > rule that (automatic) suspend can only happen if the counter is zero?
> =

> Using wakelocks instead of a global reference count ensures that your
> request cannot be cleared by someone else.

Decreasing the refcount without increasing it would have been a bug, IMO.

> It means that you can, without knowing the current state of the lock, saf=
ely
> call wake_lock when you know that you need the wakelock, and
> wake_unlock when you are done.

You can do the same with a reference counter IMO.

> It allows wakelocks with timeouts

OK

What for?

> and detailed stats.

Well, I'm not sure how this is useful in the long run.

> > Then, code paths wanting to prevent the suspend from happening would on=
ly need
> > to increase the counter and it shouldn't be difficult to provide a user=
 space
> > interface for that.
> =

> No, but you would also need to provide way to decrement it, which
> would allow user-space to override a request to stay awake in the
> kernel or from another client.

OK, that's a good reason.

However, it might be better to use a refcount along with some mechanism
allowing user space processes to increase it only once before decreasing.
That would require a per-task flag, but I think you can reuse one of the
freezer flags for that (the freezer is not going to run as long as a wakelo=
ck
is held, right?).

> >> +This works whether the wakelock is already held or not. It is useful =
if the
> >> +driver woke up other parts of the system that do not use wakelocks but
> >> +still need to run. Avoid this when possible, since it will waste power
> >> +if the timeout is long or may fail to finish needed work if the timeo=
ut is
> >> +short.
> >
> > And what's this call needed for?

Please don't remove the context.  This makes reading your reply difficult.

> It is needed to give code that do not use wakelocks a chance to run.
> For instance we have not added wakelocks to the network stack. We also
> use it in some places when passing data to untrusted userspace code.

Do you mean to take a wakelock with a timeout in one code path so that some
other code path can run knowing that suspend will not happen?

If this is correct, I don't like it, because it's inherently unreliable (you
really never know how long it will take the other code path to run, so you
can't choose the timeout 100% accurately).

I really would use a refcount and make sure it's increased (and obviously
decreased) by _every_ code path that needs to prevent suspend from happenin=
g,
including networking and so on.

> > Is there a mechanism allowing us to see what wakelocks have been create=
d by
> > the user land?  Something like this would be useful for debugging.
> =

> /proc/wakelocks shows all wakelocks. It does not currently indicate if
> a wakelock is from userspace, but if you are looking for a specific
> lock it is easy to find. I can add a prefix to the name of all user
> space wakelocks of you want.

Well, actually, do the wakelocks have to have the names?

> >> +Do not use randomly generated wakelock names as there is no api to fr=
ee
> >> +a user-space wakelock.
> >
> > This appears to be very fragile.  Please rethink it.
> =

> I'm adding a /dev interface which removes this limitation.
> =

> >> +/* wake_lock_active returns a non-zero value if the wake_lock is curr=
ently
> >> + * locked. If the wake_lock has a timeout, it does not check the time=
out,
> >> + * but if the timeout had already expired when it was checked elsewhe=
re
> >> + * this function will return 0.
> >> + */
> >> +int wake_lock_active(struct wake_lock *lock);
> >
> > What's the purpose of this function?
> =

> It is used by our alarm driver to abort suspend.

In what way, exactly?

> >> +/* has_wake_lock returns 0 if no wake locks of the specified type are=
 active,
> >> + * and non-zero if one or more wake locks are held. Specifically it r=
eturns
> >> + * -1 if one or more wake locks with no timeout are active or the
> >> + * number of jiffies until all active wake locks time out.
> >> + */
> >> +long has_wake_lock(int type);

Well, it should be called max_wake_lock_timeout() or something like this.

> > And this?
> =

> It is used to abort suspend. Currently when freezing processes, but it
> could also be called between each driver suspend call to improve
> wakeup latency when a wakelock is locked while suspending.
> =

> We also use it (with WAKE_LOCK_IDLE) to select the idle sleep mode.

OK, but it is not supposed to be used by device drivers, right?

Rafael
