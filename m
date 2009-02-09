From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: [PATCH 01/13] PM: Add wake lock api.
Date: Sun, 8 Feb 2009 18:03:31 -0800
Message-ID: <d6200be20902081803m4976c14eic88aba06548f7838@mail.gmail.com>
References: <1233802226-23386-1-git-send-email-arve@android.com>
	<200902080025.40789.rjw@sisk.pl>
	<d6200be20902071620o2012e80es272745f98345b656@mail.gmail.com>
	<200902090115.10896.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200902090115.10896.rjw@sisk.pl>
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
Cc: ncunningham@crca.org.au, u.luckas@road.de, swetland@google.com, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Sun, Feb 8, 2009 at 4:15 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
>> >> It means that you can, without knowing the current state of the lock,=
 safely
>> >> call wake_lock when you know that you need the wakelock, and
>> >> wake_unlock when you are done.
>> >
>> > You can do the same with a reference counter IMO.
>>
>> Not without some per lock state.
>
> What prevents me from increasing the reference counter when necessary and
> decreasing it when I'm done, actually?

Nothing prevents a driver from incrementing and decrementing a
reference count correctly, but it has to know if it already has a
reference. If you want to implement my current wake_lock api with a
global reference count, you need some per lock state to indicate if
the lock is locked or not.

>> >> It allows wakelocks with timeouts
>> >
>> > OK
>> >
>> > What for?
>>
>> So we do not have to change everything at once, and so we can allow
>> code that we do not really trust a chance to run.
>
> Well, are you sure this is the best way of achieving this goal?

No, but I have not seen any better suggestions, that solve the problem.

>> > However, it might be better to use a refcount along with some mechanism
>> > allowing user space processes to increase it only once before decreasi=
ng.
>> > That would require a per-task flag, but I think you can reuse one of t=
he
>> > freezer flags for that (the freezer is not going to run as long as a w=
akelock
>> > is held, right?).
>>
>> How would this be better?
>
> Simpler code, less overhead.  But I'm not insisting, just showing you ano=
ther
> possible approach.

I agree that a global reference count is less overhead, but we need
timeout support the make the system work for now. I don't see what a
per-task flag would be helpful with. Not all wakelocks are associated
with tasks.

>
>> >> >> +This works whether the wakelock is already held or not. It is use=
ful if the
>> >> >> +driver woke up other parts of the system that do not use wakelock=
s but
>> >> >> +still need to run. Avoid this when possible, since it will waste =
power
>> >> >> +if the timeout is long or may fail to finish needed work if the t=
imeout is
>> >> >> +short.
>> >> >
>> >> > And what's this call needed for?
>> >
>> > Please don't remove the context.  This makes reading your reply diffic=
ult.
>>
>>  +It can also call wake_lock_timeout to release the wakelock after a del=
ay:
>>  +     wake_lock_timeout(&state->wakelock, HZ);
>>  +
>>
>> >
>> >> It is needed to give code that do not use wakelocks a chance to run.
>> >> For instance we have not added wakelocks to the network stack. We also
>> >> use it in some places when passing data to untrusted userspace code.
>> >
>> > Do you mean to take a wakelock with a timeout in one code path so that=
 some
>> > other code path can run knowing that suspend will not happen?
>> >
>> > If this is correct, I don't like it, because it's inherently unreliabl=
e (you
>> > really never know how long it will take the other code path to run, so=
 you
>> > can't choose the timeout 100% accurately).
>>
>> I agree, but without wakelock support you have two options. Do not
>> user suspend at all, or use a global timeout that you reset everywhere
>> we lock a wakelock. By using wakelocks with timeouts we can at least
>> make some events 100% reliable.
>
> I'm not convinced.
>
> Sorry to say that, but IMO the "wakelock with timeout" mechanism looks mo=
re
> like a (poor) workaround than a solution of the problem.  Surely, I wouln=
d't
> have tried to introduce anything similar into the kernel.

I do not want to add wakelocks to every kernel subsystem while there
is no wakelock support in the mainline kernel. Using wakelocks with
timeouts allow us to make progress.

>> >
>> > I really would use a refcount and make sure it's increased (and obviou=
sly
>> > decreased) by _every_ code path that needs to prevent suspend from hap=
pening,
>> > including networking and so on.
>> >
>> >> > Is there a mechanism allowing us to see what wakelocks have been cr=
eated by
>> >> > the user land?  Something like this would be useful for debugging.
>> >>
>> >> /proc/wakelocks shows all wakelocks. It does not currently indicate if
>> >> a wakelock is from userspace, but if you are looking for a specific
>> >> lock it is easy to find. I can add a prefix to the name of all user
>> >> space wakelocks of you want.
>> >
>> > Well, actually, do the wakelocks have to have the names?
>>
>> If you want to debug the system or provide stats, yes.
>
> Care to elaborate?

We report the name and how long each wakelock is active in
/proc/wakelocks. Without a name, those stats are not very useful. You
can also enable debug options to print a message the kernel log every
time a wakelock is locked, unlocked or used to trigger a wakeup.

-- =

Arve Hj=F8nnev=E5g
